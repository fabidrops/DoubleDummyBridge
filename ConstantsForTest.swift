//
//  ConstantsForTest.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 26.02.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

let VERSION = "V0.15"

var GLOBALCOUNTER_CALCULATE_LAST = 0
var GLOBALCOUNTER_HASHTAG = 0
var GLOBALCOUNTER_MINMAX = 0
var GLOBALCOUNTER_BETA_CUTOFF = 0
var GLOBALCOUNTER_ALPHA_CUTOFF = 0

var NumberOfCardsPerHand = 5


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

let gameB = gameBoard(hands: [0b1000010001010000000001100000000000000010000000000,0b10000100000001000001010000000000000001000000000010,0b10000000100000000000000100000101000000011000000,0b10010100011000100000000000000000001], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)

// Besonderheit: 7 Karten, 5 Stiche ist richtig
// V 0.1 : #5 richtig, #V   4215, MinMax    301265, #Hash   86541, Zeit 8201 nSek, regulär Hash (0)
// V0.15: #N/S 5 #TIME 4545 #VAR 1739 #MINMAX 182242 #HASH 53500 #ALPHA 50842 #BETA 26275

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
