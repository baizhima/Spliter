//
//  ClientJoinViewController.swift
//  SplitMe
//
//  Created by Shan Lu on 15/10/15.
//  Copyright © 2015年 Shan Lu. All rights reserved.
//

import UIKit


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
        
        currMeal = Meal(splitCode: code, master: currUser)  // TODO master should be the server client
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
