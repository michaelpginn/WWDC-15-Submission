//
//  LongFade.swift
//  Michael Ginn
//
//  Created by Michael Ginn on 4/25/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit

class LongFade: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 3.0
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        _ = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        _ = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        _ = UIScreen.main.bounds
        
        let snapshot = toViewController.view.snapshotView(afterScreenUpdates: true)
        snapshot?.alpha = 0.0
        containerView.addSubview(snapshot!)
        
        UIView.animate(withDuration: 1.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            snapshot?.alpha = 1.0
            }, completion: {
                finished in
                containerView.addSubview(toViewController.view)
                snapshot?.removeFromSuperview()
                transitionContext.completeTransition(true)
        })
        
    }
}
