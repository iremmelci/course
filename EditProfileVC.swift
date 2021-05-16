//
//  EditProfileVC.swift
//  instaclone
//
//  Created by irem on 11.04.2021.
//

import UIKit
import StoreKit

class EditProfileVC: UIViewController {
   
    
    let cinsiyet = ["Female","Male","I dont'prefer to tell"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func backClick(_ sender: Any) {
        performSegue(withIdentifier: "toback", sender: nil)
    }
    @IBAction func rateButtonClicked(_ sender: Any) {
        self.rateApp()
   
       
    }
    func rateApp() {
       
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
   
}

