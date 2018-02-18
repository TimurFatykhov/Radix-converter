//
//  NumberConverter.swift
//  Converter
//
//  Created by Тимур Фатыхов on 15/02/2018.
//  Copyright © 2018 Fatykhov&Kononov. All rights reserved.
//
//  Developers:
//  Timur Fatykhov
//  Sergei Kononov

import Foundation

enum ConvertionErrors: Error {
    case muchDots
    case incorrectCharacters
    case incorrectBase
}

class NumberConverter
{
    private static let correctSet = CharacterSet(charactersIn: "abcdefABCDEF0123456789.-")
    private static let onlyDotSet : CharacterSet = ["."]
    private static let correctBaseRange : Range = 0..<17
    
    public static func convert(number: String, fromBase srcBase: Int, toBase dstBase: Int) throws -> String
    {
        if (!correctBaseRange.contains(srcBase) && correctBaseRange.contains(dstBase)){
            throw ConvertionErrors.incorrectBase
        }
        
        if (number.rangeOfCharacter(from: correctSet.inverted) == nil){
            if (number.components(separatedBy: onlyDotSet).count <= 2){
                switch(srcBase, dstBase)
                {
                case let (from, to) where from == to:
                    return number
                case (10, let to):
                    return DecimalToRadixConverter.convert(number: Double(number)!, toBase: to, accuracy: 2) // hardCode here!!!!
                case (let from, 10):
                    return String(RadixToDecimalConverter.convert(number: number, fromBase: from))
                case let(from, to):
                    let decimal = RadixToDecimalConverter.convert(number: number, fromBase: from)
                    return DecimalToRadixConverter.convert(number: decimal, toBase: to, accuracy: 4)// hardCode here!!!!
                }
            }else{
                throw ConvertionErrors.muchDots
            }
        }else{
            throw ConvertionErrors.incorrectCharacters
        }
    }
}
