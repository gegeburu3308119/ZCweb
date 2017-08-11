//
//  ZCBaseViewController.swift
//  ZCwebo
//
//  Created by 张葱 on 17/8/10.
//  Copyright © 2017年 张葱. All rights reserved.
//

import UIKit

class ZCBaseViewController: UIViewController {
  
    var visitorInfoDictionnary :[String : String]?
    
    var tableview : UITableView?
   // var refreshControl :CZRefreshControl?
    var isPullup = false
    
    lazy var navigationbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    lazy var naviItem = UINavigationItem()

    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
        setupNavigationBar()
        setUpTableview()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var title: String?{
        didSet{
        
         naviItem.title = title
        
        }
    
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
extension ZCBaseViewController{

    @objc fileprivate func loadData(){
    
    
    
    
    }
    
    
    
    fileprivate func setupUI(){
    
        view.backgroundColor = UIColor.cz_random()
        automaticallyAdjustsScrollViewInsets = false
        
        
    }
   
    
    func setUpTableview() {
        tableview = UITableView(frame: view.bounds)
        view.insertSubview(tableview!, belowSubview: navigationbar)
        
        tableview?.delegate = self
        tableview?.dataSource = self
        
        tableview?.scrollIndicatorInsets = tableview!.contentInset
        
       // refreshControl = CZRefreshControl()
        
       // tableview?.addSubview(refreshControl!)
        
       // refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    
    }


}

//tableview 的代理方法
extension ZCBaseViewController:UITableViewDataSource,UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        let  section = (tableview?.numberOfSections)! - 1
        
        if row < 0 || section < 0 {
            return
        }
        
           let count = tableView.numberOfRows(inSection: section)
        
        if row == (count - 1)  && isPullup{
            print("上啦刷新")
            isPullup = true
            
            loadData()
        }
        
        
    }


}

//创建访问视图





//创建navbar视图 
extension ZCBaseViewController{

    @objc fileprivate func login() {
      
    }
    
    @objc fileprivate func register() {
        print("用户注册")
    }

    
    
    /// 设置导航条
    fileprivate func setupNavigationBar() {
        // 添加导航条
        view.addSubview(navigationbar
        )
        
        
        
        naviItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        naviItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
        
        
        // 将 item 设置给 bar
        navigationbar.items = [naviItem]
        
        // 1> 设置 navBar 整个背景的渲染颜色
        navigationbar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        // 2> 设置 navBar 的字体颜色
        navigationbar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
        // 3> 设置系统按钮的文字渲染颜色
        navigationbar.tintColor = UIColor.orange
    }



}


