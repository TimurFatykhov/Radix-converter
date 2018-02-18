//
//  ConverterViewController.swift
//  Converter
//
//  Created by Тимур Фатыхов on 05/02/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//
//  Developers:
//  Timur Fatykhov
//  Sergei Kononov

import UIKit
import RealmSwift

class ConverterViewController: UIViewController {
    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var srcBaseTextField: UITextField!
    @IBOutlet weak var dstBaseTextField: UITextField!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var convertButton: UIButton!
    let realm = try!Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        convertButton.layer.cornerRadius = 10
        convertButton.layer.borderWidth = 1
        convertButton.layer.borderColor = UIColor.white.cgColor
        
        if self.revealViewController() != nil
            {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    @IBAction func convert(_ sender: Any) {
        if (numberTextField.text?.isEmpty)! || (srcBaseTextField.text?.isEmpty)! || (dstBaseTextField.text?.isEmpty)! {
            return
        }
        do {
            let result = try NumberConverter.convert(number: numberTextField.text!, fromBase: Int(srcBaseTextField.text!)!, toBase: Int(dstBaseTextField.text!)!)
            resultTextLabel.text = String(result)
            let convertion = Convertion(srcNumber: numberTextField.text!, dstNumber: result, srcBase: Int(srcBaseTextField.text!)!, dstBase: Int(dstBaseTextField.text!)!, date: Date())

            try? realm.write {
                realm.add(convertion)
            }
            

        } catch ConvertionErrors.muchDots {
            resultTextLabel.text = "Much dots"
        } catch ConvertionErrors.incorrectCharacters {
            resultTextLabel.text = "Incorrect number"
        } catch ConvertionErrors.incorrectBase{
            resultTextLabel.text = "Incorrect base"
        }
        catch {
            resultTextLabel.text = "some error occurred"
        }
    }
}
