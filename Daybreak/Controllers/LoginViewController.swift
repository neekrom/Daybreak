//
//  LoginViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/8/20.
//

import UIKit
import GoogleSignIn
import Firebase

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

class LoginViewController: UIViewController {
//    print("signed in")
//    let homeViewController = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
//    homeViewController.modalPresentationStyle = .fullScreen
//    DispatchQueue.main.async {
//        self.present(homeViewController, animated: true,completion: nil)
//    }
    var signedInTimer: Timer?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! HomeViewController
        destination.modalPresentationStyle = .fullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        signedInTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: { timer in
            if UserDefaults.standard.bool(forKey: "loggedin") {
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
//        GIDSignIn.sharedInstance()?.clientID =  FirebaseApp.app()?.options.clientID
    }
    
    @IBAction func logInWithGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    deinit {
        signedInTimer?.invalidate()
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
