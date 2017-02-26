//
//  GameBoard.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 26.02.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation


// Klasse beschreibt eine aktuelle Spielsituation

class gameBoard {
    
    init (hands:[UInt64], tricksNS: Int, tricksEW: Int,trickCurrent: [UInt64], trump:UInt64, leader: Int, trickSuit: UInt64, playerShape: [[Int]], cardsPlayed: UInt64, playerCurrent:Int) {
        
        self.hands = hands
        self.tricksWonByNorthSouth = tricksNS
        self.tricksWonByEastWest = tricksEW
        self.trickCurrent = trickCurrent
        self.trump = trump
        self.trickSuit = trickSuit
        self.trickLeader = leader
        self.playerShape = playerShape
        self.cardsPlayed = cardsPlayed
        self.playerCurrent = playerCurrent
        
    }
    
    // 4 Bridge Hände als 64-Bit-Zahl (davon werden 52 genutzt pro Hand)
    var hands: [UInt64]
    
    // Anzahl gewonnener Stiche Nord-Süd
    var tricksWonByNorthSouth: Int
    
    // Anzahl gewonnener Stiche Ost-West
    var tricksWonByEastWest: Int
    
    // Karten im aktuellen Stich
    var trickCurrent: [UInt64]
    
    // Trumpffarbe
    var trump: UInt64
    
    // Farbe des aktuellen Stiches
    var trickSuit: UInt64
    
    // Ausspieler 0=West,1=Nord,2=Ost,3=Süd
    var trickLeader: Int
    
    // Verteilung der Spieler als Array, z.B. [[4,4,3,2],[3,3,3,4],[4,4,3,2],[4,4,3,2]]
    var playerShape: [[Int]]
    
    // bisher gespielte Karten im gesamten Spielverlauf als 52-bit Darstellung
    var cardsPlayed:UInt64
    
    // Spieler, der dran ist 0=West,1=Nord,2=Ost,3=Süd
    var playerCurrent:Int
    
    // Regelkonforme Karten des aktuellen Spielers
    var cardsPlayable: [UInt64] {
        
        //TODO
        return []
        
    }
    
    // Karte, die den aktuellen Stich gewinnt -> Index im aktuellen Stichs
    // liefert -1, wenn Stich leer
    
    var cardTrickWinner: Int {
        
        var returnValue = -1
        var highestCardInTrick:UInt64 = 0
        
        for card in trickCurrent {
            
            if (card & trickSuit) > (highestCardInTrick & trickSuit) || (card & trump) > (highestCardInTrick & trump)  {
                
                returnValue += 1
                highestCardInTrick = card
                
            }
        }
        
        return returnValue // Index der Karte im Stich, die den Stich gewinnt
        
    }
    
    
   // FUNKTIONEN, METHODEN
    

    func playCard(card:UInt64) -> gameBoard {
    // spielt eine Karte in einem aktuellen Gameboard und liefert das neu erzeugte Gameboard zurück
    
        
        // Karte aus gespielter Hand entfernen
        hands[playerCurrent] -= card
        
        // Karte zu gespielten Karten hinzufügen
        cardsPlayed += card
        
        // Kartenshape anpassen & Stichfarbe festlegen bei der ersten Karte im Stich
        if card & spades > 0 {
            playerShape[playerCurrent][0] -= 1
            if self.trickCurrent.isEmpty {
                self.trickSuit = spades
            }
            
        }
        else if card & hearts > 0 {
            playerShape[playerCurrent][1] -= 1
            if self.trickCurrent.isEmpty {
                self.trickSuit = hearts
            }
        }
        else if card & diamonds > 0 {
            playerShape[playerCurrent][2] -= 1
            if self.trickCurrent.isEmpty {
                self.trickSuit = diamonds
            }
        }
        else {
            playerShape[playerCurrent][3] -= 1
            if self.trickCurrent.isEmpty {
                self.trickSuit = clubs
            }
        }
        
        
        // Karte in den aktuellen Stich legen
        trickCurrent.append(card)
        
        // Stich komplett ?
        let cardWinsNumber = (self.cardTrickWinner + trickLeader) % 4
        if self.trickCurrent.count == 4 {
            
            // Stichanzahl erhöhen
            
            if cardWinsNumber == 0 || cardWinsNumber == 2 { tricksWonByEastWest += 1} else {tricksWonByNorthSouth += 1}
            
            // Stich leeren & Stichfarbe zurücksetzen
            self.trickCurrent = []
            self.trickSuit = 0
            
            // Ausspieler für neuen Stich festlegen
            self.trickLeader = cardWinsNumber
            
            
            
            
        }
        
        return gameBoard(hands: hands, tricksNS: tricksWonByNorthSouth, tricksEW: tricksWonByEastWest, trickCurrent: trickCurrent, trump: trump, leader: trickLeader, trickSuit: trickSuit, playerShape: playerShape, cardsPlayed: cardsPlayed, playerCurrent: cardWinsNumber)
    }
    
    

    
    
    
}


//// END CLASS


