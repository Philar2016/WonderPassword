//
//  ViewController.swift
//  PasswordBook
//
//  Created by LiangMinglong on 29/07/2016.
//  Copyright © 2016 LiangMinglong. All rights reserved.
//

import UIKit
import LeanCloud

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let post = LCObject(className: "TestObject")
        post.set("words", value: LCString("Hello World!"))
        post.save { _ in }
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/*
let passwordBook = LCObject(className: "PasswordBook")
passwordBook.set("userName", value: LCString("JASON!"))
passwordBook.set("userAccount", object:"Philar_jason")
passwordBook.set("password", object: "1234567890")
passwordBook.set("type ", object: "E-mailAddress")

passwordBook.save { result in
    // 读取 result.isSuccess 可以判断是否操作成功
    
}*/
