//
//  HomeRouter.swift
//
//  Created by mohamed hashem on 19/02/2021.
//  Copyright (c) 2021 mohamed hashem. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum HomeDirection {
    case anyDirection
}

class HomeRouter {
    
  weak var viewController: ViewController!

  // MARK: Routing
    func routeToSomewhere(segue: UIStoryboardSegue?) {
        if segue?.identifier == "" {
            //let controller = segue?.destination as? AnyController
        }
    }

  // MARK: Navigation
    func navigateBySegue(to: HomeDirection) {
        switch to {
        case .anyDirection: break
            //viewController.performSegue(withIdentifier: "Any Name", sender: nil)

        }
    }
}
