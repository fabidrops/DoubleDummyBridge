//
//  quickTrickTable.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 28.05.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

// quickTrickTable
var qTT = [String:Int]()    //manuell
var qTT1 = [String:Int]()    //manuell für längenabhängige qT (Zahl = maxumale Kartenanzahl der Gegner)
var qTT2 = [String:Int]()    //manuell für längenabhängige qT
var qTT3 = [String:Int]()    //manuell für längenabhängige qT
var qTT4 = [String:Int]()    //manuell für längenabhängige qT

//TEST
var qTT5 = [String:[Int]]()

var hashTableQuickTricks = [String:Int]() // aus Datei


func fillquickTricksTable () {

    qTT["AKQJ10xxx"] = 8
    qTT["AKQJ10xx"] = 7
    qTT["AKQJ10x"] = 6
    qTT["AKQJ10"] = 5
    qTT["AKQJ"] = 4
    qTT["AKQ"] = 3
    qTT["AK"] = 2
    qTT["A"] = 1
    
    // 2 Stiche Kombinationen
    qTT["Ax-Kx"] = 2
    qTT["Ax-KQ"] = 2
    qTT["Ax-KJ"] = 2
    qTT["Ax-KT"] = 2
    qTT["AQ-Kx"] = 2
    qTT["AQ-KJ"] = 2
    qTT["AQ-KT"] = 2
    qTT["AJ-Kx"] = 2
    qTT["AJ-KT"] = 2
    qTT["AJ-KQ"] = 2
    qTT["AT-Kx"] = 2
    qTT["AT-KJ"] = 2
    qTT["AT-KQ"] = 2
    qTT["AQ-K"] = 2
    
    
    

    // Ax Kombinationen
    qTT["Ax-KQx"] = 3
    qTT["Ax-KQT"] = 3
    qTT["Ax-KQJ"] = 3
    qTT["Ax-KQJx"] = 4
    qTT["Ax-KQJT"] = 4
    qTT["Ax-KQJTx"] = 5

    
    qTT["Axx-KQx"] = 3
    qTT["Axx-KQT"] = 3
    qTT["Axx-KQJ"] = 3
    qTT["Axx-KQJx"] = 4
    qTT["Axx-KQJT"] = 4
    qTT["Axx-KQJTx"] = 5
    
    qTT["Axxx-KQJx"] = 4
    qTT["Axxx-KQJT"] = 4
    qTT["Axxx-KQJTx"] = 5
    qTT["Axxxx-KQJTx"] = 5
    qTT["Axxxx-KJTxx"] = 5
    qTT["Axxxx-KQTxx"] = 5
    qTT["Axxxx-KQxxx"] = 5


    // AT Kombinationen
    qTT["AT-KQx"] = 3
    qTT["AT-KQJ"] = 3
    qTT["AT-KQJx"] = 4
    
    
    qTT["ATx-KQx"] = 3
    qTT["ATx-KQx"] = 3
    qTT["ATx-KQJ"] = 3
    qTT["ATx-KQJx"] = 4
    qTT["ATx-KQJx"] = 4
    qTT["ATx-KQJxx"] = 5
    
    qTT["ATxx-KQJx"] = 4
    qTT["ATxx-KQJx"] = 4
    qTT["ATxx-KQJxx"] = 5
    qTT["ATxxx-KQJxx"] = 5

    
    // AJ Kombinationen
    qTT["AJ-KQx"] = 3
    qTT["AJ-KQT"] = 3
    qTT["AJ-KQTx"] = 4
    
    
    qTT["AJx-KQx"] = 3
    qTT["AJx-KQT"] = 3
    qTT["AJx-KQTx"] = 4
    qTT["AJx-KQTx"] = 4
    qTT["AJx-KQTxx"] = 5
    
    qTT["AJxx-KQTx"] = 4
    qTT["AJxx-KQTx"] = 4
    qTT["AJxx-KQTxx"] = 5


    
    qTT["AQx-KT"] = 3
    qTT["AQx-Kx"] = 3
    qTT["AQx-KJ"] = 3

    qTT["AQx-KTx"] = 3
    qTT["AQx-Kxx"] = 3
    qTT["AQx-KJx"] = 3
    qTT["AQx-KJT"] = 3

    qTT["AQJ-KTx"] = 3
    qTT["AQJ-Kxx"] = 3
    qTT["AQJ-KTx"] = 3


    qTT["AKJ-QT"] = 3
    qTT["AKJ-Qx"] = 3

    qTT["AKx-QT"] = 3
    qTT["AKx-Qx"] = 3
    qTT["AKx-QJ"] = 3

    qTT["AKx-QTx"] = 3
    qTT["AKx-Qxx"] = 3
    qTT["AKx-QJx"] = 3

    qTT["AJx-KTx"] = 3
    qTT["ATx-KJx"] = 3
    qTT["AJT-Kxx"] = 3
    qTT["Axx-KJT"] = 3
    qTT["AJxx-KTxx"] = 3
    qTT["ATxx-KJxx"] = 3 //

    qTT["AKJx-QTxx"] = 4
    qTT["AKJx-Qxxx"] = 4
    qTT["AKJT-Qxxx"] = 4
    qTT["AKxx-QJxx"] = 4
    qTT["AKxx-QJx"] = 4
    qTT["AKTx-QJxx"] = 4
    qTT["AKx-QJxx"] = 4
    qTT["AKT-QJxx"] = 4
    qTT["AKJ-QTxx"] = 4

    qTT["AQJT-K"] = 4
    qTT["AKJT-Q"] = 4
    qTT["AKQT-J"] = 4
    qTT["AQJT-Kx"] = 4
    qTT["AKJT-Qx"] = 4
    qTT["AKQT-Jx"] = 4
    qTT["AQJT-Kxx"] = 4
    qTT["AKJT-Qxx"] = 4
    qTT["AKQT-Jxx"] = 4
    qTT["AKQx-Jxx"] = 4
    qTT["AQTx-KJ"] = 4
    qTT["AJTx-KQ"] = 4

    qTT["AJx-KQTxx"] = 5
    qTT["ATx-KQJxx"] = 5
    
    qTT["AJx-KQTxxx"] = 6
    qTT["ATx-KQJxxx"] = 6

    qTT["AQJxx-KTx"] = 5
    qTT["AQTxx-KJx"] = 5
    
    qTT["AKJTxx-Qx"] = 6
    qTT["AKJTxx-Qxx"] = 6
    qTT["AKJTxx-Qxxx"] = 6
    qTT["AKJTxx-Qxxxx"] = 6
    
    qTT["AKJTxxx-Qx"] = 7
    qTT["AKJTxxx-Qxx"] = 7
    qTT["AKJTxxx-Qxxx"] = 7
    qTT["AKJTxxx-Qxxxx"] = 7
    
    qTT["AKQTxx-Jx"] = 6
    qTT["AKQTxx-Jxx"] = 6
    qTT["AKQTxx-Jxxx"] = 6
    qTT["AKQTxx-Jxxxx"] = 6
    
    qTT["AKQTxxx-Jx"] = 7
    qTT["AKQTxxx-Jxx"] = 7
    qTT["AKQTxxx-Jxxx"] = 7
    qTT["AKQTxxx-Jxxxx"] = 7
    
    qTT["AKQTx-Jx"] = 5
    qTT["AKQTx-Jxx"] = 5
    qTT["AKQTx-Jxxx"] = 5
    qTT["AKQTx-Jxxxx"] = 5
    
    qTT["AKQT-Jx"] = 4
    qTT["AKQT-Jxx"] = 4
    qTT["AKQT-Jxxx"] = 4
    qTT["AKQT-Jxxxx"] = 5

    qTT["AKJTx-Qx"] = 5
    qTT["AKJTx-Qxx"] = 5
    qTT["AKJTx-Qxxx"] = 5
    qTT["AKJTx-Qxxxx"] = 5

    qTT["AKQx-JTx"] = 4
    qTT["AKQx-Jx"] = 4
    qTT["AKQxx-JTx"] = 5
    
    qTT["AKJx-QTxxx"] = 5
    qTT["AKJx-QTxxxx"] = 6


 // Gegner hat weniger als eine Karte
    qTT1["Axxxxxxx"] = 8
    qTT1["AKxxxxxx"] = 8
    qTT1["AQxxxxxx"] = 8
    qTT1["AKQxxxxx"] = 8

    qTT1["Axxxxxx"] = 7
    qTT1["AKxxxxx"] = 7
    qTT1["AQxxxxx"] = 7
    qTT1["AKQxxxx"] = 7
    
    qTT1["Axxxxx"] = 6
    qTT1["AKxxxx"] = 6
    qTT1["AQxxxx"] = 6
    qTT1["AKQxxx"] = 6
    
    qTT1["Axxxx"] = 5
    qTT1["AKxxx"] = 5
    qTT1["AQxxx"] = 5
    qTT1["AKQxx"] = 5
    
    qTT1["Axxx"] = 4
    qTT1["AKxx"] = 4
    qTT1["AQxx"] = 4
    qTT1["AKQx"] = 4
    
    qTT1["Axx"] = 3
    qTT1["AKx"] = 3
    qTT1["AQx"] = 3
    qTT1["AKQ"] = 3

    qTT1["Ax"] = 2
    qTT1["AK"] = 2
    qTT1["AQ"] = 2
    
    qTT1["A"] = 1
    
    // Gegner hat weniger als zwei Karten
    qTT2["AKxxxxxx"] = 8
    qTT2["AKQxxxxx"] = 8
    
    qTT2["AKxxxxx"] = 7
    qTT2["AKQxxxx"] = 7

    qTT2["AKxxxx"] = 6
    qTT2["AKQxxx"] = 6
    
    qTT2["AKxxx"] = 5
    qTT2["AKQxx"] = 5

    qTT2["AKxx"] = 4
    qTT2["AKQx"] = 4
    
    qTT2["AKx"] = 3
    qTT2["AKQ"] = 3
    
    qTT2["AK"] = 2
    
    qTT2["AQxxxxxx-Kx"] = 8
    qTT2["AQxxxxxx-Kxx"] = 8
    qTT2["Axxxxxxx-Kx"] = 8
    
    qTT2["AQxxxxx-Kx"] = 7
    qTT2["AQxxxxx-Kxx"] = 7
    qTT2["Axxxxxx-Kx"] = 7
    
    qTT2["AQxxxx-Kx"] = 6
    qTT2["AQxxxx-Kxx"] = 6
    qTT2["Axxxxx-Kx"] = 6

    qTT2["AQxxx-Kx"] = 5
    qTT2["AQxxx-Kxx"] = 5
    qTT2["Axxxx-Kx"] = 5
    qTT2["Axxxx-KQ"] = 5
    qTT2["Axxxx-KQx"] = 5
    qTT2["Axxxx-Kxxxx"] = 5

    
    qTT2["AQxx-Kx"] = 4
    qTT2["AQxx-Kxx"] = 4
    qTT2["Axxx-Kx"] = 4
    qTT2["Axxx-KQ"] = 4
    
    qTT2["AQx-Kx"] = 3
    qTT2["AQx-Kxx"] = 3
    qTT2["Axx-Kx"] = 3
    qTT2["Axx-KQ"] = 3
    
    
}




