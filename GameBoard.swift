//
//  GameBoard.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 26.02.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation


// Klasse beschreibt eine aktuelle Spielsituation

final class gameBoard {
    
    init (hands:[UInt64], relativeHands:[UInt64],tricksNS: Int, tricksEW: Int,trickCurrent: [UInt64], trump:UInt64, leader: Int, trickSuit: UInt64, playerShape: [[Int]], cardsPlayed: UInt64, playerCurrent:Int) {
        
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
        self.relativeHands = relativeHands
       
       
        
    }
    
    // 4 Bridge Hände als 64-Bit-Zahl (davon werden 52 genutzt pro Hand)
    var hands: [UInt64]
    
    // Relative Hände der vier 4 Bridge Hände (zB wenn As fehlt wird der K das As)
    var relativeHands: [UInt64]
    
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
    
    // Testvariablen für automatische Tests
    var nameTest = "TestHand1"
    var tricksTest = 0
    var testNumberOfCards = 0
    
    
    
    var cardTrickWinner: Int {
        
        // Karte, die den aktuellen Stich gewinnt -> Index im aktuellen Stichs
        // die Zahl die returniert wird ist die Array-Position der Karte, nicht die des Spielers
        
        if trickCurrent.count == 1 {
            
            // nur eine Karte im Stich, diese gewinnt
            
            return 0
        
        } else {
            
            
            var highestCardInTrick = trickCurrent[0]
            var returnValue = 0
            
            for i in 1...trickCurrent.count-1 {
                
                if highestCardInTrick & trump > 0 {
                
                    // Trumpf schon im Stich
                    if (trickCurrent[i] & trump) > (highestCardInTrick & trump)  {
                        
                        
                        highestCardInTrick = trickCurrent[i]
                        returnValue = i
                        
                    }
                
                } else {
                    
                     // bisher kein Trumpf im Stich
                    if (trickCurrent[i] & trickSuit) > (highestCardInTrick & trickSuit) || (trickCurrent[i] & trump) > 0  {
                        
                        
                        highestCardInTrick = trickCurrent[i]
                        returnValue = i
                        
                    }
                    
                    
                    
                }
                
            }
            
            return returnValue // Index der Karte im Stich, die den Stich gewinnt
            
        }
        
    }
    
    
   // FUNKTIONEN, METHODEN
    

