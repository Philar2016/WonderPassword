//
//  EditPasswordViewController.swift
//  PasswordBook
//
//  Created by LiangMinglong on 9/08/2016.
//  Copyright © 2016 LiangMinglong. All rights reserved.
//

import UIKit
import LeanCloud

//声明一个协议，然后在协议里定义一个方法
protocol EditPasswordViewControllerDelegate: NSObjectProtocol {
    func editInfo(controller: EditPasswordViewController, selectedIndex: Int)
}

class EditPasswordViewController: UIViewController{
    

    @IBOutlet weak var accountLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var typeLabel: UITextField!
    
    var editUsername:String = ""
    var editAccount: String = ""
    var editPassword: String = ""
    var editType: String = ""
    var object_id: String = ""
    var selectedIndex: Int = 0
    
    //定义一个dalegate的变量 遵守EditPasswordViewControllerDelegate的协议
    var delegate: EditPasswordViewControllerDelegate?
    
    
    @IBAction func done_pressed(sender: AnyObject) {
        
        let todo = LCObject(className: "TodoFolder", objectId: self.object_id)
        todo.set("user_password", object: AESCrypt.encrypt(passwordLabel.text, password: "123"))
        todo.set("user_name_field",object: usernameLabel.text)
        todo.set("user_account", object: accountLabel.text)
        todo.set("user_type", object: typeLabel.text)
        
        
        todo.save({ (result) in
            if(result.isSuccess){
                print("保存成功")
                
                //页面返回到根ViewController
                self.navigationController?.popToRootViewControllerAnimated(true)
                
                //我的代理 用到editInfo的方法
                self.delegate?.editInfo(self, selectedIndex: self.selectedIndex)
                
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        accountLabel.text = editAccount
        passwordLabel.text = editPassword
        usernameLabel.text = editUsername
        typeLabel.text = editType
        print("object id is \(object_id)")
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //if segue.in
    }
    */

}
