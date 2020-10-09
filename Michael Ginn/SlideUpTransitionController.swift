//
//  SlideUpTransitionController.swift
//  Michael Ginn
//
//  Created by Michael Ginn on 4/17/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit

class SlideUpTransitionController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
        containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            toViewController.view.frame.origin.y = 0
            fromViewController.view.frame.origin.y = 0 - fromViewController.view.frame.height
            }, completion: {
                finished in
                transitionContext.completeTransition(true)
        })
    }
}
