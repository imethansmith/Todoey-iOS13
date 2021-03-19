//
//  MainModelController.swift
//  Todoey
//
//  Created by Ethan Smith on 19/03/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

class StorageStateController {
    static let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDoItems.plist")
}

//MARK: - Saving and Reading of Saved Data (ToDoItem Array)

extension StorageStateController {
    static func saveData(toDoItems: [ToDoItem]) {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(toDoItems)
            try data.write(to: StorageStateController.dataFilePath!)
        } catch {
            print("Error encoding saved data array: \(error)")
        }
    }
    
    static func retrieveToDoItems() -> [ToDoItem] {
        if let data = try? Data(contentsOf: StorageStateController.dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                return try decoder.decode([ToDoItem].self, from: data)
            } catch {
                print("Error decoding items. \(error)")
            }
        }
        return [ToDoItem]()
    }
}