    func playCard(card:UInt64) {
    // spielt eine Karte in einem aktuellen Gameboard
    
        
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
        
        // relative Hands anpassen
        relativeHands[playerCurrent] = convertToRelativeRanking(hand: relativeHands[playerCurrent], cardRemoved: card)
        
        
        // Karte in den aktuellen Stich legen
        trickCurrent.append(card)
        
        // Stich komplett ?
        
        if self.trickCurrent.count == 4 {
            
            let cardWinsNumber = (self.cardTrickWinner + trickLeader) % 4
            
            // Stichanzahl erhöhen
            
            if cardWinsNumber == 0 || cardWinsNumber == 2 {  tricksWonByEastWest += 1} else { tricksWonByNorthSouth += 1}
            
            // Stich leeren & Stichfarbe zurücksetzen
            self.trickCurrent = []
            self.trickSuit = 0
            
            // Ausspieler für neuen Stich festlegen
            self.trickLeader = cardWinsNumber
            
            // Aktueller Spieler
            self.playerCurrent = cardWinsNumber
            
            
            
        } else {
            
            // Stich nicht vollständig -> nächster Spieler dran
            // self.playerCurrent = (self.trickLeader + self.trickCurrent.count) % 4
            self.playerCurrent = (self.playerCurrent + 1) % 4
            
        }
        
    
    }
    
    
    func playableCardsOfCurrentPlayer() -> [UInt64] {
        
        var playableCards:[UInt64] = []
        var playableCardsFilterEqualCards:[UInt64] = []
        
    
        
        let cardsInPlayersHandAsArray = allCards.filter({$0 & hands[playerCurrent] > 0})
        // -> Array mit allen Karten, die in der Spielerhand sind
        
        
        if trickCurrent.isEmpty {
            // 1. Ausspieler, alle Karten, die sich in der Hand des aktuellen Spielers befinden
            
            playableCards = cardsInPlayersHandAsArray
            
        } else {
            
            // 2. Kann bedienen ?
            
            
            if hands[playerCurrent] & trickSuit == 0  {
                
                // a. Nein -> alle Spielerkarten sind spielbar
               
                playableCards = cardsInPlayersHandAsArray
                
            } else {
                
                // b. Ja
               
                playableCards = cardsInPlayersHandAsArray.filter({$0 & trickSuit > 0})
                
            }
            
        }
        
        if playableCards.count == 0 { return playableCards }
        
              if playableCards.count == 1 { return playableCards } else {
        
                
            // Ab mindestens 2 Karten, wird untersucht, ob diese "gleichwertig sind", d.h. benachbart
            for i in 0...playableCards.count-2 {
                
                if areWeEqualCards(card1: playableCards[i], card2: playableCards[i+1]) == false {
                    
                    // wenn nicht benachbart, dann wird die Karte angehängt
                    playableCardsFilterEqualCards.append(playableCards[i])
                }
                
                
            }
            
            // die letzte Karte wird immer angehängt, da dieser vorher nciht aussortiert werden kann
            playableCardsFilterEqualCards.append(playableCards.last!)
            
        }
        
        if playableCardsWithSorting == true {
            //images.sorted({ $0.fileID > $1.fileID })
            return playableCardsFilterEqualCards.sorted(by: {self.pointsForCardSorting(card: $0) > self.pointsForCardSorting(card: $1)})
            
        } else {
            
            return playableCardsFilterEqualCards
            
        }
    }
    
    
    func quickTricksPlayer(player: Int) -> [Int] {
        
        //
        let orHands = self.hands[0] | self.hands[1] | self.hands[2] | self.hands[3]
        
        var quickTricks = 0
        var entryToPartner = 0
        
        var quickTricksShape:[Int] = [0,0,0,0,0,0,0,0]
        
        // ITERATE OVER ALL SUITS ; 0 = spades : 4 = clubs
        
        for suit in 0...3 {
            
            var topCards:[UInt8] = [0b10000000,0b01000000,0b00100000,0b00010000]
            var topCards2Player:UInt8 = 0
            var topCardsCounter = 0
            
            // Ziel topCards2Player hat Syntax 0b11000010, ersten 4 Stellen für aktuellen Spieler AKQJ, letzten für Partner
            
            for card in allSuits[suit] {
                
                
                // Karte ist in keiner Spielerhand oder schon alles ausgwertet-> nächste Karte prüfen
                if topCardsCounter > 3 || card & orHands == 0 { continue }
                
                
                
                if card & hands[player] > 0 {
                    
                    // wenn die Karte in der Spieler-Hand ist, addiert man topCards in topCard2Player
                    topCards2Player += topCards[topCardsCounter]
                    
                    
                }
                
            
                if card & hands[(player+2)%4] > 0 {
                    
                    // wenn die Karte in der Spieler-Hand ist, addiert man topCards in topCard2Player
                    topCards2Player += (topCards[topCardsCounter] >> 4) // vier Stellen nach rechts verrücken
                    
                    
                }
                
                topCardsCounter += 1
                
            }
            
            
            // Farblänge des Spielers & Partner
            let a = self.playerShape[player][suit]
            let b = self.playerShape[(player+2)%4][suit]
            
            // maximale Kartenanzahlder Gegner
            let oppMax = max(self.playerShape[(player+1)%4][suit],self.playerShape[(player+3)%4][suit])
            

            
            // Entry zum Partner ?
            
            if topCards2Player & 0b00001000 > 0 && a > 0 {
                
                entryToPartner += 1
                
            }
            
            // TO DO - gleich die Partner Seite auswerten
            
            let qT = calQuickTricks(topCards: topCards2Player, a: a, b: b, oppMax: oppMax)
            
            let shifty:UInt8 = (topCards2Player << 4) + (topCards2Player >> 4)
            
            let qTP = calQuickTricks(topCards: shifty, a: b, b: a, oppMax: oppMax) // Partner auswerten

            quickTricks += qT
            
            quickTricksShape[suit] = qT
            quickTricksShape[suit+4] = qTP
            
           //  if qT > 0 { print(printBinary(number: [UInt64( topCards2Player)])) ; print (qT)}
        
        }
        
        //if self.tricksWonByEastWest + self.tricksWonByNorthSouth == 0 { print(quickTricksShape) }
        
        return [quickTricks,entryToPartner]
    }
    

    
    
    func hashIndex() -> String {
        
        // Um die Hashtabelle für Spielpositionen aufzubauen, wird einer Spielsituation ein eindeutiger String zugeordnet
        // gespielte Karten sind schon sehr eindeutig, da sie vorher auch eindeutig Händen zugeordnet waren
        
        if hashTableBuildingGuide == 0 {
            
            // Hash-Table wird exakt erzeugt
            return String(self.cardsPlayed) + String(self.playerCurrent) + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        } else if hashTableBuildingGuide == 1  {
            
            // Hash-Table macht aus 7,6,5,4,3,2 jeweils ein x
            
            let str1 = String(self.cardsPlayed & 0b1111111000000111111100000011111110000001111111000000) + String(self.playerCurrent)
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        }
        
        else if hashTableBuildingGuide == 55  {
            
            // Hash-Table macht aus 9,87,6,5,4,3,2 jeweils ein x
            
            let str1 = String(self.cardsPlayed & 0b1111100000000111110000000011111000000001111100000000) + String(self.playerCurrent)
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        } else if hashTableBuildingGuide == 56  {
            
            // 
            
            let str1 = String(self.relativeHands[0]) + String(self.relativeHands[1]) + String(self.relativeHands[2]) + String(self.relativeHands[3]) + String(self.playerCurrent)
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        }else if hashTableBuildingGuide == 2 {
            
            // Hash-Table macht aus 6,5,4,3,2 jeweils ein x
            
            let str1 = String(self.cardsPlayed & 0b1111110000000111111000000011111100000001111110000000) + String(self.playerCurrent)
            
            return  str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        } else if hashTableBuildingGuide == 99 {
            
            // Hash-Table NEW
            
            return  String(self.cardsPlayed) + String(self.trickLeader)
            
        } else {
            
            // Hash-Table macht aus 5,4,3,2 jeweils ein x
            
            let str1 = String(self.cardsPlayed & 0b1111111100000111111110000011111111000001111111100000) + String(self.playerCurrent)
            
            return  str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
            
            
        }
        
    }
    
