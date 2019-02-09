//
//  PerformanceOverallViewController.swift
//  fyp
//
//  Created by Wong Cho Hin on 29/1/2019.
//  Copyright © 2019 IK1603. All rights reserved.
//

import UIKit
import Charts
@objc(BarChartFormatter)
public class BarChartFormatter: NSObject, IAxisValueFormatter{
    
    var months: [String]! = ["10", "20", "30", "40", "50", "60", "70", "80", "90", "100"]
    
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        return months[Int(value)]
    }
}

class PerformanceOverallViewController: UIViewController {

    @IBOutlet weak var viewChart: BarChartView!
    var months: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initChart()
        months = ["10", "20", "30", "40", "50", "60", "70", "80", "90", "100"]
        let unitsSold = [5.0, 8.0, 16.0, 30.0, 20.0, 15.0, 12.0, 9.0, 4.0, 1.0]
        
        setChart(dataPoints: months, values: unitsSold)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initChart(){
        
        viewChart.noDataText = "No Data"
        viewChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        viewChart.xAxis.labelPosition = .bottom
        viewChart.chartDescription?.text = ""
        viewChart.xAxis.valueFormatter = self as? IAxisValueFormatter
        viewChart.xAxis.drawLabelsEnabled = true
        
        viewChart.legend.enabled = true
        viewChart.scaleYEnabled = false
        viewChart.scaleXEnabled = false
        viewChart.pinchZoomEnabled = false
        viewChart.doubleTapToZoomEnabled = false
        
        viewChart.leftAxis.axisMinimum = 0.0
        viewChart.leftAxis.axisMaximum = 50.0
        viewChart.highlighter = nil
        viewChart.rightAxis.enabled = false
        viewChart.xAxis.drawGridLinesEnabled = false
        
        
    }
    func setChart(dataPoints: [String], values: [Double]) {
        viewChart.noDataText = "You need to provide data for the chart."
        let formato:BarChartFormatter = BarChartFormatter()
        let xaxis:XAxis = XAxis()
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            //let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            //let dataEntry = BarChartDataEntry(x: Double(i), y: values[i], data: months as AnyObject?)
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i], data: months as AnyObject?)
            formato.stringForValue(Double(i), axis: xaxis)
            dataEntries.append(dataEntry)
        }
        xaxis.valueFormatter = formato
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "number")
        let chartData = BarChartData(dataSet: chartDataSet)
        viewChart.data = chartData
        viewChart.xAxis.valueFormatter = xaxis.valueFormatter
        
    }

}
