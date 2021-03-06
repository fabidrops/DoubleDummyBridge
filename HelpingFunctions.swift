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
// 3b.convertGameBoardHandsToRelativeRanking(game: gameBoard) -> gameBoard
// die Hände des gameBoards werden in relative Hände überführt
// 4. Shift Zahl um aus einer Hand eine Farbe zu isolieren

func shuffleDeck(numberOfCardsPerHand: Int)-> [UInt64] {
    
    // Mischt alle Karten, teilt diese auf 4 Spieler auf und gibt das Hand-Array zurück
    
    var deckOfCards = allCards
    
    //swap(&deckOfCards[0], &deckOfCards[40]) // Pik As in die Nordhand
    
    for i in 0...51 {
        
        
        
        let j = Int(arc4random_uniform(UInt32(52 - i))) + i
        guard i != j else { continue }
        
        if quickTestPlayingMode {
            
           // if deckOfCards[i]  == sA || deckOfCards[j] == sA {continue} else {swap(&deckOfCards[i], &deckOfCards[j]) }
            swap(&deckOfCards[i], &deckOfCards[j])
            
            
        } else {
        
            swap(&deckOfCards[i], &deckOfCards[j])
            
        }
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
    // Funktion rechnet sehr schnell, 5.000.000 Aufrufe vielleicht 1sek
    
    var cardsInSuit:[UInt64] = []
    
    if cardRemoved & spades > 0 { cardsInSuit = spadesLow } else if cardRemoved & hearts > 0 { cardsInSuit = heartsLow } else if cardRemoved & diamonds > 0 {
        
        cardsInSuit = diamondsLow
        
    } else { cardsInSuit = clubsLow }
    
    
    var output:UInt64 = hand
    
    for card in cardsInSuit {
        
        if card >= cardRemoved  { break }
        
        if card & hand > 0 {
        // Fall: card < cardRemoved
            
            output -= card
            output += (card << 1)
        
        }
        
        
    }
    
    return output
    
}

func convertGameBoardHandsToRelativeRanking(game: gameBoard) {
    
    let handsCheck = game.hands[0] | game.hands[1] | game.hands[2] | game.hands[3]
    
    for card in allCards.reversed() {
        
        // Alle Karten, die bei der Verteilung nicht verteilt wurden, werden überprüft und dancah die relativen Hände bestimmt
        if card & handsCheck == 0 {
            
            game.hands[0] = convertToRelativeRanking(hand: game.hands[0], cardRemoved: card)
            game.hands[1] = convertToRelativeRanking(hand: game.hands[1], cardRemoved: card)
            game.hands[2] = convertToRelativeRanking(hand: game.hands[2], cardRemoved: card)
            game.hands[3] = convertToRelativeRanking(hand: game.hands[3], cardRemoved: card)
            
            
        }
        
        
    }
 
    

    
}

func fillRealtiveHandsinInit(game: gameBoard) -> gameBoard {
    // ein gameBoard dessen Hände gefüllt sind bekommt hier die relativeHands gefüllt
    
    game.relativeHands[0] = game.hands[0]
    game.relativeHands[1] = game.hands[1]
    game.relativeHands[2] = game.hands[2]
    game.relativeHands[3] = game.hands[3]
    
    let handsCheck = game.hands[0] | game.hands[1] | game.hands[2] | game.hands[3]
    
    for card in allCards.reversed() {
        
        
        
        // Alle Karten, die bei der Verteilung nicht verteilt wurden, werden überprüft und dancah die relativen Hände bestimmt
        if card & handsCheck == 0 {
            
            game.relativeHands[0] = convertToRelativeRanking(hand: game.relativeHands[0], cardRemoved: card)
            game.relativeHands[1] = convertToRelativeRanking(hand: game.relativeHands[1], cardRemoved: card)
            game.relativeHands[2] = convertToRelativeRanking(hand: game.relativeHands[2], cardRemoved: card)
            game.relativeHands[3] = convertToRelativeRanking(hand: game.relativeHands[3], cardRemoved: card)
            
            
        }
        
        
    }
    
    return game
    
    
}

func fillRelativeHashTable() {
    
    hashTableRelativeRanking = [:]
    
    
    
    
    
}

func shiftNumber (suit: UInt64) -> UInt64 {
    
    if suit == spades {return 39}
    else if suit == hearts {return 26}
    else if suit == diamonds {return 13}
    else {return 0}
    
    
}

func readJson() {
    
    print("AAAAAAABBBBBCCCCCCDDDDDDDEEEEEEEFFFFFFFF")
     print("AAAAAAABBBBBCCCCCCDDDDDDDEEEEEEEFFFFFFFF")
     print("AAAAAAABBBBBCCCCCCDDDDDDDEEEEEEEFFFFFFFF")
     print("AAAAAAABBBBBCCCCCCDDDDDDDEEEEEEEFFFFFFFF")
    do {
        if let file = Bundle.main.url(forResource: "doubledummybridge", withExtension: "json") {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
                // json is a dictionary
                print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
                print(object)
            } else if let object = json as? [Any] {
                // json is an array
                print(object)
            } else {
                print("JSON is invalid")
            }
        } else {
            print("no file")
        }
    } catch {
        print(error.localizedDescription)
    }
}



func orderPlayableCardsWithEverySuitAtTheBeginning (cards: [UInt64]) -> [UInt64] {
    
    var setSuit: ()
    
    for card in cards {
        
        
        
    }
    
    return cards
}

