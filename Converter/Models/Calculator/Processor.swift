//
//  Processor.swift
//  Converter
//
//  Created by Сергей on 09/04/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//

import Foundation

class Processor {
	var result: Fraction
	var current: Fraction
	var operation: String = ""
	
	init() {
		result = Fraction()
		current = Fraction()
		
	}
	
	func DoFunc(op: String) {
		if (op == "SQR") {
			self.current.sqr()
		}
		else if (op == "REV") {
			self.current.revert()
		}
		else if (op == "MIN") {
			self.current.minus()
		}
	}
	
	func DoOp() {
		if (self.operation == "NULL") {
			self.result = self.current.copy()
		}
		else if (self.operation == "Add") {
			self.result.add(number: self.current)
		}
		else if (self.operation == "Sub") {
			self.result.subtract(f: self.current)
		}
		else if (self.operation == "Mul") {
			self.result.multiply(number: self.current)
		}
		else if (self.operation == "Div"){
			self.result.divide(number: self.current)
		}
	}
	
	func ResetOp() {
		self.operation = "NULL"
	}
}
