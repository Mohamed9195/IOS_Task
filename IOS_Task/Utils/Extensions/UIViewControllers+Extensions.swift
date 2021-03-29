//
//  UIViewControllers+Extensions.swift
//  CountryFood
//
//  Created by mohamed hashem on 6/29/20.
//  Copyright © 2020 Xtrava Inc. All rights reserved.
//

import UIKit
import SwiftMessages
import RxSwift

extension UIViewController {
    
    func presentEventTypeView(storyboardName: String, viewControllerID: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        var viewController = UIViewController()
        
        if #available(iOS 13.0, *) {
            viewController = storyboard.instantiateViewController(identifier: viewControllerID)
        } else {
            viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID)
        }
        viewController.modalPresentationStyle = .fullScreen
        
        self.present(viewController, animated: false)
    }

    func showCustomToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: (self.view.frame.size.width - 200) / 2, y: 100, width: 200, height: 35))
        toastLabel.backgroundColor = #colorLiteral(red: 1, green: 0.8549019608, blue: 0.1764705882, alpha: 0.8)
        toastLabel.textColor = .black
        toastLabel.font = UIFont(name: "AvenirNextLTPro-Demi", size: 15)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.numberOfLines = 2
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        toastLabel.frame.size.height = toastLabel.frame.size.height
        UIView.animate(withDuration: 10.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
