//
//  FractionalClass.swift
//  Converter
//
//  Created by Сергей on 02/03/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//

import Foundation


class Fraction {
    var numerator: Int = 0
    var denominator: Int = 1
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    init() {
    }
// Try to beautiful code
//    private func GCD( first: Int, second: Int) -> Int {
//        var second = second
//        var first = first
//        while (second != 0) {
//            let remaider = first % second
//            first = second
//            second = remaider
//
//        }
//        return first
//    }
    
    private func reduce() {
        
//        var divisor = GCD(first: numerator, second: denominator)
//        if divisor < 0 {
//            divisor *= -1
//        }
//
//        numerator /= numerator * divisor
//        denominator /= denominator
//
//
//
//        guard divisor != 0 else { return (numerator: numerator, denominator: 0) }
//        return (numerator: numerator / divisor, denominator: denominator / divisor)
        
        let sign = numerator >= 0 ? 1:-1
        var u = numerator * sign
        var v = denominator
        var r: Int
        while v != 0 {
            r = u % v
            u = v
            v = r
        }
        numerator /= u * sign
        denominator /= u
    }
    
    
    func add(number: Fraction) -> Fraction {
        var result: Fraction = Fraction()
        result.numerator = numerator * number.denominator + number.numerator * denominator
        result.denominator = denominator * number.denominator
        result.reduce()
        return result
    }
    
    func multiply(number: Fraction) -> Fraction {
        var result: Fraction = Fraction()
        result.numerator = numerator * number.numerator
        result.denominator = denominator * number.denominator
        result.reduce()
        return result
    }
    
    func divide(number: Fraction) -> Fraction {
        var result: Fraction = Fraction()
        result.numerator = numerator * number.denominator
        result.denominator = denominator * number.numerator
        result.reduce()
        return result
    }
    
    func subtract(f: Fraction) -> Fraction {
        var result: Fraction = Fraction()
        result.numerator = numerator * f.denominator - denominator * f.numerator
        result.denominator = denominator * f.denominator
        result.reduce()
        return result
    }
    
    
}
