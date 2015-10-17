//
//  TypeOwnDishesViewController.swift
//  SplitMe
//
//  Created by Shan Lu on 15/10/15.
//  Copyright © 2015年 Shan Lu. All rights reserved.
//

import UIKit


var soloDishArr = [Dish]()

class TypeOwnDishesViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UITableViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var dishField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    @IBOutlet weak var dishTable: UITableView!
    
    
    @IBAction func backPressed(sender: UIBarButtonItem) {
        if currUser.isHost {
            self.performSegueWithIdentifier("typeOwnDishesToServerWait", sender: self)
        } else {
            self.performSegueWithIdentifier("typeOwnDishesToClientJoin", sender: self)
        }
    }
    
    @IBAction func nextPressed(sender: UIBarButtonItem) {
        // extend currMeal.soloDishes by dishArr
        currMeal!.soloDishes.appendContentsOf(soloDishArr)
        if currUser.isHost {
            self.performSegueWithIdentifier("typeOwnDishesToServerTypeShareDishes", sender: self)
        } else {
            self.performSegueWithIdentifier("typeOwnDishesToClientWatchAllDishes", sender: self)
        }
    }
    
    @IBAction func addPressed(sender: UIButton) {
        if dishField!.text != "" && priceField!.text != "" {
            let currDish = Dish(name: dishField.text!, price: Double(priceField.text!)!, user: currUser)
            soloDishArr.append(currDish)
            dishField.text = ""
            priceField.text = ""
            dishTable.reloadData()
            dishField.becomeFirstResponder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = currMeal?.receiptImage
        self.scrollView.minimumZoomScale = 1.5
        self.scrollView.maximumZoomScale = 3.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        dishField.resignFirstResponder()
        priceField.resignFirstResponder()
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soloDishArr.count
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        let idx = soloDishArr.count-1-indexPath.row
        newCell.textLabel!.text = "\(soloDishArr[idx].name)"
        newCell.detailTextLabel?.text = "$" + String(NSString(format:"%.2f", soloDishArr[idx].price))
        return newCell
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
