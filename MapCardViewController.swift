//
//  MapCardViewController.swift
//  Michael Ginn
//
//  Created by Michael Ginn on 4/18/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapCardViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cardView: shadowView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.saveButton.isEnabled = false
        let defaults = UserDefaults.standard //check to see if this is viewed yet
        var cards:[Int] = defaults.object(forKey: "cards") as! [Int]
        if cards[1] == 1{
            self.saveButton.setImage(UIImage(named: "Checkmark-100.png"), for: .normal)
        } else{
            cards[1] = 1
            defaults.set(cards, forKey: "cards")
            defaults.synchronize()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.initialMap()
        })
    }
    func initialMap(){
        let usCenter = CLLocationCoordinate2DMake(39.8282, -98.5795)
        let span = MKCoordinateSpanMake(50.0, 50.0)
        let usRegion = MKCoordinateRegionMake(usCenter, span)
        self.mapView.setRegion(self.mapView.regionThatFits(usRegion), animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.zoomToMe()
        })
    }
    
    
    func zoomToMe(){
        let home = MKPointAnnotation()
        home.coordinate = CLLocationCoordinate2DMake(43.0943810, -88.3028280)
        home.title = "Where I live"
        self.mapView.addAnnotation(home)
        let viewRegion = MKCoordinateRegionMakeWithDistance(home.coordinate, 10000, 10000)
        self.mapView.setRegion(self.mapView.regionThatFits(viewRegion), animated: true)
        self.saveButton.isEnabled = true
        UIView.animate(withDuration: 0.4, animations: {
            self.saveButton.alpha = 1.0
        })
    }

    @IBAction func save(sender: AnyObject) {
        UIView.animate(withDuration: 1.3, delay: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.cardView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.cardView.frame.origin.y = self.saveButton.frame.origin.y + 100
            
            }, completion: {
                finished in
                self.dismiss(animated: true, completion: nil)
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
