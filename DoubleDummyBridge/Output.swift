//
//  outputFunctionsVisual.swift
//  bridgeAnalyse
//
//  Created by Fabian von Löbbecke on 31.10.16.
//  Copyright © 2016 Fabian von Löbbecke. All rights reserved.
//

import UIKit


func handHasVoid(suit: UInt64, hand: UInt64) -> Bool {
    
    if suit & hand == 0 {
        
        return true
        
    }
    
    return false
}


func handToStringVisualStyle(hand: UInt64) -> String {
    
    var output = "♤ "
    
    if handHasVoid(suit: spades, hand: hand) == true {output += "-"}
    
    if hand & sA > 0 { output += "A"}
    if hand & sK > 0 { output += "K"}
    if hand & sQ > 0 { output += "Q"}
    if hand & sJ > 0 { output += "J"}
    if hand & sT > 0 { output += "10"}
    if hand & s9 > 0 { output += "9"}
    if hand & s8 > 0 { output += "8"}
    if hand & s7 > 0 { output += "7"}
    if hand & s6 > 0 { output += "6"}
    if hand & s5 > 0 { output += "5"}
    if hand & s4 > 0 { output += "4"}
    if hand & s3 > 0 { output += "3"}
    if hand & s2 > 0 { output += "2"}
    
    output += "\n♡ "
    
    if handHasVoid(suit: hearts, hand: hand) == true {output += "-"}
    
    if hand & hA > 0 { output += "A"}
    if hand & hK > 0 { output += "K"}
    if hand & hQ > 0 { output += "Q"}
    if hand & hJ > 0 { output += "J"}
    if hand & hT > 0 { output += "10"}
    if hand & h9 > 0 { output += "9"}
    if hand & h8 > 0 { output += "8"}
    if hand & h7 > 0 { output += "7"}
    if hand & h6 > 0 { output += "6"}
    if hand & h5 > 0 { output += "5"}
    if hand & h4 > 0 { output += "4"}
    if hand & h3 > 0 { output += "3"}
    if hand & h2 > 0 { output += "2"}
    
    output += "\n♢ "
    
    if handHasVoid(suit: diamonds, hand: hand) == true {output += "-"}
    
    if hand & dA > 0 { output += "A"}
    if hand & dK > 0 { output += "K"}
    if hand & dQ > 0 { output += "Q"}
    if hand & dJ > 0 { output += "J"}
    if hand & dT > 0 { output += "10"}
    if hand & d9 > 0 { output += "9"}
    if hand & d8 > 0 { output += "8"}
    if hand & d7 > 0 { output += "7"}
    if hand & d6 > 0 { output += "6"}
    if hand & d5 > 0 { output += "5"}
    if hand & d4 > 0 { output += "4"}
    if hand & d3 > 0 { output += "3"}
    if hand & d2 > 0 { output += "2"}

    output += "\n♧ "
    
    if handHasVoid(suit: clubs, hand: hand) == true {output += "-"}
    
    if hand & cA > 0 { output += "A"}
    if hand & cK > 0 { output += "K"}
    if hand & cQ > 0 { output += "Q"}
    if hand & cJ > 0 { output += "J"}
    if hand & cT > 0 { output += "10"}
    if hand & c9 > 0 { output += "9"}
    if hand & c8 > 0 { output += "8"}
    if hand & c7 > 0 { output += "7"}
    if hand & c6 > 0 { output += "6"}
    if hand & c5 > 0 { output += "5"}
    if hand & c4 > 0 { output += "4"}
    if hand & c3 > 0 { output += "3"}
    if hand & c2 > 0 { output += "2"}
    
    
    //output += "\n"

    
    
    
    
    return output
}

