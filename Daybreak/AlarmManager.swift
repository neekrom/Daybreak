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
