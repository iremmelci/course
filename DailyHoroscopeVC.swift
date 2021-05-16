//
//  DailyHoroscopeVC.swift
//  instaclone
//
//  Created by irem on 16.05.2021.
//

import UIKit

class DailyHoroscopeVC: UIViewController {
    let horoscopes = ["Aries","Taurus","Gemini","Cancer","Leo","Virgo","Libra","Scorpio","Sagittarius","Capricorn","Aquarius","Pisces"]
    
    let horoscopeimages: [UIImage] = [
        UIImage(named: "aries")!,
        UIImage(named: "taurus")!,
        UIImage(named: "gemini")!,
        UIImage(named: "cancer")!,
        UIImage(named: "leo")!,
        UIImage(named: "virgo")!,
        UIImage(named: "libra")!,
        UIImage(named: "scorpio")!,
        UIImage(named: "sagittarius")!,
        UIImage(named: "capricorn")!,
        UIImage(named: "aquarius")!,
        UIImage(named: "pisces")!
    ]
 
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
          
        layout.minimumInteritemSpacing = 5
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
        
    }
    
    @objc func swipeAction(swipe:UISwipeGestureRecognizer)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension DailyHoroscopeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return horoscopes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HoroscopeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "horoscopeCell", for: indexPath) as! HoroscopeCell
        cell.horoscopeName.text = self.horoscopes[indexPath.row]
        cell.image.image = self.horoscopeimages[indexPath.item]
        
        cell.layer.cornerRadius = 10.0
        cell.layer.borderWidth = 1.0
        cell.layer.masksToBounds = true




        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width/3.2, height: view.frame.size.width/5.2)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

                collectionView.reloadData()
 
    }
    
    public func dialog(title: String!, message: String!, okayText: String = "Tamam",onOk:((_ dialog:UIAlertController) ->())? = nil) {
        
        DispatchQueue.main.async {
            let dialogAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            dialogAlert.addAction(UIAlertAction(title: okayText, style: .default, handler: { (action: UIAlertAction!) in
                
                onOk?(dialogAlert)
                dialogAlert.dismiss(animated: true, completion: nil)
            }))
            self.present(dialogAlert, animated: true, completion: nil)
        }
        
    }
}
