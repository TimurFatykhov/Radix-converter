//
//  ButtonCustom.swift
//  Converter
//
//  Created by Сергей on 11/03/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonCustom: UIButton {
    
    @IBInspectable var button: Bool = false {
        didSet {
            if button {
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if button {
            layer.cornerRadius = frame.height / 2
        }
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
