//
//  HistoryTableViewController.swift
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


class HistoryTableViewController: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let clearAlert = UIAlertController(title: "Clear", message: "All history will be lost.", preferredStyle: UIAlertControllerStyle.alert)
    let realm = try! Realm()
    lazy var history = realm.objects(Convertion.self)
    lazy var recordCount = realm.objects(Convertion.self).count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            let allUploadingObjects = self.realm.objects(Convertion.self)
            try! self.realm.write {
                self.realm.delete(allUploadingObjects)
            }
            self.recordCount = 0
            self.tableView.reloadData()
        }))
        clearAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recordCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "previousConvertCell", for: indexPath) as? PreviousConvertTableViewCell{
            cell.numberLabel.text = history[recordCount - indexPath.row - 1].srcNumber
            cell.srcBaseLabel.text = String(history[recordCount - indexPath.row - 1].srcBase)
            cell.resultLabel.text = history[recordCount - indexPath.row - 1].dstNumber
            cell.dstBaseLabel.text = String(history[recordCount - indexPath.row - 1].dstBase)
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: "previousConvertCell", for: indexPath)
    }
    @IBAction func clearHistory(_ sender: Any) {
        self.present(clearAlert, animated: true, completion: nil)
    }
}
