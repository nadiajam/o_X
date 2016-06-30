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
    
    func getCurrentGame() -> OXGame {
        return currentGame
    }

    func restartGame1() {
        currentGame.resetGame()
    }

    func playMove(cellNumber: Int) {
        currentGame.playMove(cellNumber)
    }
    
    func gameWon() {
        currentGame.gameWon()
    }
    
    func gameState() {
        currentGame.currentGameStatus()
    }

}