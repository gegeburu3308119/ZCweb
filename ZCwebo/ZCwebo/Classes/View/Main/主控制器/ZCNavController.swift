//
//  ZCNavController.swift
//  ZCwebo
//
//  Created by 张葱 on 17/8/10.
//  Copyright © 2017年 张葱. All rights reserved.
//

import UIKit
import SVProgressHUD
class ZCNavController: UINavigationController ,UINavigationControllerDelegate{


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
        navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }

    
    
    /// 重写 push 方法，所有的 push 动作都会调用此方法！
    /// viewController 是被 push 的控制器，设置他的左侧的按钮作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            // 隐藏底部的 TabBar
            viewController.hidesBottomBarWhenPushed = true
            
            // 判断控制器的类型
            if let vc = viewController as? ZCBaseViewController {
                
                var title = "返回"
                
                // 判断控制器的级数，只有一个子控制器的时候，显示栈底控制器的标题
                if childViewControllers.count == 1 {
                    // title 显示首页的标题
                    title = childViewControllers.first?.title ?? "返回"
                }
                
                // 取出自定义的 navItem，设置左侧按钮作为返回按钮
                vc.naviItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent), isBack: true)
            }
        }
        
        super.pushViewController(viewController, animated: true)
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
