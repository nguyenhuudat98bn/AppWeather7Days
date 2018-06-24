//
//  DataService.swift
//  AppWeather7Days
//
//  Created by nguyễn hữu đạt on 6/22/18.
//  Copyright © 2018 nguyễn hữu đạt. All rights reserved.
//

import Foundation
typealias DICT = Dictionary<AnyHashable,Any>
class DataService{
    class func loadApiWeather(complete: @escaping(Weather)->Void){
        let urlString = Contains.URL_BASE + "key=3fbecdbe09474ea48a1160449181806&q=Hanoi&days=7&lang=vi"
        let url = URL(string: urlString)
        let urlReQuest = URLRequest(url: url!)
        URLSession.shared.dataTask(with: urlReQuest) { (data, _, error) in
            guard error == nil else {return}
            guard let aData = data else {return}
            do{
                guard let reSult = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? DICT else {return}
                DispatchQueue.main.async {
                    complete(Weather(dict: reSult))
                }
            }
            catch{
                print(error.localizedDescription)
                
            }
        }.resume()
    }
    class func weather24Hours(complete: @escaping(Weather24Hours)->Void){
        let urlString = Contains.URL_Wearther + "9d4ce0ef202b42f7a2441904182306&q=Hanoi&format=json&num_of_days=1&tp=1&showlocaltime=yes"
        guard let url = URL(string: urlString) else { return  }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else { return}
            guard let aData = data else {return}
            do{
                guard let reSult = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? DICT else {return}
                DispatchQueue.main.async {
                    complete(Weather24Hours(dict: reSult))
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    class func hoursH() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let timeZone = TimeZone(identifier: "Asia/Hanoi")
        dateFormatter.timeZone = timeZone
         return dateFormatter.string(from: Date())
        
    }
}
