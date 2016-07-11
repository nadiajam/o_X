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
    var ID: Int = 0
    var host: String = ""
    
    //initialize board
    var board = [CellType](count: 9, repeatedValue: .Empty)
    
    //refers to var buttonCount
    func turnCount() -> Int {
        var buttonNumber: Int = 0
        for button in board {
            if button != CellType.Empty {
                buttonNumber += 1
            }
        }
        return buttonNumber
    }
    
    //returns whose turn it is
    func whoseTurn() -> CellType {
        if turnCount()%2 == 0 {
            return CellType.O
        } else {
            return CellType.X
        }
    }
    
    //registering moves as X or O in board array
    func playMove(cellNumb: Int) {
        if whoseTurn() == CellType.X {
            board[cellNumb] = CellType.O
        }
        else if whoseTurn() == CellType.O {
            board[cellNumb] = CellType.X
        }
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
    }
    
    //returns the current game state...
    func currentGameState() -> OXGameState {
        if gameWon() == true {
            return OXGameState.Won
        }
        else if self.turnCount() == 9 {
            return OXGameState.Tie
        }
    //potentially add in network mode if statement for the other OXGameStates (open, closed)
        else { return OXGameState.Inprogress }
    }

    func deserialiseBoard(boardString:String) {
        var newBoard:[CellType] = []
        
        for character in boardString.characters {
            if character == "o" {
                newBoard.append(CellType.O)
            }
            if character == "x" {
                newBoard.append(CellType.X)
            }
            if character == "_" {
                newBoard.append(CellType.Empty)
            }
        }
        board = newBoard
    }
    
    func serialiseBoard() -> String {
        var newString:String = ""
        
        for item in board {
            if item == CellType.O {
                newString.appendContentsOf("o")
            }
            if item == CellType.X {
                newString.appendContentsOf("x")
            }
            if item == CellType.Empty {
                newString.appendContentsOf("_")
            }
        }
        return newString
    }
    
    init()  {
        //we are simulating setting our board from the internet
//        let simulatedBoardStringFromNetwork = "_________" //update this string to different values to test your model serialisation
//        deserialiseBoard(simulatedBoardStringFromNetwork) //your OXGame board model should get set here
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
    }
    
}