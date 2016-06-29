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
    var buttonCount:Int = 0
    var currentTurnType:CellType = CellType.X     // is there a way to make this set to startType???
    
    private var board: [CellType] = [CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty]
    
    private var startType: CellType = CellType.X
    
    func turnCount() -> Int {
        return (self.buttonCount)
    }
    
    func whoseTurn() -> CellType {
        
        if currentTurnType == CellType.X {
            return CellType.X
        }
        else {
            return CellType.O
        }
    }
    
    func playMove(cellNumb: Int) -> CellType {
        board[cellNumb] = currentTurnType
        return currentTurnType
    }
    
    func gameWon() -> Bool {
        if (
            ((board[0], board[1]) == (board[1], board[2]) &&  board[0] != .Empty) ||
        ((board[3], board[4]) == (board[4], board[5]) &&  board[3] != .Empty) ||
        ((board[6], board[7]) == (board[7], board[8]) &&  board[6] != .Empty) ||
        ((board[0], board[3]) == (board[3], board[6]) &&  board[0] != .Empty) ||
        ((board[1], board[4]) == (board[4], board[7]) &&  board[1] != .Empty) ||
        ((board[2], board[5]) == (board[5], board[8]) &&  board[2] != .Empty) ||
        ((board[0], board[4]) == (board[4], board[8]) &&  board[0] != .Empty) ||
        ((board[2], board[4]) == (board[4], board[6]) &&  board[2] != .Empty)
        )
            {
            return true
        } else {
            return false
        }
    }
    
    func reset() {
        board = [CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty, CellType.Empty]
        buttonCount = 0
    }

}