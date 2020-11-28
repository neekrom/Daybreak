//
//  TableAlarmViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 11/22/20.
//

import UIKit

class TableAlarmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let defaults = UserDefaults.standard
    let df = DateFormatter()
    var alarmSelected: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        df.dateFormat = "hh:mm"
        self.tableView.register(UINib(nibName: "CustomAlarmTableViewCell", bundle: nil), forCellReuseIdentifier: "alarmCell")
        if defaults.array(forKey: "Alarms") == nil {
            defaults.set(Array<Any>(), forKey: "Alarms")
        }
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaults.integer(forKey: "numAlarms")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let alarm = defaults.array(forKey: "Alarms")![indexPath.row] as! Dictionary<String, Any>
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as! CustomAlarmTableViewCell
        cell.time.text = df.string(from: alarm["time"] as! Date)
        cell.weekdays.text = alarm["daysString"] as! String
        cell.enabledSwitch.isOn = alarm["enabled"] as! Bool
        cell.alarmIndex = indexPath.row
        cell.presentingVC = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alarmSelected = indexPath
        performSegue(withIdentifier: "editAlarm", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    @IBAction func add(_ sender: Any) {
        performSegue(withIdentifier: "addAlarm", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editAlarm" {
            let destination = segue.destination as! PerAlarmSettingsViewController
            let alarm = defaults.array(forKey: "Alarms")![alarmSelected!.row] as! Dictionary<String, Any>
            destination.timeDate = alarm["time"] as! Date
            destination.days = alarm["weekdays"] as! [Int]
            destination.daysString = alarm["daysString"] as! String
            destination.alarmIndex = alarmSelected!.row
        }
    }
}
