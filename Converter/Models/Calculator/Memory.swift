//
//  Memory.swift
//  Converter
//
//  Created by Сергей on 23/04/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//

import Foundation

class Memory {
	var memory: [String] = []
	
	func addResult(value: String) {
		self.memory.append(value)
	}
	
	func removeMemory() {
		self.memory.removeLast()
	}
	
	func getMemory() -> String {
		return self.memory.last!
	}
	
	func resetMemory() {
		self.memory = []
	}
}
