//
//  CheckListTableViewCell.swift
//  Enthral_Project
//
//  Created by sakshi shete on 28/07/25.
//

import UIKit

class CheckListTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerStackView: UIStackView!
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var btn4: UIButton!
    
    var optionSelected: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        }
    
    
    func configure(with question: Question, selectedIndex: Int?) {
        questionLabel.text = question.question
        
        
        let buttons = [btn1, btn2, btn3, btn4]
        
        for (index, button) in buttons.enumerated() {
            if index < question.options.count {
                let title = question.options[index]
                button?.setTitle(title, for: .normal)
                button?.isHidden = false
                button?.tag = index

                
                button?.removeTarget(nil, action: nil, for: .touchUpInside)

            
                let action = UIAction(title: title) { [weak self] _ in
                    self?.optionSelected?(index)
                }
                button?.addAction(action, for: .touchUpInside)
                button?.actions(forTarget: nil, forControlEvent: .touchUpInside)
                button?.accessibilityIdentifier = "Option_\(index)"

                
                if selectedIndex == index {
                    button?.backgroundColor = .systemBlue
                    button?.setTitleColor(.white, for: .normal)
                } else {
                    button?.backgroundColor = .white
                    button?.setTitleColor(.black, for: .normal)
                }
            } else {
                button?.isHidden = true
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)}
    
}
