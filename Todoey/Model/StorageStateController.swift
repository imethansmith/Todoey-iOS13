//
//  MainModelController.swift
//  Todoey
//
//  Created by Ethan Smith on 19/03/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class StorageStateController {
    static let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDoItems.plist")
    static let coreDataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func saveContext() {
        do {
            try coreDataContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

//MARK: - Saving, Reading & Searching of ToDoItem - Core Data

extension StorageStateController {
    
    
    static func searchItem(searchText: String) -> [ToDoItem]? {
        let request : NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        
        request.predicate = NSPredicate(format: "toDo CONTAINS[cd] %@", searchText)
        request.sortDescriptors = [NSSortDescriptor(key: "toDo", ascending: true)]
        return fetchToDoItemsArray(request: request)
    }
    
    static func fetchToDoItemsArray(request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()) -> [ToDoItem] {
        do {
            return try coreDataContext.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
            return [ToDoItem()]
        }
    }
}

//MARK: - Saving, Reading & Searching of Categories - Core Data

extension StorageStateController {
    
    static func fetchCategories(request: NSFetchRequest<Category> = Category.fetchRequest()) -> [Category] {
        do {
            return try coreDataContext.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
            return [Category()]
        }
    }
}
