//
//  ToDoModel.swift
//  Todoey
//
//  Created by Ethan Smith on 19/03/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

class ToDoModel {
    
    var ToDoListArray = [ToDoItem]()
    var toDoItemContext = StorageStateController.coreDataContext
    var delegate: ToDoListDelegate!
    
    init() {
        if let pastItems = StorageStateController.retrieveToDoItems() {
            ToDoListArray = pastItems
        }
    }
    
    func addItem(text: String) {
        let newItem = ToDoItem(context: toDoItemContext)
        newItem.toDo = text
        newItem.checked = false
        
        ToDoListArray.append(newItem)
        
        // Save appended list
        saveItems()
    }
    
    func retrieveItem(at: Int) -> ToDoItem {
        return ToDoListArray[at]
    }
    
    func searchItem(searchText: String) {
        if let result = StorageStateController.searchItem(searchText: searchText) {
            ToDoListArray = result
        } else {
            print("No items found.")
        }
        delegate.reloadData()
    }
    
    func toggleItemChecked(at: Int) {
        ToDoListArray[at].checked = !ToDoListArray[at].checked
//        toDoItemContext.delete(ToDoListArray[at])
//        ToDoListArray.remove(at: at)
        
        // Save list with toggled item
        saveItems()
    }
    
    func count() -> Int {
        return ToDoListArray.count
    }
    
    func saveItems() {
        delegate.reloadData()
        StorageStateController.saveToDoItems()
    }
}
