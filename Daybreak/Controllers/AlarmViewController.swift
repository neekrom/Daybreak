//
//  AlarmViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/17/20.
//

import UIKit
import AVFoundation

class AlarmViewController: UIViewController {

    let defaults = UserDefaults.standard
    var player = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        let radar: String = AlarmManager.volumes[Double(defaults.float(forKey: "Volume"))] ?? "radar0"
        let sound = Bundle.main.path(forResource: radar, ofType: "mp3")
        do{
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        player.numberOfLoops = -1
        player.play()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func homePressed(_ sender: Any) {
        player.stop()
        let alarms = defaults.array(forKey: "Alarms")!
        var alarm = alarms[AlarmManager.currentAlarm] as! Dictionary<String, Any>
        if alarm["weekdays"] as! [Int] == [Int]() {
            alarm["enabled"] = false
        }
        defaults.setValue(alarms, forKey: "Alarms")
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        AlarmManager.setAllAlarms()
//        defaults.setValue(Date(), forKey: "RangDate")
//        let wakeUpTime = defaults.object(forKey: "WakeUpTime") as! Date
//        let wakeUpHour = Calendar.current.component(.hour, from: wakeUpTime)
//        let wakeUpMinute = Calendar.current.component(.minute, from: wakeUpTime)
//        var time = Calendar.current.date(bySetting: .hour, value: wakeUpHour, of: Date())!
//        time = Calendar.current.date(bySetting: .minute, value: wakeUpMinute, of: time)!
//        time = Calendar.current.date(byAdding: .day, value: 1, to: time)!
//        AlarmManager.setAlarmDate(withDay: time)
        performSegue(withIdentifier: "AlarmToHome", sender: self)
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
