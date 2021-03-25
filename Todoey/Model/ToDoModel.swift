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
    
    init() {
        retrieveFullToDoItems()
    }
    
    func retrieveFullToDoItems() {
        toDoListArray = StorageStateController.fetchToDoItemsArray()
        
        // If delegate has been initialised
        if delegate != nil {
            delegate.reloadData()
        }
    }
    
    func addItem(text: String) {
        let newItem = ToDoItem(context: coreDataContext)
        newItem.toDo = text
        newItem.checked = false
        
        toDoListArray.append(newItem)
        
        // Save appended list
        saveItems()
    }
    
    func retrieveItem(at: Int) -> ToDoItem {
        return toDoListArray[at]
    }
    
    func searchItems(searchText: String) {
        if let result = StorageStateController.searchItem(searchText: searchText) {
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
