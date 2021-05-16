//
//  PremiumVC.swift
//  instaclone
//
//  Created by irem on 11.04.2021.
//

import UIKit
struct Model {
    let title: String
    let handler: (() -> Void)
}
class PremiumVC: UIViewController{
    var models = [Model]()
    override func viewDidLoad() {
        super.viewDidLoad()
        models.append(Model(title: "Be Premium", handler: {
            IAPManager.shared.purchase(product: .bePremium)
        }))
        // Do any additional setup after loading the view.
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @IBAction func purchaseClicked(_ sender: Any) {
        let model = models[0]
        model.handler()
    }
    @objc func swipeAction(swipe:UISwipeGestureRecognizer)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

   
}
