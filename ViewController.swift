//
//  ViewController.swift
//  instaclone
//
//  Created by irem on 21.03.2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var gmailbutton: UIButton!
    @IBOutlet weak var girisyapbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        girisyapbutton.layer.cornerRadius = 20
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func girisyapClicked(_ sender: Any) {
        
        if (emailText.text != "" && passwordText.text != "")
        {
            Auth.auth().signIn(withEmail: emailText.text!,password: passwordText.text!){
                (authdata, error) in
            
            if error != nil{
                self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
            }
            else{
                self.performSegue(withIdentifier: "toFeed", sender: nil)
            }
            }
        }
        else
        {
            makeAlert(titleInput: "error", messageInput: "There is no email or password")
        }
    }

    
    
    @IBAction func kayitolClicked(_ sender: Any) {
        if (emailText.text != "" && passwordText.text != "") {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                }
                else{
                    self.makeAlert(titleInput: "Başarılı", messageInput: "Kayıt işleminiz alınmıştır.")
                
                }
            }
        }
        else {
            makeAlert(titleInput: "error", messageInput: "There is no email or password")
        }
        
    }
    
   
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        
        let okbutton = UIAlertAction(title: "OK", style:UIAlertAction.Style.default , handler: nil)
        alert.addAction(okbutton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

