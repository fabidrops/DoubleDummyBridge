//
//  ViewController.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 25.02.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import UIKit
// import Firebase


class ViewController: UIViewController {
    
    @IBOutlet weak var handNorth: UILabel!
    
    @IBOutlet weak var handWest: UILabel!
    
    @IBOutlet weak var handSouth: UILabel!
    
    @IBOutlet weak var handEast: UILabel!
    
    @IBOutlet weak var outputLbl: UILabel!
    
    @IBOutlet weak var trumpLbl: UILabel!
    
    @IBOutlet weak var cardNumberCounterLbl: UILabel!
    
    @IBOutlet weak var playProgressLbl: UILabel!
    
    var loopCounter = 0 // für Wiederholungen bei quickTricks

    var testHandsOn = false // Testmodus
    
        
    // var ref: DatabaseReference!
    


    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
            if quickTestPlayingMode {
            
//                //FIREBASE
//                
//                ref = Database.database().reference()
//                
//                Auth.auth().signIn(withEmail: "fvl@koeln.de", password: "fa17024") { (user, error) in
//                    // ...
//                }
//                
//                ref.child("OTHER").setValue(["Test1":2])
        

            }
        
        
        
        cardNumberCounterLbl.text = String(NumberOfCardsPerHand)
        outputLbl.text = "HIER"
        
        fillTestHands()
        
        
        // hashTableQuickTricksFüllen
        fillquickTricksTable()
        
        // hashTable für Konvertierung von Karten -> String , wird für quickTricks benötigt
        fillHashTableHandInTopString()
        
//        print("TESTTESTTEST")
//        print(hashTableCovertHandInTopString[0b1101000110100]!)
//        print(hashTableCovertHandInTopString[0b1110000000000]!)
//        print(hashTableCovertHandInTopString[0b0010000000000]!)

        
        
        // Tabelle laden
        //hashTableQuickTricks = NSKeyedUnarchiver.unarchiveObject(withFile: docsBaseURL.path) as! [String : Int]
        
        
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
        
        loopCounter = 0
        
        //printBinary(number: [convertToRelativeRanking(hand: gameC.hands[0], cardRemoved: sK)])
        
