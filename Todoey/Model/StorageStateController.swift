//
//  MainModelController.swift
//  Todoey
//
//  Created by Ethan Smith on 19/03/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import UIKit

class StorageStateController {
    static let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDoItems.plist")
    
    static let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

//MARK: - Saving and Reading of Saved Data (ToDoItem Array)

extension StorageStateController {
    static func saveData(toDoItems: [ToDoItem]) {
        do {
            try coreDataContext.save()
        } catch {
            print("Error encoding saved data array: \(error)")
        }
    }
    
//    static func retrieveToDoItems() -> [ToDoItem] {
//        if let data = try? Data(contentsOf: StorageStateController.dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                return try decoder.decode([ToDoItem].self, from: data)
//            } catch {
//                print("Error decoding items. \(error)")
//            }
//        }
//        return [ToDoItem]()
//    }
}
