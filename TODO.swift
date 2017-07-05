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


// QuickTricks: ich bilde einzelne Farbe pro Hand ab
// 100010000011000 0111011000000
// ich ermittele die Quick Tricks unabhängig von Gegnerhänden , dh Kombinationen wo es egal ist wie die Gegnerhände sind
// das sind ide Kombination wo hand1&hand2 = 1 oder 11 oder 111 beginnen....
// bei Konstellationen wie AKB gibt die Hashtabelle einen Wert zurück je nachdem wo die Dame ist, das prüft man extra
// hash Table gibt auch entryFlag zurück

// wenn hand die ersten x Tops hat dann ist QT = Anzahl Tops
// sogar Anzahl TOP >= anzahl karten aller gener und partner ist dann ist QT = Länge der Farbe

// solche reglen kann man auch für AKB definieren usw.


// shadow hand einfügen, die immer die relative Hand mitführt, dafür am Anfang Funktion hand -> shadow hand überführen
// und dann im Modell game einbauen sowie bei playcard
