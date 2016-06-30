//
//  OXGame.swift
//  o_X
//
//  Created by Nadia Jamrozik on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

enum CellType: String {
    case O = "O"
    case X = "X"
    case Empty = ""
}

enum OXGameState: String {
    case Inprogress
    case Tie
    case Won
}

class OXGame {
    
    //variables
    var buttonCount: Int = 0
    var currentTurnType: CellType = CellType.X
    var currentGameState: OXGameState = OXGameState.Inprogress
    
    //initialize board
    var board: [CellType] = [CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty]
    
    //refers to var buttonCount
    func turnCount() -> Int {
        return (self.buttonCount)
    }
    
    //returns whose turn it is
    func whoseTurn() -> CellType {
        return currentTurnType 
    }
    
    //registering moves as X or O in board array
    func playMove(cellNumb: Int) -> CellType {
        board[cellNumb] = currentTurnType
        
        if currentTurnType == CellType.X {
            currentTurnType = CellType.O
        }
        else if currentTurnType == CellType.O {
            currentTurnType = CellType.X
        }
        return currentTurnType
    }
    
    func gameWon() -> Bool {
        return  (board[0] == board[1] && board[1] == board[2] && board[0] != .Empty) ||
                (board[3] == board[4] && board[4] == board[5] && board[3] != .Empty) ||
                (board[6] == board[7] && board[7] == board[8] && board[6] != .Empty) ||
                (board[0] == board[3] && board[3] == board[6] && board[0] != .Empty) ||
                (board[1] == board[4] && board[4] == board[7] && board[1] != .Empty) ||
                (board[2] == board[5] && board[5] == board[8] && board[2] != .Empty) ||
                (board[0] == board[4] && board[4] == board[8] && board[0] != .Empty) ||
                (board[2] == board[4] && board[4] == board[6] && board[2] != .Empty)
    }
    
    func resetGame() {
        board = [CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty]
        buttonCount = 0
    }
    
    //returns the current game state...
    func currentGameStatus() -> OXGameState {
        if gameWon() == true {
            currentGameState = OXGameState.Won
        }
        else if self.turnCount() == 9 {
            currentGameState = OXGameState.Tie
        }
        return currentGameState
    }
    
}