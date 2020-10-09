//
//  BioViewController.swift
//  Michael Ginn
//
//  Created by Michael Ginn on 4/18/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit

class BioViewController: UIViewController, UIViewControllerTransitioningDelegate {
    let slideLeftTransitionController = SlideLeftTransitionController()
    let slideRightTransitionController = SlideRightTransitionController()
    let longFadeTransitionController = LongFade()
    var lastSegue:UIStoryboardSegue? = nil
    var lastFrame:CGRect? = nil
    
    @IBOutlet weak var card2: shadowImageView!
    @IBOutlet weak var card6: shadowImageView!
    @IBOutlet weak var card7: shadowImageView!

    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        var cards:[Int] = defaults.object(forKey: "cards") as! [Int]
        
        //if any card is already viewed, grey it out
        if cards[1] == 1{
            self.card2.setImage(UIImage(named: "card2 grey"), for: .normal)
            self.card2.alpha = 0.4
        }
        if cards[5] == 1{
            self.card6.setImage(UIImage(named: "card6 grey"), for: .normal)
            self.card6.alpha = 0.4
        }
        if cards[6] == 1{
            self.card7.setImage(UIImage(named: "card7 grey"), for: .normal)
            self.card7.alpha = 0.4
        }

        
        self.finishButton.setImage(UIImage(named:"Enter Filled-100.png"), for: UIControlState.highlighted)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        var cards:[Int] = defaults.object(forKey: "cards") as! [Int]
        //show the user the transition to faded
        if cards[1] == 1{
            UIView.transition(with: self.card2, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.card2.setImage(UIImage(named: "card2 grey"), for: .normal)
                self.card2.alpha = 0.4
                }, completion: nil)
        }
        if cards[5] == 1{
            UIView.transition(with: self.card2, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.card6.setImage(UIImage(named: "card6 grey"), for: .normal)
                self.card6.alpha = 0.4
                }, completion: nil)
        }
        if cards[6] == 1{
            UIView.transition(with: self.card2, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.card7.setImage(UIImage(named: "card7 grey"), for: .normal)
                self.card7.alpha = 0.4
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
        for (id, view) in [2:self.card2, 6:self.card6, 7:self.card7]{ //check each card
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
    
    @IBAction func card2(sender: shadowImageView) {
        _ = UserDefaults.standard
        //var cards:[Int] = defaults.objectForKey("cards") as! [Int]
        
        UIView.transition(with: self.card2, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
            self.card2.setImage(UIImage(named: "card.png"), for: UIControlState.normal)
            }, completion: {
                finished in
                self.lastFrame = self.card2.frame
                self.performSegue(withIdentifier: "showMapCard", sender: self)
                
                
        })
        
    }
    @IBAction func card6(sender: shadowImageView) {
        _ = UserDefaults.standard
        //var cards:[Int] = defaults.objectForKey("cards") as! [Int]
        
        UIView.transition(with: self.card6, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
            self.card6.setImage(UIImage(named: "card.png"), for: UIControlState.normal)
            }, completion: {
                finished in
                self.lastFrame = self.card6.frame
                self.performSegue(withIdentifier: "showCard6", sender: self)

        })
        

    }
    @IBAction func card7(sender: AnyObject) {
        _ = UserDefaults.standard
        //var cards:[Int] = defaults.objectForKey("cards") as! [Int]
        
        UIView.transition(with: self.card7, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
            self.card7.setImage(UIImage(named: "card.png"), for: UIControlState.normal)
            }, completion: {
                finished in
                self.lastFrame = self.card7.frame
                self.performSegue(withIdentifier: "showCard7", sender: self)

        })

    }
    // MARK: - Navigation
    
    @IBAction func showFinish(sender: AnyObject) {
        self.performSegue(withIdentifier: "finish", sender: self)
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toViewController = segue.destination 
        toViewController.transitioningDelegate = self
        self.lastSegue = segue
        
        if segue.identifier == "showCard6"{
            (toViewController as! TextCardViewController).cardId = "6"
        } else if segue.identifier == "showCard7"{
            (toViewController as! TextCardViewController).cardId = "7"
        }
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if self.lastSegue?.identifier == "moveOn"{
            return slideLeftTransitionController
        }else if self.lastSegue?.identifier == "showMapCard" {
            return ZoomTransition(cardView: self.card2)
        }else if self.lastSegue?.identifier == "showCard6"{
            return ZoomTransition(cardView: self.card6)
        }else if self.lastSegue?.identifier == "showCard7"{
            return ZoomTransition(cardView: self.card7)
        }else if self.lastSegue?.identifier == "finish"{
            return longFadeTransitionController
        }else{
            return slideLeftTransitionController
        }
    }

    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if self.lastSegue?.identifier == "moveOn"{
            return slideRightTransitionController
        }else if self.lastSegue?.identifier == "showMapCard" || self.lastSegue?.identifier == "showCard6" || self.lastSegue?.identifier == "showCard7"{
            return nil
        }else if self.lastSegue?.identifier == "finish"{
            return longFadeTransitionController
        }else{
            return slideLeftTransitionController
        }
    }

}
