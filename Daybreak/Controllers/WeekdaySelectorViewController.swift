//
//  WeekdaySelectorViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 11/22/20.
//

import UIKit

class WeekdaySelectorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let weekdays = [0: "Sunday", 1: "Monday", 2: "Tuesday", 3: "Wednesday", 4: "Thursday", 5: "Friday", 6: "Saturday"]
    let abbreviations = [0: "Sun", 1:"Mon", 2:"Tues", 3:"Wed", 4:"Thur", 5:"Fri",6:"Sat"]
    var days = [Int]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekdayCell", for: indexPath) as! WeekdayCustomTableViewCell
        cell.weekday.text = weekdays[indexPath.row]
        if days.contains(indexPath.row){
            cell.accessoryType = .checkmark
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func save(_ sender: Any) {
        var daysString = ""
        for (index, cell) in tableView.visibleCells.enumerated() {
            if cell.accessoryType == .checkmark {
                days.append(index)
                daysString.append(abbreviations[index]! + " ")
            }
        }
        let presentingVC = presentingViewController as! PerAlarmSettingsViewController
        presentingVC.days = days
        presentingVC.daysString = daysString
        presentingVC.refreshTable()
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
class WeekdayCustomTableViewCell: UITableViewCell{
    @IBOutlet weak var weekday: UILabel!
    
}
