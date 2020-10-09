//
//  AppCardViewController.swift
//  Michael Ginn
//
//  Created by Michael Ginn on 4/23/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit

class AppCardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var cardId = ""
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cardView: shadowView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!

    @IBOutlet weak var centerAlignment: NSLayoutConstraint!

    var screenshots:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let path = Bundle.main.path(forResource: "card"+self.cardId, ofType: "txt")
        let content = (try! NSString(contentsOfFile: path!, encoding:String.Encoding.utf8.rawValue)) as String
        var array = content.components(separatedBy: "\n")
        let imageNames = array[1].components(separatedBy: ",")
        for name in imageNames{
            self.screenshots.append(UIImage(named: name)!)
        }
        self.titleLabel.text = array[0]
        self.contentTextView.text = array[2]
        
        
        let defaults = UserDefaults.standard //check to see if this is viewed yet
        var cards:[Int] = defaults.object(forKey: "cards") as! [Int]
        if cards[Int(self.cardId)! - 1] == 1{
            self.saveButton.setImage(UIImage(named: "Checkmark-100.png"), for: .normal)
        } else{
            cards[Int(self.cardId)! - 1] = 1
            defaults.set(cards, forKey: "cards")
            defaults.synchronize()
        }
        if cardId == "5"{
            self.centerAlignment.constant = -100
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, animations: {
            self.saveButton.alpha = 1.0
            self.saveButton.isEnabled = true
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        UIView.animate(withDuration: 1.3, delay: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.cardView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.cardView.frame.origin.y = self.saveButton.frame.origin.y + 100
            
            }, completion: {
                finished in
                self.dismiss(animated: true, completion: nil)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.screenshots.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screenshotCell", for: indexPath)
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = self.screenshots[indexPath.row]
        return cell
    }
    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize{
        var height:CGFloat = collectionView.frame.height - 8
        var width = height * (94.0/200.0)
        
        if self.cardId == "5"{
            if (height * (2560/1600)) < collectionView.frame.width - 32{
                width = height * (2560/1600)
            } else{
                width = collectionView.frame.width - 32
                height = width * (1600/2560)
            }
            
        }
        let size = CGSize(width: width, height: height)
        return size
    }

}
