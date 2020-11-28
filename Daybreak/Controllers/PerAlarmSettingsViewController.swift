//
//  PerAlarmSettingsViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 11/22/20.
//

import UIKit

class PerAlarmSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var alarmIdentifier: String = ""
    var days = [Int]()
    var daysString: String = ""
    var timeDate: Date?
    var alarmIndex: Int?
    @IBOutlet weak var time: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if timeDate != nil {
            time.date = timeDate!
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customSettingsCell", for: indexPath) as! CustomAlarmSettingsCell
        cell.leftText.text = "Repeats"
        cell.rightText.text = daysString
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "weekdaySegue", sender: self)
    }
    
    func refreshTable(){
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! CustomAlarmSettingsCell
        cell.rightText.text = daysString
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weekdaySegue" {
            let destination = segue.destination as! WeekdaySelectorViewController
            destination.days = days
        }
    }
    
    @IBAction func save(_ sender: Any) {
        let alarm: Dictionary<String, Any> = ["time": time.date, "enabled": true, "daysString": daysString, "weekdays": days]
        var alarms = UserDefaults.standard.array(forKey: "Alarms")!
        if alarmIndex == nil{
            alarms.append(alarm)
            let numAlarms = UserDefaults.standard.integer(forKey: "numAlarms")
            UserDefaults.standard.setValue(numAlarms + 1, forKey: "numAlarms")
        } else {
            alarms[alarmIndex!] = alarm
        }
        UserDefaults.standard.setValue(alarms, forKey: "Alarms")
        let tableAlarmVC = presentingViewController as! TableAlarmViewController
        tableAlarmVC.tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
}
class CustomAlarmSettingsCell: UITableViewCell{
    @IBOutlet weak var leftText: UILabel!
    @IBOutlet weak var rightText: UILabel!
}