func calQuickTricks(topCards: UInt8, a: Int, b:Int, oppMax:Int) -> Int {
    
    switch topCards {
        
    case 0b11110000: // AKQJ zu -
        
        if oppMax <= 4 { return a } else { return 4 }
        
    case 0b11100001: // AKQ zu J
        
        if a == 3 { return 3 }
        else {
            
            if b == 1 {
                
                if oppMax <= 3 { return a } else { return 3 }
                
            } else {
                
                if oppMax <= 4 { return max(a,b) } else { return 4 }
                
            }
            
        }
        
    case 0b11100000: // AKQ zu -
        
        if b <= 3 && oppMax <= 3 { return a } else { return 3 }
        
    case 0b11010010: // AKJ zu Q
        
        if b == 1 {
            
            
            if oppMax <= 3 { return a } else { return 3 }
            
        } else if b <= a && oppMax <= 4 { return a }
        
        else if b < a && oppMax > 4 { return 4 }
        
        else if b > a && oppMax <= 3 { return b }
        
        else { return 3 }
        
    case 0b10110100: // AQJ zu K
        
        if b == 1 {
            
            if oppMax <= 3 { return a } else { return 3 }
            
        }
        
        else if b <= a && oppMax <= 4 { return a }
            
        else if b < a && oppMax > 4 { return 4 }
            
        else if b > a && oppMax <= 3 { return b }
            
        else { return 3 }
        
    case 0b10110000: // AQJ zu -
        
        if oppMax <= 1 { return a }
            
        else { return 1 }


        
    case 0b11010000,0b11000000: // AKJ zu - // AK zu -
        
        if oppMax <= 2 && b <= a { return a }
            
        else if oppMax <= 2 && b > a { return min(a,b) }
        
        else { return 2 }
        
    
    case 0b11000010: // AK zu Q
        
        if a == 2 { return 2 }
        
        else if b == 1 && oppMax <= 2 { return a }
        
        else if b == 1 && oppMax > 2 { return 2 }
        
        else if oppMax <= 3 { return max(a,b) }
        
        else { return 3 }
        
    case 0b11000011: // AK zu QJ
        
        if a == 2 { return 2 }
            
        else if b == 2 && oppMax <= 3 { return a }
            
        else if b == 2 && oppMax > 2 { return 3 }
            
        else if oppMax <= 4 { return max(a,b) }
            
        else if a == 3 && b == 3 { return 3 }
        
        else { return 4 }
            
    case 0b11000001: // AK zu J
        
        if a == 2 { return 2 }
            
        else if b <= 2 && oppMax <= 2 { return a }
            
        else if b <= 2 && oppMax > 2 { return 2 }
            
        else if a == 3 && oppMax <= 2 { return b }
            
        else { return 2 }
      
        
    case 0b10100100: // AQ zu K
        
        if a == 2 && b <= 2 { return 2 } // AQ - K , AQ - K?
            
        else if a == 2 && oppMax <= 2 { return b }
            
        else if a == 2 && oppMax > 2 { return 2 }
            
        else if a >= 3 && b == 1 && oppMax <= 2 { return a }
            
        else if a >= 3 && b >= 2 && oppMax <= 3 { return a }
            
        else if a == 3 && b == 2 { return 3 } // AQx - Kx
            
        else if a == 3 && b >= 2 && oppMax <= 3 { return b }
            
        else { return 3 }
        
    case 0b10100101: // AQ zu KJ
        
        if a == 2 && b == 2 { return 2 } // AQ - KJ
            
        else if a == 2 && oppMax <= 3 { return b }
            
        else if a == 2 && oppMax > 3 { return 3 }
            
        else if a == 3 && b == 2 { return 3 } // AQx - KJ
            
        else if a >= 3 && b == 2 && oppMax <= 3 { return a } // AQxxxx - KJ
            
        else if a == 3 && b >= 3 && oppMax <= 4 { return b } // AQx - KJxxx
        
        else if a >= 4 && b >= 4 { return max (a,b) }
            
        else { return 3 }
        
    case 0b10100001: // AQ zu J
        
        if oppMax <= 1 && b <= 2 { return a }
        
        else { return 1 }
        
    case 0b10010010: // AJ zu Q
        
        if oppMax <= 1 && b <= 2 { return a } // AJxxx - Q(x)
            
        else if a == 2 && oppMax <= 1 && b > 1 { return b }
        
        else if oppMax <= 1 { return min (a,b) }
            
        else { return 1 }

        
    case 0b10100000: // AQ zu -
        
        if oppMax <= 1 && b <= 2 { return a }
        
        else { return 1 }
        
    case 0b10010110: // AJ zu KQ
        
        if a == 2 && b == 2 { return 2 } // AJ - KQ
            
        else if a == 2 && oppMax <= 3 { return b }
            
        else if a == 2 && oppMax > 3 { return 3 }
            
        else if a == 3 && b == 2 { return 3 } // AJx - KQ
            
        else if a >= 3 && b == 2 && oppMax <= 3 { return a } // AJxxxx - KQ
            
        else if a == 3 && b >= 3 && oppMax <= 4 { return b } // AJx - KQxxx
            
        else if a >= 4 && b >= 4 { return max (a,b) }
            
        else { return 3 }
        
    case 0b10010000: // AJ zu -
        
        if oppMax <= 1 && b <= 1 { return a }
            
        else { return 1 }
        
    case 0b10000000: // A zu -
        
        if oppMax <= 1 && b <= 1 { return a }
            
        else { return 1 }

    case 0b10010100: // AJ zu K
        
        if b == 1 && oppMax <= 1 { return a }
            
        else if b == 1 && oppMax > 1 { return 1 }
        
        else if b == 2 && oppMax <= 2 { return a }
            
        else if b >= 2 && oppMax >= 3 { return 2 }
            
        else if oppMax <= 2 { return min(a,b) }
            
        else { return 1 }
        
    case 0b10000100: // A zu K
        
        if a == 1 { return 1 }
        
        else if b == 1 && oppMax <= 1 { return a }
            
        else if b == 1 && oppMax > 1 { return 1 }
            
        else if b == 2 && oppMax <= 2 { return a }
            
        else if b >= 2 && oppMax >= 3 { return 2 }
            
        else if oppMax <= 2 { return min(a,b) }
            
        else { return 1 }
        
    case 0b10000111: // A zu KQJ
        
        if a == 1 { return 1 }
        
        else if a > b && b == 3 && oppMax <= 3 { return a } // Axxx - KQJ
        
        else if a > b && b == 3 && oppMax > 3 { return 3 } // Axxx - KQJ
        
        else if b == 3 { return 3 }
        
        else if oppMax <= 4 { return b }
        
        else { return 4 }
        
        
    case 0b10000110: // A zu KQ
        
        if a == 1 { return 1 }
            
        else if a > b && b == 2 && oppMax <= 2 { return a } // Axxx - KQ
        
        else if a > b && b == 3 && oppMax <= 3 { return a } // Axxx - KQx
            
        else if a > b && b == 3 && oppMax > 3 { return 3 } // Axxx - KQx
            
        else if b == 3 { return 3 }
            
        else if oppMax <= 3 { return b }
            
        else { return 3 }
        
    case 0b10000101: // A zu KJ
        
        if a == 1 { return 1 }
            
        else if b == 2 && oppMax <= 2 { return a } // Axxx - KJ
            
        else if a == 2 && oppMax <= 2 { return b } // Ax - KJxx
            
        else if oppMax <= 2 { return min(a,b) } // Axxx - KJx
            
        else { return 2 }
        
    case 0b10000011: // A zu QJ

        if a == 1 { return 1 }
        
        else if oppMax <= 1 && a == 2 { return b }
        
        else if  oppMax <= 1 { return min (a,b) }
        
        else { return 1 }
        
    case 0b10000010: // A zu Q
        
        if a == 1 { return 1 }
            
        else if oppMax <= 1 && a == 2 && b >= 2 { return b }
            
        else if  oppMax <= 1 { return min (a,b) }
            
        else { return 1 }
        
    case 0b10000001: // A zu J
        
        if a == 1 { return 1 }
        
        else if oppMax <= 1 && b <= 1 { return a }
            
        else if oppMax <= 1 && a == 2 { return b }
            
        else if oppMax <= 1 { return min (a,b) }
            
        else { return 1 }

        
        
    default: return 0
        
    }
    
    
    
    return 0
}

