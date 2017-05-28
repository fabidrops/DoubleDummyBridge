////
////  GameBoard.swift
////  DoubleDummyBridge
////
////  Created by Fabian von Löbbecke on 26.02.17.
////  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
////
//
//import Foundation
//
//
//// Klasse beschreibt eine aktuelle Spielsituation
//
//class gameBoard {
//    
//    init (hands:[UInt64], tricksNS: Int, tricksEW: Int,trickCurrent: [UInt64], trump:UInt64, leader: Int, trickSuit: UInt64, playerShape: [[Int]], cardsPlayed: UInt64, playerCurrent:Int) {
//        
//        self.hands = hands
//        self.tricksWonByNorthSouth = tricksNS
//        self.tricksWonByEastWest = tricksEW
//        self.trickCurrent = trickCurrent
//        self.trump = trump
//        self.trickSuit = trickSuit
//        self.trickLeader = leader
//        self.playerShape = playerShape
//        self.cardsPlayed = cardsPlayed
//        self.playerCurrent = playerCurrent
//        
//    }
//    
//    // 4 Bridge Hände als 64-Bit-Zahl (davon werden 52 genutzt pro Hand)
//    var hands: [UInt64]
//    
//    // Anzahl gewonnener Stiche Nord-Süd
//    var tricksWonByNorthSouth: Int
//    
//    // Anzahl gewonnener Stiche Ost-West
//    var tricksWonByEastWest: Int
//    
//    // Karten im aktuellen Stich
//    var trickCurrent: [UInt64]
//    
//    // Trumpffarbe
//    var trump: UInt64
//    
//    // Farbe des aktuellen Stiches
//    var trickSuit: UInt64
//    
//    // Ausspieler 0=West,1=Nord,2=Ost,3=Süd
//    var trickLeader: Int
//    
//    // Verteilung der Spieler als Array, z.B. [[4,4,3,2],[3,3,3,4],[4,4,3,2],[4,4,3,2]]
//    var playerShape: [[Int]]
//    
//    // bisher gespielte Karten im gesamten Spielverlauf als 52-bit Darstellung
//    var cardsPlayed:UInt64
//    
//    // Spieler, der dran ist 0=West,1=Nord,2=Ost,3=Süd
//    var playerCurrent:Int
//    
//    // Testvariablen für automatische Tests
//    var nameTest = "TestHand1"
//    var tricksTest = 0
//    var testNumberOfCards = 0
//    
//    
//    // Karte, die den aktuellen Stich gewinnt -> Index im aktuellen Stichs
//    // liefert -1, wenn Stich leer
//    
//    var cardTrickWinner: Int {
//        
//        
//        // die Zahl die returniert wird ist die Array-Position der Karte, nicht die des Spielers
//        
//        if trickCurrent.count == 1 {
//            
//            // nur eine Karte im Stich, diese gewinnt
//            
//            return 0
//            
//        } else {
//            
//            
//            var highestCardInTrick = trickCurrent[0]
//            var returnValue = 0
//            
//            for i in 1...trickCurrent.count-1 {
//                
//                if highestCardInTrick & trump > 0 {
//                    
//                    // Trumpf im Stich
//                    if (trickCurrent[i] & trump) > (highestCardInTrick & trump)  {
//                        
//                        
//                        highestCardInTrick = trickCurrent[i]
//                        returnValue = i
//                        
//                    }
//                    
//                } else {
//                    
//                    // kein Trumpf im Stich
//                    if (trickCurrent[i] & trickSuit) > (highestCardInTrick & trickSuit) || (trickCurrent[i] & trump) > 0  {
//                        
//                        
//                        highestCardInTrick = trickCurrent[i]
//                        returnValue = i
//                        
//                    }
//                    
//                    
//                    
//                }
//                
//            }
//            
//            return returnValue // Index der Karte im Stich, die den Stich gewinnt
//            
//        }
//        
//    }
//    
//    
//    // FUNKTIONEN, METHODEN
//    
//    
//    func playCard(card:UInt64) {
//        // spielt eine Karte in einem aktuellen Gameboard
//        
//        
//        // Karte aus gespielter Hand entfernen
//        hands[playerCurrent] -= card
//        
//        // Karte zu gespielten Karten hinzufügen
//        cardsPlayed += card
//        
//        // Kartenshape anpassen & Stichfarbe festlegen bei der ersten Karte im Stich
//        if card & spades > 0 {
//            playerShape[playerCurrent][0] -= 1
//            if self.trickCurrent.isEmpty {
//                self.trickSuit = spades
//            }
//            
//        }
//        else if card & hearts > 0 {
//            playerShape[playerCurrent][1] -= 1
//            if self.trickCurrent.isEmpty {
//                self.trickSuit = hearts
//            }
//        }
//        else if card & diamonds > 0 {
//            playerShape[playerCurrent][2] -= 1
//            if self.trickCurrent.isEmpty {
//                self.trickSuit = diamonds
//            }
//        }
//        else {
//            playerShape[playerCurrent][3] -= 1
//            if self.trickCurrent.isEmpty {
//                self.trickSuit = clubs
//            }
//        }
//        
//        
//        // Karte in den aktuellen Stich legen
//        trickCurrent.append(card)
//        
//        // Stich komplett ?
//        let cardWinsNumber = (self.cardTrickWinner + trickLeader) % 4
//        if self.trickCurrent.count == 4 {
//            
//            
//            // Stichanzahl erhöhen
//            
//            if cardWinsNumber == 0 || cardWinsNumber == 2 {  tricksWonByEastWest += 1} else { tricksWonByNorthSouth += 1}
//            
//            // Stich leeren & Stichfarbe zurücksetzen
//            self.trickCurrent = []
//            self.trickSuit = 0
//            
//            // Ausspieler für neuen Stich festlegen
//            self.trickLeader = cardWinsNumber
//            
//            // Aktueller Spieler
//            self.playerCurrent = cardWinsNumber
//            
//            
//            
//        } else {
//            
//            // Stich nicht vollständig -> nächster Spieler dran
//            self.playerCurrent = (self.trickLeader + self.trickCurrent.count) % 4
//            
//            
//        }
//        
//        
//    }
//    
//    
//    func playableCardsOfCurrentPlayer() -> [UInt64] {
//        
//        var playableCards:[UInt64] = []
//        var playableCardsFilterEqualCards:[UInt64] = []
//        
//        
//        
//        let cardsInPlayersHandAsArray = allCards.filter({$0 & hands[playerCurrent] > 0})
//        // -> Array mit allen Karten, die in der Spielerhand sind
//        
//        
//        if trickCurrent.isEmpty {
//            // 1. Ausspieler, alle Karten, die sich in der Hand des aktuellen Spielers befinden
//            
//            playableCards = cardsInPlayersHandAsArray
//            
//        } else {
//            
//            // 2. Kann bedienen ?
//            
//            
//            if hands[playerCurrent] & trickSuit == 0  {
//                
//                // a. Nein -> alle Spielerkarten sind spielbar
//                
//                playableCards = cardsInPlayersHandAsArray
//                
//            } else {
//                
//                // b. Ja
//                
//                playableCards = cardsInPlayersHandAsArray.filter({$0 & trickSuit > 0})
//                
//            }
//            
//        }
//        
//        if playableCards.count == 0 { return playableCards }
//        
//        if playableCards.count == 1 { return playableCards } else {
//            
//            
//            // Ab mindestens 2 Karten, wird untersucht, ob diese "gleichwertig sind", d.h. benachbart
//            for i in 0...playableCards.count-2 {
//                
//                if areWeEqualCards(card1: playableCards[i], card2: playableCards[i+1]) == false {
//                    
//                    // wenn nicht benachbart, dann wird die Karte angehängt
//                    playableCardsFilterEqualCards.append(playableCards[i])
//                }
//                
//                
//            }
//            
//            // die letzte Karte wird immer angehängt, da dieser vorher nciht aussortiert werden kann
//            playableCardsFilterEqualCards.append(playableCards.last!)
//            
//        }
//        
//        if playableCardsWithSorting == true {
//            //images.sorted({ $0.fileID > $1.fileID })
//            return playableCardsFilterEqualCards.sorted(by: {self.pointsForCardSorting(card: $0) > self.pointsForCardSorting(card: $1)})
//            
//        } else {
//            
//            return playableCardsFilterEqualCards
//            
//        }
//    }
//    
//    func quickTricksPlayerNew(player: Int) -> Int{
//        
//        // Strategie  10000010000111-Farbbeschreibung -> A K Q J T 9 (ZB 1010000)
//        // diese 64 Kombinationen werden zusammen mit den 64 Partnerkombinationen = 4096 Kombinationen werden ausgewertet ggf. über Hash-Table
//        // in der HashTable wird entweder direkt die qT abgelegt als Int
//        // oder eine Zahl zB 238, die bedeutet dass das Maximum der Farblängen genommen werden soll
//        
//        
//        var qT = 0
//        
//        //        for suit:UInt64 in [spades,hearts,diamonds,clubs] {
//        //
//        //            // Karten je Farbe isolieren
//        //            let cardsInSuitPlayer:UInt64 = (self.hands[player] & suit) >> (shiftNumber(suit: suit) )
//        //            let cardsInSuitPartner:UInt64 = (self.hands[(player + 2) % 4] & suit) >> (shiftNumber(suit: suit) )
//        //
//        //
//        //
//        //
//        //        }
//        
//        // Pik
//        
//        //
//        
//        var cardsInSuitPlayer:UInt16 = 0
//        
//        
//        
//        
//        
//        return qT    }
//    
//    
//    func quickTricksPlayer(player: Int) -> [Int] {
//        
//        // Ermittelt mittels einer Hash Table die quickTricks addiert pro Einzelfarbe
//        
//        var quickTricks = 0
//        var entryToPartner = 0
//        
//        var handQuick: [UInt64] = [0,0,0,0]
//        var suitQuick:[[UInt64]] = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
//        
//        let orHands = self.hands[0] | self.hands[1] | self.hands[2] | self.hands[3]
//        
//        
//        // !!! TO DO - hier muss ich nur den aktuellen Spieler auswerten, nicht alle, das wird später in MinMax gemacht
//        
//        // übergebener Player ist Index 0, Partner 2, Gegenr 1 und 3
//        for i in 0...3 { // für jeden Spieler
//            
//            handQuick[i] = self.hands[(player+i)%4]
//            
//            // Hände werden normiert, d.h. in relative Hände transfomriert
//            for card in allHighCards.reversed() {
//                
//                if card & orHands == 0 {
//                    
//                    handQuick[i] = convertToRelativeRanking(hand: handQuick[i], cardRemoved: card)
//                    
//                }
//                
//            }
//            
//            // Isolieren der Farben -> jede Hand wird in ein Array seiner Einzelfarben zerlegt
//            
//            // Farben isolieren
//            
//            suitQuick[i][0] = (handQuick[i] & spades) >> 39
//            suitQuick[i][1] = (handQuick[i] & hearts) >> 26
//            suitQuick[i][2] = (handQuick[i] & diamonds) >> 13
//            suitQuick[i][3] = (handQuick[i] & clubs)
//            
//        }
//        
//        // prüfen der Quick-Tricks pro Farbe
//        
//        for j in 0...3 { // für jede Farbe
//            
//            // Reminder: player 0 ist der untersuchte Index (player) des Spieler j ist Farbe -> Pik,Herz,Karo,Kreuz
//            
//            if suitQuick[0][j] & 0b1000000000000 > 0 {
//                
//                quickTricks += 1
//                
//                if suitQuick[0][j] & 0b0100000000000 > 0 {
//                    
//                    quickTricks += 1
//                    
//                    if suitQuick[0][j] & 0b0010000000000 > 0 {
//                        
//                        quickTricks += 1
//                        
//                    }
//                    
//                }
//                
//            } else if ((suitQuick[2][j] & 0b1000000000000) > 0) && ((suitQuick[0][j] & 0b1111111111111) > 0) {
//                
//                // Partner hat das As und man selber eine Karte -> Entry
//                entryToPartner += 1
//            }
//            
//            
//            
//            
//        }
//        
//        
//        
//        
//        return [quickTricks,entryToPartner]
//    }
//    
//    
//    
//    func hashIndex() -> String {
//        
//        // Um die Hashtabelle für Spielpositionen aufzubauen, wird einer Spielsituation ein eindeutiger String zugeordnet
//        // gespielte Karten sind schon sehr eindeutig, da sie vorher auch eindeutig Händen zugeordnet waren
//        
//        if hashTableBuildingGuide == 0 {
//            
//            // Hash-Table wird exakt erzeugt
//            return String(self.cardsPlayed) + String(self.playerCurrent) + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
//            
//        } else if hashTableBuildingGuide == 1  {
//            
//            // Hash-Table macht aus 7,6,5,4,3,2 jeweils ein x
//            
//            let str1 = String(self.cardsPlayed & 0b1111111000000111111100000011111110000001111111000000) + String(self.playerCurrent)
//            
//            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
//            
//        } else if hashTableBuildingGuide == 2 {
//            
//            // Hash-Table macht aus 6,5,4,3,2 jeweils ein x
//            
//            let str1 = String(self.cardsPlayed & 0b1111110000000111111000000011111100000001111110000000) + String(self.playerCurrent)
//            
//            return  str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
//            
//        } else if hashTableBuildingGuide == 99 {
//            
//            // Hash-Table NEW
//            
//            return  String(self.cardsPlayed) + String(self.trickLeader)
//            
//        } else {
//            
//            // Hash-Table macht aus 5,4,3,2 jeweils ein x
//            
//            let str1 = String(self.cardsPlayed & 0b1111111100000111111110000011111111000001111111100000) + String(self.playerCurrent)
//            
//            return  str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
//            
//            
//            
//        }
//        
//    }
//    
//    func areWeEqualCards(card1: UInt64, card2:UInt64) -> Bool {
//        
//        // Funktion überprüft, ob zwei Karten gleichwertig sind, d.h. nahtlos ineinander übergehen und somit
//        // bei den playable cards rausgefiltert werden können
//        
//        //Karten verschiedenfarbig
//        
//        if card1 & spades > 0 && card2 & spades == 0 {return false}
//        if card1 & hearts > 0 && card2 & hearts == 0 {return false}
//        if card1 & diamonds > 0 && card2 & diamonds == 0{return false}
//        if card1 & clubs > 0 && card2 & clubs == 0 {return false}
//        
//        var cardRun = card1
//        
//        while cardRun > card2 {
//            
//            cardRun = (cardRun >> 1)
//            
//            if cardRun == card2 {
//                
//                return true }
//            
//            //zwischen zwei möglichen benachbarten Karten muss geguckt werden, was mit diesen Karten ist
//            //Sind die Karten noch im Spiel also auf einer Gegnerhand/Partnerhand ODER im aktuellen Stich
//            //können die Karten nie benachbart sein
//            
//            if (cardRun & hands[playerCurrent] == 0 && cardRun & self.cardsPlayed == 0) || self.trickCurrent.contains(cardRun) == true {
//                
//                return false
//                
//            }
//            
//        }
//        
//        // von einer Karte zur anderen kommt nie eine Gegenspielerkarte oder Partnerkarte
//        return true
//    }
//    
//    func pointsForCardSorting(card: UInt64) -> Int {
//        
//        // Funktion soll in einer Spielsituation einen Wert geben um eine Sortierung zu ermöglichen
//        
//        
//        return 0
//        
//    }
//    
//    
//}
//
//
////// END CLASS
//
//

