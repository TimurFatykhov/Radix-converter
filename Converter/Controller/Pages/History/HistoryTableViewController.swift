//
//  HistoryTableViewController.swift
//  Converter
//
//  Created by Тимур Фатыхов on 05/02/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryTableViewController: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    typealias HistoryIndex = ReversedRandomAccessIndex<Results<Convertion>>;
    let realm = try! Realm()
    lazy var history = realm.objects(Convertion.self)
    lazy var recordCount = realm.objects(Convertion.self).count
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return realm.objects(Convertion.self).count
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
}
