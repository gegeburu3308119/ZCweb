//
//  ZCMainController.swift
//  ZCwebo
//
//  Created by 张葱 on 17/8/11.
//  Copyright © 2017年 张葱. All rights reserved.
//

import UIKit

class ZCMainController: UITabBarController {
    // 定时器
    fileprivate var timer: Timer?
    // MARK: - 私有控件
    /// 撰写按钮
    fileprivate lazy var composeButton: UIButton = UIButton.cz_imageButton(
        "tabbar_compose_icon_add",
        backgroundImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
     

        setupChildControllers()
        setupComposeButton()
    
        delegate = self
        // Do any additional setup after loading the view.
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

extension  ZCMainController : UITabBarControllerDelegate {

    /// 将要选择 TabBarItem
    ///
    /// - parameter tabBarController: tabBarController
    /// - parameter viewController:   目标控制器
    ///
    /// - returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        // 1> 获取控制器在数组中的索引
        let idx = (childViewControllers as NSArray).index(of: viewController)
        
        // 2> 判断当前索引是首页，同时 idx 也是首页，重复点击首页的按钮
        if selectedIndex == 0 && idx == selectedIndex {
            
            print("点击首页")
            // 3> 让表格滚动到顶部
            // a) 获取到控制器
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! ZCHomeController
            
            // b) 滚动到顶部
        // vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            
            // 4> 刷新数据 － 增加延迟，是保证表格先滚动到顶部再刷新
            
            
            // 5> 清除 tabItem 的 badgeNumber
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
        // 判断目标控制器是否是 UIViewController
        return !viewController.isMember(of: UIViewController.self)
    }

}

/*
 setupChildControllers()
 setupComposeButton()
 setupTimer()
 
 */


extension ZCMainController {

    fileprivate func  setupChildControllers(){
        let dir =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

        let jsonPath = (dir as String).appending("main.json")
        
        var  data = NSData(contentsOfFile: jsonPath)
        
        if data == nil {
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
        }
        
        
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: AnyObject]]
          else {
            return
        }
        
        
        var arrayM = [UIViewController]()
        for dict in array! {
        
            arrayM.append(contrller(dict: dict))
        
        }
        
    
      viewControllers = arrayM
    
    
    }

 // 使用字典创建控制器
    fileprivate func contrller(dict : [String : AnyObject]) ->UIViewController{
        guard let clsName = dict["clsName"] as? String,
        let title = dict["title"] as? String,
        let imageName = dict["imageName"] as? String,
        let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? ZCBaseViewController.Type,
        let visitorDirt = dict["visitorInfo"] as? [String : String]
        else {
            return UITableViewController()
        }
    
       
        
        
        //创建试图控制器
        let vc = cls.init()
        
        vc.title = title
        
    
        
        //  设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 设置 tabbar 的标题字体（大小）
        vc.tabBarItem.setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.orange],
            for: .highlighted)
        // 系统默认是 12 号字，修改字体大小，要设置 Normal 的字体大小
        vc.tabBarItem.setTitleTextAttributes(
            [NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
            for: UIControlState(rawValue: 0))
        vc.title = title
        // 实例化导航控制器的时候，会调用 push 方法将 rootVC 压栈
        let nav = ZCNavController(rootViewController: vc)
        
        return nav
    }

    
    
    
    func setupComposeButton() {
        
       tabBar.addSubview(composeButton)
       let count = CGFloat(childViewControllers.count)
        
       let w = tabBar.bounds.width / count
       composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w , dy: 0)
        
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
        
    }

    
    
    
    func composeStatus(){
    
    
    
    }
}




