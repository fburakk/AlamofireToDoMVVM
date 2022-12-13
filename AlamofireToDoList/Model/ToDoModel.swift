//
//  ToDoModel.swift
//  AlamofireToDoList
//
//  Created by Burak Köse on 15.11.2022.
//

import Foundation


struct ToDoModel: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var completed: Bool?
    
}
