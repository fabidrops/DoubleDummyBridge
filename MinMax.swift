//
//  MinMax.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 26.02.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

func max(game: gameBoard, alpha: Int, beta:Int, evaluateMax: Bool) -> Int {
    
    // MinMax Algorythmus
    GLOBALCOUNTER_MINMAX += 1
    
    // Spiel zu Ende: Bewerten
    if game.tricksWonByEastWest + game.tricksWonByNorthSouth == NumberOfCardsPerHand {
        
        GLOBALCOUNTER_CALCULATE_LAST += 1
        return game.tricksWonByNorthSouth
        
    }
    
    // Generiere Züge des aktuellen Spielers
    
    var maxWert:Int = alpha // schlechtester Wert für N/S
    var minWert:Int = beta
    var wert: Int = 0
    
    if evaluateMax == true {
        
       wert = alpha
        
    } else {
        
        wert = beta

    }
    
    
    for card in game.playableCardsOfCurrentPlayer() {
        
        // Kopie des gameBoards anlegen
        let kopieBoard = gameBoard(hands: game.hands, tricksNS: game.tricksWonByNorthSouth, tricksEW: game.tricksWonByEastWest, trickCurrent: game.trickCurrent, trump: game.trump, leader: game.trickLeader, trickSuit: game.trickSuit, playerShape: game.playerShape, cardsPlayed: game.cardsPlayed, playerCurrent: game.playerCurrent)
        
        // Führe Karte aus
        
        game.playCard(card: card)
        
        
        if evaluateMax == true {
        
            // Nord-Süd am Stich
            if game.playerCurrent == 1 || game.playerCurrent == 3 {
                
                // Bewertungsfunktion rekursiv
                wert = max(game: game, alpha: maxWert, beta:beta, evaluateMax: true)
                
                
                if wert > maxWert {
                    maxWert = wert
                    
                    // Alpha-Beta Pruning, der andere Spieler könnte immer Beta erzwingen, deswegen Break
                    if maxWert >= beta {
                        
                        GLOBALCOUNTER_BETA_CUTOFF += 1
                        break
                    
                    }
                }
            }
            
            // Ost-West am Stich
            if game.playerCurrent == 0 || game.playerCurrent == 2 {
                
                wert = max(game: game, alpha: maxWert, beta: beta, evaluateMax: false)
                
                
                if wert > maxWert {
                    maxWert = wert
                    
                    if maxWert >= beta {
                        
                        GLOBALCOUNTER_BETA_CUTOFF += 1
                        break
                    
                    }
                }
                
            }
            
        } else {
            
            // HIER BEGINNT MINI-FUNKTION
            
            // Nord-Süd am Stich
            if game.playerCurrent == 1 || game.playerCurrent == 3 {
                
                // Bewertungsfunktion rekursiv
                wert = max(game: game, alpha: alpha, beta:minWert, evaluateMax: true)
                
                
                if wert < minWert {
                    minWert = wert
                    
                    // Alpha-Beta Pruning, der andere Spieler könnte immer Alpha erzwingen, deswegen Break
                    if minWert <= alpha {
                        
                        GLOBALCOUNTER_ALPHA_CUTOFF += 1
                        break
                        
                    }
                }
            }
            
            // Ost-West am Stich
            if game.playerCurrent == 0 || game.playerCurrent == 2 {
                
                wert = max(game: game, alpha: alpha, beta: minWert, evaluateMax: false)
                
                
                if wert < minWert {
                    minWert = wert
                    
                    if minWert <= alpha {
                        
                        GLOBALCOUNTER_ALPHA_CUTOFF += 1
                        break
                        
                    }
                }
                
            }

            
        }
        
        // Karte rückgängig machen
        
        game.trickCurrent = kopieBoard.trickCurrent
        game.hands = kopieBoard.hands
        game.tricksWonByEastWest = kopieBoard.tricksWonByEastWest
        game.tricksWonByNorthSouth = kopieBoard.tricksWonByNorthSouth
        game.trickLeader = kopieBoard.trickLeader
        game.cardsPlayed = kopieBoard.cardsPlayed
        game.playerShape = kopieBoard.playerShape
        game.trickSuit = kopieBoard.trickSuit
        game.playerCurrent = kopieBoard.playerCurrent
        
    }
    
    return maxWert
    
}

