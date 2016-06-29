//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var Container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func Logout(sender: AnyObject) {
        print ("logout selected")
    }
    
    @IBAction func buttons(sender: AnyObject) {
        print ("button \(sender.tag) selected")
    }

}

