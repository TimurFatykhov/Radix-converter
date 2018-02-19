//
//  DecimalToRadixClass.swift
//  RadixConverter
//
//  Created by Sergei on 06.02.2018.
//
//  Developers:
//  Sergei Kononov
//  Timur Fatykhov

import Foundation

class DecimalToRadixConverter {
    
    init() {
        
    }
    //Convert number to Char
    public static func int_to_String(number:Int) -> Character {
        var charNumber = String(number)
        //Переводим числа в 16ую систему
        switch charNumber {
        case "10":
            charNumber = "A"
        case "11":
            charNumber = "B"
        case "12":
            charNumber = "C"
        case "13":
            charNumber = "D"
        case "14":
            charNumber = "E"
        case "15":
            charNumber = "F"
        default: break
        }
        return Character(charNumber)
    }
    
    //Convert number in decimal to P radix
    public static func int_to_P(number:Int, base:Int) -> String {
        var number = number
        var stack:String = "" // Place for write numbers in P radix
        var modNumber:Character = " " //One number in P radix
        var checkMinus:Bool = false
        if (number<0) {
            checkMinus = true
        }
        number = Int(abs(number))
        //loop for getting number in P radix
        repeat {
            modNumber = self.int_to_String(number: number%base)
            stack.append(modNumber)
            number/=base
        } while (number != 0)
        //reverse number for result
        stack = String(stack.reversed())
        if checkMinus {
            stack = "-" + stack //if negative number then added "-" at first item
        }
        return stack
    }
    
    //Convert fractional number in decimal to P radix
    public static func frac_to_P(number:Double, base:Int, correctness: Int) -> String {
        if correctness == 0{
            return " "
        }
        let number:Double = Double(abs(number))
        let numberOfPlaces:Double = Double(correctness)
        let powerOfTen:Double = pow(10.0, numberOfPlaces)
        var checkMinus:Bool = false
        if (number<0) {
            checkMinus = true
        }
        //get fractional part
        var targetedDecimalPlaces:Double = round((number.truncatingRemainder(dividingBy: 1.0)) * powerOfTen) / powerOfTen
        var stack:String = ""
        var mulNumber:Character = " "
        //loop for getting frac number in P radix
        repeat {
            targetedDecimalPlaces*=Double(base)
            mulNumber = self.int_to_String(number: Int(targetedDecimalPlaces))
            targetedDecimalPlaces = round((targetedDecimalPlaces.truncatingRemainder(dividingBy: 1.0)) * powerOfTen) / powerOfTen
            stack.append(mulNumber)
        } while (targetedDecimalPlaces != 0) && (Int(stack.count) != Int(numberOfPlaces))
        if checkMinus {
            stack = "-0." + stack //if negative number then added "-" at first item
        } else {
            stack = "0." + stack
        }
        return stack
    }
    
    // unite frac_to_P and int_to_P
    public static func convert(number:Double, toBase base:Int, accuracy: Int) -> String {
        var fracPart = String(self.frac_to_P(number: number, base: base, correctness: accuracy))
        fracPart.removeFirst()
        let string = String(self.int_to_P(number: Int(number), base: base)) + fracPart
        return string
    }
    
}
