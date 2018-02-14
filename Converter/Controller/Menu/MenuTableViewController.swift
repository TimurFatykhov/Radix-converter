//
//  MenuViewController.swift
//  Converter
//
//  Created by Тимур Фатыхов on 05/02/2018.
//  Copyright © 2018 Fatykhov&Suslov. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.row){
        case 0: if let cell = tableView.dequeueReusableCell(withIdentifier: "convertCell", for: indexPath) as? ConvertTableViewCell{
            cell.iconImage.image = #imageLiteral(resourceName: "orion_calc.png");
            cell.titleLabel.text = "Converter";
            return cell;
        } else{
            return tableView.dequeueReusableCell(withIdentifier: "convertCell", for: indexPath)
        }
            
        case 1: if let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as? HistoryTableViewCell
        {
            cell.iconImage.image = #imageLiteral(resourceName: "orion_history.png");
            cell.titleLabel.text = "History";
            return cell;
        } else{
            return tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        }
            
        case 2: if let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath) as? AboutTableViewCell{
            cell.iconImage.image = #imageLiteral(resourceName: "orion_about.png");
            cell.titleLabel.text = "About";
            return cell;
        } else{
            return tableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath)
        }
            
        default: return tableView.dequeueReusableCell(withIdentifier: "convertCell", for: indexPath);
        }
    }
}
