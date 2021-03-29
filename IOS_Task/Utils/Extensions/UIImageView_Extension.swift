//
//  UIImageView_Extension.swift
//  Hebat
//
//  Created by mohamed hashem on 05/12/2020.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import UIKit
import Kingfisher
import ImageIO

extension UIImageView {

    func placeholderImage() {
        self.image = #imageLiteral(resourceName: "placeholder-image")
    }

    func loadImage(urlString: String, placeholder: UIImage? = nil) {
        var correctUrl = urlString

        self.borderWidth = 0.3
        self.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        if correctUrl.contains(" ") {
            correctUrl = correctUrl.replacingOccurrences(of: " ", with: "%20")
        }

        let url = URL(string: correctUrl)

        if let image = ImageCache.default.retrieveImageInMemoryCache(forKey: correctUrl) {
            self.image = image
        } else {
            let retry = DelayRetryStrategy(maxRetryCount: 4, retryInterval: .seconds(1))
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: url,
                placeholder: .none,
                options: [.fromMemoryCacheOrRefresh, .retryStrategy(retry)], completionHandler:  { result in
                    switch result {
                    case .success(let value):
                        ImageCache.default.store(value.image, forKey: correctUrl)
                    case .failure(_):
                        self.placeholderImage()
                    }
                })
        }
    }
}

@IBDesignable
class CurvedUIImageView: UIImageView {

    func pathCurvedForView(givenView: UIView, curvedPercent:CGFloat) ->UIBezierPath {
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x:0, y:0))
        arrowPath.addLine(to: CGPoint(x:givenView.bounds.size.width, y:0))
        arrowPath.addLine(to: CGPoint(x:givenView.bounds.size.width, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)))
        arrowPath.addQuadCurve(to: CGPoint(x:0, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)), controlPoint: CGPoint(x:givenView.bounds.size.width/2, y:givenView.bounds.size.height))
        arrowPath.addLine(to: CGPoint(x:0, y:0))
        arrowPath.close()

        return arrowPath
    }

    @IBInspectable var curvedPercent : CGFloat = 0 {
        didSet{
            guard curvedPercent <= 1 && curvedPercent >= 0 else { return }

            let shapeLayer = CAShapeLayer(layer: self.layer)
            shapeLayer.path = self.pathCurvedForView(givenView: self,curvedPercent: curvedPercent).cgPath
            shapeLayer.frame = self.bounds
            shapeLayer.masksToBounds = true
            self.layer.mask = shapeLayer
        }
    }
}
