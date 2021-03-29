//
//  HomeConfiguration.swift
//
//  Created by mohamed hashem on 19/02/2021.
//  Copyright © 2021 mohamed hashem. All rights reserved.
//

import UIKit

extension ViewController: HomePresenterOutput {
}

extension HomeInteractor: ViewControllerOutput {
}

extension HomePresenter: HomeInteractorOutput {
}

class HomeConfiguration {
    // MARK: - Object lifecycle

    static let sharedInstance = HomeConfiguration()

    private init() {}

    // MARK: - Configuration by inject controller
    func configure(viewController: ViewController) {
        let router = HomeRouter()
        router.viewController = viewController

        let presenter = HomePresenter()
        presenter.output = viewController

        let worker = HomeWorker()

        let interactor = HomeInteractor(worker: worker)
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
