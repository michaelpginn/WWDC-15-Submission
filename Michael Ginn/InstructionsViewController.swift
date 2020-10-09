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
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toViewController = segue.destination
        toViewController.transitioningDelegate = self
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return slideLeftTransitionController
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return slideRightTransitionController
    }

}
