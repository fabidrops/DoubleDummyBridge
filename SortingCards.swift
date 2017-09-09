//
//  SortingCards.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 20.07.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

extension gameBoard {
    
    
    func pointsForCardSorting2(card: UInt64) -> Int {
        
        
        // Funktion baut auf DDS aus Github auf
        
        var suit:Int
        var suitUInt64: UInt64
        var relativeCards:[UInt64]
        
        var aceInSuit: UInt64
        var kingInSuit: UInt64
        var queenInSuit: UInt64
        
        var isSequence: Bool {
            
            if rankOfCard(card: card) <= 13 {
                
                if (card << 1 & hands[playerCurrent] > 0) && (card << 2 & hands[playerCurrent] > 0) {
                    
                    
                    return true }
                
            }
            
            
            return false
        }
        
        
        if card & spades > 0 { suit = 0 ; aceInSuit = sA ; kingInSuit = sK ; queenInSuit = sQ ; relativeCards = [sA,sK,sQ,sJ,sT,s9,s8,s7,s6,s5,s4,s3,s2] ; suitUInt64 = spades}
        else if card & hearts > 0 { suit = 1 ; aceInSuit = hA ; kingInSuit = hK ; queenInSuit = hQ ;  relativeCards = [hA,hK,hQ,hJ,hT,h9,h8,h7,h6,h5,h4,h3,h2]; suitUInt64 = hearts}
        else if card & diamonds > 0 { suit = 2 ; aceInSuit = dA ; kingInSuit = dK ; queenInSuit = dQ; relativeCards = [dA,dK,dQ,dJ,dT,d9,d8,d7,d6,d5,d4,d3,d2]; suitUInt64 = diamonds}
        else { suit = 3 ; aceInSuit = cA ; kingInSuit = cK; queenInSuit = cQ ; relativeCards = [cA,cK,cQ,cJ,cT,c9,c8,c7,c6,c5,c4,c3,c2] ; suitUInt64 = clubs}
        
        // isPotentialWinner, isWinner
        
        func isPotentialWinner(card: UInt64) -> Bool {
            // Karte kann den aktuellen Stich gewinnen
            
            if trickCurrent.count == 0 {
                
                // TO DO:kann er es wirklich oder gibt es eine Hand, wo alle Karten höher sind ?
                return true
                
            }
                
                
            else if card & trickSuit > 0 && trump == 0 && card > trickCurrent[cardTrickWinner]{
                
                return true
                
            }
                
            else {
                
                return false
                
            }
            
        }
        
        func isWinner(card: UInt64) -> Bool {
            
            var suit:UInt64 {
                
                if trickCurrent.count > 0 { return trickSuit }
                    
                else { return suitUInt64 }
                
                
            }
            
            // Karte WIRD aktuellen Stich gewinnen
            
            if isPotentialWinner(card: card) {
                
                if trickCurrent.count == 3 {
                    
                    // in letzter Hand ist ein PotentialWinner ein Winner
                    return true
                    
                }
                    
                    
                else {
                    
                    for opp in 1...3-trickCurrent.count {
                        
                        //print("\((playerCurrent + opp)%4)" + handToStringVisualStyle(hand: hands[(playerCurrent+opp)%4] & suit))
                        
                        if hands[(playerCurrent+opp)%4] & suit > card {
                            
                            return false
                            
                        }
                        
                    }
                    
                    //keine der nachfolgenden Karten in einer Spielerhand ist höher
                    return true
                    
                }
                
            }
                
            else {
                
                return false
                
            }
            
        }
        
        
        // relativer Rank der Karte
//        var relativeRank: Int {
//            
//            let cardsinHand = hands[0] + hands[1] + hands[2] + hands[3]
//            
//            var counter = 0
//            
//            for high in relativeCards {
//                
//                if high & cardsinHand > 0 {
//                    
//                    counter += 1
//                    
//                }
//                
//                if high == card { return counter }
//                
//            }
//            
//            return 0        }
        
        
            
            
            // RELATIVER RANK 1 -> As
            // MIN ist gut, d.h. sind die hohen Karten
            // MAX ist schlecht, d.h. kleinsten Karten
            
            var cardRelative:Int = 0
            var currentPlRelativeMin = 15
            var currentPlRelativeMax = 0
        
            var firstCard = 0.5
           
            var partnerPlRelativeMin = 15 // die Karte mit dem kleinsten relatoven Rank, also höchste Karte !
            var partnerPlRelativeMax = 0
        
            
            var LHORelativeMin = 15
            var LHORelativeMax = 0
            
            var RHORelativeMin = 15
            var RHORelativeMax = 0
            
            let card0inTrickRelative = 0
            let card1inTrickRelative = 0
            let card2inTrickRelative = 0
        
        var smallestPossibleWinnerInCurrentHand: Bool = false
        
        if trickCurrent.count > 0 {
        
            if card & trickSuit > 0 && card > trickCurrent[0] && card > (hands[(playerCurrent+1)%4] & trickSuit) { smallestPossibleWinnerInCurrentHand = true }
            
        
        }
            
            
            let cardsinHand = hands[0] + hands[1] + hands[2] + hands[3]
            
            var counter = 0
            
            for high in relativeCards {
                
                if high & cardsinHand > 0 {
                    
                    counter += 1
                    
                    if high & hands[playerCurrent] > 0 {
                        
                        if counter < currentPlRelativeMin { currentPlRelativeMin = counter }
                        if counter > currentPlRelativeMax { currentPlRelativeMax = counter }
                        
                    }
                    
                    if high & hands[(playerCurrent+1)%4] > 0 {
                        
                        if counter < LHORelativeMin { LHORelativeMin = counter }
                        if counter > LHORelativeMax { LHORelativeMax = counter }
                        
                    }
                    
                    if high & hands[(playerCurrent+2)%4] > 0 {
                        
                        if counter < partnerPlRelativeMin { partnerPlRelativeMin = counter }
                        if counter > partnerPlRelativeMax { partnerPlRelativeMax = counter }
                        
                    }
                    
                    if high & hands[(playerCurrent+3)%4] > 0 {
                        
                        if counter < RHORelativeMin { RHORelativeMin = counter }
                        if counter > RHORelativeMax { RHORelativeMax = counter }
                        
                    }
                    
                }
                
                if high == card { cardRelative = counter }
                
                
                
                
                if trickCurrent.count > 0 {
                    
                    if high == trickCurrent[0] {
                        
                        firstCard = firstCard + Double(counter) // gespielte Karte bekommt einen relativen Rank mit +0,5
                        
                    }
                    
                    if high < card && high > trickCurrent[0] && high > (hands[(playerCurrent+1)%4] & trickSuit) && smallestPossibleWinnerInCurrentHand {
                        // es gibt eine kleinere Karte als die aktuelle untersuchte Karte, die sowohl größer als die ausgesielte Karte als auch als alle anderen Karten des LHO sind, dann ist aktuelle untersuchte Karte nicht der kleinste mögliche Gewinner
                        smallestPossibleWinnerInCurrentHand = false
                        
                    }
                    
                }
                
                
                
                
                
            }
        
        
        
       
        
        
        // 1. Ausspieler
        
        if self.trickCurrent.isEmpty {
            
            //          // Abwerten von Farben, wo die Suchbäume lang sind, d.h. gemeinsame Karten sehr groß
            
            let suitCountLH = playerShape[(playerCurrent+1)%4][suit]
            let suitCountRH = playerShape[(playerCurrent+3)%4][suit]
            let suitCountP = playerShape[(playerCurrent+2)%4][suit]
            
            // weitere Modifikation (Sinn unklar)
            
            var countLH = 0
            var countRH = 0
            
            if playerCurrent == 0 || playerCurrent == 2 {
                
                countLH = (suitCountLH == 0 ? tricksWonByEastWest + 1 : suitCountLH) << 2
                countRH = (suitCountRH == 0 ? tricksWonByEastWest + 1 : suitCountRH) << 2
                
            } else {
                
                countLH = (suitCountLH == 0 ? tricksWonByNorthSouth + 1 : suitCountLH) << 2
                countRH = (suitCountRH == 0 ? tricksWonByNorthSouth + 1 : suitCountRH) << 2
                
            }
            
            var suitWeightDelta = -(((countLH + countRH) << 5) / 19)
            
            // wenn Partner void ist -> Abzug
            
            if playerShape[(playerCurrent+2)%4][suit] == 0 { suitWeightDelta -= 9 }
            
            // A. Karte wird den Stich gewinnen (relatives As) oder Partner hat das relative As, die den Stich gewinnen wird
            
            if cardRelative == 1 || relativeHands[(playerCurrent+2)%4] & aceInSuit > 0 {
                
                // RHO hat den König, den will man nicht freispielen, Ausnahme: K ist blank
                
                if relativeHands[(playerCurrent+3)%4] & kingInSuit > 0 && suitCountRH != 1 {
                    
                    suitWeightDelta += -1
                    
                }
                
                // aufwerten wenn LHO den König hat
                
                if relativeHands[(playerCurrent+1)%4] & kingInSuit > 0 {
                    
                    if suitCountLH != 1 {
                        
                        suitWeightDelta += 22
                        
                    } else {
                        
                        suitWeightDelta += 16
                        
                    }
                    
                }
                
                // aufwerten, wenn auch die zweithöchste Karte (relativer K) in eigener oder Partnerhand ist oder wenn der K ein Singleton beim Gegner ist
                
                if (relativeHands[(playerCurrent+2)%4] & kingInSuit > 0 || relativeHands[playerCurrent] & kingInSuit > 0) || suitCountLH == 1 || suitCountRH == 1 {
                    
                    return suitWeightDelta + 45 + cardRelative
                    
                } else {
                    
                    return suitWeightDelta + 18 + cardRelative
                    
                }
                
                
            } // Klammer A Ende
                
            else {
                
                // B. Seite wird den Stich nicht zwingend gewinnen
                
                // abwerten wenn RHO den relativen K oder As hat, es sei denn blank
                
                if (relativeHands[(playerCurrent+3)%4] & kingInSuit > 0 || relativeHands[(playerCurrent+3)%4] & aceInSuit > 0) {
                    
                    if suitCountRH != 1 {
                        
                        suitWeightDelta += -10
                        
                    }
                    
                    // aufwerten wenn Expass zum K steht, also Partner hat den relativen K und LHO das As
                    // Ausnahme: Partner hat Single.
                    
                } else if (relativeHands[(playerCurrent+1)%4] & aceInSuit > 0 && relativeHands[(playerCurrent+2)%4] & kingInSuit > 0) {
                    
                    if suitCountP != 1 {
                        
                        suitWeightDelta += 31
                        
                    }
                    
                }
                
                // aufwerten K und Dame an Bord sind, entweder beide beim Partner oder verteilt, aber nicht blank
                
                if (relativeHands[(playerCurrent+2)%4] & kingInSuit > 0 && relativeHands[(playerCurrent+2)%4] & queenInSuit > 0) {
                    
                    suitWeightDelta += 35
                    
                } else if (relativeHands[playerCurrent] & kingInSuit > 0 && relativeHands[(playerCurrent+2)%4] & queenInSuit > 0) || (relativeHands[(playerCurrent+2)%4] & kingInSuit > 0 && relativeHands[playerCurrent] & queenInSuit > 0) {
                    
                    if suitCountP > 1 { suitWeightDelta += 25 }
                    
                }
                
                // Auswertung
                
                if (suitCountLH == 1 && relativeHands[(playerCurrent+1)%4] & aceInSuit > 0) || (suitCountRH == 1 && relativeHands[(playerCurrent+3)%4] & aceInSuit > 0) {
                    // Single As beim Gegner
                    
                    return suitWeightDelta + 28 + cardRelative
                    
                } else if relativeHands[playerCurrent] & aceInSuit > 0 {
                    
                    // As bei Ausspieler
                    
                    return suitWeightDelta - 17 + cardRelative
                    
                }
                    
                    // Karte gehört zur Sequenz
                else if !isSequence { return suitWeightDelta + 12 + cardRelative }
                    
                    //                else if cardRelative == 2 {
                    //
                    //                     return suitWeightDelta + 48;
                    //
                    //                }
                    
                else {
                    
                    return suitWeightDelta + 29 - cardRelative
                    
                }
                
            } // Klammer B Ende
            
            
            
            
        }
        
        else if trickCurrent.count == 1 && trump == 0 && trickSuit & card > 0 {
            
            // wen Partner gewinnen kann anders agieren
            
            // Partner hat A oder Kx oder Qx
            
            if partnerPlRelativeMin == 1 && playerShape[(playerCurrent+2)%4][suit] == 1 || partnerPlRelativeMin == 2 && playerShape[(playerCurrent+2)%4][suit] <= 2 {
                
                return -rankOfCard(card: card)
            }
            
            // kleinster Gewinner (warum einen anderen verschwenden)
            
            if smallestPossibleWinnerInCurrentHand && cardRelative != 1 { return 100 }
            
            
            // sequenz splitten
            
            if isSequence && cardRelative <= 6 && isPotentialWinner(card: card){ return 50 }
            
            
            //
            if isWinner(card: card) { return 37 - cardRelative}

            
            // kleinste Karte
            
            if cardRelative == currentPlRelativeMax { return 35 }
            
            //
            
            if isPotentialWinner(card: card) { return 25 - rankOfCard(card: card) }
            
            // decken (also kleinste höhere Karte als Ausspiel), aber Kx deckt Dx zu ABx
            
            
            // To Do: wenn eine kleine Karte kleiner ist als die kleinste Karte der anderen Spieler, dann reicht es eine Karte in playable Cards zu haben
            
            // höchste Karte
            
            return -rankOfCard(card: card)
            
        }
            
            
//         else if trickCurrent.count == 1 && trump == 0 && trickSuit & card > 0 {
//            
//            
//            if Double(partnerPlRelativeMin) < firstCard && partnerPlRelativeMin < LHORelativeMin {
//               // Partner kann beide Gegner schlagen
//                
//                return -rankOfCard(card: card)
//                
//                
//            } else {
//                
//                if (Double(currentPlRelativeMin) < firstCard && currentPlRelativeMin < LHORelativeMin)  {
//                // Ich schlage beide Gegner
//                    
//                    // schlecht dann werden immer ALLE hohen Karten ausgewertet
//                
//                    return 81 - rankOfCard(card:card)
//                
//                } else if partnerPlRelativeMax < cardRelative && LHORelativeMax < cardRelative {
//                    
//                    // kleinste Karte vom Partner und vom Gegner sind immer noch höher als eigenen Karte
//                    // -> kleinste Karte
//                    
//                    return -3 + cardRelative
//                    
//                    
//                } else if Double(cardRelative) > firstCard {
//                    
//                    // kann erste Karte im Stich nicht schlagen
//                    
//                    return -11 + cardRelative
//                    
//                } else if isSequence {
//                    
//                    return 10 + cardRelative
//                    
//                } else {
//                    
//                    return 13 - rankOfCard(card:card)
//                    
//                }
//                
//            } // END Else
//            
//            
//            
//            
//        } // End
        
        
        
        
        else if trump == 0 && trickCurrent.count == 2 && trickSuit & card == 0 {
           // 2. PARTNER ist dran und kann nicht bedienen
            
            
            // BEDIENT NICHT & NT
            
            let suitCount = playerShape[(playerCurrent+2)%4][suit]
            var suitAdd = (suitCount << 6) / 24
            
            // Try not to pitch from Kx or stiff ace.
            if suitCount == 2 && cardRelative == 2 {
                
                suitAdd += -4
                
            }
                
            else if suitCount == 1 && cardRelative == 1 {
                
                suitAdd += -4
                
                
            }
            
            
            return -rankOfCard(card: card) + suitAdd
            
            
        }
            
        else if trump == 0 && trickCurrent.count == 2 && trickSuit & card > 0 && 1==0 {
            // 2. PARTNER ist dran und bedient
            
            
            
            
            
        }
            
            
            
            
            
            
        else {
            
            // Spieler muss abwerfen -> möglichst kleine Karte
            if self.trickSuit & card == 0 && card != trump { // Spieler muss abwerfen
                
                return -rankOfCard(card: card)
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
            
            
            
            
        }
        
        
        
        
        // 3. Partner
        
        
        // 4. RHO
        
        
        
        return 0
    }
    

    
    
    
    
    
    
}




func rankOfCard(card:UInt64) -> Int {
    
    if card & (sA+hA+dA+cA) > 0 { return 14}
        
    else if card & (sK+hK+dK+cK) > 0 { return 13 }
        
    else if card & (sQ+hQ+dQ+cQ) > 0 { return 12 }
        
    else if card & (sJ+hJ+dJ+cJ) > 0 { return 11}
        
    else if card & (sT+hT+dT+cT) > 0 { return 10 }
        
    else if card & (s9+h9+d9+c9) > 0 { return 9 }
        
    else if card & (s8+h8+d8+c8) > 0 { return 8 }
        
    else if card & (s7+h7+d7+c7) > 0 { return 7 }
        
    else if card & (s6+h6+d7+c7) > 0 { return 6 }
        
    else if card & (s5+h5+d5+c5) > 0 { return 5 }
        
    else if card & (s4+h4+d4+c4) > 0 { return 4 }
        
    else if card & (s3+h3+d3+c3) > 0 { return 3 }
        
    else if card & (s2+h2+d2+c2) > 0 { return 2 }
        
    else {return 0}
    
}

//func pointsForCardSorting(card: UInt64) -> Int {
//    
//    // Funktion soll in einer Spielsituation einen Wert geben um eine Sortierung zu ermöglichen
//    
//    var suitAdd:Int = 0
//    var suitBonus = 0
//    var LHO = 0
//    var RHO = 0
//    
//    if card & spades > 0 {
//        
//        suitAdd = Int(((self.playerShape[playerCurrent][0]) * 64)/36)
//        if self.relativeHands[(playerCurrent+3)%4] & (sA+sK) > 0 { suitBonus += -18 }
//        LHO = self.playerShape[(playerCurrent+1)%4][0]
//        RHO = self.playerShape[(playerCurrent+3)%4][0]
//        
//    } else if card & hearts > 0 {
//        
//        suitAdd = Int(((self.playerShape[playerCurrent][1]) * 64)/36)
//        if self.relativeHands[(playerCurrent+3)%4] & (hA+hK) > 0 { suitBonus += -18 }
//        LHO = self.playerShape[(playerCurrent+1)%4][1]
//        RHO = self.playerShape[(playerCurrent+3)%4][1]
//        
//    } else if card & diamonds > 0 {
//        
//        suitAdd = Int(((self.playerShape[playerCurrent][2]) * 64)/36)
//        if self.relativeHands[(playerCurrent+3)%4] & (dA+dK) > 0 { suitBonus += -18 }
//        LHO = self.playerShape[(playerCurrent+1)%4][1]
//        RHO = self.playerShape[(playerCurrent+3)%4][1]
//        
//    } else {
//        
//        suitAdd = Int(((self.playerShape[playerCurrent][3]) * 64)/36)
//        if self.relativeHands[(playerCurrent+3)%4] & (cA+cK) > 0 { suitBonus += -18 }
//        LHO = self.playerShape[(playerCurrent+1)%4][1]
//        RHO = self.playerShape[(playerCurrent+3)%4][1]
//        
//    }
//    
//    // TO-DO
//    // If the suit length is 2, and the hand-to-play has the next highest rank of the suit, the bonus is reduced by 2.
//    
//    
//    // 1. Ausspieler
//    
//    var suitWeightDelta:Int = suitBonus - Int(((LHO + RHO) * 32)/15)
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    // Spieler muss abwerfen -> möglichst kleine Karte
//    if self.trickSuit & card == 0 && card != trump { // Spieler muss abwerfen
//        
//        return -rankOfCard(card: card) + suitAdd
//    }
//        
//        // Spieler gibt zu
//    else if self.trickSuit & card > 0 && card != trump {
//        
//        
//        
//        if card < trickCurrent[cardTrickWinner] {
//            // man gibt zu und kann die Karte nicht schlagen, dann kleine Karte
//            
//            return -rankOfCard(card: card)
//            
//        }
//            
//        else {
//            // man gibt zu und kann die höchste Karte schlagen
//            
//            
//            // 4. Mann
//            if self.trickCurrent.count == 3 { return -rankOfCard(card: card) + 200 }
//                
//            else { return rankOfCard(card: card) }
//            
//            
//            
//        }
//    }
//    
//    return 0
//}
