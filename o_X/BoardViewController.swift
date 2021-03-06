//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var newGameButton: UIButton!
    var networkMode: Bool = false

    override func viewDidLoad() {
//        print (OXGameController.sharedInstance.getCurrentGame().board)
//        super.viewDidLoad()
        newGameButton?.hidden = true
        
//        if networkMode {
//            self.updateUI()
//        }
        self.updateUI()
    }
        
    @IBAction func Logout(sender: AnyObject) {
        UserController.sharedInstance.logout(onCompletion: { message in
            let viewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController()
            let window = UIApplication.sharedApplication().keyWindow
            window?.rootViewController = viewController
        })
    }
    
    @IBAction func refreshGameButtonPressed(sender: AnyObject) {
        OXGameController.sharedInstance.viewGame({ newGame, message in
            if message == nil {
                self.updateUI()
            } else {
                let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default)  { (action: UIAlertAction) in }
                errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func deleteGameButtonPressed(sender: AnyObject) {
        OXGameController.sharedInstance.cancelGame({ message in
            if message == nil {
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default)  { (action: UIAlertAction) in }
                errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func buttons(sender: UIButton) {
        OXGameController.sharedInstance.playMove(sender.tag)
        OXGameController.sharedInstance.gameState()
        sender.setTitle(OXGameController.sharedInstance.getCurrentGame().whoseTurn().rawValue, forState: .Normal)
        
        sender.enabled = false
        
        if networkMode {
            OXGameController.sharedInstance.networkPlayMove({ message in
                if message != nil {
                    let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                    let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default)  { (action: UIAlertAction) in }
                    errorAlert.addAction(dismissErrorAlert)
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                }
            })
        }
        
        if OXGameController.sharedInstance.getCurrentGame().gameWon() {
//            OXGameController.sharedInstance.getCurrentGame().currentGameState = OXGameState.Inprogress
            print("\(OXGameController.sharedInstance.getCurrentGame().whoseTurn()) wins, congrats!")
            newGameButton?.hidden = false
            
            for button in container.subviews {
                if let value = button as? UIButton {
                    value.enabled = false
                }
            }
            
            //UIAlert
            let whoWon: String = "\(OXGameController.sharedInstance.getCurrentGame().whoseTurn()) Won"
            let alert = UIAlertController(title: "Game Over", message: whoWon, preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler:  { (action) in
                self.newGameButton?.hidden = false
            })
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        if ( OXGameController.sharedInstance.getCurrentGame().currentGameState() == OXGameState.Tie ) {
//            OXGameController.sharedInstance.getCurrentGame().currentGameState = OXGameState.Inprogress
            newGameButton?.hidden = false
            
            //UIAlert
            let alert = UIAlertController(title: "Game Over", message: "Tie", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler:  { (action) in
                self.newGameButton?.hidden = false
            })
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    //restart board
    
    @IBAction func newGame(sender: UIButton) {
        self.restartGame()
    }
    
    func restartGame() {
        OXGameController.sharedInstance.restartGame1()
        for case let apple as UIButton in container.subviews {
            apple.setTitle("", forState: .Normal)
            apple.enabled = true
        }
    }

    func updateUI() {
        let board = OXGameController.sharedInstance.getCurrentGame().board
        for view in container.subviews {
            if let button = view as? UIButton {
                button.setTitle(board[button.tag].rawValue, forState: .Normal)
            }
        }
    
    }
}

