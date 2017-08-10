//
//  ZCNavController.swift
//  ZCwebo
//
//  Created by 张葱 on 17/8/10.
//  Copyright © 2017年 张葱. All rights reserved.
//

import UIKit

class ZCNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }

    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            if let vc = viewController as? ZCBaseViewController {
                var title = "返回"
                
                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                    
                }
                
            }
        
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style:UIBarButtonItemStyle(rawValue: 0)!, target: self, action: #selector(popToParent))
        }
    }
    
    
    
    /// POP 返回到上一级控制器
     @objc private func popToParent() {
        popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
