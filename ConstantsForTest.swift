//
//  ConstantsForTest.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 26.02.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

let VERSION = "V0.25"

//V0.20: game0(true) #N/S 1 #TIME 30290 #VAR 7971 #MINMAX 1099099 #HASH 392887 #ALPHA 187797 #BETA 210881
//V0.20: gameA(true) #N/S 1 #TIME 2544 #VAR 2045 #MINMAX 93881 #HASH 22951 #ALPHA 8170 #BETA 31758
//V0.20: gameB(true) #N/S 5 #TIME 7188 #VAR 3346 #MINMAX 257105 #HASH 73061 #ALPHA 70710 #BETA 36144
//V0.20: gameC(true) #N/S 3 #TIME 199219 #VAR 22877 #MINMAX 6861334 #HASH 1930233 #ALPHA 365340 #BETA 2617809
//V0.20: gameD(true) #N/S 5 #TIME 3734 #VAR 1875 #MINMAX 133806 #HASH 40609 #ALPHA 36467 #BETA 15504
//V0.20: gameE(true) #N/S 5 #TIME 221036 #VAR 32823 #MINMAX 7792312 #HASH 2791137 #ALPHA 2193328 #BETA 837412

//V0.21: game0(true) #N/S 1 #TIME 29540 #VAR 7748 #MINMAX 1084961 #HASH 385265 #ALPHA 184342 #BETA 208791
//V0.21: gameA(true) #N/S 1 #TIME 2589 #VAR 2045 #MINMAX 93881 #HASH 22951 #ALPHA 8170 #BETA 31758
//V0.21: gameB(true) #N/S 5 #TIME 6482 #VAR 2971 #MINMAX 235924 #HASH 64725 #ALPHA 64676 #BETA 33167
//V0.21: gameC(true) #N/S 3 #TIME 209361 #VAR 22875 #MINMAX 6861289 #HASH 1930190 #ALPHA 365300 #BETA 2617837
//V0.21: gameD(true) #N/S 5 #TIME 4778 #VAR 1423 #MINMAX 113350 #HASH 34116 #ALPHA 29211 #BETA 13883
//V0.21: gameE(true) #N/S 5 #TIME 222666 #VAR 26291 #MINMAX 5932910 #HASH 2022100 #ALPHA 1530123 #BETA 729710

//V0.21a: game0(true) #N/S 1 #TIME 29681 #VAR 7346 #MINMAX 1082860 #HASH 374833 #ALPHA 171121 #BETA 214998
//V0.21a: gameA(true) #N/S 1 #TIME 2610 #VAR 2018 #MINMAX 93737 #HASH 22821 #ALPHA 8014 #BETA 31794
//V0.21a: gameB(true) #N/S 5 #TIME 5758 #VAR 2609 #MINMAX 207559 #HASH 54098 #ALPHA 50427 #BETA 33140
//V0.21a: gameC(true) #N/S 3 #TIME 195263 #VAR 22660 #MINMAX 6857385 #HASH 1926968 #ALPHA 362395 #BETA 2618431
//V0.21a: gameD(true) #N/S 5 #TIME 2459 #VAR 1164 #MINMAX 90110 #HASH 28268 #ALPHA 17150 #BETA 14558
//V0.21a: gameE(true) #N/S 5 #TIME 145462 #VAR 22320 #MINMAX 5088864 #HASH 1713621 #ALPHA 1112405 #BETA 743807

//V0.25: game0(true) #N/S 1 #TIME 27396 #VAR 5982 #MINMAX 1001470 #HASH 354033 #ALPHA 147478 #BETA 214998
//V0.25: gameA(true) #N/S 1 #TIME 2551 #VAR 1768 #MINMAX 92277 #HASH 22637 #ALPHA 7536 #BETA 31794
//V0.25: gameB(true) #N/S 5 #TIME 4837 #VAR 1639 #MINMAX 176315 #HASH 47086 #ALPHA 41235 #BETA 33140
//V0.25: gameC(true) #N/S 3 #TIME 197602 #VAR 21637 #MINMAX 6848601 #HASH 1926299 #ALPHA 359724 #BETA 2618431
//V0.25: gameD(true) #N/S 5 #TIME 2300 #VAR 871 #MINMAX 82971 #HASH 26965 #ALPHA 14927 #BETA 14558
//V0.25: gameE(true) #N/S 5 #TIME 127579 #VAR 16022 #MINMAX 4416971 #HASH 1534542 #ALPHA 928978 #BETA 743807

var GLOBALCOUNTER_CALCULATE_LAST = 0
var GLOBALCOUNTER_HASHTAG = 0
var GLOBALCOUNTER_MINMAX = 0
var GLOBALCOUNTER_BETA_CUTOFF = 0
var GLOBALCOUNTER_ALPHA_CUTOFF = 0

var NumberOfCardsPerHand = 5

var testHands = [game0,gameA,gameB,gameC,gameD,gameE]
//var testHands = [game0]

