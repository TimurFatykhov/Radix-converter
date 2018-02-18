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
    
    private static func log(value val : Double, base : Int) -> Double
    {
        return log2(val) / log2(Double(base))
    }
    
    public static func convert(number: String, fromBase srcBase: Int, toBase dstBase: Int) throws -> String
    {
        if (!correctBaseRange.contains(srcBase) && correctBaseRange.contains(dstBase)){
            throw ConvertionErrors.incorrectBase
        }
        
        var realPartSize : Double = 0
        if let dotIndex = number.index(of: "."){
            realPartSize = Double(number.distance(from: dotIndex, to: number.endIndex) - 1)
        }
        print("\(number) -> \(realPartSize)")
        
        if (number.rangeOfCharacter(from: correctSet.inverted) == nil){
            if (number.components(separatedBy: onlyDotSet).count <= 2){
                switch(srcBase, dstBase)
                {
                case let (from, to) where from == to:
                    return number
                case (10, let to):
                    let accuracy = realPartSize * log(value: 10, base: to) + 0.5
                    print(Int(round(accuracy)))
                    return DecimalToRadixConverter.convert(number: Double(number)!, toBase: to, accuracy: Int(round(accuracy))) // hardCode here!!!!
                case (let from, 10):
                    return String(RadixToDecimalConverter.convert(number: number, fromBase: from))
                case let(from, to):
                    var accuracy = realPartSize * log(value: Double(from), base: 10) + 0.5
                    let decimal = RadixToDecimalConverter.convert(number: number, fromBase: from)
                    print(Int(round(accuracy)))
                    accuracy = realPartSize * log(value: 10, base: to) + 0.5
                    print(Int(round(accuracy)))
                    return DecimalToRadixConverter.convert(number: decimal, toBase: to, accuracy: Int(round(accuracy)))// hardCode here!!!!
                }
            }else{
                throw ConvertionErrors.muchDots
            }
        }else{
            throw ConvertionErrors.incorrectCharacters
        }
    }
}
