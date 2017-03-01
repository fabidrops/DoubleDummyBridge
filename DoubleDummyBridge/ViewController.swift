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
        
        playProgressLbl.text = "CALCULATE..."
        
        let game = gameBoard(hands: shuffleDeck(numberOfCardsPerHand: NumberOfCardsPerHand), tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)
    
        print(game.playerShape)
        game.playerShape =  fillPlayersShape(hands: game.hands)
        
        print (game.playerShape)
        
        // print("\(game.playerShape[0][0])-\(game.playerShape[0][1])-\(game.playerShape[0][2])-\(game.playerShape[0][3])")
        
    
        
        handNorth.text = handToStringVisualStyle(hand: game.hands[1])
        handSouth.text = handToStringVisualStyle(hand: game.hands[3])
        handWest.text = handToStringVisualStyle(hand: game.hands[0])
        handEast.text = handToStringVisualStyle(hand: game.hands[2])
        
        if game.trump == spades { trumpLbl.text = "SPADES" }
        if game.trump == hearts { trumpLbl.text = "HEARTS" }
        if game.trump == diamonds { trumpLbl.text = "DIAMONDS" }
        if game.trump == clubs { trumpLbl.text = "CLUBS" }
        if game.trump == 0 { trumpLbl.text = "SANS ATOUT" }
        
        
        //outputLbl.text = "Max Stiche N/S:\(mini(game: game, alpha:0, beta:numberOfCardsPerHand))\n"+"Zweige:\(GLOBALCOUNTER)"
        
        
        
        
        outputLbl.text = "Max Stiche N/S:\(mini(game: game, alpha:0, beta:NumberOfCardsPerHand))\n"+"Zweige:\(GLOBALCOUNTER_CALCULATE_LAST)"
        
        print("ALPHACUTOFF:\(GLOBALCOUNTER_ALPHA_CUTOFF)")
        print("BETACUTOFF:\(GLOBALCOUNTER_BETA_CUTOFF)")
         print("Varianten:\(GLOBALCOUNTER_CALCULATE_LAST)")
         print("MinMaxAufrufe:\(GLOBALCOUNTER_MINMAX)")

        GLOBALCOUNTER_MINMAX = 0
        GLOBALCOUNTER_CALCULATE_LAST = 0
        GLOBALCOUNTER_ALPHA_CUTOFF = 0
        GLOBALCOUNTER_BETA_CUTOFF = 0
        
        
        //createHashTable
    }

}

