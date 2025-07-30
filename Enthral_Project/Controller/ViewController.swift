//
//  ViewController.swift
//  Enthral_Project
//
//  Created by sakshi shete on 28/07/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var timer: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func GoBtn(_ sender: Any) {
         
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert("")
            return
        }
        
        let checkListViewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "CheckListViewController") as! CheckListViewController
        checkListViewcontroller.userName = name 
        navigationController?.pushViewController(checkListViewcontroller, animated: true)

    }
    private func showAlert(_ message: String) {
           let alert = UIAlertController(title: "Please Enter your name", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
}

