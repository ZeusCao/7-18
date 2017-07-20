//
//  ListTableViewController.swift
//  7-18-界面搭建
//
//  Created by Zeus on 2017/7/18.
//  Copyright © 2017年 Zeus. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    // 实例化联系人数组
    var personList = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadData { (list) in
            print(list)
            
            // 拼接数组 注意：闭包中定义好的代码在需要的时候执行，需要self. 来指定语境
           self.personList += list
            // 刷新表格
            self.tableView.reloadData()
        }
    }
    
    private func loadData(completion:@escaping (_ list:[Person]) -> ()) -> (){
        DispatchQueue.global().async {
            print("正在努力加载中。。。。")
            Thread.sleep(forTimeInterval: 1.0)
            var arrayM = [Person]()
            for i in 0..<20 {
                let p = Person()
                p.name = "zhangsan-\(i)"
                p.phone = "1860" + String(format: "%06d", arc4random_uniform(1000000))
                p.title = "boss"
                arrayM.append(p)
            }
            
            // 主线程回调
            DispatchQueue.main.async(execute: { 
                // 回调，执行闭包
                completion(arrayM)
            })
        }
    }
    
    //MARK ----- 数据源方法 ---
        override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return personList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = personList[indexPath.row].name
        cell.detailTextLabel?.text = personList[indexPath.row].phone
        return cell
        
    }
    
    
    // MARK --- 代理方法 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 执行segue
        performSegue(withIdentifier: "list2detail", sender: indexPath)
    }
    
    
    //MARK---- 控制器跳转方法
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 类型转换（强转）
        // swift中除了string之外，绝大多数使用as需要？或者！
        // as! / as? 直接根据前面的返回值确认 这里不是可选类型用！
        // 注意 if let 、 guard let 这些判空语句，一律使用as？
        let vc = segue.destination as! DetailViewController
        // 设置选中的person 
        if let indexpath = sender as? IndexPath {
            // indexPath一定有值
            vc.person = personList[indexpath.row]
            
            // 设置编辑完成的闭包
            vc.completionCallBack = {
                // 刷新指定行
                self.tableView.reloadRows(at: [indexpath], with: .automatic)
            }
        }
        else
        {
            // 新建个人记录（此处VC强引用闭包，闭包中强引用VC，造成循环引用）
            vc.completionCallBack = { [weak vc] in
                
                // 1. 获取明细控制器的person （因为是可选类型）
                guard let p = vc?.person else {
                    return
                }
                
                
                // 2. 插入到数组顶部
                self.personList.insert(p, at: 0)
                
                // 3. 刷新列表
                self.tableView .reloadData()
                
                
            }
            
        }
    
        
    }
    
    
    
    // 加号按钮添加联系人
    @IBAction func newPersonAction(_ sender: Any) {
        
        // 执行segue跳转界面
        performSegue(withIdentifier: "list2detail", sender: nil)
        
    }
    
    
    
    

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
