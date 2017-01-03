//
//  SliderTabbarVC.swift
//  ELeague
//
//  Created by Yudiz Solutions Pvt.Ltd. on 10/06/16.
//  Copyright © 2016 Yudiz Pvt.Ltd. All rights reserved.
//

import UIKit

class SlideMenuTabbarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting View Controllers for Tab
        self.tabBar.isHidden = true
        if let vcs = self.viewControllers{
            for vc in vcs{
                vc.view.layoutIfNeeded()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
