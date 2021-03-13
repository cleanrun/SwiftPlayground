//
//  Extensions.swift
//  SwiftPlayground
//
//  Created by Marchell on 13/03/21.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UIWindow {
    func currentViewController() -> UIViewController? {
        var current = self.rootViewController
        while true {
            if let presented = current?.presentedViewController {
                current = presented
            } else if let nav = current as? UINavigationController {
                current = nav.visibleViewController
            } else if let tab = current as? UITabBarController {
                current = tab.selectedViewController
            } else {
                break
            }
        }
        return current
    }
}
