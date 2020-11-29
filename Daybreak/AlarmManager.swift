//
//  AlarmManager.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/18/20.
//

import Foundation
import UserNotifications

class AlarmManager {
    static let volumes = [0.0: "radar-6", 20.0: "radar-3", 40.0: "radar0", 60.0: "radar3", 80.0: "radar6", 100.0: "radar9"]
    static let defaults = UserDefaults.standard
    static var currentAlarm: Int = 0
    class func setAllAlarms() {
        if let alarms = defaults.array(forKey: "Alarms"){
            let content = self.notifContent()
            for (index, alarm) in alarms.enumerated(){
                let alarmDict = alarm as! Dictionary<String, Any>
                if alarmDict["enabled"] as! Bool {
                    var time = alarmDict["time"] as! Date
                    if alarmDict["weekdays"] as! [Int] != [Int]() {
                        for weekday in alarmDict["weekdays"] as! [Int] {
                            let event = DateComponents(hour: Calendar.current.component(.hour, from: time), minute: Calendar.current.component(.minute, from: time), weekday: weekday + 1)
                            time = Calendar.current.date(from: event)!
                            for i in 0...60 {
                                let newTime = time.addingTimeInterval(23.0 * Double(i))
                                let components = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: newTime)
                                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                                let request = UNNotificationRequest(identifier: "Alarm_\(index)_\(i)", content: content, trigger: trigger)
                                UNUserNotificationCenter.current().add(request)
                            }
                        }
                    } else {
                        for i in 0...60 {
                            let newTime = time.addingTimeInterval(23.0 * Double(i))
                            let components = Calendar.current.dateComponents([.hour, .minute, .second], from: newTime)
                            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                            let request = UNNotificationRequest(identifier: "Alarm_\(index)_\(i)", content: content, trigger: trigger)
                            UNUserNotificationCenter.current().add(request)
                        }
                    }
                }
            }
        }
    }
    class func setAlarms(time: Date){
        if UserDefaults.standard.bool(forKey: "Enabled") {
            let content = self.notifContent()
            for index in 0...60 {
                let newTime = time.addingTimeInterval(23.0 * Double(index))
                let components = Calendar.current.dateComponents([.hour, .minute, .second], from: newTime)
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                let request = UNNotificationRequest(identifier: "Alarm\(index)", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                // add user defaults set sent notif
            }
        }
    }
    
    private class func notifContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Wake Up!"
        content.body = "Alarm"
        let radar: String = AlarmManager.volumes[Double(UserDefaults.standard.float(forKey: "Volume"))] ?? "radar0"
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: radar + ".mp3"))
        return content
    }
    
    class func rangToday() -> Bool {
        let rangDate = UserDefaults.standard.object(forKey: "RangDate") as! Date
        let dayComparison = Calendar.current.compare(Date(), to: rangDate, toGranularity: .day)
        let monthComparison = Calendar.current.compare(Date(), to: rangDate, toGranularity: .month)
        let yearComparison = Calendar.current.compare(Date(), to: rangDate, toGranularity: .year)
        return (dayComparison == ComparisonResult.orderedSame) && (monthComparison == ComparisonResult.orderedSame) && (yearComparison == ComparisonResult.orderedSame)
    }
    
    class func setAlarmDate(withDay time: Date) {
        let content = self.notifContent()
        for index in 0...60 {
            let newTime = time.addingTimeInterval(23.0 * Double(index))
            let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: newTime)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "Alarm\(index)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            
        }
    }
    
    class func sendNotif(title: String, body: String){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(1), repeats: false)
        let request = UNNotificationRequest(identifier: "AppClosed", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}
