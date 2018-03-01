//
//  Extensions.swift
//  Converter
//
//  Created by Тимур Фатыхов on 15/02/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//
//  Developers:
//  Timur Fatykhov
//  Sergei Kononov

import Foundation

extension Character {
    var asciiValue: UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
}
