//
//  ZoomTransition.swift
//  Michael Ginn
//
//  Created by Michael Ginn on 4/18/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit


class ZoomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var startFrame:CGRect? = nil
    var cardView:shadowImageView? = nil
    
    init(cardView:shadowImageView?) {
        self.cardView = cardView
        self.startFrame = cardView?.frame
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        let snapshot = toViewController.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = self.startFrame!
        containerView.addSubview(snapshot!)
        
        
        
        UIView.animate(withDuration: 1.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            snapshot?.frame = fromViewController.view.frame
            }, completion: {
                finished in
                containerView.addSubview(toViewController.view)
                snapshot?.removeFromSuperview()
                transitionContext.completeTransition(true)
        })
    }
}
