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

    var testHandsOn = false // Testmodus
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        cardNumberCounterLbl.text = String(NumberOfCardsPerHand)
        outputLbl.text = "HIER"
        
        fillTestHands()
        fillquickTricksTable()
        
        
    }

    @IBAction func Plus(_ sender: AnyObject) {
        
        NumberOfCardsPerHand += 1
        cardNumberCounterLbl.text = String(NumberOfCardsPerHand)
        
    }
    
    @IBAction func Minus(_ sender: AnyObject) {
        
        NumberOfCardsPerHand -= 1
        cardNumberCounterLbl.text = String(NumberOfCardsPerHand)
        
    }
    
    @IBAction func testMode(_ sender: AnyObject) {
        
        testHandsOn = !testHandsOn
        
        printBinary(number: [convertToRelativeRanking(hand: gameC.hands[0], cardRemoved: sK)])
        
        if testHandsOn {
            
            print("TESTMODE!")
            
        } else {
            
            print ("REALMODE!")
        }
        
        
        
    }
    
    
    @IBAction func dealButton(_ sender: AnyObject) {
        
                
        if testHandsOn {
            
            // Testmodus
        
            for hand in testHands {
                
//                printBinary(number: [hand.hands[0],hand.hands[1],hand.hands[2],hand.hands[3]])
                
                //Covert in kanonische Hände
                if convertHandsToRelativeHand {
                    
                    for card in allCards.reversed() {
                        
                        // Alle Karten, die bei der Verteilung nicht verteilt wurden, werden überprüft und dancah die relativen Hände bestimmt
                        if card & (hand.hands[0] | hand.hands[1] | hand.hands[2] | hand.hands[3]) == 0 {
                            
                            hand.hands[0] = convertToRelativeRanking(hand: hand.hands[0], cardRemoved: card)
                            hand.hands[1] = convertToRelativeRanking(hand: hand.hands[1], cardRemoved: card)
                            hand.hands[2] = convertToRelativeRanking(hand: hand.hands[2], cardRemoved: card)
                            hand.hands[3] = convertToRelativeRanking(hand: hand.hands[3], cardRemoved: card)
                            
                            
                        }
                        
                        
                    }
                    
                }
            
                //Hash-Table leeren, Hash Methode wird in Variable HashArt gesetzt
                //hashTable = [:]
                hashTableAlphaBeta = [:]
                
                playProgressLbl.text = "CALCULATE..."
                
                
                // Korrekte Shape-Struktur der Spieler ermitteln
                hand.playerShape =  fillPlayersShape(hands: hand.hands)
                
                // Hände anzeigen
                fillVisual(game: hand)
                
                let game = gameBoard(hands: hand.hands, tricksNS: hand.tricksWonByNorthSouth, tricksEW: hand.tricksWonByEastWest, trickCurrent: hand.trickCurrent, trump: hand.trump, leader: hand.trickLeader, trickSuit: hand.trickSuit, playerShape: hand.playerShape, cardsPlayed: hand.cardsPlayed, playerCurrent: hand.playerCurrent)
                    game.testNumberOfCards = hand.testNumberOfCards
                
                
                // Testparameter setzen
                NumberOfCardsPerHand = hand.testNumberOfCards
                game.tricksTest = hand.tricksTest
                game.nameTest = hand.nameTest
                
                
                
                hashTableBuildingGuide = 0
                
                let time1 = DispatchTime.now()
                let erg6 = miniMax(game: game, deep: 4*NumberOfCardsPerHand, alpha: 0, beta: 13, turnNS: false)
                let time2 = DispatchTime.now()
                let delta = (time2.uptimeNanoseconds - time1.uptimeNanoseconds)/1000000
                
                //hashTable = [:]
                
                outputLbl.text = "Max Stiche N/S:\(erg6)\n"+"Zweige:\(GLOBALCOUNTER_CALCULATE_LAST)"
                
                var testScoreCorrect = true
                
                if erg6 != game.tricksTest {testScoreCorrect = false }
                
                 print("\(VERSION): \(game.nameTest)(\(testScoreCorrect)) #N/S \(erg6) #TIME \(delta) #VAR \(GLOBALCOUNTER_CALCULATE_LAST) #MINMAX \(GLOBALCOUNTER_MINMAX) #HASH \(GLOBALCOUNTER_HASHTAG) #ALPHA \(GLOBALCOUNTER_ALPHA_CUTOFF) #BETA \(GLOBALCOUNTER_BETA_CUTOFF) #TRICKS \(game.testNumberOfCards) ")
                
            }
            
        } else {
            
            var game = gameBoard(hands: shuffleDeck(numberOfCardsPerHand: NumberOfCardsPerHand), tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)
            
            if quickTestPlayingMode == true {
                
               game = gameBoard(hands: shuffleDeck(numberOfCardsPerHand: NumberOfCardsPerHand), tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 1, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 1)
                
            }
            
//              print(handToStringVisualStyle(hand: game.hands[0]))
//              print(handToStringVisualStyle(hand: game.hands[1]))
//              print(handToStringVisualStyle(hand: game.hands[2]))
//              print(handToStringVisualStyle(hand: game.hands[3]))
            
            
           
            
            // Anzahl Karten im Gesamtspiel setzen
            game.testNumberOfCards = NumberOfCardsPerHand
            
            
            //Covert in kanonische Hände
            if convertHandsToRelativeHand {
                
                for card in allCards.reversed() {
                    
                    if card & (game.hands[0] | game.hands[1] | game.hands[2] | game.hands[3]) == 0 {
                        
                        //print(returnCardAsString(hand: card))
                        
                        game.hands[0] = convertToRelativeRanking(hand: game.hands[0], cardRemoved: card)
                        game.hands[1] = convertToRelativeRanking(hand: game.hands[1], cardRemoved: card)
                        game.hands[2] = convertToRelativeRanking(hand: game.hands[2], cardRemoved: card)
                        game.hands[3] = convertToRelativeRanking(hand: game.hands[3], cardRemoved: card)
                        
                        
                    }
                    
                    
                }
                
            }
        
            // Korrekte Shape-Struktur der Spieler ermitteln
            game.playerShape =  fillPlayersShape(hands: game.hands)
            
            //PRINT TEST
            print(game.quickTricksPlayer2(player: 0))
            
            // Anzeige
            fillVisual(game: game)
            
            //hashTable = [:]
            hashTableAlphaBeta = [:]
            hashTableBuildingGuide = 0
            
            let time1 = DispatchTime.now()
            
            let erg = miniMax(game: game, deep: 4*NumberOfCardsPerHand, alpha: -13, beta: 13, turnNS: (game.playerCurrent == 1 || game.playerCurrent == 3 ))
            
            let time2 = DispatchTime.now()
            let delta = (time2.uptimeNanoseconds - time1.uptimeNanoseconds)/1000000
            
            outputLbl.text = "Max Stiche N/S:\(erg)\n"+"Zweige:\(GLOBALCOUNTER_CALCULATE_LAST)"
            
            
            print("gameZ.nameTest = \"gameZ\"")
            print("gameZ.testNumberOfCards = \(game.testNumberOfCards)")
            print("gameZ.tricksTest = \(erg)")
            
            print("var gameZ = gameBoard(hands: [0b\(SingleBinary(number: game.hands[0])), 0b\(SingleBinary(number: game.hands[1])), 0b\(SingleBinary(number: game.hands[2])), 0b\(SingleBinary(number: game.hands[3]))], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)")
            
            print("\(VERSION): #N/S \(erg) #TIME \(delta) #VAR \(GLOBALCOUNTER_CALCULATE_LAST) #MINMAX \(GLOBALCOUNTER_MINMAX) #HASH \(GLOBALCOUNTER_HASHTAG) #ALPHA \(GLOBALCOUNTER_ALPHA_CUTOFF) #BETA \(GLOBALCOUNTER_BETA_CUTOFF) #TRICKS \(game.testNumberOfCards) ")
            

            
        }
        
        
    }
    
    func fillVisual(game: gameBoard) {
        
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
        
        // Hand ausdrucken
        
        if testHandsOn == false {
            
            
            printBinary(number: game.hands)
            
        }

        // Test-Counter zurücksetzen
        
        GLOBALCOUNTER_MINMAX = 0
        GLOBALCOUNTER_CALCULATE_LAST = 0
        GLOBALCOUNTER_ALPHA_CUTOFF = 0
        GLOBALCOUNTER_BETA_CUTOFF = 0
        GLOBALCOUNTER_HASHTAG = 0
        
    }
    
    
}

