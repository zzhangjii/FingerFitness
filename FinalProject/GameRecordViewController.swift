//
//  GameRecordViewController.swift
//  FinalProject
//
//  Created by zhangji on 11/25/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import UIKit

class GameRecordViewController: UIViewController {

    @IBAction func backbutton(_ sender: UIButton) {
        ourDefaults.set(record_name, forKey: "record_name")
        ourDefaults.set(record_date, forKey: "record_date")
        ourDefaults.set(record_playtime, forKey: "record_playtime")
        ourDefaults.set(record_totalhit, forKey: "record_totalhit")
        ourDefaults.set(record_correcthit, forKey: "record_correcthit")
    }
    @IBOutlet weak var bestscore: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var playtime: UILabel!
    @IBOutlet weak var totalhit: UILabel!
    @IBOutlet weak var correcthit: UILabel!
    
    @IBOutlet weak var yourscore: UILabel!
    @IBOutlet weak var yourplaytime: UILabel!
    @IBOutlet weak var youtcorrecthit: UILabel!
    @IBOutlet weak var yourtotalhit: UILabel!
    var ourDefaults = UserDefaults.standard
    var dateFormatter = DateFormatter()
    
    var record_name = ""
    var record_date = Date()
    var record_playtime = 0
    var record_totalhit = 0
    var record_correcthit = 0
    var record_bestscore = 0
    
    var user_playtime = 0
    var user_totalhit = 0
    var user_correcthit = 0
    var user_bestscore = 0
    
    var game_result:GameResult? = nil
    
    
    override func viewDidLoad() {

        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        user_playtime = (game_result?.user_playtime)!
        user_totalhit = (game_result?.user_totalHit)!
        user_correcthit = (game_result?.user_correctHit)!
        user_bestscore = (user_correcthit*50*user_playtime)/(user_totalhit+1)
    
        if let check = ourDefaults.object(forKey: "record_totalhit") as? Int {
            
            record_name = (ourDefaults.object(forKey: "record_name") as? String)!
            record_date = (ourDefaults.object(forKey: "record_date") as? Date)!
            record_playtime = (ourDefaults.object(forKey: "record_playtime") as? Int)!
            record_totalhit = check //(ourDefaults.object(forKey: "record_totalhit") as? Int)!
            record_correcthit = (ourDefaults.object(forKey: "record_correcthit") as? Int)!
            record_bestscore = (record_correcthit*50*record_playtime)/(record_totalhit+1)
            
            bestscore.text = String(record_bestscore)
            name.text = record_name
            date.text = dateFormatter.string(from: record_date)
            playtime.text = String(record_playtime)
            totalhit.text = String(record_totalhit)
            correcthit.text = String(record_correcthit)
            
            yourscore.text = String(user_bestscore)
            yourplaytime.text = String(user_playtime)
            yourtotalhit.text = String(user_totalhit)
            youtcorrecthit.text = String(user_correcthit)
            
            if(user_bestscore > record_bestscore){
                Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.showAlert), userInfo: nil, repeats: false)
            }

        }
        else{
            
            record_date = Date()
            record_playtime = user_playtime
            record_totalhit = user_totalhit
            record_correcthit = user_correcthit
            record_bestscore = user_bestscore
            
            bestscore.text = String(record_bestscore)
            name.text = record_name
            date.text = dateFormatter.string(from: record_date)
            playtime.text = String(record_playtime)
            totalhit.text = String(record_totalhit)
            correcthit.text = String(record_correcthit)
            
            yourscore.text = String(user_bestscore)
            yourplaytime.text = String(user_playtime)
            yourtotalhit.text = String(user_totalhit)
            youtcorrecthit.text = String(user_correcthit)
            
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.showAlert1), userInfo: nil, repeats: false)
        }
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "1.png")!)
    }

    func showAlert(alert: UIAlertController){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Congratulations!\nYou beat the record!\n", message: "Enter the champion's name:", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.record_name = (textField?.text!)!
            self.record_date = Date()
            self.record_playtime = self.user_playtime
            self.record_totalhit = self.user_totalhit
            self.record_correcthit = self.user_correcthit
            self.record_bestscore = self.user_bestscore
            self.bestscore.text = String(self.record_bestscore)
            self.name.text = self.record_name
            self.date.text = self.dateFormatter.string(from: self.record_date)
            self.playtime.text = String(self.record_playtime)
            self.totalhit.text = String(self.record_totalhit)
            self.correcthit.text = String(self.record_correcthit)
       
            }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    
    }
    func showAlert1(alert: UIAlertController){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "You are the first player!\n", message: "Enter the champion's name:", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.record_name = (textField?.text!)!
            self.name.text = self.record_name
            
            }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
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
