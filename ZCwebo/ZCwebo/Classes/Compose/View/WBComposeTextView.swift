//
//  WBComposeTextView.swift
//  传智微博
//
//  Created by apple on 16/7/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

/// 撰写微博的文本视图
class WBComposeTextView: UITextView {

    /// 占位标签
    fileprivate lazy var placeholderLabel = UILabel()

    override func awakeFromNib() {
        setupUI()
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 监听方法
    @objc fileprivate func textChanged() {
        // 如果有文本，不显示占位标签，否则显示
        placeholderLabel.isHidden = self.hasText
    }
}

// MARK: - 表情键盘专属方法
extension WBComposeTextView {
    
    /// 返回 textView 对应的纯文本的字符串[将属性图片转换成文字]
    var emoticonText: String {
        
        // 1. 获取 textView 的属性文本
        guard let attrStr = attributedText else {
            return ""
        }
        
        // 2. 需要获得属性文本中的图片[附件 Attachment]
        /**
         1> 遍历的范围
         2> 选项 []
         3> 闭包
         */
        var result = String()
        
        attrStr.enumerateAttributes(in: NSRange(location: 0, length: attrStr.length), options: [], using: { (dict, range, _) in
            
            // 如果字典中包含 NSAttachment `Key` 说明是图片，否则是文本
            // 下一个目标：从 attachment 中如果能够获得 chs 就可以了！
                  })
        
        return result
    }
    
    /// 向文本视图插入表情符号[图文混排]
    ///
    /// - parameter em: 选中的表情符号，nil 表示删除
}

fileprivate extension WBComposeTextView {
    
    func setupUI() {
        
        // 0. 注册通知
        // - 通知是一对多，如果其他控件监听当前文本视图的通知，不会影响
        // - 但是如果使用代理，其他控件就无法使用代理监听通知！
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textChanged),
            name: NSNotification.Name.UITextViewTextDidChange,
            object: self)
        
        // 1. 设置占位标签
        placeholderLabel.text = "分享新鲜事..."
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        
        placeholderLabel.sizeToFit()
        
        addSubview(placeholderLabel)
        
//        // 2. 测试代理 - 自己当自己的代理
//        self.delegate = self
    }
}
