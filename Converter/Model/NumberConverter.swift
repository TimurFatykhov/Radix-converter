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
    case incorrectNumbers
    case incorrectBase
}

class NumberConverter
{
    private static let alphabet : Dictionary<Int, String> = [0: "-", 1: ".", 2: "01", 3: "2", 4: "3", 5: "4", 6: "5", 7: "6", 8: "7", 9: "8", 10: "9", 11: "Aa", 12: "Bb", 13: "Cc", 14: "Dd", 15: "Ee", 16: "Ff"]
    private static var correctCharacters : String = ""
    private static var correctSet = CharacterSet(charactersIn: "")
    private static let onlyDotSet : CharacterSet = ["."]
    private static let correctBaseRange : Range = 0..<17
    
    private static func log(value val : Double, base : Int) -> Double
    {
        return log2(val) / log2(Double(base))
    }
    
    public static func convert(number: String, fromBase srcBase: Int, toBase dstBase: Int) throws -> String
    {
        if ( !(correctBaseRange.contains(srcBase) && correctBaseRange.contains(dstBase)) ){
            throw ConvertionErrors.incorrectBase
        }
        
        correctCharacters = ""
        for i in 0...srcBase{
            correctCharacters += alphabet[i]!
        }
        correctSet = CharacterSet(charactersIn: correctCharacters)
        
        var realPartSize : Double = 0
        if let dotIndex = number.index(of: "."){
            realPartSize = Double(number.distance(from: dotIndex, to: number.endIndex) - 1)
        }
        
        if (number.rangeOfCharacter(from: correctSet.inverted) == nil){
            if (number.components(separatedBy: onlyDotSet).count <= 2){
                switch(srcBase, dstBase)
                {
                case let (from, to) where from == to:
                    return number
                case (10, let to):
                    let accuracy = realPartSize * log(value: 10, base: to) + 0.49
                    return DecimalToRadixConverter.convert(number: Double(number)!, toBase: to, accuracy: Int(round(accuracy)))
                case (let from, 10):
                    if realPartSize == 0{
                        return String(Int(RadixToDecimalConverter.convert(number: number, fromBase: from)))
                    }else{
                        return String(RadixToDecimalConverter.convert(number: number, fromBase: from))
                    }
                case let(from, to):
                    var accuracy = realPartSize * log(value: Double(from), base: 10) + 0.49
                    let decimal = RadixToDecimalConverter.convert(number: number, fromBase: from)
                    accuracy = realPartSize * log(value: 10, base: to) + 0.49
                    return DecimalToRadixConverter.convert(number: decimal, toBase: to, accuracy: Int(round(accuracy)))
                }
            }else{
                throw ConvertionErrors.muchDots
            }
        }else{
            throw ConvertionErrors.incorrectNumbers
        }
    }
}
