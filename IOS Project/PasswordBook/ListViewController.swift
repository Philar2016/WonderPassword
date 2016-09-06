//
//  ListViewController.swift
//  PasswordBook
//
//  Created by LiangMinglong on 1/08/2016.
//  Copyright © 2016 LiangMinglong. All rights reserved.
//

import UIKit
import LeanCloud

class ListViewController: UIViewController,UITableViewDelegate,UISearchBarDelegate, UITableViewDataSource, EditPasswordViewControllerDelegate, AddPasswordPackViewControllerDelegate, loginSucessDelegate,passwordDataDelegate {
    
    var todos = Array<LCObject>()
    var password_data_delegate:PasswordData?
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBAction func add_button_pressed(sender: AnyObject) {
        if LCUser.current == nil {
            print("用户未登录")
            self.performSegueWithIdentifier("show_login_controller", sender: self)
        }else{
            print("用户已登录")
            self.performSegueWithIdentifier("new_password_segue", sender: self)
        }
    }
    
    
    @IBOutlet weak var table_view: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sksplash渐变色动画
        //let color_splash_view: SKSplashView = SKSplashView.init(backgroundColor: UIColor.purpleColor(), animationType: SKSplashAnimationType.Zoom)
        //color_splash_view.animationDuration = 3.0
        
        //self.view.addSubview(color_splash_view)
        //color_splash_view.startAnimation()
        //print("splash animation complete")
        
        
        //初始化splash view
        //声明图标
        let splashIcon: SKSplashIcon = SKSplashIcon.init(image: UIImage.init(named: "passwordConfrom.png"), animationType: SKIconAnimationType.Fade)
        //声明动画
        let icon_splash_view: SKSplashView = SKSplashView.init(splashIcon: splashIcon, backgroundColor: UIColor.blackColor(), animationType: SKSplashAnimationType.Zoom)
        
        icon_splash_view.animationDuration = 1.0
        self.view.addSubview(icon_splash_view)
        icon_splash_view.startAnimation()
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        //let dec_str:String = AESCrypt.decrypt(cry_str, password: "123")
        //print("解密后的字符="+dec_str)
        
        password_data_delegate = PasswordData.init()
        password_data_delegate!.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        //let loginViewController = segue.destinationViewController as! ViewController
        //ViewController.delegate = self
        
