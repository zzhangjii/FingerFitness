//
//  UserViewController.swift
//  FinalProject
//
//  Created by zhangji on 11/25/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    var user_index = -1

    @IBAction func StartButton(_ sender: UIButton) {
        performSegue(withIdentifier: "start", sender: UserViewController.self)
    }
    @IBAction func CheckRecordButton(_ sender: UIButton) {
        performSegue(withIdentifier: "checkrecord", sender: UserViewController.self)
    }
    
    @IBAction func exitUser(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "1.png")!)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "start"{
            let destVC = segue.destination as? TestViewController
            destVC?.user_index = self.user_index
        }
        else if segue.identifier == "checkrecord"{
            let destVC = segue.destination as? RecordViewController
            destVC?.user_index = self.user_index
        }
        
    }
    @IBAction func unwindFromTestView(sender:UIStoryboardSegue) {
        print("\(self.user_index)HAHAHHAH");
        if sender.source is RecordViewController {
            
            let sVC = sender.source as? RecordViewController
            self.user_index = (sVC?.user_index)!
        }
        
    }
    


}
