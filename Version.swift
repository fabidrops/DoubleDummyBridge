//
//  Version.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 19.03.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation

// ## 0.1   MinMax mit Alpha/Beta Pruning in einer Funktion rekursiv mit Parameter Tiefe eingebaut
// ## 0.2   Hash-Table installiert mit verschiedenen Hash-Methoden
//          Automatisches Testtool 
// ## 0.25  MinMax prüft, ob N/S überhaupt noch mit den vorhandenen Reststichen noch alpha erreichen kann, sonst kann man gleich abbrechen
// ## 0.26  Funktion die Hand->kanonische Hand zu überführen, d.h. AQ -> AK wenn der König schon raus ist
// ## 0.30  Quick Tricks Implementation Begin
// ## 0.35  Better Quick Tricks
// ## 0.40  Better Quick Tricks
// ## 0.45  quickTrickPlaying Mode als Variable, wenn diese auf true ist bricht das Programm ab sowie O/W einen Stich macht oder die Farbe Pik nicht mehr gespielt wird, somit kann mann die quickTricks der Farbe Pik des Nord Spielers herleiten, in Minmax  (game.trickCurrent.count == 0 || game.trickSuit != spades) 
//    nimmt man != spades raus, dann bekommt man alle quickTricks der Hand, leider dauert dieses Verfahren zu lange
//Users/Fabi/Downloads/doubledummybridge-export.json

// ## 0.50 quickTricks Fully Implemented 


// in info.plist habe ich firebase reporting auf NO gesetzt
