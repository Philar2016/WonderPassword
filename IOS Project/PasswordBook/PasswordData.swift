//
//  PasswordData.swift
//  PasswordBook
//
//  Created by LiangMinglong on 16/08/2016.
//  Copyright © 2016 LiangMinglong. All rights reserved.
//

import UIKit
import LeanCloud

protocol passwordDataDelegate: NSObjectProtocol {
    
    func gotpassword(password: NSArray)
}

class PasswordData: NSObject {
    
    var delegate: passwordDataDelegate?
    
    override init() {
        super.init()
    }
    
     func get_user_password(search_string:String){
        
        var result_array:NSArray = []
        
        let query = LCQuery(className: "TodoFolder")
        query.whereKey("password_owner", LCQuery.Constraint.EqualTo(value: LCUser.current!))
        
        if search_string.characters.count > 0 {
            query.whereKey("user_account", LCQuery.Constraint.MatchedSubstring(string: search_string))
        }
        // 执行查找
        query.find({ (result) in
            if(result.isSuccess){
                result_array = result.objects!
                self.delegate?.gotpassword(result_array)
                // 获取 Todo 数组
                //self.todos = result.objects!
                //刷新表格
                //self.table_view.reloadData()
            }
        })
    }

}

/* MD5加密 不可逆
extension String{
    
    func md5() ->String!{
        
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        CC_MD5(str!, strLen, result)
        var hash = NSMutableString()
        
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.destroy()
        
        return String(format: hash as String)
    }
}*/