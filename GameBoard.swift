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
    
    // 
    
    var hand4thFlag = false
    
    
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
        
        // -> Array mit allen Karten, die in der Spielerhand sind
        
        
        if trickCurrent.isEmpty {
            // 1. Ausspieler, alle Karten, die sich in der Hand des aktuellen Spielers befinden
            
            playableCards = allCards.filter({$0 & hands[playerCurrent] > 0})
            
        } else {
            
            // 2. Kann bedienen ?
            
            
            if hands[playerCurrent] & trickSuit == 0  {
                
                // a. Nein -> alle Spielerkarten sind spielbar
               
                playableCards = allCards.filter({$0 & hands[playerCurrent] > 0})
                
                if deleteAllCardsFromPlayableCardsThatAreNotTheSmallestOnesInSuitYouCannotGiveSuit {
                    
                    // wenn Konstante gesetzt, dann wird immer nur die kleinste Karte einer Farbe ausgewertet
                    // ergab bei den Testhänden bis ZA keine Fehler !
                    
                    let playableSpades = playableCards.filter({$0 & spades > 0}).sorted(by: {$0 < $1})
                    let playableHearts = playableCards.filter({$0 & hearts > 0}).sorted(by: {$0 < $1})
                    let playableDiamonds = playableCards.filter({$0 & diamonds > 0}).sorted(by: {$0 < $1})
                    let playableClubs = playableCards.filter({$0 & clubs > 0}).sorted(by: {$0 < $1})
                    
                    var playableNew:[UInt64] = []
                    
                    if !playableSpades.isEmpty { playableNew.append(playableSpades[0]) }
                    if !playableHearts.isEmpty { playableNew.append(playableHearts[0]) }
                    if !playableDiamonds.isEmpty { playableNew.append(playableDiamonds[0]) }
                    if !playableClubs.isEmpty { playableNew.append(playableClubs[0]) }
                    
                    playableCards = playableNew
                    
                }
                
                

                
            } else {
                
                // b. Ja
               
                playableCards = allCards.filter({$0 & hands[playerCurrent] & trickSuit > 0})
                
                
                // wenn der Größte es nie schaffen kann, nimm nur die kleinste
                let playableNew:[UInt64] = playableCards.sorted(by: {$0 > $1})
                
                if deleteAllCardsExceptGreatestWhenEveryCardIsSmallerThanSmallestOfOpps {
                
                    if (playableNew[0] < hands[(playerCurrent+1)%4] & trickSuit) && (playableNew[0] < hands[(playerCurrent+2)%4] & trickSuit) && (playableNew[0] < hands[(playerCurrent+3)%4] & trickSuit) {
                        
                        return [playableNew.last!]
                        
                    }
                
                }
                
                
            }
            
        }
        
        if playableCards.count <= 1 { return playableCards }
        
              else {
        
                
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
        
        // TO: Karten rausfiltern wo Q gespielt und man hält KB , da sollte K immer richtig sein, na ja kann mal richtig sein, wenn Q vorgelegt wird zu ducken
        
        if playableCardsWithSorting == true {
            
            
            
//            for card in playableCardsFilterEqualCards {
//            
//                if tricksWonByEastWest + tricksWonByNorthSouth == 0 && trickCurrent.isEmpty {
//                
//                    print("\(returnCardAsString(hand: card)): \(pointsForCardSorting2(card: card))")
//                   
//                
//                
//                }
//            
//            }
            
            // TO DO: von jeder Farbe sollte eine Karte vorne stehen ! aber nur wenn nicht bedient wird, sonst ist es ja so
            
            return playableCardsFilterEqualCards.sorted(by: {self.pointsForCardSorting2(card: $0) > self.pointsForCardSorting2(card: $1)})
            
        } else {
            
            return playableCardsFilterEqualCards
            
        }
    }
    
    
    func quickTricksPlayer(player: Int) -> [Int] {
        
        //
        let orHands = self.hands[0] | self.hands[1] | self.hands[2] | self.hands[3]
        
        var quickTricks = 0
        var entryToPartner = 0
        
        var LHOhasKing = false
        var LHOhasQueen = false
        var LHOhasJack = false
        
        var quickTricksShape:[Int] = [0,0,0,0,0,0,0,0]
        
        // ITERATE OVER ALL SUITS ; 0 = spades : 4 = clubs
        
        for suit in 0...3 {
            
            var topCards:[UInt8] = [0b10000000,0b01000000,0b00100000,0b00010000]
            var topCards2Player:UInt8 = 0
            var topCardsCounter = 0
            
            LHOhasKing = false
            LHOhasQueen = false
            LHOhasJack = false

            
            
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
                
                if card & hands[(player+1)%4] > 0 && topCardsCounter == 1 { LHOhasKing = true }
                if card & hands[(player+1)%4] > 0 && topCardsCounter == 2 { LHOhasQueen = true }
                if card & hands[(player+1)%4] > 0 && topCardsCounter == 3 { LHOhasJack = true }
                
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
            var qTFull:[Int] = []
            
            let qT = calQuickTricks(topCards: topCards2Player, a: a, b: b, oppMax: oppMax, LHO: [LHOhasKing,LHOhasQueen,LHOhasJack])
                
          
            
            let shifty:UInt8 = (topCards2Player << 4) + (topCards2Player >> 4)
            
            // RHO !!!!!!
            let qTP = calQuickTricks(topCards: shifty, a: b, b: a, oppMax: oppMax, LHO: [LHOhasKing,LHOhasQueen,LHOhasJack]) // Partner auswerten
            
//            qTFull[4*suit] = qT       // für jede Farbe, wenn von West gespielt wird
//            qTFull[4*suit+1] = qTP    // für jede Farbe, wenn von Ost gespielt wird 
//            qTFull[4*suit+2] = 0      
//            qTFull[4*suit+3] = 0
            
            

            quickTricks += qT
            
//            print(qTFull)
            
//            quickTricksShape[suit] = qT
//            quickTricksShape[suit+4] = qTP
            
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
        
        
        else if hashTableBuildingGuide == 5555  {
            
            // Hash-Table macht aus 9,87,6,5,4,3,2 jeweils ein x
            
//            V0.60a: game0(false) #N/S 2 #TIME 46 #VAR 0 #MINMAX 1109 #HASH 87 #ALPHA 3 #BETA 465 #TRICKS 8
//            V0.60a: gameA(true) #N/S 1 #TIME 100 #VAR 7 #MINMAX 3149 #HASH 147 #ALPHA 7 #BETA 1459 #TRICKS 7
//            V0.60a: gameB(true) #N/S 5 #TIME 428 #VAR 40 #MINMAX 13374 #HASH 1007 #ALPHA 4884 #BETA 930 #TRICKS 7
//            V0.60a: gameC(true) #N/S 3 #TIME 6724 #VAR 131 #MINMAX 195601 #HASH 13708 #ALPHA 32123 #BETA 55518 #TRICKS 10
//            V0.60a: gameD(true) #N/S 5 #TIME 0 #VAR 0 #MINMAX 22 #HASH 0 #ALPHA 0 #BETA 6 #TRICKS 7
//            V0.60a: gameE(true) #N/S 5 #TIME 17 #VAR 0 #MINMAX 441 #HASH 39 #ALPHA 0 #BETA 131 #TRICKS 9
//            V0.60a: gameF(true) #N/S 7 #TIME 156 #VAR 51 #MINMAX 4457 #HASH 535 #ALPHA 1902 #BETA 141 #TRICKS 11
//            V0.60a: gameF1(true) #N/S 4 #TIME 55770 #VAR 210 #MINMAX 1536200 #HASH 172479 #ALPHA 119869 #BETA 546597 #TRICKS 11
//            V0.60a: gameG(true) #N/S 9 #TIME 27742 #VAR 90 #MINMAX 774429 #HASH 107631 #ALPHA 279772 #BETA 64586 #TRICKS 13

            
            let str1 = String(self.cardsPlayed & 0b1111100000000111110000000011111000000001111100000000) + String(self.playerCurrent)
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        }  else if hashTableBuildingGuide == 5544  {
            
            
            let str1 = String(self.cardsPlayed & 0b1111100000000111110000000011111000000001111100000000) + String(self.playerCurrent)
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        }

            
        else if hashTableBuildingGuide == 6666 {
//            V0.60a: game0(true) #N/S 1 #TIME 276 #VAR 3 #MINMAX 7427 #HASH 896 #ALPHA 817 #BETA 1746 #TRICKS 8
//            V0.60a: gameA(true) #N/S 1 #TIME 102 #VAR 7 #MINMAX 3149 #HASH 147 #ALPHA 7 #BETA 1459 #TRICKS 7
//            V0.60a: gameB(true) #N/S 5 #TIME 634 #VAR 44 #MINMAX 19510 #HASH 1650 #ALPHA 7001 #BETA 1503 #TRICKS 7
//            V0.60a: gameC(true) #N/S 3 #TIME 10873 #VAR 188 #MINMAX 329780 #HASH 23181 #ALPHA 49956 #BETA 97800 #TRICKS 10
//            V0.60a: gameD(true) #N/S 5 #TIME 0 #VAR 0 #MINMAX 22 #HASH 0 #ALPHA 0 #BETA 6 #TRICKS 7
//            V0.60a: gameE(true) #N/S 5 #TIME 17 #VAR 0 #MINMAX 451 #HASH 37 #ALPHA 0 #BETA 131 #TRICKS 9
//            V0.60a: gameF(true) #N/S 7 #TIME 137 #VAR 51 #MINMAX 4477 #HASH 531 #ALPHA 1902 #BETA 141 #TRICKS 11
//            V0.60a: gameF1(true) #N/S 4 #TIME 72968 #VAR 300 #MINMAX 2084025 #HASH 212167 #ALPHA 186160 #BETA 707616 #TRICKS 11
//            V0.60a: gameG(true) #N/S 9 #TIME 53210 #VAR 137 #MINMAX 1533463 #HASH 201582 #ALPHA 572045 #BETA 119056 #TRICKS 13
            
            let str1 = String(self.cardsPlayed & 0b1111110000000111111000000011111100000001111110000000) + String(self.playerCurrent)
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        }
        else if hashTableBuildingGuide == 7777 {
            
            let str1 = String(self.cardsPlayed & 0b1111111000000111111100000011111110000001111111000000) + String(self.playerCurrent)
            
            //hashTableBuildingGuide = 4444
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        }
        else if hashTableBuildingGuide == 8888 {
            
            let str1 = String(self.cardsPlayed & 0b1111111100000111111110000011111111000001111111100000) + String(self.playerCurrent)
            
            //hashTableBuildingGuide = 4444
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        }
        else if hashTableBuildingGuide == 4444  {
            
//            V0.60a: game0(false) #N/S 2 #TIME 27 #VAR 0 #MINMAX 655 #HASH 55 #ALPHA 2 #BETA 277 #TRICKS 8
//            V0.60a: gameA(true) #N/S 1 #TIME 83 #VAR 5 #MINMAX 2348 #HASH 117 #ALPHA 5 #BETA 1090 #TRICKS 7
//            V0.60a: gameB(true) #N/S 5 #TIME 250 #VAR 27 #MINMAX 7429 #HASH 587 #ALPHA 2520 #BETA 662 #TRICKS 7
//            V0.60a: gameC(true) #N/S 3 #TIME 3047 #VAR 59 #MINMAX 90540 #HASH 7742 #ALPHA 16910 #BETA 23298 #TRICKS 10
//            V0.60a: gameD(true) #N/S 5 #TIME 0 #VAR 0 #MINMAX 22 #HASH 0 #ALPHA 0 #BETA 6 #TRICKS 7
//            V0.60a: gameE(true) #N/S 5 #TIME 16 #VAR 0 #MINMAX 432 #HASH 39 #ALPHA 0 #BETA 129 #TRICKS 9
//            V0.60a: gameF(true) #N/S 7 #TIME 253 #VAR 151 #MINMAX 8485 #HASH 948 #ALPHA 3841 #BETA 147 #TRICKS 11
//            V0.60a: gameF1(true) #N/S 4 #TIME 19864 #VAR 113 #MINMAX 541423 #HASH 66602 #ALPHA 52200 #BETA 180486 #TRICKS 11
//            V0.60a: gameG(false) #N/S 10 #TIME 5188 #VAR 54 #MINMAX 143254 #HASH 20163 #ALPHA 54125 #BETA 9769 #TRICKS 13

            //hashTableBuildingGuide = 7777
            
            let str1 = String(self.cardsPlayed & 0b1111000000000111100000000011110000000001111000000000) + String(self.playerCurrent)
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        }
        
        else if hashTableBuildingGuide == 3333  {
            
//            V0.60a: game0(false) #N/S 2 #TIME 22 #VAR 0 #MINMAX 568 #HASH 40 #ALPHA 2 #BETA 241 #TRICKS 8
//            V0.60a: gameA(true) #N/S 1 #TIME 50 #VAR 3 #MINMAX 1552 #HASH 80 #ALPHA 3 #BETA 725 #TRICKS 7
//            V0.60a: gameB(false) #N/S 4 #TIME 114 #VAR 8 #MINMAX 3533 #HASH 327 #ALPHA 1131 #BETA 372 #TRICKS 7
//            V0.60a: gameC(true) #N/S 3 #TIME 1109 #VAR 16 #MINMAX 31926 #HASH 2916 #ALPHA 6463 #BETA 7653 #TRICKS 10
//            V0.60a: gameD(true) #N/S 5 #TIME 0 #VAR 0 #MINMAX 22 #HASH 0 #ALPHA 0 #BETA 6 #TRICKS 7
//            V0.60a: gameE(true) #N/S 5 #TIME 13 #VAR 0 #MINMAX 334 #HASH 36 #ALPHA 0 #BETA 102 #TRICKS 9
//            V0.60a: gameF(true) #N/S 7 #TIME 244 #VAR 139 #MINMAX 7798 #HASH 907 #ALPHA 3555 #BETA 120 #TRICKS 11
//            V0.60a: gameF1(false) #N/S 2 #TIME 3044 #VAR 26 #MINMAX 82621 #HASH 8658 #ALPHA 3513 #BETA 34094 #TRICKS 11
//            V0.60a: gameG(false) #N/S 10 #TIME 1937 #VAR 20 #MINMAX 52987 #HASH 8408 #ALPHA 19673 #BETA 3710 #TRICKS 13
            
            
            
            let str1 = String(self.cardsPlayed & 0b1110000000000111000000000011100000000001110000000000) + String(self.playerCurrent)
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        }else if hashTableBuildingGuide == 2222  {
            
            
            
            let str1 = String(self.cardsPlayed & 0b1100000000000110000000000011000000000001100000000000) + String(self.playerCurrent)
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        }else if hashTableBuildingGuide == 58  {
            
            // Hash-Table macht aus 9,87,6,5,4,3,2 jeweils ein x
            
            if tricksWonByNorthSouth + tricksWonByEastWest <= TOTALTRICKSINGAME/3 - 1 {
                
                            
            let str1 = String(self.cardsPlayed & 0b1111000000000111100000000011110000000001111000000000) + String(self.playerCurrent)
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
                
            }
            
            else if tricksWonByNorthSouth + tricksWonByEastWest <= 2*TOTALTRICKSINGAME/3 - 1 {
                
                let str1 = String(self.cardsPlayed & 0b1111110000000111111000000011111100000001111110000000) + String(self.playerCurrent)
                
                return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
                
            }
            else  {
                
                let str1 = String(self.cardsPlayed) + String(self.playerCurrent)
                
                return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
                
            }

            
            
            
        }else if hashTableBuildingGuide == 77 {
            
            // bis auf die erste Hand passt es
            
            if tricksWonByNorthSouth + tricksWonByEastWest <= TOTALTRICKSINGAME/3 - 1 {
                
                
                let str1 = String(self.cardsPlayed & 0b1111000000000111100000000011110000000001111000000000) + String(self.playerCurrent)
                
                return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
                
            }
                
            else if tricksWonByNorthSouth + tricksWonByEastWest <= 2*TOTALTRICKSINGAME/3 - 1 {
                
                let str1 = String(self.cardsPlayed & 0b1111100000000111110000000011111000000001111100000000) + String(self.playerCurrent)
                
                return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
                
            }
            else  {
                
                let str1 = String(self.cardsPlayed) + String(self.playerCurrent)
                
                return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
                
            }
            
            
            
            
        }else if hashTableBuildingGuide == 56  {
            
            // 
            
            let str1 = String(self.relativeHands[0]) + String(self.relativeHands[1]) + String(self.relativeHands[2]) + String(self.relativeHands[3]) + String(self.playerCurrent)
            
            return str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth) 
            
        } else if hashTableBuildingGuide == 199  {
            
          
            
            let str1 = String(self.cardsPlayed & 0b1111000000000111100000000011110000000001111000000000) + String(self.playerCurrent)
            
            return  str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
            
        }else if hashTableBuildingGuide == 57 {
            
            // Hash-Table macht aus T,...,6,5,4,3,2 jeweils ein x
            
            let str1 = String(self.cardsPlayed & 0b1111000000000111100000000011110000000001111000000000) + String(self.playerCurrent)
            
            return  str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
        } else if hashTableBuildingGuide == 99 {
            
            // Hash-Table NEW
            
            return  String(self.cardsPlayed) + String(self.trickLeader)
            
        } else if hashTableBuildingGuide == 8888 {
            
            // Hash-Table macht aus 5,4,3,2 jeweils ein x
            
            let str1 = String(self.cardsPlayed & 0b1111111100000111111110000011111111000001111111100000) + String(self.playerCurrent)
            
            return  str1 + String(tricksWonByEastWest) + String(tricksWonByNorthSouth)
            
            
            
        } else {
            
            return ""
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
            
            // aquivalent zu eigene Hand oder gespielt ? -> hilf das ?
            
            
            if (cardRun & hands[playerCurrent] == 0 && cardRun & self.cardsPlayed == 0) || self.trickCurrent.contains(cardRun) == true {
                
                return false
                
            }
            
//            if !((cardRun & hands[playerCurrent] > 0) || (cardRun & cardsPlayed) > 0) {
//                
//                return false
//            }
            
        }
        
        // von einer Karte zur anderen kommt nie eine Gegenspielerkarte oder Partnerkarte
        return true
    }
    
        
}


//// END CLASS


