//
//  CategoryModel.swift
//  Todoey
//
//  Created by Ethan Smith on 26/03/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

class CategoryModel {
   
    var categoryArray = [Category]()
    var coreDataContext = StorageStateController.coreDataContext
    var delegate : CategoryTableViewDelegate!
    
    init() {
        retrieveFullCategories()
    }

    func retrieveFullCategories() {
        categoryArray = StorageStateController.fetchCategories()
        
        // If delegate has been initialised
        if delegate != nil {
            delegate.reloadData()
        }
    }
    
    func addCategory(type: String) {
        let newCategory = Category(context: coreDataContext)
        newCategory.type = type
        
        categoryArray.append(newCategory)
        
        saveItems()
    }
    
    //MARK: - Save Items
    
    func saveItems() {
        delegate.reloadData()
        StorageStateController.saveContext()
    }
}
