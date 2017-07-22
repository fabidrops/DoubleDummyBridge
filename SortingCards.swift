//
//  SortingCards.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 20.07.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

func rankOfCard(card:UInt64) -> Int {
    
    if card & (sA+hA+dA+cA) > 0 { return 14}
        
    else if card & (sK+hK+dK+cK) > 0 { return 13 }
        
    else if card & (sQ+hQ+dQ+cQ) > 0 { return 12 }
        
    else if card & (sJ+hJ+dJ+cJ) > 0 { return 11}
        
    else if card & (sT+hT+dT+cT) > 0 { return 10 }
        
    else if card & (s9+h9+d9+c9) > 0 { return 9 }
        
    else if card & (s8+h8+d8+c8) > 0 { return 8 }
        
    else if card & (s7+h7+d7+c7) > 0 { return 7 }
        
    else if card & (s6+h6+d7+c7) > 0 { return 6 }
        
    else if card & (s5+h5+d5+c5) > 0 { return 5 }
        
    else if card & (s4+h4+d4+c4) > 0 { return 4 }
        
    else if card & (s3+h3+d3+c3) > 0 { return 3 }
        
    else if card & (s2+h2+d2+c2) > 0 { return 2 }
        
    else {return 0}
    
}
