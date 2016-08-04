//
//  AddPassWordPackController.swift
//  PasswordBook
//
//  Created by LiangMinglong on 29/07/2016.
//  Copyright © 2016 LiangMinglong. All rights reserved.
//

import UIKit
import LeanCloud

class AddPassWordPackController: UIViewController {
    
    
    @IBOutlet weak var user_name_field: UITextField!
    @IBOutlet weak var user_account: UITextField!
    @IBOutlet weak var user_password: UITextField!
    @IBOutlet weak var user_type: UITextField!
    
    @IBAction func save_button_pressed(sender: AnyObject) {
        let todoFolder = LCObject(className: "TodoFolder")
        todoFolder.set("user_name_field", object: self.user_name_field.text)
        todoFolder.set("user_account", object: self.user_account.text)
        todoFolder.set("user_password", object: self.user_password.text)
        todoFolder.set("user_type", object: self.user_type.text)
        
        todoFolder.save { result in
            if (result.isSuccess){
                print("success")
            }else{
                print("fail")
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
