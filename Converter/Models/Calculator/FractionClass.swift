//
//  FractionalClass.swift
//  Converter
//
//  Created by Сергей on 02/03/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//

import Foundation


class Fraction {
    var numerator: Double = 0.0
    var denominator: Double = 1.0
    
    init(numerator: Double, denominator: Double) {
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
        var u = numerator * Double(sign)
        var v = denominator
        var r: Int
        while v != 0 {
            r = Int(u.truncatingRemainder(dividingBy: v))
            u = v
            v = Double(r)
        }
        numerator /= u * Double(sign)
        denominator /= u
    }
    
    
    func add(number: Fraction) {
        self.numerator = numerator * number.denominator + number.numerator * denominator
        self.denominator = denominator * number.denominator
        self.reduce()
    }
    
    func sqr() {
        self.multiply(number: self.copy())
    }
    
    func multiply(number: Fraction){
        self.numerator = numerator * number.numerator
        self.denominator = denominator * number.denominator
        self.reduce()
    }
    
    func divide(number: Fraction) {
		self.numerator = numerator * number.denominator
        self.denominator = denominator * number.numerator
        self.reduce()
    }
    
    func subtract(f: Fraction) {
       	self.numerator = numerator * f.denominator - denominator * f.numerator
        self.denominator = denominator * f.denominator
        self.reduce()
    }
	
	func revert() {
		let temp: Double = self.denominator
		self.denominator = self.numerator
		self.numerator = temp
	}
	
	func minus() {
		self.multiply(number: Fraction(numerator: -1, denominator: 1))
	}
	
	
	
	
	func copy() -> Fraction {
		return Fraction(numerator: self.numerator, denominator: self.denominator)
	}
    
    
}
