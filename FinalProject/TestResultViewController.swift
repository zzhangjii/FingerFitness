//
//  TestResultViewController.swift
//  FinalProject
//
//  Created by zhangji on 11/25/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import UIKit
import Charts
import CoreGraphics

class TestResultViewController: UIViewController,ChartViewDelegate {
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var hittotal: UILabel!
    @IBOutlet weak var lfthit: UILabel!
    @IBOutlet weak var rhthit: UILabel!
    @IBOutlet weak var averageT: UILabel!
    @IBOutlet weak var phr: UILabel!
    
    var test_result : TestResult? = nil
    var user_index = -1
    var UA:[UserAccount] = []
    var hit_time:[Int] = []
    override func viewDidLoad() {
        if let tempArr = NSKeyedUnarchiver.unarchiveObject(withFile: UserAccount.ArchiveURL.path) as? [UserAccount] {
            UA = tempArr
        }
        
        super.viewDidLoad()
        self.barChartView.gridBackgroundColor = UIColor.lightGray
        self.barChartView.drawGridBackgroundEnabled = true
        setChart(values: self.hit_time)
        
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "1.png")!)
        let th:Int = (test_result?.test_totalHit)!
        hittotal.text = String(th)
        let lh:Int = (test_result?.test_lftHit)!
        lfthit.text = String(lh)
        let rh:Int = (test_result?.test_rhtHit)!
        rhthit.text = String(rh)
        
        let at:Double = 15000/Double(1 + (test_result?.test_totalHit)!)
        averageT.text = String(format:"%.2f", at)
        let PHR : Double = 100*Double((lh + rh))/Double(th)
        phr.text = String(format:"%.2f", PHR)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Savebutton(_ sender: UIButton) {
        UA[user_index].user_totalHit.append((test_result?.test_totalHit)!)
        UA[user_index].user_lftHit.append((test_result?.test_lftHit)!)
        UA[user_index].user_rhtHit.append((test_result?.test_rhtHit)!)
        UA[user_index].user_testTime.append((test_result?.test_time)!)
        UA[user_index].user_testDuration.append((test_result?.test_duration)!)
        NSKeyedArchiver.archiveRootObject(UA, toFile: UserAccount.ArchiveURL.path)    }

    @IBAction func CancelButton(_ sender: UIButton) {
        
    }
   // MARK: - Navigation

    func setChart(values: [Int]) {
        self.barChartView.noDataText = "No data provided"
        self.barChartView.chartDescription?.text = ""
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(100/values[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Hit Frequency")
        let data = BarChartData()
        data.addDataSet(chartDataSet)
        self.barChartView.data = data
        self.barChartView.xAxis.drawLabelsEnabled = false
        self.barChartView.leftAxis.drawLabelsEnabled = false
        self.barChartView.rightAxis.drawLabelsEnabled = false
        self.barChartView.animate(yAxisDuration: 1.0, easingOption: .easeInBounce)
        
    }
}