    func areWeEqualCards(card1: UInt64, card2:UInt64) -> Bool {
        
        // Funktion überprüft, ob zwei Karten gleichwertig sind, d.h. nahtlos ineinander übergehen und somit
        // bei den playable cards rausgefiltert werden können
        
        //Karten verschiedenfarbig
        
        if card1 & spades > 0 && card2 & spades == 0 {return false}
        if card1 & hearts > 0 && card2 & hearts == 0 {return false}
        if card1 & diamonds > 0 && card2 & diamonds == 0{return false}
        if card1 & clubs > 0 && card2 & clubs == 0 {return false}
        
        var cardRun = card1
        
        while cardRun > card2 {
            
            cardRun = (cardRun >> 1)
            
            if cardRun == card2 {
                
                return true }
            
            //zwischen zwei möglichen benachbarten Karten muss geguckt werden, was mit diesen Karten ist
            //Sind die Karten noch im Spiel also auf einer Gegnerhand/Partnerhand ODER im aktuellen Stich
            //können die Karten nie benachbart sein
            
            if (cardRun & hands[playerCurrent] == 0 && cardRun & self.cardsPlayed == 0) || self.trickCurrent.contains(cardRun) == true {
                
                return false
                
            }
            
        }
        
        // von einer Karte zur anderen kommt nie eine Gegenspielerkarte oder Partnerkarte
        return true
    }
    
    func pointsForCardSorting(card: UInt64) -> Int {
    
        // Funktion soll in einer Spielsituation einen Wert geben um eine Sortierung zu ermöglichen
        
        var suitAdd:Int = 0
        var suitBonus = 0
        var LHO = 0
        var RHO = 0
        
        if card & spades > 0 {
        
            suitAdd = Int(((self.playerShape[playerCurrent][0]) * 64)/36)
            if self.relativeHands[(playerCurrent+3)%4] & (sA+sK) > 0 { suitBonus += -18 }
            LHO = self.playerShape[(playerCurrent+1)%4][0]
            RHO = self.playerShape[(playerCurrent+3)%4][0]
            
        } else if card & hearts > 0 {
            
            suitAdd = Int(((self.playerShape[playerCurrent][1]) * 64)/36)
            if self.relativeHands[(playerCurrent+3)%4] & (hA+hK) > 0 { suitBonus += -18 }
            LHO = self.playerShape[(playerCurrent+1)%4][1]
            RHO = self.playerShape[(playerCurrent+3)%4][1]
            
        } else if card & diamonds > 0 {
            
            suitAdd = Int(((self.playerShape[playerCurrent][2]) * 64)/36)
            if self.relativeHands[(playerCurrent+3)%4] & (dA+dK) > 0 { suitBonus += -18 }
            LHO = self.playerShape[(playerCurrent+1)%4][1]
            RHO = self.playerShape[(playerCurrent+3)%4][1]
            
        } else {
            
            suitAdd = Int(((self.playerShape[playerCurrent][3]) * 64)/36)
            if self.relativeHands[(playerCurrent+3)%4] & (cA+cK) > 0 { suitBonus += -18 }
            LHO = self.playerShape[(playerCurrent+1)%4][1]
            RHO = self.playerShape[(playerCurrent+3)%4][1]
            
        }
        
        // TO-DO
        // If the suit length is 2, and the hand-to-play has the next highest rank of the suit, the bonus is reduced by 2.
        
        
        // 1. Ausspieler
        
        var suitWeightDelta:Int = suitBonus - Int(((LHO + RHO) * 32)/15)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // Spieler muss abwerfen -> möglichst kleine Karte
        if self.trickSuit & card == 0 && card != trump { // Spieler muss abwerfen
            
            return -rankOfCard(card: card) + suitAdd
        }
        
        // Spieler gibt zu
        else if self.trickSuit & card > 0 && card != trump {
            
            
            
            if card < trickCurrent[cardTrickWinner] {
                // man gibt zu und kann die Karte nicht schlagen, dann kleine Karte
                
                 return -rankOfCard(card: card)
                
            }
            
            else {
                // man gibt zu und kann die höchste Karte schlagen
                
                
                // 4. Mann
                if self.trickCurrent.count == 3 { return -rankOfCard(card: card) + 200 }
                
                else { return rankOfCard(card: card) }
                
                
                
            }
        }
        
        return 0
    }
    
    
}


//// END CLASS


