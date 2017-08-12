//
//  ZCNeTWorkSessionManager.swift
//  ZCwebo
//
//  Created by 张葱 on 17/8/11.
//  Copyright © 2017年 张葱. All rights reserved.
//

import UIKit
import AFNetworking

enum ZCHttpMethod{
  case GET
  case POST


}
class ZCNeTWorkSessionManager: AFHTTPSessionManager {

    static let shared: ZCNeTWorkSessionManager = {
     let instance = ZCNeTWorkSessionManager()
     instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
     return instance
    
    }()
    
    
    /// 封装 AFN 的 GET / POST 请求
    
    
    
    /// 封装 AFN 的 GET / POST 请求
    ///
    /// - parameter method:     GET / POST
    /// - parameter URLString:  URLString
    /// - parameter parameters: 参数字典
    /// - parameter completion: 完成回调[json(字典／数组), 是否成功]
    
    
    func request (method : ZCHttpMethod = .GET , URLString : String,parameters:[String: AnyObject]?,completion : @escaping (_ json : Any? , _ isSUccess : Bool) -> ()){
    
        let success = {(task : URLSessionDataTask?,json: Any?) ->() in
            
           completion(json as AnyObject,true)
        
        }
        
        let  failure = {(task : URLSessionDataTask?,error : Error) -> () in
        
        completion("\(error.localizedDescription)",false)
        
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
            
        }else{
        
          post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        
        }
        
    
    
    }

    
    

}

//调用接口们
extension ZCNeTWorkSessionManager{

//list
    func requestTodayFireVoice(key : String,  URLString : String,completion : @escaping (_ json : Any? , _ isSUccess : Bool) -> ()){
    

        let url  =   kBaseUrl + "mobile/discovery/v2/rankingList/track"
        
        let params = ["device": "iPhone",
                    "key": key,
                   "pageId": "1",
                    "pageSize": "30"]
        
        
        request(method: .GET, URLString: url, parameters: params as [String : AnyObject]?, completion: completion)
    
    
    }


// 顶部标题栏
    
    
    func requestTodayFireItem(key: String ,URString : String ,completion :  @escaping (_ json : Any? , _ isSUccess : Bool) -> ()){

        
        let url = kBaseUrl + "mobile/discovery/v2/rankingList/track"
        let params = ["device": "iPhone",
                      "key": "ranking:track:scoreByTime:1:0",
                      "pageId": "1",
                      "pageSize": "0"]
        
          request(method: .GET, URLString: url, parameters: params as [String : AnyObject]?, completion: completion)
        
    }


}


