//
//  TextCardViewController.swift
//  Michael Ginn
//
//  Created by Michael Ginn on 4/18/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit

class TextCardViewController: UIViewController {
    var cardId = ""

    @IBOutlet weak var cardView: shadowView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.saveButton.isEnabled = false
        
        let path = Bundle.main.path(forResource: "card"+self.cardId, ofType: "txt")
        let content = (try! NSString(contentsOfFile: path!, encoding:String.Encoding.utf8.rawValue)) as String
        var array = content.components(separatedBy: "\n")
        
        self.titleLabel.text = array[0]
        self.contentLabel.text = array[1]
        
        let defaults = UserDefaults.standard //check to see if this is viewed yet
        var cards:[Int] = defaults.object(forKey: "cards") as! [Int]
        if cards[Int(self.cardId)! - 1] == 1{
            self.saveButton.setImage(UIImage(named: "Checkmark-100.png"), for: .normal)
        } else{
            cards[Int(self.cardId)! - 1] = 1
            defaults.set(cards, forKey: "cards")
            defaults.synchronize()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
