//
//  HomeVC.swift
//  instaclone
//
//  Created by irem on 16.05.2021.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var coinButton: UIButton!
    @IBOutlet weak var horoscopeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func coinClicked(_ sender: Any) {
        performSegue(withIdentifier: "toPremium", sender: nil)    }
    
    @IBAction func horoscopeClicked(_ sender: Any) {
        performSegue(withIdentifier: "toHoroscope", sender: nil)
    }
    
}
