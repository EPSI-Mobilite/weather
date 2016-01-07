//
//  CellCity.swift
//  Weather
//
//  Created by Quentin Logie on 1/7/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import UIKit

class CellCity:UITableViewCell {
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var cp: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
