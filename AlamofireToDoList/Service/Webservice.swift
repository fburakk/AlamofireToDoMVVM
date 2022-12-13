//
//  Webservice.swift
//  AlamofireToDoList
//
//  Created by Burak Köse on 18.11.2022.
//

import Foundation
import Alamofire

private enum JsonPath: String {
    case TODOS = "/todos"
}

extension JsonPath  {
    func pathUrl() -> String {
        return "https://jsonplaceholder.typicode.com\(self.rawValue)"
    }
}

struct Webservice {
    
    func fetchToDoData(onSuccess: @escaping([ToDoModel]) -> Void, onFail: @escaping(String) -> Void) {
        
        AF.request(JsonPath.TODOS.pathUrl(),method: .get).validate().responseDecodable(of: [ToDoModel].self) { response  in
            
            guard let items = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
}
