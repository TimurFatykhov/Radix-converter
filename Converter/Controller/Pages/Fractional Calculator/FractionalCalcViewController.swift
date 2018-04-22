//
//  FractionalCalcViewController.swift
//  Converter
//
//  Created by Сергей on 01/03/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//

import UIKit

enum Operation:String {
    case Add = "+"
    case Sub = "-"
    case Div = "/"
    case Mul = "*"
    case NULL = "Null"
}

class FractionalCalcViewController: UIViewController {

    
    @IBOutlet weak var output: UILabel!
    
    var runningNumber = ""
    
    var leftValue = ""
    var leftValueNumerator = ""
    var leftValueDenumerator = ""
    
    var rightValue = ""
    var rightValueNumerator = ""
    var rightValueDenumerator = ""
    
    var result = ""
    var currentOperation:Operation = .NULL
	
	var processor = Processor()
	var number = Fraction()
	var memory = Memory()
	
	
	@IBAction func memoryClear(_ sender: ButtonCustom) {
		memory.resetMemory()
	}
	
	@IBAction func addMemory(_ sender: ButtonCustom) {
		memory.addResult(value: output.text!)
	}
	
	@IBAction func removeMemory(_ sender: ButtonCustom) {
		memory.removeMemory()
	}
	
	@IBAction func readMemory(_ sender: ButtonCustom) {
		output.text = memory.getMemory()
	}
	
	
	
	
	
	
	
	
	
	
    
    @IBAction func numberPressed(_ sender: ButtonCustom) {
        if runningNumber.count <= 8 {
            runningNumber += "\(sender.tag)"
            output.text = runningNumber
        }
        
        
    }
    
    @IBAction func clearButton(_ sender: ButtonCustom) {
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .NULL
        output.text = "0"
		self.number.numerator = 0
		self.number.denominator = 1
    }
    
    @IBAction func dotButton(_ sender: ButtonCustom) {
        if runningNumber.count <= 7 {
            runningNumber += "."
            output.text = runningNumber
        }
    }
    
    @IBAction func splitButton(_ sender: ButtonCustom) {
        if runningNumber.count <= 7 {
            runningNumber += "/"
            output.text = runningNumber
        }
    }
    
    @IBAction func equalPressed(_ sender: ButtonCustom) {
		
		operation(operation: currentOperation)
    }
    @IBAction func addPressed(_ sender: ButtonCustom) {
		operation(operation: .Add)
    }
    @IBAction func subPressed(_ sender: ButtonCustom) {
		operation(operation: .Sub)
    }
    @IBAction func multiplyPressed(_ sender: ButtonCustom) {
		operation(operation: .Mul)
    }
    @IBAction func divPressed(_ sender: ButtonCustom) {
		operation(operation: .Div)
    }  
    @IBAction func sqr(_ sender: ButtonCustom) {
		var splitNumber = output.text?.split(separator: "/", maxSplits: 2, omittingEmptySubsequences: false)
		if splitNumber?.count == 2 {
			var leftValueNumerator1 = String(splitNumber![0])
			var leftValueDenumerator1 = String(splitNumber![1])
			var a = Int(leftValueNumerator1)
			var b = Int(leftValueDenumerator1)
			output.text = String(a!*a!) + "/" + String(b!*b!)
			runningNumber = output.text!
		}
		else {
			splitNumber?.append("1")
			var leftValueNumerator1 = String(splitNumber![0])
			var leftValueDenumerator1 = String(splitNumber![1])
			var a = Int(leftValueNumerator1)
			var b = Int(leftValueDenumerator1)
			output.text = String(a!*a!) + "/" + String(b!*b!)
			runningNumber = output.text!
		}
		
		
    }
	
	
	func operation(operation: Operation) {
		if currentOperation == .NULL {
			//работаем с левой частью
			if leftValue == "" {
				leftValue = runningNumber
			}
			currentOperation = operation
			runningNumber = ""
			
			
			
			var splitNumber = leftValue.split(separator: "/", maxSplits: 2, omittingEmptySubsequences: false)
			if splitNumber.count == 2 {
				leftValueNumerator = String(splitNumber[0])
				leftValueDenumerator = String(splitNumber[1])
			}
			else {
				splitNumber.append("1")
				leftValueNumerator = String(splitNumber[0])
				leftValueDenumerator = String(splitNumber[1])
			}
			


			
			self.number = Fraction(numerator: Double(leftValueNumerator)!, denominator: Double(leftValueDenumerator)!)
		
		
		
		} else {
			if runningNumber != "" {
				rightValue = runningNumber
				var splitNumber = rightValue.split(separator: "/", maxSplits: 2, omittingEmptySubsequences: false)
				if splitNumber.count == 2 {
					rightValueNumerator = String(splitNumber[0])
					rightValueDenumerator = String(splitNumber[1])
				}
				else {
					splitNumber.append("1")
					rightValueNumerator = String(splitNumber[0])
					rightValueDenumerator = String(splitNumber[1])
				}
				runningNumber = ""
			}
			
			if rightValue == "" {
				rightValueNumerator = leftValueNumerator
				rightValueDenumerator = leftValueDenumerator
				
			}
			
			
			/////////////////////////////////
			if currentOperation == .Add {
				self.number.add(number: Fraction(numerator: Double(rightValueNumerator)!, denominator: Double(rightValueDenumerator)!))
				self.processor.result = self.number
				result = "\(Int(self.processor.result.numerator))/\(Int(self.processor.result.denominator))"
			}else if currentOperation == .Sub {
				self.number.subtract(f: Fraction(numerator: Double(rightValueNumerator)!, denominator: Double(rightValueDenumerator)!))
				self.processor.result = self.number
				result = "\(Int(self.processor.result.numerator))/\(Int(self.processor.result.denominator))"
			}else if currentOperation == .Mul {
				self.number.multiply(number: Fraction(numerator: Double(rightValueNumerator)!, denominator: Double(rightValueDenumerator)!))
				self.processor.result = self.number
				result = "\(Int(self.processor.result.numerator))/\(Int(self.processor.result.denominator))"
			}else if currentOperation == .Div {
				self.number.divide(number: Fraction(numerator: Double(rightValueNumerator)!, denominator: Double(rightValueDenumerator)!))
				self.processor.result = self.number
				result = "\(Int(self.processor.result.numerator))/\(Int(self.processor.result.denominator))"
			}
			///////////////////
			
			
			var splitNumber = result.split(separator: "/")
			leftValueNumerator = String(splitNumber[0])
			leftValueDenumerator = String(splitNumber[1])
			self.number = Fraction(numerator: Double(leftValueNumerator)!, denominator: Double(leftValueDenumerator)!)
			
			if leftValueDenumerator == "1" {
				output.text = result
				output.text?.removeLast()
				output.text?.removeLast()
			} else {
				output.text = result
			}

		}

		
		currentOperation = operation
		
		
	}

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil
        {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        output.text = "0"
        output.layer.masksToBounds = true
        output.layer.cornerRadius = 20
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
