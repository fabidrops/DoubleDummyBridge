//
//  TODO.swift
//  DoubleDummyBridge
//
//  Created by Fabian von Löbbecke on 27.02.17.
//  Copyright © 2017 Fabian von Löbbecke. All rights reserved.
//

import Foundation


// FEHLER
// done - 1. NT scheint richtig zu sein, mit Trumpf nicht
// HashTableModus 3 bisher fehlerfrei 1,2 nicht



// SPEED
// done - 0. Funktion playable Cards prüft nur die nächste Karte also 78 aber nicht 79 wenn die 8 nicht im spiel ist
// 0a.Karten sortieren
// 1. Hash-Table für "Wer gewinnt den Stich"
// 2. Hash-Table Stellung
// 3. Hash-Table für "Ranghöchste" -> QuickTricks
// 4. Kleine Karten gleichwertig behandeln
// 5. Hash-Table for playable Cards ?
// Hash für die Restkarten, nicht für die Gesamtsticheanzahl bisher, versucht, hatt nicht funktioniert

// Optimierung
// Hash-Table nach Anzahl der Restkarten, zB 13-10 Restkarten darf auch "7" -> x verwandeln, darunter nur ab der 6 -> x ?

