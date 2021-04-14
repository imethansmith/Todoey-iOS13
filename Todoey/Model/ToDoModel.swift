//
//  ToDoModel.swift
//  Todoey
//
//  Created by Ethan Smith on 19/03/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

class ToDoModel {
    
    var toDoListArray = [ToDoItem]()
    var coreDataContext = StorageStateController.coreDataContext
    var delegate: ToDoListDelegate!
    var category: String?
    
    init(selectedCategory: String) {
        category = selectedCategory
        retrieveFullToDoItems(category: category!)
    }
    
    func retrieveFullToDoItems(category: String) {
        toDoListArray = StorageStateController.fetchToDoItemsArray(searchCategory: category)
        
        // If delegate has been initialised
        if delegate != nil {
            delegate.reloadData()
        }
    }
    
    func retrieveItem(at: Int) -> ToDoItem {
        return toDoListArray[at]
    }
    
    func addItem(text: String, category: Category) {
        let newItem = ToDoItem(context: coreDataContext)
        newItem.toDo = text
        newItem.checked = false
        newItem.parentCategory = category
        
        toDoListArray.append(newItem)
        
        // Save appended list
        saveItems()
    }
    
    func searchItems(searchText: String) {
        if let result = StorageStateController.searchItem(searchCategory: category!, searchText: searchText) {
            toDoListArray = result
        } else {
            print("No items found.")
        }
        delegate.reloadData()
    }
    
    func toggleItemChecked(at: Int) {
        toDoListArray[at].checked = !toDoListArray[at].checked
//        toDoItemContext.delete(ToDoListArray[at])
//        ToDoListArray.remove(at: at)
        
        // Save list with toggled item
        saveItems()
    }
    
    func count() -> Int {
        return toDoListArray.count
    }
    
    func saveItems() {
        delegate.reloadData()
        StorageStateController.saveContext()
    }
}
