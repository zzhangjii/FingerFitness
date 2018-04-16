//
//  MainViewController.swift
//  FinalProject
//
//  Created by zhangji on 11/25/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "1.png")!)
        // Do any additional setup after loading the view.
    }

    @IBAction func GoToTest(_ sender: UIButton) {
    }
    @IBAction func GoToPlay(_ sender: UIButton) {
    }

    @IBAction func Exit(_ sender: UIButton) {
      //  UIApplication *app = [UIApplication, sharedApplication];
      //  [app performSelector:@selector(suspend)];
        
        //wait 2 seconds while app is going background
     //   [NSThread sleepForTimeInterval:2.0];
        
        //exit app when app is in background
        exit(0);
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unwindFromUserList(sender:UIStoryboardSegue) {
        
        
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
