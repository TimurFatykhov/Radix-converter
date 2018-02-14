//
//  ConverterViewController.swift
//  Converter
//
//  Created by Тимур Фатыхов on 05/02/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//

import UIKit
import RealmSwift

class ConverterViewController: UIViewController {
    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var srcBaseTextField: UITextField!
    @IBOutlet weak var dstBaseTextField: UITextField!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let realm = try!Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            let result = try NumberConverter.convert(number: numberTextField.text!, srcBase: Int(srcBaseTextField.text!)!, dstBase: Int(dstBaseTextField.text!)!)
            resultTextLabel.text = String(result)
            let convertion = Convertion(srcNumber: numberTextField.text!, dstNumber: result, srcBase: Int(srcBaseTextField.text!)!, dstBase: Int(dstBaseTextField.text!)!, date: Date())

            try? realm.write {
                realm.add(convertion)
            }
            

        } catch ConvertionErrors.couldNotConvert {
            resultTextLabel.text = "could not convert"
        } catch ConvertionErrors.wrongBase {
            resultTextLabel.text = "wrong base"
        } catch {
            resultTextLabel.text = "some error occurred"
        }
    }
}
