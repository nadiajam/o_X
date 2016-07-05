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
    
    func getGames(onCompletion onCompletion: ([OXGame]?, String?) -> Void) {
        
        let a = OXGame()
        let b = OXGame()
        let c = OXGame()
        
        a.ID = 5
        a.host = "tobin"
        
        b.ID = 12
        b.host = "elvis"
        
        c.ID = 544
        b.host = "max"
        
        onCompletion([a,b,c], nil)
    }

}