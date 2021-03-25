//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let toDoModel = ToDoModel()
    
    @IBOutlet var toDoItemsList: UITableView!
    
    override func viewDidLoad() {
        // Retrieve any stored ToDoItems
        super.viewDidLoad()
        toDoModel.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoModel.count()
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = toDoModel.retrieveItem(at: indexPath.row)
        
        cell.textLabel!.text = item.toDo
        cell.accessoryType = item.checked ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods - Row Selected
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Toggle item checked, save data, reload view, play deselection animation
        toDoModel.toggleItemChecked(at: indexPath.row)
        toDoModel.saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "What's next?", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // Add item to model, reload view
            self.toDoModel.addItem(text: textField.text!)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter your next task."
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - UISearchBarDelegate - Search Bar Delegate

extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoModel.searchItems(searchText: searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.count == 0) {
            toDoModel.retrieveFullToDoItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

//MARK: - ToDoListDelegate - Reload Data via Delegate

extension ToDoListViewController: ToDoListDelegate {
    func reloadData() {
        // Reload current TableView
        DispatchQueue.main.async {
            self.toDoItemsList.reloadData()
        }
    }
}

//MARK: - Setup of ToDoListDelegate Protocol

protocol ToDoListDelegate {
    func reloadData()
}
