//
//  ConstantsForTest.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 26.02.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

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

// Besonderheit: 1 Stich ist richtig (7830 Varianten 15.03.17)
// aber bei Hashing 1 & 2 liefert er nur 0 Stiche (Fehler)





