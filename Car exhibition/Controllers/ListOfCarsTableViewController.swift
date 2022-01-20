//
//  ListOfCarsTableViewController.swift
//  Car exhibition
//
//  Created by Наталья Шарапова on 16.01.2022.
//

import UIKit

class ListOfCarsTableViewController: UITableViewController {
    
    private let cellManager = CellManager()
    var registrations = [Registration]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registrations = Registration.loadAll() ?? Registration.loadDefaults()
        
        // Changing leftBarButtonItem
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    // Preparing the data for the Add registration controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Checking: is it the necessary segue and selectedPath or not
        guard segue.identifier == "EditSegue" else {
            return
        }
        guard let selectedPath = tableView.indexPathForSelectedRow else {
            return
            
        }
        // Getting registration from this row
        let registration = registrations[selectedPath.row]
        
        // Creating destination for this registration
        let destination = segue.destination as! AddRegistrationTableViewController
        
        //Assigning the data from the selected cell to the emoji property
        destination.registration = registration
    }
}

extension ListOfCarsTableViewController /*: UITableViewDataSource */ {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return registrations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let registration = registrations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell")! as! RegistrationCell
        
        //Assigning the data from the Registration to all labels
        
        cellManager.configure(cell, with: registration)
        
        return cell
    }
    
    // Add possibility to move the cell
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // Moving cells
        let movedRegistration = registrations.remove(at: sourceIndexPath.row)
        registrations.insert(movedRegistration, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
}

extension ListOfCarsTableViewController {
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
        guard segue.identifier == "SaveSegue" else {
            return
        }
        // Data transmission from AddRegistrationTableViewController
        let source = segue.source as! AddRegistrationTableViewController
        
        let registration = source.registration
        
        // If we edited this row (in AddRegistrationTableViewController)
        if let selectedPath = tableView.indexPathForSelectedRow {
            
            // Assigning the data from AddRegistrationTableViewController to the edited cell
            registrations[selectedPath.row] = registration
            
            // Reloading the tableView
            tableView.reloadRows(at: [selectedPath], with: .left)
        } else {
            
            // If we added new registration in AddRegistrationTableViewController
            let indexPath = IndexPath(row: registrations.count, section: 0)
            
            // Add new registration in the [registrations]
            registrations.append(registration)
            
            // Add new row
            tableView.insertRows(at: [indexPath], with: .left)
        }
    }
}

extension ListOfCarsTableViewController /*: UITableViewDelegate*/ {
    
    // Add possibility to delete the cell
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        
        case .delete:
            
            // Deleting the cell
            registrations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        case .insert:
            break
        case .none:
            break
            
        @unknown default:
            print("Unknown case in file \(#file)")
        }
    }
}
