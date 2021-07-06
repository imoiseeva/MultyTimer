//
//  CountDown.swift
//  MultyTimer
//
//  Created by Irina Moiseeva on 04.07.2021.
//

import Foundation

class CountDown {
    
    static var shared = CountDown()
    
   private var realTimer = Timer()
   private var totalSecond = 10
    private var label = ""
    
       func startTimer() {
           realTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
       }
       
    @objc func updateTime(data: Timers){
        guard let time = data.seconds else { return }
        totalSecond = Int(time)!
        print(timeFormatted(totalSecond))
        label = String(timeFormatted(totalSecond))
        if totalSecond != 0 {
            totalSecond -= 1
        } else {
            endTimer()
        }
    }
       
       func endTimer() {
           realTimer.invalidate()
       }
       
       func timeFormatted(_ totalSeconds: Int) -> String {
           let seconds: Int = totalSeconds % 60
           return String(format: "0:%02d", seconds)
       }
private init(){}

}
