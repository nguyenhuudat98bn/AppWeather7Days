//
//  ViewController.swift
//  AppWeather7Days
//
//  Created by nguyễn hữu đạt on 6/22/18.
//  Copyright © 2018 nguyễn hữu đạt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var countryText: UILabel!
    @IBOutlet weak var conditionText: UILabel!
    @IBOutlet weak var temp_cText: UILabel!
    @IBOutlet weak var todayIsText: UILabel!
    @IBOutlet weak var maxTemcText: UILabel!
    @IBOutlet weak var minTemcText: UILabel!
    @IBOutlet weak var todayText: UILabel!
    var weatherDays: [Weatherday] = []
    var weather24H:[Hourly] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.loadApiWeather { (weather) in
            self.todayIsText.text = weather.localtime_epoch.dayWeek(identifier: "VI")
            self.nameText.text = weather.name
            self.countryText.text = weather.country
            self.conditionText.text = weather.condition.text
            self.temp_cText.text = String(weather.temp_c)
            self.weatherDays = weather.forecastday
            self.maxTemcText.text = String(self.weatherDays[0].maxtemp_c) + "°"
            self.minTemcText.text = String(self.weatherDays[0].mintemp_c) + "°"
        
            
            self.tableView.reloadData()
        }
        DataService.weather24Hours { (weather24Hours) in
            for i in weather24Hours.arrHourly {
                if Int(i.time) ?? 0 >= Int(DataService.hoursH())!*100 {
                    self.weather24H.append(i)
                }
            self.collectionView.reloadData()
            }
           
        }
//        let jeremyGif = UIImage.gifImageWithName("anhdong")
//        let imageView = UIImageView(image: jeremyGif)
//        imageView.frame = CGRect(x: 20.0, y: 50.0, width: self.view.frame.size.width - 40, height: 150.0)
//        view.addSubview(imageView)
//        collectionView.setup(numberOfItem: 3 , padding: 10, scrollDirection: .vertical)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDays.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.maxText.text = String(weatherDays[indexPath.row].maxtemp_c) + "°"
        cell.minText.text = String(weatherDays[indexPath.row].mintemp_c) + "°"
        cell.daytext.text = weatherDays[indexPath.row].date_epoch.dayWeek(identifier: "VI")
        cell.imageIcon.download(from: weatherDays[indexPath.row].condition.icon)
      return cell
}
}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather24H.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CollectionViewCell
        cell.temp_cText.text = weather24H[indexPath.row].tempC + "°"
        cell.imageView.download(from: weather24H[indexPath.row].value)
        cell.currentText.text = "\( Int(weather24H[indexPath.row].time)! / 100).00"
        return cell
    }

    
}
extension UICollectionView {
    func setup(numberOfItem: CGFloat, padding: CGFloat, scrollDirection: UICollectionViewScrollDirection) {
        let sizeCollectionView = scrollDirection == .vertical ?  self.bounds.width : self.bounds.height
        let sizeItem = (sizeCollectionView - padding*2 - padding*(numberOfItem-1))/numberOfItem
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: sizeItem, height: sizeItem)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.scrollDirection = scrollDirection
        self.collectionViewLayout = layout
    }
}

