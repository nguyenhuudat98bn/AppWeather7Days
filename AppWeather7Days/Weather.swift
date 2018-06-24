//
//  Weather.swift
//  AppWeather7Days
//
//  Created by nguyễn hữu đạt on 6/22/18.
//  Copyright © 2018 nguyễn hữu đạt. All rights reserved.
//

import Foundation
class Weather{
    var name: String
    var country: String
    var localtime_epoch: TimeInterval
    var temp_c: Double
    var forecastday: [Weatherday] = []
    var condition: Condition
    var weatherday: Weatherday
    init(dict: DICT) {
        let location = dict["location"] as? DICT ?? [:]
         name = location["name"] as? String ?? "-1"
        country = location["country"] as? String ?? "-1"
        localtime_epoch = location["localtime_epoch"] as? TimeInterval ?? -1
        let current = dict["current"] as? DICT ?? [:]
        let condition = current["condition"] as? DICT ?? [:]
        self.condition = Condition(dict: condition)
        let weatherday = dict["weatherday"] as? DICT ?? [:]
        self.weatherday = Weatherday(dict: weatherday)
        temp_c = current["temp_c"] as? Double ?? -1000
        let forecast = dict["forecast"] as? DICT ?? [:]
        let forecastday = forecast["forecastday"] as? [DICT] ?? []
        for wetherday in forecastday {
            self.forecastday.append(Weatherday(dict: wetherday))
        }
    }
}
struct Condition {
    var text: String
    var icon: String
    init(dict: DICT) {
        text = dict["text"] as? String ?? "-1"
        icon = "http:" + (dict["icon"] as? String ?? "-1")
        
    }
}
struct Weatherday {
    var date_epoch: TimeInterval
    var maxtemp_c: Double
    var mintemp_c: Double
    var condition: Condition
    init(dict: DICT) {
        let day = dict["day"] as? DICT ?? [:]
        maxtemp_c = day["maxtemp_c"] as? Double ?? -1000
        mintemp_c = day["mintemp_c"] as? Double ?? -1000
        date_epoch = dict["date_epoch"] as? TimeInterval ?? -1
        let condition = day["condition"] as? DICT ?? [:]
        self.condition = Condition(dict: condition)
        
        
    }
}
