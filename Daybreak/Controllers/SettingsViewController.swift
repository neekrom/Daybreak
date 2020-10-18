//
//  SettingsViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/17/20.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var wakeUpTime: UIDatePicker!
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        
        super.viewDidLoad()
        wakeUpTime.setDate(defaults.object(forKey: "WakeUpTime") as? Date ?? Date(), animated: false)
        // Do any additional setup after loading the view.
    }


    @IBAction func wakeUpTimeChanged(_ sender: Any) {
        let time = wakeUpTime.date
        defaults.set(time, forKey: "WakeUpTime")
        defaults.setValue(false, forKey: "RangToday")
        AlarmManager.setAlarms(time: time)
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
