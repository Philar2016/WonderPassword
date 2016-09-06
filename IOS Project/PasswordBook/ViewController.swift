//
//  ViewController.swift
//  PasswordBook
//
//  Created by LiangMinglong on 29/07/2016.
//  Copyright © 2016 LiangMinglong. All rights reserved.
//

import UIKit
import LeanCloud

protocol loginSucessDelegate: NSObjectProtocol {
    func loginSucess()
}

class ViewController: UIViewController {

    var delegate: loginSucessDelegate?
    
    
    
    @IBAction func facebookButton(sender: AnyObject) {
        let urlString = "http://facebook.com"
        let url = NSURL(string: urlString)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func GoogleButton(sender: AnyObject) {
        let urlString = "http://google.com"
        let url = NSURL(string: urlString)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBOutlet weak var LoginEmailLabel: UITextField!
    @IBOutlet weak var LoginPasswordLabel: UITextField!
    
    
    @IBAction func LoginButtonPressed(sender: AnyObject) {
        
        if LoginEmailLabel.text!.isEmpty {
            print("EmailAddress Can Not be Empty!")
            
             alertAction("Please enter your Email address to continue.")
            
             return
        }
        
        if LoginPasswordLabel.text!.isEmpty{
            print("Password Can Not be Empty!")
            
            alertAction("Please enter your password to continue.")
        

            return
        }
        
        LCUser.logIn(username: LoginEmailLabel.text!, password:LoginPasswordLabel.text! , completion: { ( result ) in
            if result.isSuccess{
                let user = result.object! as LCUser
                self.dismissViewControllerAnimated(true, completion: nil)
                
                self.delegate?.loginSucess()
                
                print(user.username?.value)
                
            }else{
                print("login fail")
                
                self.alertAction("Your Email address or password is incorrect, please try again.")
                

            }
            
        })
             
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("登录界面已显示")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func alertAction(info_string: String){
        
        let alertController = UIAlertController(title: "Mention:", message: info_string, preferredStyle:  .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: {
            action in
            print("Confirm Pressed")
        })
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
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
