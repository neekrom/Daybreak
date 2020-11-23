//
//  SettingsViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/17/20.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController {

    @IBOutlet weak var wakeUpTime: UIDatePicker!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var alarmVolume: UISlider!
    var player = AVAudioPlayer()
    let step: Float = 20
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        
        super.viewDidLoad()
        wakeUpTime.setDate(defaults.object(forKey: "WakeUpTime") as? Date ?? Date(), animated: false)
        alarmSwitch.setOn(defaults.bool(forKey: "Enabled"), animated: false)
        alarmVolume.setValue(defaults.float(forKey: "Volume"), animated: false)
        // Do any additional setup after loading the view.
    }
    
    deinit {
        player.stop()
    }

    @IBAction func wakeUpTimeChanged(_ sender: Any) {
        let time = wakeUpTime.date
        defaults.set(time, forKey: "WakeUpTime")
        defaults.setValue(Date(timeIntervalSinceReferenceDate: 0.0), forKey: "RangDate")
        AlarmManager.setAlarms(time: time)
    }
    
    @IBAction func volumeChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        defaults.setValue(roundedValue, forKey: "Volume")
        AlarmManager.setAlarms(time: wakeUpTime.date)
    }
    @IBAction func alarmSwitchChanged(_ sender: UISwitch) {
        defaults.setValue(sender.isOn, forKey: "Enabled")
        AlarmManager.setAlarms(time: wakeUpTime.date)
    }
    @IBAction func testVolume(_ sender: Any) {
        let radar: String = AlarmManager.volumes[Double(defaults.float(forKey: "Volume"))] ?? "radar0"
        let sound = Bundle.main.path(forResource: radar, ofType: "mp3")
        do{
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        var audioPlayerTimer = Timer()
        player.play()
        audioPlayerTimer = Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false, block: {_ in
            self.player.stop()
        })
    }
    @IBAction func testAlarm(_ sender: Any) {
        let date = Date() + 10
        let time = date
        defaults.set(time, forKey: "WakeUpTime")
        defaults.setValue(Date(timeIntervalSinceReferenceDate: 0.0), forKey: "RangDate")
        AlarmManager.setAlarms(time: date)
//        print(1)
    }
    @IBAction func multipleAlarmsPressed(_ sender: Any) {
        performSegue(withIdentifier: "alarmTable", sender: self)
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
