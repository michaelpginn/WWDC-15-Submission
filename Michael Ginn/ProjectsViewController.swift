//
//  ProjectsViewController.swift
//  Michael Ginn
//
//  Created by Michael Ginn on 4/22/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    let slideRightTransitionController = SlideRightTransitionController()
    var lastSegue:UIStoryboardSegue? = nil
    var lastFrame:CGRect? = nil
    
    @IBOutlet weak var card3: shadowImageView!
    @IBOutlet weak var card9: shadowImageView!
    @IBOutlet weak var card5: shadowImageView!
    @IBOutlet weak var card8: shadowImageView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        var cards:[Int] = defaults.object(forKey: "cards") as! [Int]
        //if a card is already viewed, grey it out
        if cards[2] == 1{
            self.card3.setImage(UIImage(named: "card3 grey"), for: .normal)
            self.card3.alpha = 0.4
        }
        if cards[8] == 1{
            self.card9.setImage(UIImage(named: "card9 grey"), for: .normal)
            self.card9.alpha = 0.4
        }
        if cards[4] == 1{
            self.card5.setImage(UIImage(named: "card5 grey"), for: .normal)
            self.card5.alpha = 0.4
        }
        if cards[7] == 1{
            self.card8.setImage(UIImage(named: "card8 grey"), for: .normal)
            self.card8.alpha = 0.4
        }
        
        self.finishButton.setImage(UIImage(named:"Enter Filled-100.png"), for: UIControlState.highlighted)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        var cards:[Int] = defaults.object(forKey: "cards") as! [Int]
        //show the user the transition to faded
        if cards[2] == 1{
            UIView.transition(with: self.card3, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.card3.setImage(UIImage(named: "card3 grey"), for: .normal)
                self.card3.alpha = 0.4
                }, completion: nil)
        }
        if cards[8] == 1{
            UIView.transition(with: self.card9, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.card9.setImage(UIImage(named: "card9 grey"), for: .normal)
                self.card9.alpha = 0.4
                }, completion: nil)
        }
        if cards[4] == 1{
            UIView.transition(with: self.card9, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.card5.setImage(UIImage(named: "card5 grey"), for: .normal)
                self.card5.alpha = 0.4
                }, completion: nil)
        }
        if cards[7] == 1{
            UIView.transition(with: self.card8, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.card8.setImage(UIImage(named: "card8 grey"), for: .normal)
                self.card8.alpha = 0.4
                }, completion: nil)
        }
        //check if all cards are viewed
        var shouldContinue = false
        for card in cards{
            if card == 0{
                shouldContinue = true
            }
        }
        if defaults.bool(forKey: "finished") == true{
            shouldContinue = false
            self.finishButton.isHidden = false
            self.finishButton.isEnabled = true
        }
        if !shouldContinue{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.performSegue(withIdentifier: "finish", sender: self)
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //make the cards look nice for next time we see them
        let defaults = UserDefaults.standard
        var cards:[Int] = defaults.object(forKey: "cards") as! [Int]
        for (id, view) in [3:self.card3, 9:self.card9, 5:self.card5, 8:self.card8]{ //check each card
            if cards[id - 1] == 0{
                view?.setImage(UIImage(named: "card\(id).png"), for: .normal)
            } else{
                view?.setImage(UIImage(named: "card\(id) grey.png"), for: .normal)
                view?.alpha = 0.4
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swipeRight(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func card3(sender: AnyObject) {
        _ = UserDefaults.standard
        //_:[Int] = defaults.objectForKey("cards") as! [Int]
        
        UIView.transition(with: self.card3, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
            self.card3.setImage(UIImage(named: "card.png"), for: UIControlState.normal)
            }, completion: {
                finished in
                self.lastFrame = self.card3.frame
                self.performSegue(withIdentifier: "showCard3", sender: self)
        })
        
    }
    @IBAction func card9(sender: AnyObject) {
        _ = UserDefaults.standard
        //_:[Int] = defaults.objectForKey("cards") as! [Int]
        
        UIView.transition(with: self.card9, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
            self.card9.setImage(UIImage(named: "card.png"), for: UIControlState.normal)
            }, completion: {
                finished in
                self.lastFrame = self.card9.frame
                self.performSegue(withIdentifier: "showCard9", sender: self)
        })
        
    }
    @IBAction func card5(sender: AnyObject) {
        _ = UserDefaults.standard
        //_:[Int] = defaults.objectForKey("cards") as! [Int]
        
        UIView.transition(with: self.card5, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
            self.card5.setImage(UIImage(named: "card.png"), for: UIControlState.normal)
            }, completion: {
                finished in
                self.lastFrame = self.card5.frame
                self.performSegue(withIdentifier: "showCard5", sender: self)
        })
        
    }
    @IBAction func card8(sender: AnyObject) {
        _ = UserDefaults.standard
        //_:[Int] = defaults.objectForKey("cards") as! [Int]
        
        UIView.transition(with: self.card8, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
            self.card8.setImage(UIImage(named: "card.png"), for: UIControlState.normal)
            }, completion: {
                finished in
                self.lastFrame = self.card8.frame
                self.performSegue(withIdentifier: "showCard8", sender: self)
        })
        
    }
    
    @IBAction func showFinish(sender: AnyObject) {
        self.performSegue(withIdentifier: "finish", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toViewController = segue.destination 
        toViewController.transitioningDelegate = self
        self.lastSegue = segue
        
        if segue.identifier == "showCard3"{
            (toViewController as! AppCardViewController).cardId = "3"
        }else if segue.identifier == "showCard9"{
            (toViewController as! AppCardViewController).cardId = "9"
        }else if segue.identifier == "showCard5"{
            (toViewController as! AppCardViewController).cardId = "5"
        }else if segue.identifier == "showCard8"{
            (toViewController as! AppCardViewController).cardId = "8"
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if self.lastSegue?.identifier == "showCard3" {
            return ZoomTransition(cardView: self.card3)
        }else if self.lastSegue?.identifier == "showCard9"{
            return ZoomTransition(cardView: self.card9)
        }else if self.lastSegue?.identifier == "showCard5"{
            return ZoomTransition(cardView: self.card5)
        }else if self.lastSegue?.identifier == "showCard8"{
            return ZoomTransition(cardView: self.card8)
        }else{
            return nil
        }
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }


}
