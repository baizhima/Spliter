//
//  ClientJoinViewController.swift
//  SplitMe
//
//  Created by Shan Lu on 15/10/15.
//  Copyright © 2015年 Shan Lu. All rights reserved.
//

import UIKit
import Parse


class ClientJoinViewController: UIViewController {

    
    @IBOutlet weak var inputCodeField: UITextField!
    
    @IBOutlet weak var connectInfo: UILabel!
    
    @IBAction func backPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("clientJoinToHome", sender: self)
    }
    
    
    @IBAction func confirmPressed(sender: UIButton) {
        let code = Int(inputCodeField!.text!)!
        if code > 9999 || code < 1000 {
            connectInfo.text = "Code is 4 digits"
            connectInfo.hidden = false
            return
        }
        connectInfo.text = "Connecting \(code)..."
        connectInfo.hidden = false
        // connecting
        
        let query = PFQuery(className:"Meal")
        query.whereKey("splitCode", equalTo: code)
        do {
            let mealArray = try query.findObjects()
            if mealArray.count > 0 {
                mealId = mealArray[0].objectId!
                connectInfo.text = "Join successfully"
                print(mealId)
                
                
            } else {
                connectInfo.text = "Invalid splitCode"
                
                return
            }
        } catch _ {
            
        }
        let query2 = PFQuery(className:"Meal")
        query2.getObjectInBackgroundWithId(mealId) {
            (meal: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let meal = meal {
                meal.addUniqueObject(userId, forKey:"users")
                meal.saveInBackground()
            }
        }
        
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectInfo.hidden = true
        // Do any additional setup after loading the view.
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
