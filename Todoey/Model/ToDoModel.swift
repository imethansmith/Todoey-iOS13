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
    
    init() {
        ToDoListArray = StorageStateController.retrieveToDoItems()
    }
    
    func addItem(text: String) {
        ToDoListArray.append(ToDoItem(toDo: text))
        
        // Save data
        saveItems()
    }
    
    func retrieveItem(at: Int) -> ToDoItem {
        return ToDoListArray[at]
    }
    
    func toggleItemChecked(at: Int) {
        ToDoListArray[at].checked = !ToDoListArray[at].checked
    }
    
    func saveItems() {
        StorageStateController.saveData(toDoItems: self.ToDoListArray)
    }
    
    func count() -> Int {
        return ToDoListArray.count
    }
}
