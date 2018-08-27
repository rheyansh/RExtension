//
//  RViewControllerExtension.swift
//  RExtension
//
//  Created by rajkumar.sharma on 20/08/18.
//  Copyright © 2018 Raj Sharma. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    var isModal: Bool {
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
    
    public func moveUIComponentWithValue(_ value: CGFloat, forLayoutConstraint: NSLayoutConstraint, forDuration: TimeInterval) {
        UIView.beginAnimations("MoveView", context: nil)
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationDuration(forDuration)
        forLayoutConstraint.constant = value
        self.view.layoutSubviews()
        self.view.layoutIfNeeded()
        UIView.commitAnimations()
    }
    
    public func animateUIComponentWithValue(_ value: CGFloat, forLayoutConstraint: NSLayoutConstraint, forDuration: TimeInterval) {
        
        forLayoutConstraint.constant = value
        
        UIView.animate(withDuration: forDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.view.layoutSubviews()
            self.view.layoutIfNeeded()
            
        }) { (Bool) -> Void in
            // do anything on completion
        }
    }
    
    func backViewController() -> UIViewController? {
        if let stack = self.navigationController?.viewControllers {
            for count in 0...stack.count - 1 {
                if(stack[count] == self) {
                    print("viewController     \(stack[count-1])")
                    return stack[count-1]
                }
            }
        }
        return nil
    }
    
    func getToolBarWithDoneButton() -> UIToolbar {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneBarButtonAction(_:)))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: nil,
                                          action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        return toolBar;

    }
    
    @objc private func doneBarButtonAction(_ button : UIButton) {
        view.endEditing(true)
    }

}
