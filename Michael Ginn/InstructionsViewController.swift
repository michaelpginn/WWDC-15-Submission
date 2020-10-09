//
//  InstructionsViewController.swift
//  Michael Ginn
//
//  Created by Michael Ginn on 4/17/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var instructionsView: UIView!
    let slideLeftTransitionController = SlideLeftTransitionController()
    let slideRightTransitionController = SlideRightTransitionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.instructionsView.layer.borderColor = UIColor.white.cgColor
        
        let defaults = UserDefaults.standard
        defaults.set([0,0,0,0,0,0,0,0,0], forKey: "cards")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let toViewController = segue.destination
        toViewController.transitioningDelegate = self
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return slideLeftTransitionController
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return slideRightTransitionController
    }

}
