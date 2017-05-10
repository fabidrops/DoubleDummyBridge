//
//  HashTable.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 16.03.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

var hashTable = [String:Int]()
var hashTableAlphaBeta = [String : [Int]]()
var hashTableRelativeRanking = [String:UInt64]()



var hashTableBuildingGuide = 0 // wichtige Konstante, die die Hash-Table-Erzeugung steuert -> Gameboard.hashtag gucken


// Funktion funktioniert, hat aber keinen Geschwindigkeitsvorteil gebracht, deshlab nicht reingebracht !
// Hash-Table, die alle StichKartenkombinationen vorberechnet, damit man die gewinnende Karte nicht mehr ausrechnen muss
var hashTableTrickWinnerNoTrump = [UInt64:UInt64]()

func fillHashTableRelativeSuitOrder() {}







func fillHashTableTrickWinnerNoTrump() {
    
    print("Fill HashTableTrickWinner")
    let time1 = DispatchTime.now()
    
    
    let trump:UInt64 = 0
    var returnValue:UInt64 = 0
    
    for card1 in allCards {
        
        var trickSuit: UInt64 = 0
        
        if card1 & spades > 0 {trickSuit = spades} else if card1 & hearts > 0 {trickSuit = hearts } else if card1 & diamonds > 0 {
            trickSuit = diamonds
        } else {
            
            trickSuit = clubs
        }
        
        
        for card2 in allCards where card2 != card1 {
            
            for card3 in allCards where card3 != card2 && card3 != card1 {
                
                for card4 in allCards where card4 != card1 && card4 != card2 && card4 != card3 {
                    
                        var trickCurrent = [card1,card2,card3,card4]
                        returnValue = 0
                    
                        var highestCardInTrick = trickCurrent[0]
                    
                        
                        for i in 1...trickCurrent.count-1 {
                            
                            if highestCardInTrick & trump > 0 {
                                
                                // Trumpf im Stich
                                if (trickCurrent[i] & trump) > (highestCardInTrick & trump)  {
                                    
                                    
                                    highestCardInTrick = trickCurrent[i]
                                    returnValue = trickCurrent[i]
                                    
                                }
                                
                            } else {
                                
                                // kein Trumpf im Stich
                                if (trickCurrent[i] & trickSuit) > (highestCardInTrick & trickSuit) || (trickCurrent[i] & trump) > 0  {
                                    
                                    
                                    highestCardInTrick = trickCurrent[i]
                                    returnValue = trickCurrent[i]
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                  
                    hashTableTrickWinnerNoTrump[card1|card2|card3|card4] = returnValue
                                      
                    
            }
                
        }
            
    }
        

    }
    
    var time2 = DispatchTime.now()
    print(hashTableTrickWinnerNoTrump[c7|c3|c4|c5])
    var delta = (time2.uptimeNanoseconds - time1.uptimeNanoseconds)/1000000
    print("\(delta)")
}