        if testHandsOn {
            
            print("TESTMODE!")
            
        } else {
            
            print ("REALMODE!")
        }
        
        
        
    }
    
    
    @IBAction func dealButton(_ sender: AnyObject) {
        
        
        
        
        
                
        if testHandsOn {
            
            //print(hashTableQuickTricks)
            
            

            
            // Testmodus
        
            for hand in testHands {
                
                //print(handToStringVisualStyle(hand: hand.hands[0]))
                // die relativeHands ableiten
                fillRealtiveHandsinInit(game: hand)
                
                
                
//                printBinary(number: [hand.hands[0],hand.hands[1],hand.hands[2],hand.hands[3]])
                
                //Covert in kanonische (relative) Hände
                if convertHandsToRelativeHand {
                    
                    convertGameBoardHandsToRelativeRanking(game: hand)
                    
                }
            
                //Hash-Table leeren, Hash Methode wird in Variable HashArt gesetzt
                //hashTable = [:]
                hashTableAlphaBeta = [:]
                
                playProgressLbl.text = "CALCULATE..."
                
                
                // Korrekte Shape-Struktur der Spieler ermitteln
                hand.playerShape =  fillPlayersShape(hands: hand.hands)
                
                // Hände anzeigen
                fillVisual(game: hand)
                
                let game = gameBoard(hands: hand.hands, relativeHands: [0,0,0,0], tricksNS: hand.tricksWonByNorthSouth, tricksEW: hand.tricksWonByEastWest, trickCurrent: hand.trickCurrent, trump: hand.trump, leader: hand.trickLeader, trickSuit: hand.trickSuit, playerShape: hand.playerShape, cardsPlayed: hand.cardsPlayed, playerCurrent: hand.playerCurrent)
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
            
            var game = gameBoard(hands: shuffleDeck(numberOfCardsPerHand: NumberOfCardsPerHand), relativeHands: [0,0,0,0], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)
            
            var gameInverted = gameBoard(hands: shuffleDeck(numberOfCardsPerHand: NumberOfCardsPerHand), relativeHands: [0,0,0,0], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)
            
            // die relativeHands ableiten
            game = fillRealtiveHandsinInit(game: game)
            gameInverted = fillRealtiveHandsinInit(game: gameInverted)
            
            
//            print(handToStringVisualStyle(hand: game.hands[0]))
//            print("RELATIVE")
//            print(handToStringVisualStyle(hand: game.relativeHands[0]))

            
            if quickTestPlayingMode == true {
                
               game = gameBoard(hands: shuffleDeck(numberOfCardsPerHand: NumberOfCardsPerHand), relativeHands: [0,0,0,0], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 1, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 1)
                
                
                
                
                
                // Austauschen der Mittelkarten
                
                for middleCard in [s9,s8,s7] {
                
                    if game.hands[1] & middleCard > 0 {
                        
                        for card in [s2,s3,s4,s5,s6] {
                            
                            if card & game.hands[0] > 0 {
                                
                                game.hands[0] -= card
                                game.hands[0] += middleCard
                                game.hands[1] += card
                                game.hands[1] -= middleCard
                                
                                break
                                
                                
                            } else if card & game.hands[2] > 0 {
                                
                                game.hands[2] -= card
                                game.hands[2] += middleCard
                                game.hands[1] += card
                                game.hands[1] -= middleCard

                                break
                                
                            }
                            
                            
                        }
                        
                        
                    } else if game.hands[3] & middleCard > 0 {
                        
                        for card in [s2,s3,s4,s5,s6] {
                            
                            if card & game.hands[0] > 0 {
                                
                                game.hands[0] -= card
                                game.hands[0] += middleCard
                                game.hands[3] += card
                                game.hands[3] -= middleCard

                                break
                                
                            } else if card & game.hands[2] > 0 {
                                
                                game.hands[2] -= card
                                game.hands[2] += middleCard
                                game.hands[3] += card
                                game.hands[3] -= middleCard
                                break
                                
                            }
                            
                            
                        }
                        
                        
                    }
                
                }
                
                
            }
            
            // quickTricks von der anderen Seite
            gameInverted = gameBoard(hands: game.hands, relativeHands: [0,0,0,0], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 3, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 3)
            
            // Korrekte Shape-Struktur der Spieler ermitteln
            game.playerShape =  fillPlayersShape(hands: game.hands)
            
            
            
            // Anzahl Karten im Gesamtspiel setzen
            game.testNumberOfCards = NumberOfCardsPerHand
            
            
            //Covert in kanonische Hände
            if convertHandsToRelativeHand {
                
                convertGameBoardHandsToRelativeRanking(game: game)
                                
            }
        
            var quickTrickOutput = ""
            quickTrickOutput += handToStringQuickTrickStyle(hand: game.hands[1])
            var playerStr = handToStringQuickTrickStyle(hand: game.hands[1])
            quickTrickOutput += "-"
            quickTrickOutput += handToStringQuickTrickStyle(hand: game.hands[3])
            var playerStr2 = handToStringQuickTrickStyle(hand: game.hands[3])
            quickTrickOutput += "-"
            // die Gegenerhände brauchen maximal so viele Karten wie Maxiumum der N/S Spieler für quickTricks
            let maxV:Int = max(game.playerShape[1][0],game.playerShape[3][0]) // max Pik Anzahl von Sp1 oder Sp3
            let stringShort1 = String(handToStringQuickTrickStyle(hand: game.hands[0]).characters.prefix(maxV))
            quickTrickOutput += stringShort1
            let stringShort2 = String(handToStringQuickTrickStyle(hand: game.hands[2]).characters.prefix(maxV))
            quickTrickOutput += "-"
            quickTrickOutput += stringShort2
            //print(quickTrickOutput)

            
            //PRINT TEST
            // print(game.quickTricksPlayer2(player: 0))
            
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
            hashTableQuickTricks[quickTrickOutput] = erg
            
//            print("gameZ.nameTest = \"gameZ\"")
//            print("gameZ.testNumberOfCards = \(game.testNumberOfCards)")
//            print("gameZ.tricksTest = \(erg)")
//            
//            print("var gameZ = gameBoard(hands: [0b\(SingleBinary(number: game.hands[0])), 0b\(SingleBinary(number: game.hands[1])), 0b\(SingleBinary(number: game.hands[2])), 0b\(SingleBinary(number: game.hands[3]))], tricksNS: 0, tricksEW: 0, trickCurrent: [], trump: 0, leader: 0, trickSuit: 0, playerShape: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], cardsPlayed: 0, playerCurrent: 0)")
            
            print("\(VERSION): #N/S \(erg) #TIME \(delta) #VAR \(GLOBALCOUNTER_CALCULATE_LAST) #MINMAX \(GLOBALCOUNTER_MINMAX) #HASH \(GLOBALCOUNTER_HASHTAG) #ALPHA \(GLOBALCOUNTER_ALPHA_CUTOFF) #BETA \(GLOBALCOUNTER_BETA_CUTOFF) #TRICKS \(game.testNumberOfCards) ")
            
//            ref.child("QUICKTRICKS").removeValue { (error, ref) in
//                if error != nil {
//                    print("error \(error)")
//                }
//            }
            
//            if quickTestPlayingMode && playerStr.hasPrefix("A") {
//                if erg == 3 {
//                 
//                ref.child("QUICKTRICK3").child(playerStr).child(playerStr2).child(stringShort1).child(stringShort2).setValue(["qT":erg])
//                }
//                
//                if erg == 4 {
//                    
//                    ref.child("QUICKTRICK4").child(playerStr).child(playerStr2).child(stringShort1).child(stringShort2).setValue(["qT":erg])
//                }
//                if erg == 5 {
//                    
//                    ref.child("QUICKTRICK5").child(playerStr).child(playerStr2).child(stringShort1).child(stringShort2).setValue(["qT":erg])
//                }
//                
//                if erg == 6 {
//                    
//                    ref.child("QUICKTRICK6").child(playerStr).child(playerStr2).child(stringShort1).child(stringShort2).setValue(["qT":erg])
//                }
//                
//                if erg >= 7 {
//                    
//                    ref.child("QUICKTRICK7+").child(playerStr).child(playerStr2).child(stringShort1).child(stringShort2).setValue(["qT":erg])
//                }
//                
//                
//                
//            }
            
        }
        
//        if loopCounter <= 1 {
//            
//            loopCounter += 1
//            
//            self.dealButton(self)
//            
//            
//        }
        
       
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
            
            
            // printBinary(number: game.hands)
            
        }

        // Test-Counter zurücksetzen
        
        GLOBALCOUNTER_MINMAX = 0
        GLOBALCOUNTER_CALCULATE_LAST = 0
        GLOBALCOUNTER_ALPHA_CUTOFF = 0
        GLOBALCOUNTER_BETA_CUTOFF = 0
        GLOBALCOUNTER_HASHTAG = 0
        
    }
    
    
}

