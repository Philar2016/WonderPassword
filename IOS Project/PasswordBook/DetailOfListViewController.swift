//
//  DetailOfListViewController.swift
//  
//
//  Created by LiangMinglong on 8/08/2016.
//
//

import UIKit

class DetailOfListViewController: UIViewController {
    
    @IBOutlet weak var AccountLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var TypeLabel: UILabel!
    @IBOutlet weak var UsernameLabel: UILabel!
    
    var user_selected_index:Int = 0
    var selected_user_name:String = ""
    var selected_account: String = ""
    var selected_password: String = ""
    var selected_type: String = ""
    var objectID: String = ""
    
    var edit_delegate: EditPasswordViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("user selected index is \(user_selected_index) user name is \(selected_user_name)")
        // Do any additional setup after loading the view.
        
        AccountLabel.text = "Account: \(selected_account)"
        //PasswordLabel.text = "Password: \(selected_password)"
        PasswordLabel.text = "Password: \(AESCrypt.decrypt(selected_password, password: "123"))"
        UsernameLabel.text = "Username : \(selected_user_name)"
        TypeLabel.text = "Type: \(selected_type)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditPassword" {
            
            let editViewController = segue.destinationViewController as! EditPasswordViewController
            
            editViewController.delegate = edit_delegate
            
            editViewController.editUsername = selected_user_name
            editViewController.editAccount = selected_account
            editViewController.editPassword = AESCrypt.decrypt(selected_password, password: "123")
            editViewController.editType = selected_type
            editViewController.object_id = objectID
            editViewController.selectedIndex = user_selected_index
            
            
        }
    }



}
