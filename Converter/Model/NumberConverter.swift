//
//  Controller.swift
//  Converter
//
//  Created by Sergey Suslov on 05/02/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//


enum ConvertionErrors: Error {
    case couldNotConvert
    case wrongBase
}

class NumberConverter {

    static let alphabet: [String: Int] = ["0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "a": 10, "b": 11, "c": 12, "d": 13, "e": 14, "f": 15]

    static func convert(number: String, srcBase: Int, dstBase: Int) throws -> String {
        if srcBase < 2 || srcBase > 16 || dstBase < 2 || srcBase > 16 {
            throw ConvertionErrors.wrongBase
        }
        let splitedNumber = number.split(separator: ".")
        if splitedNumber.count > 1 {
            let baseNumber = splitedNumber[0]
            let floatingNumber = splitedNumber[1]
            do {
                let result = try convertToDeciminal(String(baseNumber), base: srcBase)
                let resultFloating = convertFloatingToDeciminal(String(floatingNumber), base: srcBase)
                print(resultFloating)
                let converted = try convertFromDeciminal(Int(result), base: dstBase)
                let convertedFloating = try convertFromDeciminalFloating(resultFloating, base: dstBase)
                let finalString = converted + "." + convertedFloating
                return finalString
            }
            catch ConvertionErrors.couldNotConvert {
                throw ConvertionErrors.couldNotConvert
            }
        } else {
            do {
                let result = try convertToDeciminal(number, base: srcBase)
                return String(Int(result), radix: dstBase)
            }
            catch ConvertionErrors.couldNotConvert {
                throw ConvertionErrors.couldNotConvert
            }
        }
    }
    
    private static func convertFromDeciminal(_ number: Int, base: Int) throws -> String {
        return String(number, radix: base)
    }
    
    private static func convertFromDeciminalFloating(_ number: Float, base: Int) throws -> String {
        var result = ""
        var tmpNumber = number
        print(number)
        print(tmpNumber)
        for _ in 0...4{
            tmpNumber *= Float(base)
            result.append((alphabet.filter({ (key, value) -> Bool in
                return value == Int(tmpNumber)
            }).first?.key)!)
            print(tmpNumber)
            if tmpNumber > 1 {
                tmpNumber -= Float(Int(tmpNumber))
            }
            print(tmpNumber)
        }
        return result
    }

    private static func convertToDeciminal(_ number: String, base: Int) throws -> Float {
        if let result = Int(number, radix: base) {
            return Float(result)
        } else {
            throw ConvertionErrors.couldNotConvert
        }
    }

    private static func convertFloatingToDeciminal(_ number: String, base: Int) ->Float {
        var result: Float = 0
        for (index, value) in Array(number.lowercased()).enumerated() {
            result += pow(Float(base), Float(-1-index)) * Float(alphabet[String(value)]!)
        }
        return result
    }
}








