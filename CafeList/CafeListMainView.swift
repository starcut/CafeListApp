//
//  CafeListMainView.swift
//  CafeList
//
//  Created by stardust on 2017/06/07.
//  Copyright © 2017年 stardust. All rights reserved.
//

import UIKit

class CafeListMainView: UITableViewController {
    var window: UIWindow?
    
    var cafeListBiz = CafeListBiz()
    var naviController :UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // 新規登録ボタン
        let addNewListButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewListButtonPushed(sender:)))
        self.navigationItem.rightBarButtonItem = addNewListButton
        
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButtonItem
    }

    func addNewListButtonPushed(sender: UIButton){
        let listDataRegisterView : UIViewController = ListDataRegisterView()
        listDataRegisterView.modalTransitionStyle = .crossDissolve
        self.naviController?.pushViewController(listDataRegisterView, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CafeListBiz.listItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")

        //cell.textLabel!.text = "\(CafeListBiz.listItems[indexPath.row])"
        cell.detailTextLabel?.text = "URL"
        
        return cell
    }
    
    /*
     Cellが選択された際に呼び出される
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルがタップされた時の処理
        
        let cafeListDetailView: UIViewController = CafeListDetailView()
        cafeListDetailView.modalTransitionStyle = .crossDissolve
        self.naviController?.pushViewController(cafeListDetailView, animated: true)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.window?.rootViewController != nil){
            
        }
        else{
            // ナビゲーションバーの設定
            naviController = UINavigationController(rootViewController:self)
            self.window = UIWindow(frame: UIScreen.main.bounds);
            self.window?.rootViewController = naviController
            self.window!.makeKeyAndVisible();
        }
    }
}
