//
//  quickTrickTable.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 28.05.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

// quickTrickTable
var qTT = [String:Int]()


func fillquickTricksTable () {

    qTT["AKQJ10xxx"] = 8
    qTT["AKQJ10xx"] = 7
    qTT["AKQJ10x"] = 6
    qTT["AKQJ10"] = 5
    qTT["AKQJ"] = 4
    qTT["AKQ"] = 3
    qTT["AK"] = 2
    qTT["A"] = 1

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
    qTT["AQ-K"] = 2

    qTT["Ax-KQx"] = 3
    qTT["Ax-KQJ"] = 3
    qTT["Ax-KQJx"] = 4
    qTT["AT-KQx"] = 3
    qTT["AT-KQJ"] = 3
    qTT["AT-KQJx"] = 4


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

    qTT["AKJx-QTxx"] = 4
    qTT["AKJx-Qxxx"] = 4
    qTT["AKJT-Qxxx"] = 4
    qTT["AKxx-QJxx"] = 4
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



    qTT["AQJxx-KTx"] = 5
    qTT["AQTxx-KJx"] = 5




}
