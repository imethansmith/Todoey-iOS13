//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Ethan Smith on 26/03/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    @IBOutlet var categoryList: UITableView!
    let categoryModel = CategoryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryModel.delegate = self
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Create category", message: "Enter a name for this category", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            self.categoryModel.addCategory(type: textField.text!)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter your next task."
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryModel.categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = categoryModel.categoryArray[indexPath.row]
        
        cell.textLabel!.text = item.type
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
                
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryModel.getCategory(at: indexPath.row)
        }
    }
}

//MARK: - CategoryTableViewDelegate

extension CategoryTableViewController: CategoryTableViewDelegate {
    func reloadData() {
        // Reload current TableView
        DispatchQueue.main.async {
            self.categoryList.reloadData()
        }
    }
}

protocol CategoryTableViewDelegate {
    func reloadData()
}
