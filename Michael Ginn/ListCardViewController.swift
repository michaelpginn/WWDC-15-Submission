//
//  ListCardViewController.swift
//  Michael Ginn
//
//  Created by Michael Ginn on 4/18/15.
//  Copyright (c) 2015 Michael Ginn. All rights reserved.
//

import UIKit

class ListCardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cardView: shadowView!
    @IBOutlet weak var tableView: UITableView!
    let languages = ["Swift", "Objective-C", "C++", "C#/Java", "Python", "DOS", "Linux/Unix", "HTML", "CSS", "CFML"]
    var colors:[UIColor] = []
    var tableData:[String] = []
    var timer:Timer? = nil
    var i = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.saveButton.isEnabled = false
        let defaults = UserDefaults.standard //check to see if this is viewed yet
        var cards:[Int] = defaults.object(forKey: "cards") as! [Int]
        if cards[0] == 1{
            self.saveButton.setImage(UIImage(named: "Checkmark-100.png"), for: .normal)
        } else{
            cards[0] = 1
            defaults.set(cards, forKey: "cards")
            defaults.synchronize()
        }
        
        var reds:[CGFloat] = [247, 248, 245, 210, 131, 46, 18, 18, 38, 61]
        var greens:[CGFloat] = [168, 137, 22, 0, 0, 0, 0, 81, 165, 255]
        var blues:[CGFloat] = [5, 8, 9, 11, 84, 138, 138, 163, 159, 83, 8]
            for j in 0...9{
            self.colors.append(UIColor(red: reds[j] / 255.0, green: greens[j] / 255.0, blue: blues[j] / 255.0, alpha: 1.0))
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, animations: {
            self.saveButton.alpha = 1.0
            self.saveButton.isEnabled = true
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(ListCardViewController.fillTableView), userInfo: nil, repeats: true)
            
        }
    }
    
    @objc func fillTableView(){
        
        if i < 10{
            self.tableData.append(self.languages[i])
            self.tableView.insertRows(at: [NSIndexPath(row: i, section: 0) as IndexPath], with: UITableViewRowAnimation.right)
            i += 1
        }else{
            self.timer?.invalidate()
        }
        
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath as IndexPath)
        cell.textLabel!.text = self.tableData[indexPath.row]
        cell.textLabel?.textColor = self.colors[indexPath.row]
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
