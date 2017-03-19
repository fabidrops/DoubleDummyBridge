//
//  MinMax.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 26.02.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

// MinMax-Algorythmus
// mit alpha/beta pruning

func miniMax( game: gameBoard, deep: Int, alpha: Int, beta: Int , turnNS: Bool) -> Int {
    
    var game = game
    let alpha = alpha
    let beta = beta
    
    let playableCards = game.playableCardsOfCurrentPlayer()
    
    // Spiel zu Ende -> Bewertung vornehmen
    if deep == 0 || playableCards.count == 0 {
        
        return game.tricksWonByNorthSouth
        
    }
    
    // Wer ist dran ? N/S hier gehts weiter sonst im Else Zweig für O/W
    
    if turnNS {
        
        var value: Int
        var maxValue = alpha
        
        for card in playableCards {
            
            // Kopie des gameBoards anlegen
            let kopieBoard = gameBoard(hands: game.hands, tricksNS: game.tricksWonByNorthSouth, tricksEW: game.tricksWonByEastWest, trickCurrent: game.trickCurrent, trump: game.trump, leader: game.trickLeader, trickSuit: game.trickSuit, playerShape: game.playerShape, cardsPlayed: game.cardsPlayed, playerCurrent: game.playerCurrent)
            
            // Führe Karte aus
            
            game.playCard(card: card)
            
            value = miniMax(game: game , deep: deep - 1, alpha: maxValue, beta: beta, turnNS: (game.playerCurrent == 1 || game.playerCurrent == 3 ))
            
            // Karte rückgängig machen
            
            game = kopieBoard
            
            // Beta - CutOff ?
            
            if (value > maxValue) {
                
                maxValue = value
                
                if (maxValue >= beta) {
                    
                    // Zug ist widerlegt, alle anderen Züge können verworfen werden, weil dieser Zweig nie gewählt würde vom minimierenden Spieler
                    
                    break
                    
                }
                
            }
            
        }
        
        return maxValue
        
    } else {
        
        // OW am Stich
        
        var value: Int
        var minValue = beta
        
        for card in playableCards {
            
            // Kopie des gameBoards anlegen
            let kopieBoard = gameBoard(hands: game.hands, tricksNS: game.tricksWonByNorthSouth, tricksEW: game.tricksWonByEastWest, trickCurrent: game.trickCurrent, trump: game.trump, leader: game.trickLeader, trickSuit: game.trickSuit, playerShape: game.playerShape, cardsPlayed: game.cardsPlayed, playerCurrent: game.playerCurrent)
            
            // Führe Karte aus
            
            game.playCard(card: card)
            
            value = miniMax(game: game , deep: deep - 1, alpha: alpha, beta: minValue, turnNS: (game.playerCurrent == 1 || game.playerCurrent == 3 ))
           
            // Karte rückgängig machen
                        
            game = kopieBoard
            
            // Alpha - CutOff ?
            
            if (value < minValue) {
                
                minValue = value
                
                if (minValue <= alpha) {
                    
                    // Zug ist widerlegt, alle anderen Züge können verworfen werden, weil dieser Zweig nie gewählt würde vom maximierenden Spieler
                    
                    break
                    
                }
                
            }
            
        }
        
        return minValue
        
    }
    
}