        if LCUser.current != nil {
            reload_table_view("")
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func  gotpassword(password: NSArray) {
        self.todos = password as! Array<LCObject>
        self.table_view.reloadData()
    }
    
    //定义一个reload_table_view的方法，查询todofolder 然后刷新table_view
    func reload_table_view(search_string:String){
        
        password_data_delegate!.get_user_password(search_string)
        
        //self.todos = PasswordData.get_user_password(search_string)
        //self.table_view.reloadData()
        
        /*
        let query = LCQuery(className: "TodoFolder")
        
        query.whereKey("password_owner", LCQuery.Constraint.EqualTo(value: LCUser.current!))

        if search_string.characters.count > 0 {
            query.whereKey("user_account", LCQuery.Constraint.MatchedSubstring(string: search_string))
        }
        // 执行查找
        query.find({ (result) in
            if(result.isSuccess){
                // 获取 Todo 数组
                self.todos = result.objects!
                //刷新表格
                self.table_view.reloadData()
            }
        })
        */
    }
    
    //查询输入框
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("输入的字符串 = \(searchBar.text)")
        
        if LCUser.current != nil {
          reload_table_view(searchBar.text!)
            
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("当前数据行=\(indexPath.row)")
        //读取视图中的cell
        let cell :PasswordCell = tableView.dequeueReusableCellWithIdentifier("pass_word_cell", forIndexPath: indexPath) as! PasswordCell
        //获取数组的当前值
        let this_password = self.todos[indexPath.row]
        //获取数组中存储的字段值
        let user_name: LCString! = this_password.get("user_name_field")
        let user_account: LCString! = this_password.get("user_account")
        let user_password: LCString! = this_password.get("user_password")
        let user_type: LCString! = this_password.get("user_type")
        //显示到cell上
        cell.Username_label.text = "Username：\(user_name.value)"
        cell.Account_label.text = "Account： \(user_account.value)"
        cell.Password_label.text = "Password:  ******"
        cell.Type_label.text = "Type：\(user_type.value)"

        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    
    /*
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("要搜索的字符是＝\(searchBar.text)")
        
        let query = LCQuery(className: "TodoFolder")
        // 执行查找
        if searchBar.text?.characters.count > 0 {
            query.whereKey("user_name_field", LCQuery.Constraint.MatchedSubstring(string: searchBar.text!))
        }
        query.find({ (result) in
            if(result.isSuccess){
                // 获取 Todo 数组
                self.todos = result.objects!
                //刷新表格
                self.table_view.reloadData()
                /*
                 // 遍历数组
                 for todo in self.todos {
                 // 打印 title
                 let value:LCString! = todo.get("user_name_field")
                 print("value = \(value.value)")
                 }
                 */
            }
        })

    }
    */
    
    
    //设置背景颜色
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = todos.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.8
        return UIColor(red: 25/255.0, green: 25/252.0, blue: 25/255.0, alpha: 1.0)
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
                   forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = colorForIndex(indexPath.row)
    }
    
    
    
    
    
    // Override to support conditional editing of the table view.左滑删除
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.左滑删除
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print("delete table view cell")
        if editingStyle == .Delete {
          
            //获取数组中要删除的数据
            let this_password = self.todos[indexPath.row]
            this_password.delete { (result) in
                
                if(result.isSuccess){
                    // 根据 result.isSuccess 可以判断是否删除成功
                    self.todos.removeAtIndex(indexPath.row)
                    
                    //删除对应的cell
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    
                } else {
                    if (result.error != nil){
                        print(result.error?.reason)
                        // 如果删除失败，可以查看是否当前正确使用了 ACL
                    }
                }
            }
            
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    //列表左滑删除！
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
        
        }
        delete.backgroundColor = UIColor.purpleColor()
        return [delete]

    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // 要显示自定义的action,cell必须处于编辑状态
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // 同时你也需要实现本方法,否则自定义action是不会显示的
        print("你确认了删除按钮")
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            //self.todos?[indexPath.section]?.removeAtIndex(indexPath.row)
            //self.table_view.dataSource.removeAtIndex(indexPath.row)
            self.todos.removeAtIndex(indexPath.row)
            //删除对应的cell
            self.table_view?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
            print("你确认了删除按钮")
        }
       
    }
    */
    
    
    
    // MARK: - Navigation

    // 从listViewController传值Segue到DetailOfListViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "show_detail_view_controller" {
            let cell = sender as! UITableViewCell
            let indexPath = self.table_view.indexPathForCell(cell)
            
            let detailViewController = segue.destinationViewController as! DetailOfListViewController
            
            
            //索引是哪个
            //数组应该是哪个数据
            let this_password = self.todos[indexPath!.row]
            print("用户选择的索引是=\(indexPath?.row)")
            
            let user_name: LCString! = this_password.get("user_name_field")
            let user_account: LCString! = this_password.get("user_account")
            let user_password: LCString! = this_password.get("user_password")
            let user_type: LCString! = this_password.get("user_type")

            detailViewController.user_selected_index = (indexPath?.row)!
            
            detailViewController.edit_delegate = self
            detailViewController.selected_user_name = user_name.value
            detailViewController.selected_account = user_account.value
            detailViewController.selected_password = user_password.value
            detailViewController.selected_type = user_type.value
            detailViewController.objectID = (this_password.objectId?.value)!
            
        } else if(segue.identifier == "new_password_segue"){
            let new_passsword_controller = segue.destinationViewController as! AddPassWordPackController
            new_passsword_controller.delegate = self
            
        } else if(segue.identifier == "show_login_controller"){
            
            let show_login_Controller = segue.destinationViewController as! ViewController
              show_login_Controller.delegate = self
        }
        
    }
    
    
    func loginSucess() {
        reload_table_view("")
    }
    
    func editInfo(controller: EditPasswordViewController, selectedIndex: Int) {
      print("编辑页面返回的索引值=\(selectedIndex)")
        //一个cell刷新
        reload_table_view("")
    }
    
    func new_password_save_success() {
        print("新的密码添加成功了")
        reload_table_view("")
    }
    
}
