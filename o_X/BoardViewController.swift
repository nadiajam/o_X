//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {


    @IBOutlet weak var container: UIView!
    @IBOutlet weak var newGameButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.restartGame()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //logout of current game
    @IBAction func Logout(sender: AnyObject) {
        UserController.sharedInstance.logout(onCompletion: { message in
            let viewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController()
            let window = UIApplication.sharedApplication().keyWindow
            window?.rootViewController = viewController
        })
    }
    
    
    //button pressed on board
    @IBAction func buttons(sender: UIButton) {
        OXGameController.sharedInstance.playMove(sender.tag)
        OXGameController.sharedInstance.gameState()
        sender.setTitle(OXGameController.sharedInstance.getCurrentGame().whoseTurn().rawValue, forState: .Normal) 
        
        sender.enabled = false
        
        if OXGameController.sharedInstance.getCurrentGame().gameWon() {
            OXGameController.sharedInstance.getCurrentGame().currentGameState = OXGameState.Inprogress
            print("\(OXGameController.sharedInstance.getCurrentGame().currentTurnType) wins, congrats!")
            newGameButton.hidden = false
            
            for button in container.subviews {
                if let value = button as? UIButton {
                    value.enabled = false
                }
            }
            
            //UIAlert
            let whoWon: String = "\(OXGameController.sharedInstance.getCurrentGame().currentTurnType) Won"
            let alert = UIAlertController(title: "Game Over", message: whoWon, preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler:  { (action) in
                self.newGameButton.hidden = false
            })
            alert.addAction(alertAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        if ( OXGameController.sharedInstance.getCurrentGame().currentGameStatus() == OXGameState.Tie ) {
            OXGameController.sharedInstance.getCurrentGame().currentGameState = OXGameState.Inprogress
            newGameButton.hidden = false
            
            //UIAlert
            let alert = UIAlertController(title: "Game Over", message: "Tie", preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler:  { (action) in
                self.newGameButton.hidden = false
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
        newGameButton.hidden = true
    }
}

