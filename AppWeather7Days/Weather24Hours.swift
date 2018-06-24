//
//  Weather24Hours.swift
//  AppWeather7Days
//
//  Created by nguyễn hữu đạt on 6/23/18.
//  Copyright © 2018 nguyễn hữu đạt. All rights reserved.
//

import Foundation
class Weather24Hours{
    var arrHourly: [Hourly] = []
    init(dict: DICT) {
        let data = dict["data"] as? DICT ?? [:]
        let weather = data["weather"] as? [DICT] ?? []
        let hourly = weather[0]["hourly"] as? [DICT] ?? []
        for hourly24h in hourly{
        let dataHour = Hourly(dict: hourly24h)
            arrHourly.append(dataHour)
        }
    }
}
struct Hourly {
    var tempC: String
    var time: String
    var value: String
    init(dict: DICT) {
        time = dict["time"] as? String ?? "-1"
        tempC = dict["tempC"] as? String ?? "-1"
        let weatherIconUrl = dict["weatherIconUrl"] as? [DICT] ?? []
        value = weatherIconUrl[0]["value"] as? String ?? "-1"
    }
}

