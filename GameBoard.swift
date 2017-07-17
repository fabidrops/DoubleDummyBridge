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
    
    
    // Karte, die den aktuellen Stich gewinnt -> Index im aktuellen Stichs
    // liefert -1, wenn Stich leer
    
    var cardTrickWinner: Int {
        
        
        // die Zahl die returniert wird ist die Array-Position der Karte, nicht die des Spielers
        
        if trickCurrent.count == 1 {
            
            // nur eine Karte im Stich, diese gewinnt
            
            return 0
        
        } else {
            
            
            var highestCardInTrick = trickCurrent[0]
            var returnValue = 0
            
            for i in 1...trickCurrent.count-1 {
                
                if highestCardInTrick & trump > 0 {
                
                    // Trumpf im Stich
                    if (trickCurrent[i] & trump) > (highestCardInTrick & trump)  {
                        
                        
                        highestCardInTrick = trickCurrent[i]
                        returnValue = i
                        
                    }
                
                } else {
                    
                     // kein Trumpf im Stich
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
        let cardWinsNumber = (self.cardTrickWinner + trickLeader) % 4
        if self.trickCurrent.count == 4 {
            
            
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
            self.playerCurrent = (self.trickLeader + self.trickCurrent.count) % 4
            
            
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
    
    func quickTricksPlayerNew(player: Int) -> Int{
        
        // Strategie  10000010000111-Farbbeschreibung -> A K Q J T 9 (ZB 1010000)
        // diese 64 Kombinationen werden zusammen mit den 64 Partnerkombinationen = 4096 Kombinationen werden ausgewertet ggf. über Hash-Table
        // in der HashTable wird entweder direkt die qT abgelegt als Int
        // oder eine Zahl zB 238, die bedeutet dass das Maximum der Farblängen genommen werden soll
        
        
        var qT = 0
        
//        for suit:UInt64 in [spades,hearts,diamonds,clubs] {
//            
//            // Karten je Farbe isolieren
//            let cardsInSuitPlayer:UInt64 = (self.hands[player] & suit) >> (shiftNumber(suit: suit) )
//            let cardsInSuitPartner:UInt64 = (self.hands[(player + 2) % 4] & suit) >> (shiftNumber(suit: suit) )
//            
//            
//            
//            
//        }
        
        // Pik
        
        // 
        
        var cardsInSuitPlayer:UInt16 = 0
        
        
        
        
        
        return qT    }
    
    
    func quickTricksPlayer(player: Int) -> [Int] {
    
        // Ermittelt mittels einer Hash Table die quickTricks addiert pro Einzelfarbe
        
        var quickTricks = 0
        var entryToPartner = 0
        
        var handQuick: [UInt64] = [0,0,0,0]
        var suitQuick:[[UInt64]] = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
        
        let orHands = self.hands[0] | self.hands[1] | self.hands[2] | self.hands[3]
        
        
        // !!! TO DO - hier muss ich nur den aktuellen Spieler auswerten, nicht alle, das wird später in MinMax gemacht
        
        // übergebener Player ist Index 0, Partner 2, Gegenr 1 und 3
        for i in 0...3 { // für jeden Spieler
            
            handQuick[i] = self.hands[(player+i)%4]
            
            // Hände werden normiert, d.h. in relative Hände transfomriert
            for card in allHighCards.reversed() {
                
                if card & orHands == 0 {
                    
                    handQuick[i] = convertToRelativeRanking(hand: handQuick[i], cardRemoved: card)
                    
                }
                
            }
            
            // Isolieren der Farben -> jede Hand wird in ein Array seiner Einzelfarben zerlegt
            
            // Farben isolieren
            
            suitQuick[i][0] = (handQuick[i] & spades) >> 39
            suitQuick[i][1] = (handQuick[i] & hearts) >> 26
            suitQuick[i][2] = (handQuick[i] & diamonds) >> 13
            suitQuick[i][3] = (handQuick[i] & clubs)
            
        }
        
        // prüfen der Quick-Tricks pro Farbe
        
        for j in 0...3 { // für jede Farbe
            
            // Reminder: player 0 ist der untersuchte Index (player) des Spieler j ist Farbe -> Pik,Herz,Karo,Kreuz
            
            if suitQuick[0][j] & 0b1000000000000 > 0 {
                
                quickTricks += 1
                
                if suitQuick[0][j] & 0b0100000000000 > 0 {
                    
                    quickTricks += 1
                    
                    if suitQuick[0][j] & 0b0010000000000 > 0 {
                        
                        quickTricks += 1
                        
                    }

                }
            
            } else if ((suitQuick[2][j] & 0b1000000000000) > 0) && ((suitQuick[0][j] & 0b1111111111111) > 0) {
                
                // Partner hat das As und man selber eine Karte -> Entry
                entryToPartner += 1
            }
            
            
            
            
        }
        
        
       
        
        return [quickTricks,entryToPartner]
    }

    func quickTricksPlayer2(player: Int) -> [Int] {
        
        // Format AKJ5Q3 (AKJ zu fünft zu Q zu dritt ergibt 5 Stiche) mit Gegner AKJ5-3-Q2-3 (AKJxx zu xxx linke Qx ergibt 3), Anzahl Entries eintragen ?
        
        let orHands = self.hands[0] | self.hands[1] | self.hands[2] | self.hands[3]
        
        var quickTricks = 0
        var entryToPartner = 0
        
        // ITERATE OVER ALL SUITS ; 0 = spades : 4 = clubs
        
        for suit in 0...3 {
            
            // maximale Kartenanzahl eines anderen Spielers
            let farbLängeMax = max(self.playerShape[(player+1)%4][suit],self.playerShape[(player+2)%4][suit],self.playerShape[(player+3)%4][suit])
            
            let farbLängeMaxOpp = max(self.playerShape[(player+1)%4][suit],self.playerShape[(player+3)%4][suit])
            
            // let ace = [sA,hA,dA,cA]
        
            var strInSuit = ["A","K","Q","J","T","x","x","x","x","x","x","x","x"] // bei jedem Schleifendurchlauf neue Farbe mit "frischem Array"
            var qTInSuit = ["","","",""]

            
            
            for card in allSuits[suit] {
                
                
                // Karte ist in keiner Spielerhand -> nächste Karte prüfen
                if card & orHands == 0 { continue }
                
                
                if card & hands[player] > 0 {
                    
                    // wenn die Karte in der Spieler-Hand ist, wird der erste Zeichen des Strings verarbeitet, anschließend der String verkürzt
                    qTInSuit[0] += strInSuit[0]
                    strInSuit.remove(at: 0)
                
                }
                
                if card & hands[(player+1)%4] > 0 {
                    
                    qTInSuit[1] += strInSuit[0]
                    strInSuit.remove(at: 0)
                    
                }

                
                if card & hands[(player+2)%4] > 0 {
                    
                    qTInSuit[2] += strInSuit[0]
                    strInSuit.remove(at: 0)
                    

                }
                
                if card & hands[(player+3)%4] > 0 {
                    
                    qTInSuit[3] += strInSuit[0]
                    strInSuit.remove(at: 0)
                    
                }
                
            }
            
            // bis hier ist qTInSuit für alle Spieler gefüllt
            
            
            
            let handX = qTInSuit[0]
            
            // As nicht in Hand/Partnerhand -> nächste Farbe prüfen
            // geht nicht if handX.hasPrefix("A") == false {continue}
            
            let farbLänge = handX.characters.count
            
            
            let handY = qTInSuit[2]
            
            let farbLängePartner = handY.characters.count
            
            let handXY = qTInSuit[0] + "-" + qTInSuit[2]
            
            let handYX = qTInSuit[2] + "-" + qTInSuit[0]
            
            // Entry zum Partner ?
            
            if handX != "" && qTInSuit[2].hasPrefix("A") {
                
                entryToPartner += 1
                
            }
            

            // Test für Top Tricks
            
            if let qT = qTT[handXY] {
                
                quickTricks += qT
                
                
            }
                
            // TO DO: revresed auswerten, dann muss man aber auch longestsuitbeside... anders auswerten
//            if let qT = qTT[handYX] {
//                
//                if entryToPartner > 0 {
//                    
//                    quickTricks += qT
//
//                    
//                }
//                
//            }
            
            else if handX.hasPrefix("AKQJT") {
                
                if farbLängeMax <= 5 { quickTricks += self.playerShape[player][suit] }
                else { quickTricks += 5 }
                
            }
            
            else if handX.hasPrefix("AKQJ") {
                
                if farbLängeMax <= 4 { quickTricks += self.playerShape[player][suit] }
                else { quickTricks += 4 }
                
            }
            
            else if handX.hasPrefix("AKQ") {
                
                if farbLängeMax <= 3 { quickTricks += self.playerShape[player][suit] }
                else { quickTricks += 3 }
                
            }
            
            else if handX.hasPrefix("AK") {
                
                if farbLängeMax <= 2 { quickTricks += self.playerShape[player][suit] }
                else { quickTricks += 2 }
                
            }
            
            else if handX.hasPrefix("A") {
                
                if farbLängeMax <= 1 { quickTricks += self.playerShape[player][suit] }
                    
                    
                else if handY.hasPrefix("K") {
                    
                    // Ax Kxxxxxx
                    if farbLänge == 2 && farbLängeMaxOpp <= 2 && farbLängePartner >= 2 {
                        
                        quickTricks += self.playerShape[(player+2)%4][suit]
                        
                    // Axxxxx Kx
                    } else if farbLänge >= 2 && farbLängeMaxOpp <= 2 && farbLängePartner == 2 {
                        
                        quickTricks += self.playerShape[player][suit]
                        
                    //
                    } else if farbLänge >= 2  && farbLängePartner >= 2 { quickTricks += 2 }
                    
                    else { quickTricks += 1 }
                    
                    
                }
                    
                else { quickTricks += 1 }
            
            }
                

            else if let qT = qTT[handX] {
                
                quickTricks += qT
                
            }
            
            
            
            
        
        }
        
        //if quickTricks >= 4 {print("qT:\(quickTricks), Player:(\(player))")}
        return [quickTricks,entryToPartner]
    }
    
    func quickTricksPlayer3(player: Int) -> [Int] {
        
        // Format AKJ5Q3 (AKJ zu fünft zu Q zu dritt ergibt 5 Stiche) mit Gegner AKJ5-3-Q2-3 (AKJxx zu xxx linke Qx ergibt 3), Anzahl Entries eintragen ?
        
        let orHands = self.hands[0] | self.hands[1] | self.hands[2] | self.hands[3]
        
        var quickTricks = 0
        var entryToPartner = 0
        
        // ITERATE OVER ALL SUITS ; 0 = spades : 4 = clubs
        
        for suit in 0...3 {
            
            var strInSuit = ["A","K","Q","J","T","x","x","x","x","x","x","x","x"] // bei jedem Schleifendurchlauf neue Farbe mit "frischem Array"
            var qTInSuit = ["","","",""]
            
            var strInSuitx = ["A","K","Q","x","x","x","x","x","x","x","x","x","x"] // bei jedem Schleifendurchlauf neue Farbe mit "frischem Array"
            var qTInSuitx = ["","","",""]
            
            
            for card in allSuits[suit] {
                
                
                // Karte ist in keiner Spielerhand -> nächste Karte prüfen
                if card & orHands == 0 { continue }
                
                
                if card & hands[player] > 0 {
                    
                    // wenn die Karte in der Spieler-Hand ist, wird der erste Zeichen des Strings verarbeitet, anschließend der String verkürzt
                    qTInSuit[0] += strInSuit[0]
                    strInSuit.remove(at: 0)
                    
                    qTInSuitx[0] += strInSuitx[0]
                    strInSuitx.remove(at: 0)
                    
                }
                
                if card & hands[(player+1)%4] > 0 {
                    
                    qTInSuit[1] += strInSuit[0]
                    strInSuit.remove(at: 0)
                    
                    qTInSuitx[1] += strInSuitx[0]
                    strInSuitx.remove(at: 0)
                    
                }
                
                
                if card & hands[(player+2)%4] > 0 {
                    
                    qTInSuit[2] += strInSuit[0]
                    strInSuit.remove(at: 0)
                    
                    qTInSuitx[2] += strInSuitx[0]
                    strInSuitx.remove(at: 0)
                    
                    
                }
                
                if card & hands[(player+3)%4] > 0 {
                    
                    qTInSuit[3] += strInSuit[0]
                    strInSuit.remove(at: 0)
                    
                    qTInSuitx[3] += strInSuitx[0]
                    strInSuitx.remove(at: 0)
                    
                }
                
            }
            
            // bis hier ist qTInSuit für alle Spieler gefüllt
            
            
            // Auswertung X Spieler; Y Partner , zB AKJx
            let handX = qTInSuit[0]
            let handY = qTInSuit[2]
            let handXY = qTInSuit[0] + "-" + qTInSuit[2]
            let handYX = qTInSuit[2] + "-" + qTInSuit[0]
            
            // Auswertung X Spieler; Y Partner, zB Axxxx
            let handXx = qTInSuitx[0]
            let handYx = qTInSuitx[2]
            let handXYx = qTInSuitx[0] + "-" + qTInSuitx[2]
            let handYXx = qTInSuitx[2] + "-" + qTInSuitx[0]

            
            // Farblänge des Spielers & Partner
            let farbLänge = handX.characters.count
            let farbLängePartner = handY.characters.count
            
            // maximale Kartenanzahl eines anderen Spielers
            let farbLängeMax = max(self.playerShape[(player+1)%4][suit],self.playerShape[(player+2)%4][suit],self.playerShape[(player+3)%4][suit])
            
            // maximale Kartenzahl eines Gegners
            let farbLängeMaxOpp = max(self.playerShape[(player+1)%4][suit],self.playerShape[(player+3)%4][suit])
            
            
            
            // Entry zum Partner ?
            
            if handX != "" && qTInSuit[2].hasPrefix("A") {
                
                entryToPartner += 1
                
            }
            
            
            // Test für Top Tricks
            
            if let qT = qTT[handXY] {
                
                quickTricks += qT
                continue
                
            } else if let qT = qTT1[handXx] {
                
                if farbLängeMax <= 1 {
                    
                    quickTricks += qT
                    
                } else { quickTricks += 1}
            
            }
                
            else if let qT = qTT2[handXx] {
                
                if farbLängeMax <= 2 {
                    
                    quickTricks += qT
                    
                } else { quickTricks += 2}
                
            }
                
            else if handX.hasPrefix("AKQJT") {
                
                if farbLängeMax <= 5 { quickTricks += self.playerShape[player][suit] }
                else { quickTricks += 5 }
                
            }
                
            else if handX.hasPrefix("AKQJ") {
                
                if farbLängeMax <= 4 { quickTricks += self.playerShape[player][suit] }
                else { quickTricks += 4 }
                
            }
                
            else if handX.hasPrefix("AKQ") {
                
                if farbLängeMax <= 3 { quickTricks += self.playerShape[player][suit] }
                else { quickTricks += 3 }
                
            }
                
            else if handX.hasPrefix("AK") {
                
                if farbLängeMax <= 2 { quickTricks += self.playerShape[player][suit] }
                else { quickTricks += 2 }
                
            }
                
            else if handX.hasPrefix("A") {
                
                if farbLängeMax <= 1 { quickTricks += self.playerShape[player][suit] }
                    
                    
                else if handY.hasPrefix("K") {
                    
                    // Ax Kxxxxxx
                    if farbLänge == 2 && farbLängeMaxOpp <= 2 && farbLängePartner >= 2 {
                        
                        quickTricks += self.playerShape[(player+2)%4][suit]
                        
                        // Axxxxx Kx
                    } else if farbLänge >= 2 && farbLängeMaxOpp <= 2 && farbLängePartner == 2 {
                        
                        quickTricks += self.playerShape[player][suit]
                        
                        //
                    } else if farbLänge >= 2  && farbLängePartner >= 2 { quickTricks += 2 }
                        
                    else { quickTricks += 1 }
                    
                    
                }
                    
                else { quickTricks += 1 }
                
            }
                
                
            else if let qT = qTT[handX] {
                
                quickTricks += qT
                
            }
            
            
            
            
            
        }
        
        //if quickTricks >= 4 {print("qT:\(quickTricks), Player:(\(player))")}
        return [quickTricks,entryToPartner]
    }
    
    
    func quickTricksPlayer4(player: Int) -> [Int] {
        
        //
        let orHands = self.hands[0] | self.hands[1] | self.hands[2] | self.hands[3]
        
        var quickTricks = 0
        var entryToPartner = 0
        
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
            
            let qT = calQuickTricks(topCards: topCards2Player, a: a, b: b, oppMax: oppMax)
            quickTricks += qT
            
           //  if qT > 0 { print(printBinary(number: [UInt64( topCards2Player)])) ; print (qT)}
        
        }
        
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
            
        } else if hashTableBuildingGuide == 2 {
            
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
        
        
        return 0
    
    }
    
    
}


//// END CLASS


