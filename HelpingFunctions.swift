//
//  HelpingFunctions.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 27.02.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

// 1. Shuffle Deck -> Mischt die Karten
// 2. FillPlayersShape -> game.hands in game.playersShape umwandeln
// 3. Relative Rankings

func shuffleDeck(numberOfCardsPerHand: Int)-> [UInt64] {
    
    // Mischt alle Karten, teilt diese auf 4 Spieler auf und gibt das Hand-Array zurück
    
    var deckOfCards = allCards
    
    for i in 0...51 {
        let j = Int(arc4random_uniform(UInt32(52 - i))) + i
        guard i != j else { continue }
        swap(&deckOfCards[i], &deckOfCards[j])
    }
    
    var hand: [UInt64] = [0,0,0,0]
    
    for i in 0...3 {
        
        for j in 0...numberOfCardsPerHand-1 {
            
            hand[i] += deckOfCards[i*13+j]
            
        }
        
    }
    
    return [hand[0],hand[1],hand[2],hand[3]]
}

func fillPlayersShape(hands: [UInt64]) -> [[Int]] {
    
    var shape = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    
    // FILL playerShape
    
    for i in 0...3 {
        
        for card in allCards {
            
            if card & spades & hands[i] > 0 {
                
                shape[i][0] += 1
                
            }
            
            if card & hearts & hands[i] > 0 {
                
                
                shape[i][1] += 1
                
            }
            
            if card & diamonds & hands[i] > 0 {
                
                
                shape[i][2] += 1
                
            }
            
            if card & clubs & hands[i] > 0 {
                
                
                shape[i][3] += 1
                
            }
            
            
        }
        
    }
    
    return shape
}

func convertToRelativeRanking(hand: UInt64, cardRemoved: UInt64) -> UInt64 {
    
    
    var cardsInSuit:[UInt64] = []
    
    if cardRemoved & spades > 0 { cardsInSuit = spadesLow } else if cardRemoved & hearts > 0 { cardsInSuit = heartsLow } else if cardRemoved & diamonds > 0 {
        
        cardsInSuit = diamondsLow
        
    } else { cardsInSuit = clubsLow }
    
    
    var output:UInt64 = hand
    
    for card in cardsInSuit {
        
        if (card >= cardRemoved)  { break }
        
        if (card < cardRemoved)  && (card & hand > 0) {
            
            output -= card
            output += (card << 1)
        
        }
        
        
    }
    
    return output
    
}