//
//  quickTricksTable.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 18.05.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//
//
//import Foundation
//
//// quickTrickTable
//var qTT = [String:Int]()
//
//func fillquickTricksTable () {
//    
//    qTT["AKQJ109xx"] = 8
//    qTT["AKQJ109x"] = 7
//    qTT["AKQJ109"] = 6
//    qTT["AKQJ10"] = 5
//    qTT["AKQJ"] = 4
//    qTT["AKQ"] = 3
//    qTT["AK"] = 2
//    qTT["A"] = 1
//    
//    qTT["Ax-Kx"] = 2
//    qTT["Ax-KQ"] = 2
//    qTT["Ax-KJ"] = 2
//    qTT["Ax-KT"] = 2
//    qTT["AQ-Kx"] = 2
//    qTT["AQ-KJ"] = 2
//    qTT["AQ-KT"] = 2
//    qTT["AJ-Kx"] = 2
//    qTT["AJ-KT"] = 2
//    qTT["AJ-KQ"] = 2
//    qTT["AQ-K"] = 2
//    
//    qTT["Ax-KQx"] = 3
//    qTT["Ax-KQJ"] = 3
//    qTT["Ax-KQJx"] = 4
//    qTT["AT-KQx"] = 3
//    qTT["AT-KQJ"] = 3
//    qTT["AT-KQJx"] = 4
//    
//    
//    qTT["AQx-KT"] = 3
//    qTT["AQx-Kx"] = 3
//    qTT["AQx-KJ"] = 3
//    
//    qTT["AQx-KTx"] = 3
//    qTT["AQx-Kxx"] = 3
//    qTT["AQx-KJx"] = 3
//    qTT["AQx-KJT"] = 3
//    
//    qTT["AQJ-KTx"] = 3
//    qTT["AQJ-Kxx"] = 3
//    qTT["AQJ-KTx"] = 3
//    
//    
//    qTT["AKJ-QT"] = 3
//    qTT["AKJ-Qx"] = 3
//    
//    qTT["AKx-QT"] = 3
//    qTT["AKx-Qx"] = 3
//    qTT["AKx-QJ"] = 3
//    
//    qTT["AKx-QTx"] = 3
//    qTT["AKx-Qxx"] = 3
//    qTT["AKx-QJx"] = 3
//    
//    qTT["AJx-KTx"] = 3
//    qTT["ATx-KJx"] = 3
//    
//    qTT["AKJx-QTxx"] = 4
//    qTT["AKJx-Qxxx"] = 4
//    qTT["AKJT-Qxxx"] = 4
//    qTT["AKxx-QJxx"] = 4
//    qTT["AKTx-QJxx"] = 4
//    qTT["AKx-QJxx"] = 4
//    qTT["AKT-QJxx"] = 4
//    qTT["AKJ-QTxx"] = 4
//    
//    qTT["AQJT-K"] = 4
//    qTT["AKJT-Q"] = 4
//    qTT["AKQT-J"] = 4
//    qTT["AQJT-Kx"] = 4
//    qTT["AKJT-Qx"] = 4
//    qTT["AKQT-Jx"] = 4
//    qTT["AQJT-Kxx"] = 4
//    qTT["AKJT-Qxx"] = 4
//    qTT["AKQT-Jxx"] = 4
//    qTT["AKQx-Jxx"] = 4
//    qTT["AQTx-KJ"] = 4
//    qTT["AJTx-KQ"] = 4
//    
//    
//    
//    qTT["AQJxx-KTx"] = 5
//    qTT["AQTxx-KJx"] = 5
//    
//    
//    
//    
//}