func fillTestHands() {
    
    // To DO: In Fill Funktion
    game0.nameTest = "game0"
    game0.testNumberOfCards = 8
    game0.tricksTest = 1
    
    
    gameA.nameTest = "gameA"
    gameA.testNumberOfCards = 7
    gameA.tricksTest = 1
    
    gameB.nameTest = "gameB"
    gameB.testNumberOfCards = 7
    gameB.tricksTest = 5
    
    gameC.nameTest = "gameC"
    gameC.testNumberOfCards = 10
    gameC.tricksTest = 3
    
    gameD.nameTest = "gameD"
    gameD.testNumberOfCards = 7
    gameD.tricksTest = 5
    
    gameE.nameTest = "gameE"
    gameE.testNumberOfCards = 9
    gameE.tricksTest = 5
    
    
}





// Testhand 0

let game0 = gameBoard(hands: [0b10000001000001000000000001001000000010011, 0b100010010001000000010000000010100000010000000000000, 0b10111001001010000000100000000, 0b10000100000000100000000000000000100000011001000100], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)


// Testhand A

let hand1:UInt64 = s5+hA+hK+hT+h9+d4+c7
let hand2:UInt64 = sJ+s8+h7+h6+d6+cT+c8
let hand3:UInt64 = sA+s9+s3+d8+d7+cA+c6
let hand4:UInt64 = sQ+s7+hQ+h4+dQ+d5+d3

let gameA = gameBoard(hands: [hand1,hand2,hand3,hand4], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)

// Besonderheit: 7 Karten, 1 Stich ist richtig (7830 Varianten 15.03.17)
// aber bei Hashing 1 & 2 liefert er nur 0 Stiche (Fehler)
// V 0.1 : #1 richtig, #V   1758, MinMax    83577, #Hash 19827, Zeit 2399 nSek, regulär Hash    alpha   beta
// V0.15: #N/S 1 #TIME 1549 #VAR 946 #MINMAX 61944 #HASH 15916 #ALPHA 4581 #BETA 21520
// V0.20: #N/S 1 #TIME 1948 #VAR 1213 #MINMAX 76486 #HASH 20742 #ALPHA 6751 #BETA 25020 

let gameB = gameBoard(hands: [0b1000010001010000000001100000000000000010000000000,0b10000100000001000001010000000000000001000000000010,0b10000000100000000000000100000101000000011000000,0b10010100011000100000000000000000001], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)

// Besonderheit: 7 Karten, 5 Stiche ist richtig
// V 0.1 : #5 richtig, #V   4215, MinMax    301265, #Hash   86541, Zeit 8201 nSek, regulär Hash (0)
// V0.15: #N/S 5 #TIME 4545 #VAR 1739 #MINMAX 182242 #HASH 53500 #ALPHA 50842 #BETA 26275
// V0.20: #N/S 5 #TIME 5897 #VAR 1833 #MINMAX 227777 #HASH 69116 #ALPHA 63171 #BETA 30727

let gameC = gameBoard(hands: [0b101000000100000001010001001000000000000010000110000,0b1000001100000000100100010000100100000000100000000100,0b10000001001000000000010011000000101001000000010,0b10100000000110000000000000000011110000000100001000], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)

// Besonderheit: 10 Stiche Hände, 3 Stiche
// 23.03. korrekt 3 Stiche 28243 Varianten
// V 0.1 : #3 richtig, #V 20018, MinMax 6363001, #Hash 1749519, Zeit 177285 nSek, regular Hash AlphaCut BetaCut
// V 0.1 :             #V 8356                          700856        71702                1
// V0.15: #N/S 3 #TIME 86793 #VAR 6547 #MINMAX 3227435 #HASH 935556 #ALPHA 149142 #BETA 1256259

// Testhand D

let hand1d:UInt64 = sJ+hA+h6+h5+h3+h2+c4
let hand2d:UInt64 = sA+sQ+s9+s8+s3+c9+c2
let hand3d:UInt64 = sK+s7+hT+h9+dJ+cT+c7
let hand4d:UInt64 = sT+s5+hJ+dQ+d9+cA+cQ

let gameD = gameBoard(hands: [hand1d,hand2d,hand3d,hand4d], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)

// Besonderheit: 7 Karten, 5 Stich ist richtig
// aber bei Hashing 98 liefert er nur 6 Stiche (Fehler)
// V 0.1 : #5 richtig, #V 2213, MinMax 166369, #Hash 50946, Zeit 4218 nSek, regulär Hash
// V 0.1x: #5 richtig, #V 901, MinMax 115793, #Hash 37634, Zeit 3093 nSek, Hash 99
// V0.15: #N/S 5 #TIME 5997 #VAR 1483 #MINMAX 240869 #HASH 78773 #ALPHA 64858 #BETA 30349 

// 11 Stiche
// ["10000001000000010010011100000000101000000001010000", "1100000001000100001100000000001010010100000000100", "100000100110010000000000000100000000101001100000001", "1000011000000001000100000010000100000000010010100010"]
// V0.15: #N/S 7 #TIME 1489613 #VAR 25606 #MINMAX 58057157 #HASH 19377049 #ALPHA 10937931 #BETA 13020632


let gameE = gameBoard(hands: [0b10001010000000000001001000000000010001001000100000,0b1000000000000110010010000010000010001010, 0b100010000000010000000000100001000010100010001,0b1001000000000010000100010001000001000100000000000100], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)

    
// FEHLER: 9 Stiche
//
// V0.15: #N/S 6 #TIME 231789 #VAR 15994 #MINMAX 9122168 #HASH 3433677 #ALPHA 2471282 #BETA 1028136
