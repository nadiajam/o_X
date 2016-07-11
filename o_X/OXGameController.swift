//
//  OXGameController.swift
//  o_X
//
//  Created by Nadia Jamrozik on 6/29/16.
//  Copyright © 2016 iX. All rights reserved.
//

import Foundation

class OXGameController: WebService {
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
        currentGame.currentGameState()
    }
    
    func getGames(onCompletion: ([OXGame]?, String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games"), method: "GET", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            var OXGameArray: [OXGame] = []
            
            if (responseCode == 200)   {
                for item in json.arrayValue {
                    let OXGameInstance = OXGame()
                    OXGameInstance.ID = item["id"].intValue
                    OXGameInstance.host = item["host_user"]["uid"].stringValue
                    OXGameArray.append(OXGameInstance)
                }
                onCompletion(OXGameArray, nil)
            }  else    {
            let errorMessage = json["errors"]["full_messages"][0].stringValue
            onCompletion(nil,errorMessage)
            }
        })
    }
    
    
    func joinGame(gameNumber: Int, gameArray: [OXGame], onCompletion: (OXGame?, String?) -> Void) {
        
        let game = gameArray[gameNumber]
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(game.ID)/join"), method: "GET", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            if (responseCode == 200)   {
                self.currentGame.ID = game.ID
                self.currentGame.host = game.host
                onCompletion(self.currentGame, nil)
            }  else    {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(nil, errorMessage)
            }
        })
    }
    
    func hostGame(onCompletion: (OXGame?, String?) -> Void) {

        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/"), method: "POST", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            
            
            if (responseCode == 200)   {
                self.currentGame.ID = json["id"].intValue
                self.currentGame.host = json["host_user"]["uid"].stringValue
                onCompletion(self.currentGame, nil)
            }  else    {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(nil, errorMessage)
            }
        })
    }
    

    func viewGame(onCompletion: (OXGame?, String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com//games/\(self.currentGame.ID)"), method: "GET", parameters: nil)
            self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
                 
                if (responseCode == 200)   {
                    self.currentGame.deserialiseBoard(json["board"].stringValue)
                    onCompletion(self.currentGame, nil)
                }  else    {
                    let errorMessage = json["errors"]["full_messages"][0].stringValue
                    onCompletion(nil,errorMessage)
                }
            })
    }
    
    func networkPlayMove(onCompletion: (String?) -> Void) {
        
        let boardString = ["board":self.currentGame.serialiseBoard()]
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com/games/\(self.currentGame.ID)"), method: "PUT", parameters: boardString)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in
            print(json)
            
            if (responseCode == 200)   {
                onCompletion(nil)
            }  else    {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(errorMessage)
            }
        })
    }


    func cancelGame(onCompletion: (String?) -> Void) {
        
        let request = self.createMutableRequest(NSURL(string: "https://ox-backend.herokuapp.com//games/\(self.currentGame.ID)"), method: "DELETE", parameters: nil)
        self.executeRequest(request, requestCompletionFunction: {(responseCode, json) in

            if (responseCode == 200)   {
                self.currentGame.resetGame()
                onCompletion(nil)
            }  else    {
                let errorMessage = json["errors"]["full_messages"][0].stringValue
                onCompletion(errorMessage)
            }
        })
    }
    
    
}