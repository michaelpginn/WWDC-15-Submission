//
//  StartingViewController.swift
//  WWDC15
//
//  Created by Michael Ginn on 4/17/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var hiLabel: UILabel!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var andILabel: UILabel!
    @IBOutlet weak var introView: UIView!
    @IBOutlet weak var learnMoreView: UIView!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    let slideUpTransitionController = SlideUpTransitionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "finished")
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.learnMoreView.frame.origin.y = self.learnMoreView.frame.origin.y + 150

        UIView.animate(withDuration: 1.0, animations: {
            self.hiLabel.alpha = 1.0
        })
        UIView.animate(withDuration: 1.0, delay: 1.0, options: [], animations: {
            self.myNameLabel.alpha = 1.0
        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 2.0, options: [], animations: {
            self.andILabel.alpha = 1.0
            }, completion: nil)
        UIView.animate(withDuration: 2.0, delay: 3.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.introView.frame.origin.y = self.introView.frame.origin.y - 150
            self.learnMoreView.frame.origin.y = self.learnMoreView.frame.origin.y - 150
            }, completion: {
                finished in
                self.centerConstraint.constant = 150
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "continue" {
            let toViewController = segue.destination
            toViewController.transitioningDelegate = self
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return slideUpTransitionController
    }
    
}
