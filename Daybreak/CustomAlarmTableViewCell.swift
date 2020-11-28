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
    var alarmIndex: Int?
    var presentingVC: TableAlarmViewController? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func switchChanged(_ sender: Any) {
        let alarms = defaults.array(forKey: "Alarms")!
        var alarm = alarms[alarmIndex!] as! Dictionary<String, Any>
        alarm["enabled"] = enabledSwitch.isOn
        defaults.setValue(alarms, forKey: "Alarms")
        //maybe call alarmmanager
    }
    @IBAction func deleteAlarm(_ sender: Any) {
        var alarms = defaults.array(forKey: "Alarms")
        alarms?.remove(at: alarmIndex!)
        defaults.setValue(alarms, forKey: "Alarms")
        let numAlarms = defaults.integer(forKey: "numAlarms")
        defaults.setValue(numAlarms - 1, forKey: "numAlarms")
        presentingVC?.tableView.reloadData()
        //call alarmmanager
    }
}
