//
//  AlarmViewController.swift
//  Daybreak
//
//  Created by Tyler Sameshima on 10/17/20.
//

import UIKit
import AVFoundation

class AlarmViewController: UIViewController {

    var player = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        let sound = Bundle.main.path(forResource: "radar", ofType: "mp3")
        do{
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        player.numberOfLoops = -1
        player.play()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func homePressed(_ sender: Any) {
        player.stop()
        performSegue(withIdentifier: "AlarmToHome", sender: self)
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
