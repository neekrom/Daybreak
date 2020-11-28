//
//  LandingScreenViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/8/20.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import UserNotifications

class LandingScreenViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                if settings.authorizationStatus == .authorized {
                    // Already authorized
                }
                else {
                    // Either denied or notDetermined
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                        (granted, error) in
                          // add your own
                        if !granted{
                            UNUserNotificationCenter.current().delegate = self
                            let alertController = UIAlertController(title: "Notification Alert", message: "Please enable notifications", preferredStyle: .alert)
                            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                    return
                                }
                                if UIApplication.shared.canOpenURL(settingsUrl) {
                                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                    })
                                }
                            }
                            alertController.addAction(settingsAction)
                            DispatchQueue.main.async {
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        
        Auth.auth().addStateDidChangeListener {(auth, user) in
            if let user = user{
                print("signed in")
                let homeViewController = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                DispatchQueue.main.async {
                    self.present(homeViewController, animated: true,completion: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LoginViewController
        destination.modalPresentationStyle = .fullScreen
    }
    
    @IBAction func getStarted(_ sender: UIButton) {
        performSegue(withIdentifier: "getStartedSegue", sender: nil)
    }
    
}
