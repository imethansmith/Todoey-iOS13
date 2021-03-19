//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy eggs", "Win life"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        // Restore UserDefaults saved text
        if let items = defaults.stringArray(forKey: "ToDoListArray") {
            itemArray = items
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel!.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let selectedRowAcessory = tableView.cellForRow(at: indexPath) {
            if selectedRowAcessory.accessoryType == .checkmark {
                selectedRowAcessory.accessoryType = .none
            } else {
                selectedRowAcessory.accessoryType = .checkmark
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "What's next?", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // What happens once user chooses to add an item
            print(textField.text!)
            self.itemArray.append(textField.text!)
            
            self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter your next task."
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

