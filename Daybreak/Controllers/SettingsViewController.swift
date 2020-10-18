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
        let content = UNMutableNotificationContent()
        content.title = "Wake Up!"
        content.body = "Alarm"
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "radar.mp3"))
        let time = wakeUpTime.date
        defaults.set(time, forKey: "WakeUpTime")
        let components = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "Alarm", content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request, withCompletionHandler: {(error) in
            if error != nil{
                print("error")
            }
        })
        
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
