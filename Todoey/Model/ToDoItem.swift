//
//  ToDoItem.swift
//  Todoey
//
//  Created by Ethan Smith on 19/03/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct ToDoItem: Codable {
    var toDo: String?
    var checked: Bool = false
}
