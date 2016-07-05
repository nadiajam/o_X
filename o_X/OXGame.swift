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
    case Open  //game w no opponent yet
    case Abandoned  //game that one player has cancelled
}

class OXGame {
    
    //variables
    var buttonCount: Int = 0
    var currentTurnType: CellType = CellType.X
    var currentGameState: OXGameState = OXGameState.Inprogress
    var ID: Int = 0
    var host: String = ""
    
    //initialize board
    var board = [CellType](count: 9, repeatedValue: .Empty)
    
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
        buttonCount += 1
        
        if currentTurnType == CellType.X {
            currentTurnType = CellType.O
        }
        else if currentTurnType == CellType.O {
            currentTurnType = CellType.X
        }
        return board[cellNumb]
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
        board = [CellType](count: 9, repeatedValue: .Empty)
        currentTurnType = .X
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
    
    //class stuff
//    private func deserialiseBoard(boardString: String) -> [CellType] {
//        var board:String = ["_________"]
//        for item in (0...9) {
//            if ( boardString.characters[item] ) == "x" {
//                board[item] = CellType.X
//            }
//        }
//        for item in (0...9) {
//            if ( boardString.characters[item] ) == "o" {
//                board[item] = CellType.O
//            }
//        }
//        for item in (0...9) {
//            if ( boardString.characters[item] ) == "_" {
//                board[item] = CellType.Empty
//            }
//        }
//    }
//    private func serialiseBoard() -> String {
//        
//    }
//    
//    init()  {
//        init()
//        //we are simulating setting our board from the internet
//        let simulatedBoardStringFromNetwork = "o________" //update this string to different values to test your model serialisation
//        self.board = deserialiseBoard(simulatedBoardStringFromNetwork) //your OXGame board model should get set here
//        if(simulatedBoardStringFromNetwork == serialiseBoard())    {
//            print("start\n------------------------------------")
//            print("congratulations, you successfully deserialised your board and serialized it again correctly. You can send your data model over the internet with this code. 1 step closer to network OX ;)")
//            
//            print("done\n------------------------------------")
//        }   else    {
//            print("start\n------------------------------------")
//            print ("your board deserialisation and serialization was not correct :( carry on coding on those functions")
//            
//            print("done\n------------------------------------")
//        }
//        
//    }
    
}