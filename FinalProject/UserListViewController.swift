//
//  UserListViewController.swift
//  FinalProject
//
//  Created by zhangji on 11/25/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var UserList: UITableView!
    
    var uaList: [UserAccount] = []
    var ourDefaults = UserDefaults.standard
    
    var dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        
        initTable()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        self.navigationItem.rightBarButtonItem = addButton
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        // Do any additional setup after loading the view.
    }

    func initTable(){
        for i in 0...11 {
            uaList.append(UserAccount(String, UInt, NSDate, [TestResult])!)
        }
    }
    
    func addItem(_ sender: AnyObject){
        performSegue(withIdentifier: "AddHit", sender: UserListViewController.self)
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        UserList.setEditing(editing, animated: animated)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            uaList.remove(at: (indexPath as NSIndexPath).row)
            
            UserList.reloadData();
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return uaList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? MyTableViewCell
        
        // Configure the cell...
 //       cell?.IndexLabel?.text = String(mmList[indexPath.row].number)
 //       cell?.StateLabel?.text = mmList[indexPath.row].NPstate
 //       cell?.NPLabel.text = mmList[indexPath.row].NPname
 //       cell?.DateLabel.text = mmList[indexPath.row].date
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
