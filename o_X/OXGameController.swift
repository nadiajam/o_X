//
//  OXGameController.swift
//  o_X
//
//  Created by Nadia Jamrozik on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGameController {
    static let sharedInstance = OXGameController()


    private var currentGame: OXGame = OXGame()

//    Implement the following methods. You need to decide the inputs and outputs of each methods as well as the logic to make the game work.
//    getCurrentGame
//    restartGame
//    playMove. Should call playMove on the OXGame
    
    func getCurrentGame() -> OXGame {
        return currentGame
    }

    func resetGame() {
        currentGame.reset()
        print("hi")
    }

    func playMove(cellNumber: Int) {
        currentGame.playMove(cellNumber)
    }

}