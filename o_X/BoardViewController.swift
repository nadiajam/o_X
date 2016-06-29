//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func Logout(sender: AnyObject) {
        print ("logout selected")
    }
    
    
    @IBAction func buttons(sender: AnyObject) {
        print ("button \(sender.tag) selected")
        gameObject.buttonCount += 1
        if gameObject.currentTurnType == CellType.X {
            gameObject.currentTurnType = CellType.O
        }
        else if gameObject.currentTurnType == CellType.O{
            gameObject.currentTurnType = CellType.X
        }
    }

    var gameObject = OXGame()
}

