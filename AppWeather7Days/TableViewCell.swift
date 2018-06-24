//
//  TableViewCell.swift
//  AppWeather7Days
//
//  Created by nguyễn hữu đạt on 6/22/18.
//  Copyright © 2018 nguyễn hữu đạt. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var maxText: UILabel!
    @IBOutlet weak var minText: UILabel!
    @IBOutlet weak var daytext: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
