//
//  ToDoItem.swift
//  TODOAPP
//
//  Created by Carrington Tafadzwa Manyuchi on 2023/01/11.
//

import Foundation


struct ToDoItem {
    
    var name: String
    var details: String
    var completionDate: Date
    var startDate: Date
    var isComplete: Bool
    
    init(name: String, details: String, completionDate: Date) {
        
        self.name = name
        self.details = details
        self.completionDate = completionDate
        self.isComplete = false
        self.startDate = Date ()
    }
    
    
}
