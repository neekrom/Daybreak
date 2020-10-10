//
//  LandingScreenViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/8/20.
//

import UIKit
import GoogleSignIn
import UserNotifications

class LandingScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
////            if !granted{
////                let alertController = UIAlertController(title: "Denied access", message: "Looks like you denied access to notification. Please enable this in your settings or you won't receive notifications!", preferredStyle: .alert)
////                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
////                self.present(alertController, animated: true, completion: nil)
////            }
//        }
        // Do any additional setup after loading the view.
        
        if GIDSignIn.sharedInstance()?.currentUser != nil{
            //placeholder move to new VC
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
