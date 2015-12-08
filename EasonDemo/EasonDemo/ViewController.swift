//
//  ViewController.swift
//  EasonDemo
//
//  Created by Jie Cao on 12/5/15.
//  Copyright © 2015 Jie Cao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var tweets:[Tweet]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableViewCell:UITableViewCell = self.tableView .dequeueReusableCellWithIdentifier("tableViewCell", forIndexPath: indexPath)
        tableViewCell.detailTextLabel?.text = tweets![indexPath.row].user?.name
        tableViewCell.textLabel?.text = tweets![indexPath.row].text
        
        return tableViewCell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets{
            return tweets.count
        }
        return 0
    }


}

