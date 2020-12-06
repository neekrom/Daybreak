//
//  HomeViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/17/20.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
//    var timer = Timer()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        if let user = user{
            let userName = user.displayName?.components(separatedBy: " ")[0]
            nameLabel.text = userName ?? "error"
            let pic = user.photoURL
            print(pic?.absoluteString)
            let url = URL(string: pic!.absoluteString)!
            let data = (try? Data(contentsOf: url))!
            let image = UIImage(data: data)
            profilePic.image = image
        }
//        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: {(Timer) in
//            print("running")
//            if UserDefaults.standard.bool(forKey: "CameFromAlarm") {
//                let alarmController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AlarmView") as! AlarmViewController
//                alarmController.modalPresentationStyle = .fullScreen
//                UserDefaults.standard.set(false, forKey: "CameFromAlarm")
//                self.present(alarmController, animated: false, completion: nil)
//            }
//        })
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func settingsButton(_ sender: Any) {
        performSegue(withIdentifier: "settingsSegue", sender: self)
    }
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut() } catch let signOutError as NSError {
            print("caught signout error")
                return
        }
        UserDefaults.standard.setValue(false, forKey: "loggedin")
        let alert = UIAlertController(title: "Logged out", message: "Please restart the app", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
}

