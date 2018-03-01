//
//  CalcTableViewCell.swift
//  Converter
//
//  Created by Сергей on 01/03/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//

import UIKit

class CalcTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
