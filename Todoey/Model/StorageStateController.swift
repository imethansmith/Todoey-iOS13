//
//  MainModelController.swift
//  Todoey
//
//  Created by Ethan Smith on 19/03/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StorageStateController {
    static let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDoItems.plist")
    static let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

//MARK: - Saving and Reading of Saved Data (ToDoItem Array)

extension StorageStateController {
    static func saveToDoItems() {
        do {
            try coreDataContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    static func retrieveToDoItems() -> [ToDoItem] {
        let request : NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        do {
            return try coreDataContext.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
            return [ToDoItem]()
        }
    }
}
