//
//  MinMax.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 26.02.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

// MinMax-Algorythmus
// Alpha/Beta pruning
// Hash Table
// TO DO: Killer Moves

func miniMax( game: gameBoard, deep: Int, alpha: Int, beta: Int , turnNS: Bool) -> Int {
    
    GLOBALCOUNTER_MINMAX += 1
    
    var game = game
    let alpha = alpha
    let beta = beta
    
    let playableCards = game.playableCardsOfCurrentPlayer()
    
    // Spiel zu Ende -> Bewertung vornehmen
    if deep == 0 || playableCards.count == 0  {
        
        GLOBALCOUNTER_CALCULATE_LAST += 1
        return game.tricksWonByNorthSouth
        
    }
    
     // HASH-Table Look-Up BEGINN
    
    let hashIndexActual = game.hashIndex()
    
    // Hash Position nur am Anfang eines Stiches
    let hashFlag = (game.trickCurrent.count == 0)
    
    // Hash Typus: resultierte der Wert aus einem Cut-Off oder war er exkat berechnet
    var hashFlagStore = 0 // 0 = exakt ; 1 = lower bound ; 2 = upper bound

    if let hashValue = hashTableAlphaBeta[hashIndexActual] {

        if hashFlag == true {
            
            GLOBALCOUNTER_HASHTAG += 1
            
            switch hashValue[1] {
                
                case 0: return hashValue[0] // exakter Wert
                
                case 1: // lower bound
                    
                    if (hashValue[0] >= beta) {
                            return hashValue[0]
                        }
                
                case 2: // upper bound
                    
                    if (hashValue[0] <= alpha) {
                            return hashValue[0]
                        }
                
                default: return hashValue[0] // kommt nicht vor
                
            }

        }
        
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
                    
                    // Max variiert immer nur das Alpha, Zug für Zug sucht es immer bessere Züge
                    // wenn es aber Beta erreicht muss nicht weiter gesucht werden, da der Min-Player
                    // schon bessere Varianten wählen kann und diesen Zug nicht zulässt
                    
                    hashFlagStore = 1
                    
                    GLOBALCOUNTER_BETA_CUTOFF += 1
                    
                    break
                    
                }
                
            }
            
        }
        
        // HASH-Table Write
        // TO DO: Beta Cutoff dann darf ich hier eigentlich nur eine Grenze reinschreiben ?! nicht exakten Wert
        
        if hashFlag {
    
            hashTableAlphaBeta[hashIndexActual] = [maxValue,hashFlagStore]
    
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
                    
                    // Min variiert immer nur das Beta, Zug für Zug sucht es immer minimierende Züge
                    // wenn es aber unter Alpha muss nicht weiter gesucht werden, da der Max-Player
                    // schon bessere Varianten wählen kann und diesen Zug nicht zulässt
                    
                    GLOBALCOUNTER_ALPHA_CUTOFF += 1
                    hashFlagStore = 2
                    
                    break
                    
                }
                
            }
            
        }
        
        // HASH-Table Write
        
        if hashFlag  {
                
                hashTableAlphaBeta[hashIndexActual] = [minValue,hashFlagStore]
            
        }

        return minValue
        
    }
    
}
