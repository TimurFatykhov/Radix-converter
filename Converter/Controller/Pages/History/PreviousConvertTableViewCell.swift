//
//  PreviousConvertTableViewCell.swift
//  Converter
//
//  Created by Тимур Фатыхов on 05/02/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//

import UIKit

class PreviousConvertTableViewCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var srcBaseLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var dstBaseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
