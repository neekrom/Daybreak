//
//  HomeViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/17/20.
//

import UIKit

class HomeViewController: UIViewController {
//    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
