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



}
