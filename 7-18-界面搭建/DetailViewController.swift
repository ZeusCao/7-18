//
//  DetailViewController.swift
//  7-18-界面搭建
//
//  Created by Zeus on 2017/7/18.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var titlrText: UITextField!
    
    var person: Person?
    
    // 完成回调的闭包属性
    //var completionCallBack: () -> () ?   ——》代表闭包的返回值可选
    // 闭包是可选的，
    var completionCallBack: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 判断person是否有值
        if person != nil {
            nameText.text = person?.name
            phoneText.text = person?.phone
            titlrText.text = person?.title
        }
       
    }

    
    @IBAction func saveAction(_ sender: Any) {
        
        // 判断person是否为nil,如果为空就新建
        if person == nil {
            person = Person()
        }
        
        
        
        
        // 2.用UI更新person的内容
        person?.name = nameText.text
        person?.phone = phoneText.text
        person?.title = titlrText.text
        
        // 3.执行闭包回调，返回刷新数据
        // oc中执行block前都必须判断是否有值，否则会造成崩溃
        // swift中 ！强行解包(不要用xcode帮助修订的！) ；  ？可选解包（如果闭包为nil，就什么也不做）
        completionCallBack?()
        
        // 4 返回上一级界面
        // 方法的返回值没有使用
        // 报错：方法的返回值没有使用  “_" 可以忽略一切不关心的内容
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
