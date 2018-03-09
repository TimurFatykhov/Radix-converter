//
//  FractionalCalcViewController.swift
//  Converter
//
//  Created by Сергей on 01/03/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//

import UIKit

class FractionalCalcViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil
        {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
