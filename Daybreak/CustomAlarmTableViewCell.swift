//
//  CustomAlarmTableViewCell.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 11/22/20.
//

import UIKit

class CustomAlarmTableViewCell: UITableViewCell {
    let defaults = UserDefaults.standard
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var weekdays: UILabel!
    @IBOutlet weak var enabledSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func switchChanged(_ sender: Any) {
        
    }
    
}
