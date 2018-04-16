//
//  InputUserInfoViewController.swift
//  FinalProject
//
//  Created by zhangji on 12/3/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import UIKit

class InputUserInfoViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate{
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var YOBLabel: UILabel!
    @IBOutlet weak var userNamebox: UITextField!

    @IBOutlet weak var YOBpicker: UIPickerView!
    @IBOutlet weak var Genderpicker: UIPickerView!
    
    
    var cur_date = NSDateComponents()
    var Agelist = ["under 25", "25 - 34", "35 - 44", "45 - 54", "55 - 65", "above 65"]
    let Genderlist = ["Male", "Female", "I'd rather no to say"]
    var user_name = ""
    var Age =  ""
    var Gender = ""

    @IBAction func Cancel(_ sender: UIButton) {
        user_name = ""
    }
    
    @IBAction func Save(_ sender: UIButton) {
        user_name = userNamebox.text!
        Age = Agelist[YOBpicker.selectedRow(inComponent: 0)]
        Gender = Genderlist[Genderpicker.selectedRow(inComponent: 0)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "3.png")!)
        YOBpicker.dataSource = self
        YOBpicker.delegate = self
        Genderpicker.dataSource = self
        Genderpicker.delegate = self

        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return Agelist.count
        }
        else{
            return Genderlist.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return Agelist[row]
        }
        else{
            return Genderlist[row]
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNamebox.resignFirstResponder()
        

        return true}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveUserInfo" {
            let destVC = segue.destination as? UserListTableViewController
            destVC?.input_username = user_name
            destVC?.YOB = YOB
        }
        
      */
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    

}
