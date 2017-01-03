//
//  CustomNavigationController.swift
//  Checkin
//
//  Created by Yudiz Solutions Pvt.Ltd. on 30/03/16.
//  Copyright © 2016 Yudiz Solutions Pvt.Ltd. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weak var weakSelf: CustomNavigationController? = self
        self.interactivePopGestureRecognizer?.delegate = weakSelf!
        self.delegate = weakSelf!
        self.isNavigationBarHidden = true

    }
 
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool{
        if self.viewControllers.count > 1{
            return true
        }else{
            return false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Add every non interactive view controller so controller dont go back automatically.
        if  viewController is SlideMenuTabbarVC{
            self.interactivePopGestureRecognizer!.isEnabled = false
        }else{
            self.interactivePopGestureRecognizer!.isEnabled = true
        }
    }
}
