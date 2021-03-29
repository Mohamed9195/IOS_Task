//
//  ViewController.swift
//  IOS_Task
//
//  Created by mohamed hashem on 29/03/2021.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

protocol ViewControllerInput: class {
    func display(section: IOSTaskModel)
    func display(error: Error)
}

protocol ViewControllerOutput: class {
    func loadAllNews(apiKey: String)
}

class ViewController: UIViewController {

    @IBOutlet weak var TestHomeTableView: UITableView!

    private let disposed = DisposeBag()
    var output: ViewControllerOutput?
    var router: HomeRouter!

    var viewModel: HomeViewModel = HomeViewModel()

    private var iOSTaskModel: IOSTaskModel?

    // MARK: View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        HomeConfiguration.sharedInstance.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.homeDelegate = self

        viewModel.getProfile()
        output?.loadAllNews(apiKey: "6e83053abd624955a30459274157aa04")

        configureViewModelObservable()
    }

    private func configureViewModelObservable() {
        viewModel
            .userProfile
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                /// for ARC
//                [weak self] profile in
//                guard let self = self else { return }

                /// from here can bind data from Behaviorsubject and know any change in data that emitted by it
            }).disposed(by: disposed)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PKHUDIndicator.showProgressView()
    }
}

//MARK:- protocol Home ViewController Input
extension ViewController: ViewControllerInput, HomeViewModelOutput {
    func display(section: IOSTaskModel) {
        PKHUDIndicator.hideProgressView()
        iOSTaskModel = section
        TestHomeTableView.reloadData()
    }

    func display(error: Error) {
        PKHUDIndicator.hideProgressView()
        PopUpAlert.showErrorToastWith(error)
    }

    func display(profile: Profile) {
        /// from here can bind data from view model Delegation and know any change in data that emitted by it
    }
}

//MARK:- protocol UITable Delegate UITable DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articles = iOSTaskModel?.articles else {
            return 0
        }

        return articles.count + 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1,3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StaticCellTableViewCell", for: indexPath) as? StaticCellTableViewCell else {
                fatalError("not find StaticCellTableViewCell Cell")
            }

            return cell

        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TestTableViewCell", for: indexPath) as? TestTableViewCell else {
                fatalError("not find TestTableViewCell Cell")
            }

            if let articles = iOSTaskModel {
                cell.postDescriptionLabel.text = articles.articles[indexPath.row].description ?? "--"
                cell.postImage.loadImage(urlString: articles.articles[indexPath.row].urlToImage ?? "")
                cell.publishDateLabel.text = articles.articles[indexPath.row].publishedAt ?? "--"
                cell.postTitle.text = articles.articles[indexPath.row].author ?? "--"
            }

            return cell
        }
    }
}


//MARK:- Scroll View Delegate
extension ViewController: UIScrollViewDelegate {
    ///  can change distance by changing in scroll.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}
