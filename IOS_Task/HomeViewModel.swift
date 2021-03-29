//
//  HomeViewModel.swift
//  IOS_Task
//
//  Created by mohamed hashem on 29/03/2021.
//

import Foundation
import RxSwift

protocol HomeViewModelOutput: class {
    func display(profile: Profile)
}

protocol HomeViewModelProtocol: class {
    func getProfile()
}

final class HomeViewModel: HomeViewModelProtocol {

    weak var homeDelegate: HomeViewModelOutput?
    var userProfile: BehaviorSubject<Profile?> = BehaviorSubject(value: nil)
    private let disposed = DisposeBag()

    func getProfile() {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "profile", ofType: "json") else {
            fatalError("profile.json cannot be loaded")
        }

        guard let json = try? String(contentsOfFile: path) else { fatalError("Cannot load json file") }

        guard let jsonProfile = try? JSONDecoder().decode(Profile.self, from: json.data(using: .utf8)!) else {
            fatalError("Profile is not found")
        }

        homeDelegate?.display(profile: jsonProfile)
        userProfile.onNext(jsonProfile)
    }
}
