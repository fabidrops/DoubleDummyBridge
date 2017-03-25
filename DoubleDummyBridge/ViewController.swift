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
        
        
        
        //fillHashTableTrickWinnerNoTrump()
        
        
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
        //hashTable = [:]
        hashTableAlphaBeta = [:]
        
        // Hash Art wird in Constants gesetzt !
        
        playProgressLbl.text = "CALCULATE..."
        
        let game76 = gameC
        
        let game = gameBoard(hands: shuffleDeck(numberOfCardsPerHand: NumberOfCardsPerHand), tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)
        
   
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
        
        
        var game6 = game
        printBinary(number: game.hands)

        
        hashTableBuildingGuide = 99
        
        var time1 = DispatchTime.now()
        let erg6 = miniMax(game: game6, deep: 4*NumberOfCardsPerHand, alpha: -13, beta: 13, turnNS: false)
        var time2 = DispatchTime.now()
        var delta = (time2.uptimeNanoseconds - time1.uptimeNanoseconds)/1000000
        
        hashTable = [:]
        
        outputLbl.text = "Max Stiche N/S:\(erg6)\n"+"Zweige:\(GLOBALCOUNTER_CALCULATE_LAST)"
        
        
         print("\(VERSION): #N/S \(erg6) #TIME \(delta) #VAR \(GLOBALCOUNTER_CALCULATE_LAST) #MINMAX \(GLOBALCOUNTER_MINMAX) #HASH \(GLOBALCOUNTER_HASHTAG) #ALPHA \(GLOBALCOUNTER_ALPHA_CUTOFF) #BETA \(GLOBALCOUNTER_BETA_CUTOFF)  ")
        
        
        GLOBALCOUNTER_MINMAX = 0
        GLOBALCOUNTER_CALCULATE_LAST = 0
        GLOBALCOUNTER_ALPHA_CUTOFF = 0
        GLOBALCOUNTER_BETA_CUTOFF = 0
        GLOBALCOUNTER_HASHTAG = 0
        
        //createHashTable
    }

}

