//
//  AppDelegate.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/6/20.
//

import AVFoundation
import UIKit
import Firebase
import GoogleSignIn
import UserNotifications
import BackgroundTasks


@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var firstTimeLaunch: Bool!
    let defaults = UserDefaults.standard
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        UNUserNotificationCenter.current().delegate = self
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "checkTime", using: nil, launchHandler: {(task) in
//            self.handleAppRefresh(task: task as! BGAppRefreshTask)
//        })
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: [.duckOthers, .defaultToSpeaker])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            NSLog("Audio session error : \(error)")
        }
        return true
    }
    
//    func handleAppRefresh(task: BGAppRefreshTask){
//        task.expirationHandler = {
//            task.setTaskCompleted(success: false)
//        }
//        guard let wakeupTime = defaults.object(forKey: "WakeUpTime") else {
//            task.setTaskCompleted(success: true)
//            return
//        }
//        let currentTime = Date()
//
//    }
    
//    func scheduleTimeCheck(){
//        let timeCheckTask = BGAppRefreshTaskRequest(identifier: "checkTime")
//        timeCheckTask.earliestBeginDate = nil
//        do {
//            try BGTaskScheduler.shared.submit(timeCheckTask)
//        } catch {
//            print("schedule error")
//        }
//    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
//        AlarmManager.sendNotif(title: "Application Terminated", body: "The app will not be able to properly ring the alarm.")
//        if defaults.object(forKey: "WakeUpTime") != nil  && !AlarmManager.rangToday(){
//            AlarmManager.setAlarms(time: defaults.object(forKey: "WakeUpTime") as! Date)
//        }
//        NSLog("terminated")
    }
    // did return from background
    // check defaults value if it is set to true, then go to view controller
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //moving to the alarm screen only seems to work on first open, closing and then using the app after the initial opening makes this transition not work for some reason
        if String(response.notification.request.identifier.prefix(5)) == "Alarm" {
            let alarmIndex = Int(response.notification.request.identifier.components(separatedBy: "_")[1])
            AlarmManager.currentAlarm = alarmIndex!
            defaults.set(true, forKey: "CameFromAlarm")
            let alarmController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AlarmView") as! AlarmViewController
            alarmController.modalPresentationStyle = .fullScreen
            if var topController = UIApplication.shared.windows.first?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(alarmController, animated: false, completion: nil)
            }
        }
//        UIApplication.shared.windows.first?.rootViewController?.present(alarmController, animated: false, completion: nil)
        completionHandler()
    }

}
