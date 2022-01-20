//
//  SelectAdditionTableViewController.swift
//  Car exhibition
//
//  Created by Наталья Шарапова on 14.01.2022.
//

import UIKit

class SelectAdditionTableViewController: UITableViewController {
    
    var addition: Addition?
    
    // Create the delegate property
    var delegate: SelectAdditionTableViewControllerProtocol?
}

extension SelectAdditionTableViewController /*: UITableViewDataSourse */ {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Addition.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdditionCell", for: indexPath)
        
        let addition = Addition.all[indexPath.row]
        
        cell.textLabel?.text = addition.name
        cell.detailTextLabel?.text = "id: \(addition.id)"
        cell.accessoryType = addition == self.addition ? .checkmark : .none
        
        return cell
    }
}

extension SelectAdditionTableViewController /*: UITableViewDelegate */  {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        addition = Addition.all[indexPath.row]
        
        // Call the protocol's method
        delegate?.didSelect(addition: addition!)
        tableView.reloadData()
    }
}
