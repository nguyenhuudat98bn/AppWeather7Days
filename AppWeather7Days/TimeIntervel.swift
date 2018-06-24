//
//  TimeIntervel.swift
//  AppWeather7Days
//
//  Created by nguyễn hữu đạt on 6/23/18.
//  Copyright © 2018 nguyễn hữu đạt. All rights reserved.
//

import Foundation
extension TimeInterval{
    func dayWeek(identifier: String) -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: identifier)
        return dateFormatter.string(from: date)
        
}
}
