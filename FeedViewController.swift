//
//  FeedVC.swift
//  instaclone
//
//  Created by irem on 22.03.2021.
//

import UIKit
import Firebase
import SDWebImage
import WebKit
class FeedViewController: UIViewController {


    @IBOutlet weak var button: UIButton!

    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
    }


    
    @IBAction func buttonClicked(_ sender: Any) {
        let controller : PremiumVC? = storyboard?.instantiateViewController(withIdentifier: "premiumVC") as? PremiumVC
        navigationController?.pushViewController(controller!, animated: true)
    }


    @IBAction func horoscopeClicked(_ sender: UIButton) {
        let controller : DailyHoroscopeVC? = storyboard?.instantiateViewController(withIdentifier: "dailyHoroscopeVC") as? DailyHoroscopeVC
        navigationController?.pushViewController(controller!, animated: true)
    }



}
