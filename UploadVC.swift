//
//  UploadVC.swift
//  instaclone
//
//  Created by irem on 22.03.2021.
//

import UIKit
import Firebase

class UploadVC: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate{

    
    @IBOutlet weak var textfield: UITextField!
    var pickerView = UIPickerView()

    let niyet = ["Aşk","Sağlık","Kariyer","Genel"]
 

    @IBOutlet weak var commentfield: UITextField!
    
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var imageview2: UIImageView!
    @IBOutlet weak var imageview1: UIImageView!
    @IBOutlet weak var uploadbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadbutton.layer.cornerRadius = 25
        imageview.isUserInteractionEnabled = true
        imageview1.isUserInteractionEnabled = true
        imageview2.isUserInteractionEnabled = true
        textfield.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageview.addGestureRecognizer(gestureRecognizer)
        imageview1.addGestureRecognizer(gestureRecognizer)
        imageview2.addGestureRecognizer(gestureRecognizer)
    }
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageview.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        imageview1.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        imageview2.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func uploadbutton(_ sender: Any) {
        
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        
        if let data = imageview.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    
                    imageReference.downloadURL { (url, error) in
                        
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            
                            //DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentfield.text!,"date" : FieldValue.serverTimestamp(), "likes" : 0 ] as [String : Any]

                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    
                                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                                    
                                } else {
                                    
                                    self.imageview.image = UIImage(named: "select.png")
                                    self.commentfield.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                }
                            })
                            
                            
                            
                        }
                        
                        
                    }
                    
                }
            }
            
            
        }
        
    }
    
    

    
  
}

extension UploadVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return niyet.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return niyet[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textfield.text = niyet[row]
        textfield.resignFirstResponder()
    }
}
