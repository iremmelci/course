//
//  SettingsVC.swift
//  instaclone
//
//  Created by irem on 22.03.2021.
//

import UIKit
import Firebase
class SettingsVC: UIViewController {

    @IBOutlet weak var premiumButton: UIButton!
   
    @IBOutlet weak var ratebutton: UIButton!
  
    @IBOutlet weak var userInfoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        ratebutton.layer.cornerRadius = 20
        premiumButton.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }

    @IBAction func logoutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toLogin", sender: nil)
        }
        catch{
            print("error")
        }
    }
    
    @IBAction func premiumClicked(_ sender: Any) {
        performSegue(withIdentifier: "toPremiumVC", sender: nil)
    }
    @IBAction func editClicked(_ sender: Any) {
        performSegue(withIdentifier: "toEditProfile", sender: nil)
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