func handToStringVisualStyle2(hand: UInt64) -> String {
    
    var output = "♤ "
    
    if handHasVoid(suit: spades, hand: hand) == true {output += "-"}
    
    if hand & sA > 0 { output += "A"}
    if hand & sK > 0 { output += "K"}
    if hand & sQ > 0 { output += "Q"}
    if hand & sJ > 0 { output += "J"}
    if hand & sT > 0 { output += "10"}
    if hand & s9 > 0 { output += "9"}
    if hand & s8 > 0 { output += "8"}
    if hand & s7 > 0 { output += "7"}
    if hand & s6 > 0 { output += "6"}
    if hand & s5 > 0 { output += "5"}
    if hand & s4 > 0 { output += "4"}
    if hand & s3 > 0 { output += "3"}
    if hand & s2 > 0 { output += "2"}
    
    output += "♡ "
    
    if handHasVoid(suit: hearts, hand: hand) == true {output += "-"}
    
    if hand & hA > 0 { output += "A"}
    if hand & hK > 0 { output += "K"}
    if hand & hQ > 0 { output += "Q"}
    if hand & hJ > 0 { output += "J"}
    if hand & hT > 0 { output += "10"}
    if hand & h9 > 0 { output += "9"}
    if hand & h8 > 0 { output += "8"}
    if hand & h7 > 0 { output += "7"}
    if hand & h6 > 0 { output += "6"}
    if hand & h5 > 0 { output += "5"}
    if hand & h4 > 0 { output += "4"}
    if hand & h3 > 0 { output += "3"}
    if hand & h2 > 0 { output += "2"}
    
    output += "♢ "
    
    if handHasVoid(suit: diamonds, hand: hand) == true {output += "-"}
    
    if hand & dA > 0 { output += "A"}
    if hand & dK > 0 { output += "K"}
    if hand & dQ > 0 { output += "Q"}
    if hand & dJ > 0 { output += "J"}
    if hand & dT > 0 { output += "10"}
    if hand & d9 > 0 { output += "9"}
    if hand & d8 > 0 { output += "8"}
    if hand & d7 > 0 { output += "7"}
    if hand & d6 > 0 { output += "6"}
    if hand & d5 > 0 { output += "5"}
    if hand & d4 > 0 { output += "4"}
    if hand & d3 > 0 { output += "3"}
    if hand & d2 > 0 { output += "2"}
    
    output += "♧ "
    
    if handHasVoid(suit: clubs, hand: hand) == true {output += "-"}
    
    if hand & cA > 0 { output += "A"}
    if hand & cK > 0 { output += "K"}
    if hand & cQ > 0 { output += "Q"}
    if hand & cJ > 0 { output += "J"}
    if hand & cT > 0 { output += "10"}
    if hand & c9 > 0 { output += "9"}
    if hand & c8 > 0 { output += "8"}
    if hand & c7 > 0 { output += "7"}
    if hand & c6 > 0 { output += "6"}
    if hand & c5 > 0 { output += "5"}
    if hand & c4 > 0 { output += "4"}
    if hand & c3 > 0 { output += "3"}
    if hand & c2 > 0 { output += "2"}
    
    
    //output += "\n"
    
    
    
    
    
    return output
}

func returnCardAsString (hand: UInt64) -> String {
    
    if hand & sA > 0 { return "♠A" }
    if hand & sK > 0 { return "♠K" }
    if hand & sQ > 0 { return "♠Q" }
    if hand & sJ > 0 { return "♠J"}
    if hand & sT > 0 { return "♠T"}
    if hand & s9 > 0 { return "♠9"}
    if hand & s8 > 0 { return "♠8"}
    if hand & s7 > 0 { return "♠7"}
    if hand & s6 > 0 { return "♠6"}
    if hand & s5 > 0 { return "♠5"}
    if hand & s4 > 0 { return "♠4"}
    if hand & s3 > 0 { return "♠3"}
    if hand & s2 > 0 { return "♠2"}
    if hand & hA > 0 { return "♥A"}
    if hand & hK > 0 { return "♥K"}
    if hand & hQ > 0 { return "♥Q"}
    if hand & hJ > 0 { return "♥J"}
    if hand & hT > 0 { return "♥T"}
    if hand & h9 > 0 { return "♥9"}
    if hand & h8 > 0 { return "♥8"}
    if hand & h7 > 0 { return "♥7"}
    if hand & h6 > 0 { return "♥6"}
    if hand & h5 > 0 { return "♥5"}
    if hand & h4 > 0 { return "♥4"}
    if hand & h3 > 0 { return "♥3"}
    if hand & h2 > 0 { return "♥2"}
    if hand & dA > 0 { return "♦A"}
    if hand & dK > 0 { return "♦K"}
    if hand & dQ > 0 { return "♦Q"}
    if hand & dJ > 0 { return "♦J"}
    if hand & dT > 0 { return "♦T"}
    if hand & d9 > 0 { return "♦9"}
    if hand & d8 > 0 { return "♦8"}
    if hand & d7 > 0 { return "♦7"}
    if hand & d6 > 0 { return "♦6"}
    if hand & d5 > 0 { return "♦5"}
    if hand & d4 > 0 { return "♦4"}
    if hand & d3 > 0 { return "♦3"}
    if hand & d2 > 0 { return "♦2"}
    if hand & cA > 0 { return "♣A"}
    if hand & cK > 0 { return "♣K"}
    if hand & cQ > 0 { return "♣Q"}
    if hand & cJ > 0 { return "♣J"}
    if hand & cT > 0 { return "♣T"}
    if hand & c9 > 0 { return "♣9"}
    if hand & c8 > 0 { return "♣8"}
    if hand & c7 > 0 { return "♣7"}
    if hand & c6 > 0 { return "♣6"}
    if hand & c5 > 0 { return "♣5"}
    if hand & c4 > 0 { return "♣4"}
    if hand & c3 > 0 { return "♣3"}
    if hand & c2 > 0 { return "♣2"}
    
    return "XX"
}

