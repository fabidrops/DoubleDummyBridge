//
//  ViewController.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 25.02.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var handNorth: UILabel!
    
    @IBOutlet weak var handWest: UILabel!
    
    @IBOutlet weak var handSouth: UILabel!
    
    @IBOutlet weak var handEast: UILabel!
    
    @IBOutlet weak var outputLbl: UILabel!
    
    @IBOutlet weak var trumpLbl: UILabel!
    
    @IBOutlet weak var cardNumberCounterLbl: UILabel!
    
    @IBOutlet weak var playProgressLbl: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Projektstart 25.02.2017
        cardNumberCounterLbl.text = String(NumberOfCardsPerHand)
        outputLbl.text = "HIER"
        
        
    }

    @IBAction func Plus(_ sender: AnyObject) {
        
        NumberOfCardsPerHand += 1
        cardNumberCounterLbl.text = String(NumberOfCardsPerHand)
        
    }
    
    
    @IBAction func Minus(_ sender: AnyObject) {
        
        NumberOfCardsPerHand -= 1
        cardNumberCounterLbl.text = String(NumberOfCardsPerHand)
        
    }
    
    @IBAction func dealButton(_ sender: AnyObject) {
        
        //Hash-Table leeren
        hashTable = [:]
        
        playProgressLbl.text = "CALCULATE..."
        
        //let game = gameBoard(hands: shuffleDeck(numberOfCardsPerHand: NumberOfCardsPerHand), tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)
        
        let hand1:UInt64 = hJ+hT+dJ+d4+d3+cK+cT+c9+c5+c2
        let hand2:UInt64 = sK+sJ+s2+h9+h6+d8+d7+cQ+cJ+c4
        let hand3:UInt64 = sA+sQ+s7+h3+h2+dA+d6+d5+d2+c7
        let hand4:UInt64 = sT+s8+hA+hK+hQ+h5+dT+c8+c6+c3
        
        
        let game = gameBoard(hands: [hand1,hand2,hand3,hand4], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)
        
//        let game7 = gameBoard(hands: [0b101000000100000001010001001000000000000010000110000,0b1000001100000000100100010000100100000000100000000100,0b10000001001000000000010011000000101001000000010,0b10100000000110000000000000000011110000000100001000], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)
//        
//        let game3 = gameBoard(hands: [0b1000010001010000000001100000000000000010000000000,0b10000100000001000001010000000000000001000000000010,0b10000000100000000000000100000101000000011000000,0b10010100011000100000000000000000001], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)
        
        //10 Stiche fehlerhand kommt n/2 2 raus obwohl es 3 sein müssten 42166, mit sort 47000+
        //let game = gameBoard(hands: [0b101000000100000001010001001000000000000010000110000,0b1000001100000000100100010000100100000000100000000100,0b10000001001000000000010011000000101001000000010,0b10100000000110000000000000000011110000000100001000], tricksNS: 0, tricksEW: 0, actualTrick: [], leader: 0,actualTrickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]],cardsPlayedInOrder: [])
        
        //7 stiche hand 7093 varianten // 5303 //2287//1305 = 5 Sti
        //let game = gameBoard(hands: [0b1000010001010000000001100000000000000010000000000,0b10000100000001000001010000000000000001000000000010,0b10000000100000000000000100000101000000011000000,0b10010100011000100000000000000000001], tricksNS: 0, tricksEW: 0, actualTrick: [], leader: 0,actualTrickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]],cardsPlayedInOrder: [])
    
        // Korrekte Shape-Struktur der Spieler ermitteln
        game.playerShape =  fillPlayersShape(hands: game.hands)
        
        print (game.playerShape)
        
    
        
        // Hände anzeigen
        handNorth.text = handToStringVisualStyle(hand: game.hands[1])
        handSouth.text = handToStringVisualStyle(hand: game.hands[3])
        handWest.text = handToStringVisualStyle(hand: game.hands[0])
        handEast.text = handToStringVisualStyle(hand: game.hands[2])
        
        if game.trump == spades { trumpLbl.text = "SPADES" }
        if game.trump == hearts { trumpLbl.text = "HEARTS" }
        if game.trump == diamonds { trumpLbl.text = "DIAMONDS" }
        if game.trump == clubs { trumpLbl.text = "CLUBS" }
        if game.trump == 0 { trumpLbl.text = "SANS ATOUT" }
        
        
        // Eigentliche Berechnung anstoßen
        outputLbl.text = "Max Stiche N/S:\(mini(game: game, alpha:0, beta:NumberOfCardsPerHand))\n"+"Zweige:\(GLOBALCOUNTER_CALCULATE_LAST)"
        
        print("ALPHACUTOFF:\(GLOBALCOUNTER_ALPHA_CUTOFF)")
        print("BETACUTOFF:\(GLOBALCOUNTER_BETA_CUTOFF)")
        print("Varianten:\(GLOBALCOUNTER_CALCULATE_LAST)")
        print("MinMaxAufrufe:\(GLOBALCOUNTER_MINMAX)")
        print("HashTableFindings:\(GLOBALCOUNTER_HASHTAG)")

        GLOBALCOUNTER_MINMAX = 0
        GLOBALCOUNTER_CALCULATE_LAST = 0
        GLOBALCOUNTER_ALPHA_CUTOFF = 0
        GLOBALCOUNTER_BETA_CUTOFF = 0
        GLOBALCOUNTER_HASHTAG = 0
        
        //createHashTable
    }

}

