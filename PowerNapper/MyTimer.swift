//
//  MyTimer.swift
//  PowerNapper
//
//  Created by Lo Howard on 5/7/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import Foundation

class MyTimer: NSObject {
    
    var timeRemaining: TimeInterval?
    var timer: Timer?
    
    var isOn: Bool {
        return timeRemaining != nil
    }
    
    var timeAsString: String {
        let timeRemaining = Int(self.timeRemaining ?? 20 * 60)
        let minutesRemaining = timeRemaining / 60
        let secondsRemaining = timeRemaining - (minutesRemaining * 60)
        return String(format: "%02d : %02d", arguments: [minutesRemaining, secondsRemaining])
    }
    
    func secondTicked() {
        guard let timeRemaining = timeRemaining else { return }
        if timeRemaining > 0 {
            self.timeRemaining = timeRemaining - 1
            print(timeRemaining)
        } else {
            timer?.invalidate()
            self.timeRemaining = nil
        }
    }
    
    func startTimer(time: TimeInterval) {
        if !isOn {
            timeRemaining = time
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                    self.secondTicked()
                })
            }
        }
    }
    
    func stopTimer() {
        if isOn {
            timeRemaining = nil
        } 
    }
    
    
}
