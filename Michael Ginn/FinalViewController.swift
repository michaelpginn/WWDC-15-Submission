//
//  FinalViewController.swift
//  Michael Ginn
//
//  Created by Michael Ginn on 4/25/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {


    @IBOutlet var constraints: [NSLayoutConstraint]!
    var locations:[UIButton:CGPoint] = [:]
    @IBOutlet var cards: [UIButton]!
    @IBOutlet weak var returnView: UIView!
    @IBOutlet weak var thanksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for card in cards{
            card.alpha = 0.0
        }
        
        self.thanksLabel.alpha = 0.0
        self.returnView.alpha = 0.0
        for view in self.returnView.subviews{
            (view ).alpha = 0.0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.animateCards()
        })
    }
    
    func animateCards(){
        
        for i in 0 ..< cards.count {
            UIView.animate(withDuration: 0.5, delay: Double(i) * 0.3, options: .curveEaseInOut, animations: {
                self.cards[i].alpha = 1.0
            }, completion: nil)
        }
        
        for constraint in self.constraints{
            constraint.constant = 0
        }
        UIView.animate(withDuration: 1.0, delay: 5.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: {
                finished in
                UIView.animate(withDuration: 0.5, animations: {
                    self.thanksLabel.alpha = 1.0
                    }, completion: {
                        finished in
                        self.returnView.alpha = 1.0
                        for view in self.returnView.subviews{
                            (view ).alpha = 1.0
                        }
                })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToCards(sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "finished")
        defaults.synchronize()
        self.dismiss(animated: true, completion: nil)
    }


}
