//
//  MyDayViewController.swift
//  BP-DIFR
//
//  Created by jkbjhs on 23/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Firebase
import Charts

class MyDayViewController: UIViewController {
    
    @IBOutlet weak var chartView: BarChartView!
    
    var weeks: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weeks = ["11.2", "18.2", "25.2"]
        let workouts = [1.0,2.0,5.0]
        
        setChart(dataPoints: weeks, values: workouts)
    }
    
    // nastavovanie chartu
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        var counter = 0.0
        
        for i in 0..<dataPoints.count {
            counter += 1.0
            let dataEntry = BarChartDataEntry(x: values[i], y: counter)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Times")
        let chartData = BarChartData()
        chartData.addDataSet(chartDataSet)
        chartView.data = chartData
        
    }
    
}
