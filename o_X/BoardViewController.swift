//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var GameButton0: UIButton!
    @IBOutlet weak var GameButton1: UIButton!
    @IBOutlet weak var GameButton2: UIButton!
    @IBOutlet weak var GameButton3: UIButton!
    @IBOutlet weak var GameButton4: UIButton!
    @IBOutlet weak var GameButton5: UIButton!
    @IBOutlet weak var GameButton6: UIButton!
    @IBOutlet weak var GameButton7: UIButton!
    @IBOutlet weak var GameButton8: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func Logout(sender: AnyObject) {
        print ("logout selected")
        
    }
    
    
    @IBAction func buttons(sender: UIButton) {
        print ("button \(sender.tag) selected")
        OXGameController.sharedInstance.getCurrentGame().buttonCount += 1
        OXGameController.sharedInstance.playMove(sender.tag)
        sender.setTitle(OXGameController.sharedInstance.getCurrentGame().whoseTurn().rawValue, forState: .Normal)
//        sender.enabled = false
    }
    
    @IBAction func newGame(sender: AnyObject) {
        self.restartGame()
    }
    
    func restartGame() {
//        func reset() {
            board = [CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty]
            //        buttonCount = 0        //sets the titles of the cell buttons to “” (empty string)
//        GameButton0.enabled = true
//        GameButton1.enabled = true
//        GameButton2.enabled = true
//        GameButton3.enabled = true
//        GameButton4.enabled = true
//        GameButton5.enabled = true
//        GameButton6.enabled = true
//        GameButton7.enabled = true
//        GameButton8.enabled = true
}

