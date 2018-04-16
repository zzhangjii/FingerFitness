//
//  RecordViewController.swift
//  FinalProject
//
//  Created by zhangji on 11/25/16.
//  Copyright © 2016 zhangji. All rights reserved.
//

import UIKit
import Charts
import CoreGraphics

class RecordViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var lineChartView: LineChartView!

    @IBOutlet weak var barChartView: BarChartView!
    @IBAction func backbutton(_ sender: UIButton) {
        // performSegue(withIdentifier: "exitcheckrecord", sender: self)
    }
    
    var UA:[UserAccount] = []
    var user_index = -1
    var Index:[Double] = []
    var AVG:[Double] = []
 //   var dataSet: ChartDataSet!

    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "2.png")!)
        if let tempArr = NSKeyedUnarchiver.unarchiveObject(withFile: UserAccount.ArchiveURL.path) as? [UserAccount] {
            UA = tempArr
        }
        let ua = UA[user_index]
        if(ua.user_totalHit != []){
        let num = ua.user_totalHit.count
        for i in 0..<num {
            Index.append(Double(i+1))
            AVG.append(Double(1000*(ua.user_testDuration[i])/(ua.user_totalHit[i]+1)))
        }
        self.barChartView.gridBackgroundColor = UIColor.lightGray
        self.barChartView.drawGridBackgroundEnabled = true
        setChart(values: ua.user_totalHit)
        
        self.lineChartView.delegate = self
        // 2
        self.lineChartView.chartDescription?.text = ""
        // 3
        self.lineChartView.chartDescription?.textColor = UIColor.blue
        self.lineChartView.gridBackgroundColor = UIColor.lightGray
        self.lineChartView.drawGridBackgroundEnabled = true
        // 4
        self.lineChartView.noDataText = "No data provided"
        // 5
        setChartData(values: AVG)
        }
        // Do any additional setup after loading the view.
    }

    func setChartData(values : [Double]) {
        // 1 - creating an array of data entries
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0 ..< values.count {
            yVals1.append(ChartDataEntry(x: Double(i), y: AVG[i]))
        }
        // 2 - create a data set with our array
        let set1: LineChartDataSet = LineChartDataSet(values: yVals1, label: "Average Hit Time Interval(ms)")
        set1.axisDependency = .left // Line will correlate with left axis values
        set1.setColor(UIColor.red.withAlphaComponent(0.5)) // our line's opacity is 50%
        set1.setCircleColor(UIColor.red) // our circle will be dark red
        set1.lineWidth = 2.0
        set1.circleRadius = 6.0 // the radius of the node circle
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor.red
        set1.highlightColor = UIColor.white
        set1.drawCircleHoleEnabled = true
        
        //3 - create an array to store our LineChartDataSets
   //     var dataSets : [LineChartDataSet] = [LineChartDataSet]()
  //      dataSets.append(set1)
        
        //4 - pass our months in for our x-axis label value along with our dataSets
        let data: LineChartData = LineChartData()
        data.addDataSet(set1)
     //   data.setValueTextColor(UIColor.white)
        
        //5 - finally set our data
        self.lineChartView.data = data
        
        self.lineChartView.animate(xAxisDuration: 1.0, easingOption: .easeInBounce)
    }
    
    func setChart(values: [Int]) {
        self.barChartView.noDataText = "No data provided"
        self.barChartView.chartDescription?.text = ""
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Total Hit in each test")
        let data = BarChartData()
        data.addDataSet(chartDataSet)
        self.barChartView.data = data
        self.barChartView.animate(yAxisDuration: 1.0, easingOption: .easeInBounce)
        
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
        if segue.identifier == "exitcheckrecord"{
            let destVC = segue.destination as? UserViewController
            destVC?.user_index = self.user_index
        }
    }
    
    

}
