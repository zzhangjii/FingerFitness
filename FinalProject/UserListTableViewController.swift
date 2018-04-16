//
//  UserListTableViewController.swift
//  FinalProject
//
//  Created by zhangji on 11/27/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {

    @IBAction func backbutton(_ sender: UIButton) {
    }
    var users: [UserAccount] = []
    var input_username = ""
    var YOB = -1
    var ourDefaults = UserDefaults.standard
   
    var dateFormatter = DateFormatter()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "3.png")!)
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector (addItem))
        self.navigationItem.rightBarButtonItem = addButton
        if let tempArr = NSKeyedUnarchiver.unarchiveObject(withFile: UserAccount.ArchiveURL.path) as? [UserAccount] {
                users = tempArr
        }
    }

    func addItem(_ sender: AnyObject){
        performSegue(withIdentifier: "AddHit", sender: UserListTableViewController.self)
        
    }
    
    
    func updatePersistentStorage() {
        // persist data
        NSKeyedArchiver.archiveRootObject(users, toFile: UserAccount.ArchiveURL.path)
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
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableCell", for: indexPath) as! MyTableViewCell

        let object = users[(indexPath as NSIndexPath).row]
        cell.Username.text = object.user_name
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "4.png")!)
        return cell
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
            users.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updatePersistentStorage()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sendUser"{
            let destVC = segue.destination as? UserViewController
            let selectedIndexPath = self.tableView.indexPathForSelectedRow
            destVC?.user_index = (selectedIndexPath?.row)!
        }
        
    }
    @IBAction func unwindFromCancel(sender:UIStoryboardSegue) {
        
        
    }
    
    @IBAction func unwindFromDetail(sender:UIStoryboardSegue) {
        if sender.source is InputUserInfoViewController{
            let sVC = sender.source as? InputUserInfoViewController
            users.append(UserAccount((sVC?.user_name)!,NSDateComponents(), [],[],[],tT: [],tD: []))
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData() 
            
            updatePersistentStorage()
        }
        
    }
    

}
