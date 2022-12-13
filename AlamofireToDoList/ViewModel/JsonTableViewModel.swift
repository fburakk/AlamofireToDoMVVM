//
//  JsonTableViewModel.swift
//  AlamofireToDoList
//
//  Created by Burak Köse on 15.11.2022.
//

import Foundation
import UIKit

protocol JsonTableViewProtocol {
    func update(items: [ToDoModel])
}

protocol JsonTableViewOutput: AnyObject {
    func onSelect(item: ToDoModel)
}

class JsonTableViewModel:NSObject {
    
    lazy var items = [ToDoModel]()
    weak var delegate: JsonTableViewOutput?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isCompleted = items[indexPath.row].completed!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ToDoCell
        cell.titleLabel.text = items[indexPath.row].title
        cell.usernameLabel.text = "User\(items[indexPath.row].userId!)"
        
        cell.accessoryType = isCompleted ? .checkmark : .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelect(item: items[indexPath.row])
    }
    
}

extension JsonTableViewModel: UITableViewDataSource,UITableViewDelegate {}

extension JsonTableViewModel: JsonTableViewProtocol {
    func update(items: [ToDoModel]) {
        self.items = items
    }
}
