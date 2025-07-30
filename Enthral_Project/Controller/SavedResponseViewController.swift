//
//  SavedResponseViewController.swift
//  Enthral_Project
//
//  Created by sakshi shete on 29/07/25.
//

import UIKit

class SavedResponseViewController: UIViewController {

    @IBOutlet weak var savedResponseTableView: UITableView!
    
    var savedResponses: [SavedResponse] = []
    var reuseidentifierForSavedData = "SavedResponseTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedResponseTableView.dataSource = self
        savedResponseTableView.delegate = self

        registerwithXIB()
        loadSavedResponses()
    }
    func registerwithXIB(){
        let nib = UINib(nibName: reuseidentifierForSavedData, bundle: nil)
        self.savedResponseTableView.register(nib, forCellReuseIdentifier: reuseidentifierForSavedData)
    }
    
    func loadSavedResponses() {
            if let data = UserDefaults.standard.data(forKey: "savedResponses"),
               let decoded = try? JSONDecoder().decode([SavedResponse].self, from: data) {
                savedResponses = decoded
            }
            savedResponseTableView.reloadData()
        }
  

}
extension SavedResponseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedResponses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let response = savedResponses[indexPath.row]
        cell.textLabel?.text = response.userName
        cell.detailTextLabel?.text = "Completed at: \(response.completionTime)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let response = savedResponses[indexPath.row]
           let detailVC = ResponseDetailViewController()
           detailVC.savedResponse = response
           navigationController?.pushViewController(detailVC, animated: true)
       }
}
