//
//  AlarmManager.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/18/20.
//

import Foundation
import UserNotifications

class AlarmManager {
    class func setAlarms(time: Date){
        let content = self.notifContent()
        for index in 0...60 {
            let newTime = time.addingTimeInterval(23.0 * Double(index))
            let components = Calendar.current.dateComponents([.hour, .minute, .second], from: newTime)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier: "Alarm\(index)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    private class func notifContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Wake Up!"
        content.body = "Alarm"
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "radar.mp3"))
        return content
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
