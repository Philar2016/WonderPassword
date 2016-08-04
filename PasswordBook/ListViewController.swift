//
//  ListViewController.swift
//  PasswordBook
//
//  Created by LiangMinglong on 1/08/2016.
//  Copyright © 2016 LiangMinglong. All rights reserved.
//

import UIKit
import LeanCloud

class ListViewController: UITableViewController ,UISearchBarDelegate{
    
    var todos = Array<LCObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let query = LCQuery(className: "TodoFolder")
        // 执行查找
        query.find({ (result) in
            if(result.isSuccess){
                // 获取 Todo 数组
                self.todos = result.objects!
                //刷新表格
                self.tableView.reloadData()
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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
        cell.user_name_label.text = "用户名：" + user_name.value;
        cell.pass_word_label.text = "密码：" + user_password.value;
        cell.site_name_label.text = "帐号:" + user_account.value;
        cell.user_type_label.text = "类型：" + user_type.value
        // Configure the cell...

        return cell
    }
 
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        <#code#>
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
