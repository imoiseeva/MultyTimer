//
//  Model.swift
//  MultyTimer
//
//  Created by Irina Moiseeva on 02.07.2021.
//

import Foundation

//struct Model {
//
//    var timerArray = ["Timer1", "Timer2", "Timer3", "Timer4", "Timer5"]
//    var secondsArray = ["10", "20", "30", "40", "50"]
//
//    var timerName: String
//    var time: String
//}

struct Model {
    var timerName: String
    var time: String
}
extension Model {
    static func getTimers() -> [Model] {
        [
            Model(timerName: "Timer1", time: "10"),
            Model(timerName: "Timer2", time: "20"),
            Model(timerName: "Timer3", time: "30"),
            Model(timerName: "Timer4", time: "40"),
            Model(timerName: "Timer5", time: "50")
        ]
    }

}
