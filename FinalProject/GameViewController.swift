//
//  GameViewController.swift
//  FinalProject
//
//  Created by zhangji on 11/25/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class GameViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate  {
    @IBOutlet weak var key_C4: UIButton!
    @IBOutlet weak var key_B: UIButton!
    @IBOutlet weak var key_A: UIButton!
    @IBOutlet weak var key_G: UIButton!
    @IBOutlet weak var key_F: UIButton!
    @IBOutlet weak var key_E: UIButton!
    @IBOutlet weak var key_D: UIButton!
    @IBOutlet weak var key_C3: UIButton!
    @IBOutlet weak var key_AS: UIButton!
    @IBOutlet weak var key_GS: UIButton!
    @IBOutlet weak var key_FS: UIButton!
    @IBOutlet weak var key_DS: UIButton!
    @IBOutlet weak var key_CS: UIButton!
    @IBOutlet weak var time_picker: UIPickerView!
    
    var A_ID:SystemSoundID = 0
    var AS_ID:SystemSoundID = 0
    var B_ID:SystemSoundID = 0
    var CS_ID:SystemSoundID = 0
    var C3_ID:SystemSoundID = 0
    var C4_ID:SystemSoundID = 0
    var D_ID:SystemSoundID = 0
    var DS_ID:SystemSoundID = 0
    var E_ID:SystemSoundID = 0
    var F_ID:SystemSoundID = 0
    var FS_ID:SystemSoundID = 0
    var G_ID:SystemSoundID = 0
    var GS_ID:SystemSoundID = 0
    let S1: SystemSoundID = 1104
    
    @IBAction func backbutton(_ sender: UIButton) {
    }

    var timer = Timer()
    var counter_max = 0
    var counter = 0
    var running = false
    var inTime = false
    var totalHit = 0
    var correctHit = 0
    var game_result: GameResult? = nil

    var HINT = -1
    var DHINT1 = -1
    var DHINT2 = -1
    var DH = 0
    var counterlist = [15, 30, 45, 60, 90, 120]
    override func viewDidLoad() {
        self.time_picker.dataSource = self
        self.time_picker.delegate = self
        
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/A", ofType: "mp3"))!), &A_ID)
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/A#", ofType: "mp3"))!), &AS_ID)
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/B", ofType: "mp3"))!), &B_ID)
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/C#", ofType: "mp3"))!), &CS_ID)
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/C3", ofType: "mp3"))!), &C3_ID)
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/C4", ofType: "mp3"))!), &C4_ID)
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/D", ofType: "mp3"))!), &D_ID)
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/D#", ofType: "mp3"))!), &DS_ID)
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/E", ofType: "mp3"))!), &E_ID)
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/F", ofType: "mp3"))!), &F_ID)
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/F#", ofType: "mp3"))!), &FS_ID)
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/G", ofType: "mp3"))!), &G_ID)
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: (Bundle.main.path(forResource: "sound/G#", ofType: "mp3"))!), &GS_ID)

        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "2.png")!)

    }

    @IBAction func keyC4(_ sender: UIButton) {
        buttonAction(index: 12, sID: C4_ID)
    }
    @IBAction func keyB(_ sender: UIButton) {
        buttonAction(index: 11, sID: B_ID)
    }
    @IBAction func keyAS(_ sender: UIButton) {
        buttonAction(index: 10, sID: AS_ID)
    }
    @IBAction func keyA(_ sender: UIButton) {
        buttonAction(index: 9, sID: A_ID)
    }
    @IBAction func keyGS(_ sender: UIButton) {
        buttonAction(index: 8, sID: GS_ID)
    }
    @IBAction func keyG(_ sender: UIButton) {
        buttonAction(index: 7, sID: G_ID)
    }
    @IBAction func keyFS(_ sender: UIButton) {
        buttonAction(index: 6, sID: FS_ID)
    }    
    @IBAction func keyF(_ sender: UIButton) {
        buttonAction(index: 5, sID: F_ID)
    }
    @IBAction func keyE(_ sender: UIButton) {
        buttonAction(index: 4, sID: E_ID)
    }
    @IBAction func keyDS(_ sender: UIButton) {
        buttonAction(index: 3, sID: DS_ID)
    }    
    @IBAction func keyD(_ sender: UIButton) {
        buttonAction(index: 2, sID: D_ID)
    }
    @IBAction func keyCS(_ sender: UIButton) {
        buttonAction(index: 1, sID: CS_ID)
    }
    @IBAction func keyC3(_ sender: UIButton) {
        buttonAction(index: 0, sID: C3_ID)
    }

    
    func buttonAction(index : Int, sID: SystemSoundID){
        if(running){
            resetHints()
            totalHit += 1
            if(HINT==index){
                correctHit += 1
                AudioServicesPlaySystemSound(sID)
            }
            else if(HINT > 12&&(DHINT1 == index||DHINT2 == index) ){
                    correctHit += 1
                    DH += 1
                    AudioServicesPlaySystemSound(sID)
            }
            else{
                AudioServicesPlaySystemSound(S1)
            }
        }
        else{
            AudioServicesPlaySystemSound(sID)
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return counterlist.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return String(counterlist[row])
    }
    
    @IBAction func startButton(_ sender: UIButton) {

        if(!running){
            running = true
            inTime = true
            timer = Timer(timeInterval: 1, target: self, selector: #selector(TestViewController.updateCounter), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        }
    }
    func updateCounter() {
        checkDoubleHit()
        counter += 1
        resetHints()
        if(counter == counterlist[time_picker.selectedRow(inComponent: 0)]) {
            timer.invalidate()
            counter = 0
            running = false
            inTime = false
            let currentTime = NSDateComponents()
            game_result = GameResult(_: counterlist[time_picker.selectedRow(inComponent: 0)],_: currentTime, _ : totalHit, _: correctHit)

            print("\(totalHit) ANDANDANDANDADN \(correctHit)")
            totalHit = 0
            correctHit = 0
            showResults()
        }
        updateHints()
        
    }
    func checkDoubleHit(){
        if(HINT == 0 && DHINT1 != DHINT2){
            if(DH == 2){
                totalHit += 2
            }
        }
        DHINT1 = -1
        DHINT2 = -1
        DH = 0
    }
    
    func resetHints(){
        key_C3.isHighlighted = false
        key_CS.isHighlighted = false
        key_D.isHighlighted = false
        key_DS.isHighlighted = false
        key_E.isHighlighted = false
        key_F.isHighlighted = false
        key_FS.isHighlighted = false
        key_G.isHighlighted = false
        key_GS.isHighlighted = false
        key_A.isHighlighted = false
        key_AS.isHighlighted = false
        key_B.isHighlighted = false
        key_C4.isHighlighted = false
    }
    
    func updateHints() {
        let k:Int = Int(arc4random_uniform(1000));
        HINT = k % 15;
        if HINT > 12 {//double touch, it's possible DHINT1 == DHINT2, if so, still single touch
           DHINT1 = Int(arc4random_uniform(100)) % 13
           DHINT2 = Int(arc4random_uniform(100)) % 13
           updateDoubleHintsHighlight()
        }
        else {
            updateHintsHighlight()
        }
    }
    func updateHintsHighlight() {
        if HINT == 0 {
            key_C3.isHighlighted = true
            
        }
        else if HINT == 1 {
            key_CS.isHighlighted = true
            
        }
        else if HINT == 2 {
            key_D.isHighlighted = true
            
        }
        else if HINT == 3{
            key_DS.isHighlighted = true
            
        }
        else if HINT == 4 {
            key_E.isHighlighted = true
        }
        else if HINT == 5 {
            key_F.isHighlighted = true
            
        }
        else if HINT == 6 {
            key_FS.isHighlighted = true
            
        }
        else if HINT == 7{
            key_G.isHighlighted = true
            
        }
        else if HINT == 8 {
            key_GS.isHighlighted = true
        }
        else if HINT == 9{
            key_A.isHighlighted = true
            
        }
        else if HINT == 10 {
            key_AS.isHighlighted = true
            
        }
        else if HINT == 11{
            key_B.isHighlighted = true
            
        }
        else if HINT == 12 {
            key_C4.isHighlighted = true
        }
    }
    func updateDoubleHintsHighlight() {
            if DHINT1 == 0 || DHINT2 == 0 {
                key_C3.isHighlighted = true
                
            }
            if DHINT1 == 1 || DHINT2 == 1 {
                key_CS.isHighlighted = true
                
            }
            if DHINT1 == 2 || DHINT2 == 2 {
                key_D.isHighlighted = true
                
            }
            if DHINT1 == 3 || DHINT2 ==  3{
                key_DS.isHighlighted = true
                
            }
            if DHINT1 == 4 || DHINT2 ==  4 {
                key_E.isHighlighted = true
            }
            if DHINT1 == 5 || DHINT2 ==  5 {
                key_F.isHighlighted = true
                
            }
            if DHINT1 == 6 || DHINT2 ==  6 {
                key_FS.isHighlighted = true
                
            }
            if DHINT1 == 7 || DHINT2 ==  7{
                key_G.isHighlighted = true
                
            }
            if DHINT1 == 8 || DHINT2 ==  8 {
                key_GS.isHighlighted = true
            }
            if DHINT1 == 9 || DHINT2 ==  9{
                key_A.isHighlighted = true
                
            }
            if DHINT1 == 10 || DHINT2 ==  10 {
                key_AS.isHighlighted = true
                
            }
            if DHINT1 == 11 || DHINT2 ==  11{
                key_B.isHighlighted = true
                
            }
            if DHINT1 == 12 || DHINT2 ==  12 {
                key_C4.isHighlighted = true
            }
    }
    
    func showResults() {
        performSegue(withIdentifier: "showGameResult", sender: self)
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
        if segue.identifier == "showGameResult" {
            let destVC = segue.destination as? GameRecordViewController
            destVC?.game_result = self.game_result
        }
    }
    

}
