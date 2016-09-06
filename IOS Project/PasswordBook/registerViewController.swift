//
//  registerViewController.swift
//  
//
//  Created by LiangMinglong on 3/08/2016.
//
//

import UIKit
import LeanCloud

class registerViewController: UIViewController {

    @IBOutlet weak var NameLabel: UITextField!
    @IBOutlet weak var EmailAddressLabel: UITextField!
    @IBOutlet weak var PasswordLabel: UITextField!
    @IBOutlet weak var ConfirmPasswordLabel: UITextField!
    
    @IBAction func loginNowButtonPressed(sender: AnyObject) {
        
    self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func RegisterButtonPressed(sender: AnyObject) {
        
        if NameLabel.text!.isEmpty {
            print("Username Can Not be Empty")
            return
        }
        if EmailAddressLabel.text!.isEmpty {
            print("EmailAddress Can Not be Empty!")
            return
        }
        if PasswordLabel.text!.isEmpty{
            print("Password Can Not be Empty!")
            return
        }
        if ConfirmPasswordLabel.text!.isEmpty{
            print("Confirm Password Can Not be Empty!")
            return
        }
        if PasswordLabel.text != ConfirmPasswordLabel.text {
            print("Wrong Password!!")
            return
        }
        
        let randomUser = LCUser()
        randomUser.set("nick_name", value: LCString(NameLabel.text!))
        randomUser.username = LCString(EmailAddressLabel.text!)
        randomUser.email = LCString(EmailAddressLabel.text!)
        randomUser.password = LCString(PasswordLabel.text!)
        randomUser.signUp { (result) in
            if result.isSuccess {
                print("Register Successfully!")
                self.alertAction("Register Successfully, Do you need Touch ID?")
                
            }else{
                print("Register UnSuccessfully! \(result.error)")
                
            }
        }
        
    }
    
    //添加一个提示框
    func alertAction(info_string: String){
        
        let alertController = UIAlertController(title: "Mention:", message: info_string, preferredStyle:  .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .Default,
                                     handler: {
                                        action in
                                        self.goToTouchID()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

    func goToTouchID(){
        print("you click ok, then go to the TouchID page")
        performSegueWithIdentifier("showTouchID", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
