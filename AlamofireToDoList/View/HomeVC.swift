//
//  HomeVC.swift
//  AlamofireToDoList
//
//  Created by Burak Köse on 15.11.2022.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statsLabel: UILabel!
    
    private let jsonTableViewModel = JsonTableViewModel()
    private let webservice = Webservice()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegation()
        fetchData()
        
    }
    
    private func fetchData() {
        self.statsLabel.text = JsonDataStatus.onProgress.message()
        webservice.fetchToDoData { items in
            self.jsonTableViewModel.update(items: items)
            self.tableView.reloadData()
            self.statsLabel.text = JsonDataStatus.success.message()
            
        } onFail: { error in
            self.statsLabel.text = JsonDataStatus.fail.message()
        }
    }
    
   private func delegation() {
        tableView.delegate = jsonTableViewModel
        tableView.dataSource = jsonTableViewModel
        jsonTableViewModel.delegate = self
    }
    
}

extension HomeVC: JsonTableViewOutput {
    func onSelect(item: ToDoModel) {
        print(item)
    }
}

enum JsonDataStatus {
    case success,fail,onProgress
    
    func message() -> String {
        switch self {
        case .onProgress:
            return "Loading"
        case .success:
            return "Loaded"
        case .fail:
            return "Failed"
        }
    }
}
