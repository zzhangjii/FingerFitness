//
//  TestViewController.swift
//  FinalProject
//
//  Created by zhangji on 11/25/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var testimage: UIImageView!
    @IBOutlet weak var testimage1: UIImageView!
    @IBOutlet weak var touch0: UILabel!
    @IBOutlet weak var touch1: UILabel!
    @IBOutlet weak var TIMER: UILabel!
    @IBOutlet weak var TIMER1: UILabel!
    
    var user_index = -1
    var test_result: TestResult? = nil
    var timer = Timer()
    var TIMER0 = Timer()
    var counter = 150
    var touchArray = [(Double, Int)]()
    var inTime = false
    var running = false
    var totalHit = 0
    var lftHit = 0
    var rhtHit = 0
    var checkSeq = true
    var correctHit = 0
    var temp_results: [TestResult] = []
    var hit_time = 150
    var hit_times: [Int] = []
    @IBAction func START(_ sender: UIButton) {
        if(!running){
            hit_time = 150
            hit_times = []
            running = true
            inTime = true
            TIMER0 = Timer(timeInterval: 15, target: self, selector: #selector(TestViewController.updateFinal), userInfo: nil, repeats: true)
            timer = Timer(timeInterval: 0.1, target: self, selector: #selector(TestViewController.updateCounter), userInfo: nil, repeats: true)
            RunLoop.current.add(TIMER0, forMode: RunLoopMode.commonModes)
            RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        }
    }
    func updateFinal(){
        timer.invalidate()
        TIMER0.invalidate()
        counter = 150
        running = false
        inTime = false
        let currentTime = NSDateComponents()
        test_result = TestResult(_: currentTime, _ : 15, _ : totalHit, _: lftHit, _: rhtHit)
        totalHit = 0
        lftHit = 0
        rhtHit = 0
        checkSeq = true
        correctHit = 0
        updateText()
        touch0.text = String(lftHit)
        touch1.text = String(rhtHit)
        showResults()
    }

    func updateCounter() {
        testimage.isHighlighted = false;
        testimage1.isHighlighted = false;
        counter -= 1
        updateText()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "1.png")!)
    //  testimage.image = UIImage(named: "0.jpg")
      //  testimage1.image = UIImage(named: "1.jpg")
        updateText()
        // Do any additional setup after loading the view.
    }
    
    func updateText() {
        let SEC = counter/10;
        let MSEC = counter%10;
        var SECString = ""
        var MSECString = ""
        if(SEC < 10){ SECString = "0"+String(SEC)}
        else{SECString = String(SEC)}
        MSECString = String(MSEC)
        TIMER.text = SECString
        TIMER1.text = MSECString
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(inTime){
            let touch = touches.first
        
            if touch?.view?.tag == 10 {
                testimage.isHighlighted = true;
                totalHit+=1
                lftHit+=1
                touch0.text = String(lftHit)
                if checkSeq {
                    checkSeq = false
                    correctHit+=1
                }
                hit_times.append(hit_time - counter)
                hit_time = counter
                
            }
            else if touch?.view?.tag == 20 {
                testimage1.isHighlighted = true
                totalHit+=1
                rhtHit+=1
                touch1.text = String(rhtHit)
                if ((!checkSeq)||(totalHit==0)){
                    checkSeq = true
                    correctHit+=1
                }
                hit_times.append(hit_time - counter)
                hit_time = counter
            }
            else {
                totalHit+=1
            }
        }
    }
    
    
    func showResults() {
        performSegue(withIdentifier: "showTestResult", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitTest(_ sender: UIButton) {
        performSegue(withIdentifier: "exittest", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTestResult" {
            let destVC = segue.destination as? TestResultViewController
            destVC?.user_index = self.user_index
            destVC?.test_result = self.test_result
            destVC?.hit_time = self.hit_times
        }
        else if segue.identifier == "exittest"{
            let destVC = segue.destination as? UserViewController
            destVC?.user_index = self.user_index
        }

    }
    @IBAction func unwindFromSaveResultView(sender:UIStoryboardSegue) {
        
        
    }
    @IBAction func unwindFromCancelResultView(sender:UIStoryboardSegue) {
        
        
    }
}
