//
//  NetworkGamesTableViewController.swift
//  o_X
//
//  Created by Nadia Jamrozik on 7/4/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class NetworkGamesTableViewController: UITableViewController {
    
    var gamesArray: [OXGame] = []
    
    @IBAction func dismissButtonPressed(sender: AnyObject) {
        [self .dismissViewControllerAnimated(true, completion:nil)]
        print("dismiss pressed")
    }
    
    @IBAction func addGameButtonPressed(sender: AnyObject) {
        OXGameController.sharedInstance.hostGame { (newGame, message) in
            if message == nil {
                self.performSegueWithIdentifier("networkSegue", sender: self)
            } else {
                let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default)  { (action: UIAlertAction) in }
                errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OXGameController.sharedInstance.getGames { games, error in
            self.gamesArray = games!
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GameCell", forIndexPath: indexPath)
        cell.textLabel?.text = "\(gamesArray[indexPath.row].ID), hosted by \(gamesArray[indexPath.row].host)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        OXGameController.sharedInstance.joinGame(indexPath.row, gameArray: gamesArray, onCompletion: { newGame, message in
            if message == nil {
                self.performSegueWithIdentifier("networkSegue", sender: self)
            } else {
                let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default)  { (action: UIAlertAction) in }
                errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
            }
        })
        return
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nextView = segue.destinationViewController as? BoardViewController {
            nextView.networkMode = true
        }
    }
}
