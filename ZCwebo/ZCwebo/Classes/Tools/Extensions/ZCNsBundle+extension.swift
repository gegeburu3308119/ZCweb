//
//  ZCNsBundle+extension.swift
//  ZCwebo
//
//  Created by 张葱 on 17/8/11.
//  Copyright © 2017年 张葱. All rights reserved.
//

import UIKit

extension Bundle{
    
    var nmespace : String {
    
        return infoDictionary?["CFBundleName"] as? String  ?? ""
    
    }


}
