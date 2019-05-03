//
//  ProgressViewController.swift
//  BP-DIFR
//
//  Created by jkbjhs on 07/04/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import SwiftCharts

class ProgressViewController: UIViewController {
    
    var chartView: BarsChart!
    var bars = [(String, Double)]()
    var exerciseSets = [ExercisesSet]()
    var exerciseSetsNetworkService: ExercisesSetsNetworkService!
    var user: AppUser!
    var exerciseId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseSetsNetworkService = ExercisesSetsNetworkService()
        self.exerciseSetsNetworkService.getAllExerciseSetsByUser(userUid: AppUser.shared.uid!, exerciseId: self.exerciseId) { (result) in
            DispatchQueue.main.async {
                if let exerciseSets = result {
                    self.bars = self.createBarsFromExerciseSetsArray(exerciseSetsArray: exerciseSets)
                    
                    self.setUpChart()
                }
            }
        }
    }
    
    func setUpChart() {
        let chartConfig = BarsChartConfig(valsAxisConfig: ChartAxisConfig(from: 0, to: 120, by: 5))
        let frame = CGRect(x: 0, y: 270, width: self.view.frame.width, height: 450)
        let chart = BarsChart(frame: frame,
                              chartConfig: chartConfig,
                              xTitle: "Sets",
                              yTitle: "Kg Lifted",
                              bars: self.bars,
                              color: UIColor.blue,
                              barWidth: 15)
        
        self.view.addSubview(chart.view)
        self.chartView = chart
    }
    
    // Zoberiem pole setov, prekonvertujem na typove pole, vytvorim tak parameter pre graf v tvar X -> String, Y -> Double
    func createBarsFromExerciseSetsArray(exerciseSetsArray: [ExercisesSet]) -> [(String, Double)] {
        var bars = [(String,Double)]()
        var i = 1
        
        for exerciseSet in exerciseSetsArray {
            bars.append((String(i), Double(exerciseSet.kg ?? 0)))
            i += 1
        }
        
        return bars
    }
}
