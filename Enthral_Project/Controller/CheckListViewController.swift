//
//  CheckListViewController.swift
//  Enthral_Project
//
//  Created by sakshi shete on 28/07/25.
//

import UIKit

class CheckListViewController: UIViewController {
    
    @IBOutlet weak var checkListTableView: UITableView!
    
    var userName: String = "Unknown"

    var checklist : Checklist?
  
    var answers: [Int?] = []
    
    var reuseIdentifier = "CheckListTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkListTableView.dataSource = self
        checkListTableView.delegate = self
        registerXIB()
        loadChecklistJSON()
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
       
            guard let questions = checklist?.questions else { return }

            var allAnswered = true
            for (index, answer) in answers.enumerated() {
                if answer == nil {
                    allAnswered = false
                    let questionText = questions[index].question
                    print("Unanswered Question: \(questionText)")
                }
            }

            if !allAnswered {
                // You can show an alert to the user
                let alert = UIAlertController(title: "Incomplete", message: "Please answer all questions before submitting.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }

        
            // All answers are present → Submit
            for (index, selectedIndex) in answers.enumerated() {
                let question = questions[index]
                let selectedOption = question.options[selectedIndex!]
                
            }
        
        // 1. Collect answers
           let submittedAnswers: [String] = answers.enumerated().map { (index, selectedIndex) in
               let question = questions[index]
               return question.options[selectedIndex!]
           }
        //  2. Get username and timestamp (assume username is stored somewhere)
           let userName = UserDefaults.standard.string(forKey: "userName") ?? "Unknown"
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           let timeString = formatter.string(from: Date())
        
        //  3. Build response object
        let submittedQAs: [QA] = answers.enumerated().map { (index, selectedIndex) in
            let question = questions[index].question
            let selectedAnswer = questions[index].options[selectedIndex!]
            return QA(question: question, answer: selectedAnswer)
        }

        let response = SavedResponse(userName: self.userName,
                                     completionTime: timeString,
                                     questionsAndAnswers: submittedQAs)


           // 4. Save it to UserDefaults (or use file-based persistence if needed)
           var previousResponses = fetchSavedResponses()
           previousResponses.append(response)
           
        if let data = try? JSONEncoder().encode(previousResponses) {
               UserDefaults.standard.set(data, forKey: "savedResponses")
           }
        
        UserDefaults.standard.removeObject(forKey: "sakshi")


            // You can now save or upload results here
        let savedResponseVC = self.storyboard?.instantiateViewController(withIdentifier: "SavedResponseViewController") as! SavedResponseViewController
        navigationController?.pushViewController(savedResponseVC, animated: true)
        
    }
    func fetchSavedResponses() -> [SavedResponse] {
        if let data = UserDefaults.standard.data(forKey: "savedResponses"),
           let decoded = try? JSONDecoder().decode([SavedResponse].self, from: data) {
            return decoded
        }
        return []
    }
    
    func registerXIB(){
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        self.checkListTableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    func loadChecklistJSON() {
        guard let url = Bundle.main.url(forResource: "checklist", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(CheckListModel.self, from: data) else {
            print("Failed to load checklist.json")
            return
        }
        self.checklist = decoded.checklist
        self.answers = Array(repeating: nil, count: decoded.checklist.questions.count)
        self.checkListTableView.reloadData()
        print(checklist as Any)
    }
    
}
extension CheckListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (checklist?.questions.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.checkListTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CheckListTableViewCell

        if let question = checklist?.questions[indexPath.row] {
            
        let selectedIndex = answers[indexPath.row]
            
               cell.configure(with: question, selectedIndex: selectedIndex)
            
            cell.optionSelected = { [weak self] selectedOptionIndex in
                self?.answers[indexPath.row] = selectedOptionIndex
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        return cell
    }
}

extension CheckListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        220.0
    }
}

