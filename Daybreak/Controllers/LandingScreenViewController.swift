//
//  LandingScreenViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/8/20.
//

import UIKit
import GoogleSignIn

class LandingScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
