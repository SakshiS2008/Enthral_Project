//
//  SavedResponseTableViewCell.swift
//  Enthral_Project
//
//  Created by sakshi shete on 29/07/25.
//

import UIKit

class SavedResponseTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    func configure(with response: SavedResponse) {
            nameLabel.text = response.userName
            timeLabel.text = "Completed at: \(response.completionTime)"
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
