//
//  TimerViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 27/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

class TimerViewModel: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    var secondsLeft: TimeInterval!
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        setSecondsToZero()
    }
    
    @IBAction func plusSecondsButtonTapped(_ sender: Any) {
        addSecondsToTimer()
    }
    
    @IBAction func minusSecondsButtonTapped(_ sender: Any) {
        minusSecondsToTimer()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTimer(notification:)), name: .timer, object: nil)
    }
    
    // Prijme notifikaciu z NotificationCenter a nastavi secondsLeft v tomto view
    @objc func updateTimer(notification: Notification) {
        self.secondsLeft = notification.object as? TimeInterval
        timerLabel.text = String(secondsLeft)
        
        // Ak dojdem na 0 zmizne view pretoze timer skoncil
        if self.secondsLeft <= 0 {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func addSecondsToTimer(){
        self.secondsLeft += 30
        NotificationCenter.default.post(name: .timerUpdated, object: self.secondsLeft)
    }
    
    func minusSecondsToTimer() {
        self.secondsLeft -= 30
        NotificationCenter.default.post(name: .timerUpdated, object: self.secondsLeft)
    }
    
    func setSecondsToZero() {
        self.secondsLeft = 0
        NotificationCenter.default.post(name: .timerUpdated, object: self.secondsLeft)
    }
}

extension Notification.Name {
    static let timerUpdated = Notification.Name(rawValue: "TimerUpdated")
}
