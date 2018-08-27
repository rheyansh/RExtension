//
//  RNavigationControllerExtension.swift
//  RExtension
//
//  Created by rajkumar.sharma on 20/08/18.
//  Copyright © 2018 Raj Sharma. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func popWithFadeAnimation() {
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.view.layer.add(transition, forKey: nil)
        self.popViewController(animated: false)
    }
    
    func pushToViewControllerWithFadeAnimation(_ controller: UIViewController) {
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.view.layer.add(transition, forKey: nil)
        self.pushViewController(controller, animated: false)
    }
}
