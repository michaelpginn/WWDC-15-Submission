//
//  EducationViewController.swift
//  Michael Ginn
//
//  Created by Michael Ginn on 4/18/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit

class EducationViewController: UIViewController, UIViewControllerTransitioningDelegate  {
    let slideLeftTransitionController = SlideLeftTransitionController()
    let slideRightTransitionController = SlideRightTransitionController()
    var lastSegue:UIStoryboardSegue? = nil
    var lastFrame:CGRect? = nil
    
    @IBOutlet weak var card1: shadowImageView!
    @IBOutlet weak var card4: shadowImageView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        var cards:[Int] = defaults.object(forKey: "cards") as! [Int]
        //if a card is already viewed, grey it out
        if cards[0] == 1{
            self.card1.setImage(UIImage(named: "card1 grey"), for: .normal)
            self.card1.alpha = 0.4
        }
        if cards[3] == 1{
            self.card4.setImage(UIImage(named: "card4 grey"), for: .normal)
            self.card4.alpha = 0.4
        }
        self.finishButton.setImage(UIImage(named:"Enter Filled-100.png"), for: UIControlState.highlighted)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        var cards:[Int] = defaults.object(forKey: "cards") as! [Int]
        //show the user the transition to faded
        if cards[0] == 1{
            UIView.transition(with: self.card1, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.card1.setImage(UIImage(named: "card1 grey"), for: .normal)
                self.card1.alpha = 0.4
                }, completion: nil)
        }
        if cards[3] == 1{
            UIView.transition(with: self.card4, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.card4.setImage(UIImage(named: "card4 grey"), for: .normal)
                self.card4.alpha = 0.4
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
        for (id, view) in [1:self.card1, 4:self.card4]{ //check each card
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
    @IBAction func card4(sender: AnyObject) {
        let defaults = UserDefaults.standard
        var _:[Int] = defaults.object(forKey: "cards") as! [Int]
        
        UIView.transition(with: self.card4, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
            self.card4.setImage(UIImage(named: "card.png"), for: UIControlState.normal)
            }, completion: {
                finished in
                self.lastFrame = self.card4.frame
                self.performSegue(withIdentifier: "showCard4", sender: self)
        
        })
    }
    @IBAction func card1(sender: AnyObject) {
        let defaults = UserDefaults.standard
        var _:[Int] = defaults.object(forKey: "cards") as! [Int]
        
        UIView.transition(with: self.card1, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
            self.card1.setImage(UIImage(named: "card.png"), for: UIControlState.normal)
            }, completion: {
                finished in
                self.lastFrame = self.card1.frame
                self.performSegue(withIdentifier: "showCard1", sender: self)
        })

    }
    @IBAction func showFinish(sender: AnyObject) {
        self.performSegue(withIdentifier: "finish", sender: self)
    }

    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let toViewController = segue.destination 
        toViewController.transitioningDelegate = self
        self.lastSegue = segue
        
        if segue.identifier == "showCard4"{
            (toViewController as! TextCardViewController).cardId = "4"
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if self.lastSegue?.identifier == "moveOn"{
            return slideLeftTransitionController
        }else if self.lastSegue?.identifier == "showCard1" {
            return ZoomTransition(cardView: self.card1)
        }else if self.lastSegue?.identifier == "showCard4"{
            return ZoomTransition(cardView: self.card4)
        }else{
            return slideLeftTransitionController
        }
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if self.lastSegue?.identifier == "moveOn"{
            return slideRightTransitionController
        }else if self.lastSegue?.identifier == "showCard1" || self.lastSegue?.identifier == "showCard4"{
            return nil
        } else{
            return slideLeftTransitionController
        }
    }
}
