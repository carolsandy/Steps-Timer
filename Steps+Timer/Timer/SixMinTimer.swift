//
//  TimerUseCase.swift
//  Steps+Timer
//
//  Created by Carmen Salvador on 17/09/20.
//  Copyright © 2020 Carmen Salvador. All rights reserved.
//

import Foundation

class SixMinTimer {
    
    var timer = Timer()
    var (minutes, seconds) = (0,0)
    var timeUpdater: ((Int, Int, Bool) -> Void)?

    let timeInterval = 1
    let testDuration = 6
    
    func startTimer(timeUpdater: @escaping (Int, Int, Bool) -> Void) {
        self.timeUpdater = timeUpdater
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.trackTime), userInfo: nil, repeats: true)
    }
    
    @objc private func trackTime() {
        seconds += timeInterval
        if seconds > 59 {
            minutes += timeInterval
            seconds = 0
        }
        
        if minutes == testDuration {
            updateTime(isTestFinished: true)
            timer.invalidate()
        } else {
            updateTime()
        }
    }
    
    private func updateTime(isTestFinished: Bool = false) {
        if let updater = timeUpdater {
            updater(minutes, seconds, isTestFinished)
        }
    }
}
