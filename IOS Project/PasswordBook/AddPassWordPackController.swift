//
//  AddPassWordPackController.swift
//  PasswordBook
//
//  Created by LiangMinglong on 29/07/2016.
//  Copyright © 2016 LiangMinglong. All rights reserved.
//

import UIKit
import LeanCloud

protocol AddPasswordPackViewControllerDelegate: NSObjectProtocol {
    func new_password_save_success()
}

class AddPassWordPackController: UIViewController {
    

    var delegate: AddPasswordPackViewControllerDelegate?
    
    @IBOutlet weak var user_name_field: UITextField!
    @IBOutlet weak var user_account: UITextField!
    @IBOutlet weak var user_password: UITextField!
    @IBOutlet weak var user_type: UITextField!
    
    @IBAction func save_button_pressed(sender: AnyObject) {
        let todoFolder = LCObject(className: "TodoFolder")
        todoFolder.set("user_name_field", object: self.user_name_field.text)
        todoFolder.set("user_account", object: self.user_account.text)
        todoFolder.set("user_password", object: AESCrypt.encrypt(self.user_password.text, password: "123"))
        todoFolder.set("user_type", object: self.user_type.text)
        todoFolder.set("password_owner",object:LCUser.current)
        todoFolder.save { result in
            if (result.isSuccess){
                print("success")
                
                //返回最初的ViewController
            self.navigationController?.popToRootViewControllerAnimated(true)
            self.delegate?.new_password_save_success()
                
            }
        } 
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
