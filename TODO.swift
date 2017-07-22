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


// QUICKTRICKS OPTIMIERUNG

// entry management um auch xx gegen AQxxxxx auszuwerten etc, d.h. spielen von beiden Seiten berücksichtigen

// qT nach erster Karte im Stich !!!


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


// SORTING

//The following pseudo-code contains empirical weights that are used to obtain move orderings that tend to put optimum move early in the list of moves. These may or may not be the exact weights and algorithms used in the current DDS version, but they give an idea of the important factors; the code is significantly more complex. One aim is to move the likely candidates to the top of the list, and another aim is to have good mixture of moves (i.e. not all cards from the same suit first) in case the heuristic is not good for a particular set-up.
//If the hand-to-play is void in the trick lead suit, the suit selected for the discard gets a bonus:
//suitAdd = ((suit length) * 64)/36;
//If the suit length is 2, and the hand-to-play has the next highest rank of the suit, the bonus is reduced by 2.
//Hand-to-play is trick-leading hand
//The contribution of the suit to the weight is:
//suitWeightDelta = suitBonus – ((countLH+countRH) * 32)/15
//suitBonus has the initial value 0, changed if conditions below apply:
//If it is a trump contract, and the suit is not trump, then there is a suitBonus change of
// LHO is void and LHO has trump card(s), or
// RHO is void and RHO has trump card(s).
//–10 if
//If RHO has either the highest rank of the suit played by hand-to-play or the next highest rank, then there is a suitBonus change of –18.
//If it is a trump contract, the suit is not trump, the own hand has a singleton, the own hand has at least one trump, partner has the highest rank in the suit and at least a suit length of 2, then there is a suitBonus change of +16. Suits are thus favoured where the opponents have as few move alternatives as possible.
//countLH =
//countLH =
//countRH =
//countRH =
//length of LHO) * 4, if LHO is not void in the suit,
//(suit
//(depth + 4), if LHO is void in the suit
//length of RHO) * 4, if RHO is not void in the suit,
//(suit
//(depth + 4), if RHO is void in the suit
//9
//if (trick winning card move) {
//if (one of the opponents has a singleton highest rank in the
//suit)
//the suit)
//if if
//}
//else {
//if else
//weight = suitWeightDelta + 30 – (rank of card move)
//(the card move is ”best move” as obtained at alpha-beta
//weight = weight + 52;
//(the card move is ”best move” as obtained from the Transposition Table) weight = weight + 11;
///* Not a trick winning move */
//(either LHO or RHO has singleton in suit which has highest rank) weight = suitWeightDelta + 29 – (rank of card move)
//}
//else }
//weight = suitWeightDelta + 35 – (rank of card
//else
//if (hand-to-play has second highest rank together with equivalent card(s) in suit)
//weight = suitWeightDelta + 40 – (rank of card move) if (hand-to-play has highest rank in suit) {
//if (partner has second highest rank in suit)
//weight = suitWeightDelta + 50 – (rank of card move)
//else if (the card move is the card with highest rank in weight = suitWeightDelta + 31
//else
//}
//else if  (partner  has highest rank in suit)  {
//if (hand-to-play has second highest rank in suit) weight = suitWeightDelta + 50 – (rank of card
//else
//weight = suitWeightDelta + 19 – (rank of card
//move)
//move)
//move)
//weight = suitWeightDelta + 40
//else
//if (hand-to-play has highest rank in suit)  {
//if (partner has second highest rank in suit)
//weight = suitWeightDelta + 44 – (rank of card move) else if (the card move is the card with highest rank in
//the suit)
//weight = suitWeightDelta + 25
//else
//weight = suitWeightDelta + 13 – (rank of card
//move)
//move)
//move)
//}
//else if  (partner  has highest rank in suit)  {
//if (hand-to-play has second highest rank in suit) weight = suitWeightDelta + 44 – (rank of card
//else }
//weight = suitWeightDelta + 29 – (rank of card
//else
//if (hand-to-play has second highest rank together with equivalent card(s) in suit)
//weight = suitWeightDelta + 29
//else
//if if
//weight = suitWeightDelta + 13 – (rank of card move)
//(the card move is ”best move” as obtained at alpha-beta
//weight = weight + 20;
//(the card move is ”best move” as obtained from the Transposition Table) weight = weight + 9;
//cutoff)
//cutoff)
//10
//Hand-to-play is left hand opponent (LHO) to leading hand
//if (trick winning card move) {
//} else
//}
//else {
//if
//} else
//else
//weight = 45 - (rank of card move)
//// card move is not trick winning
//(hand-to-play void in the suit played by the leading hand) { if (trump contract and trump is equal to card move suit)
//weight = 15 - (rank of card move) + suitAdd
//else
//weight = - (rank of card move) + suitAdd
//if (lowest card for leader’s partner or for RHO in the suit played is higher than played card for LHO)
//weight = - (rank of card move)
//if (LHO played card is higher than card played by the leading hand) {
//if (LHO move card has at least one equivalent card) weight = 20 - (rank of card move)
//else
//weight = 10 - (rank of card move)
//if
//} else
//else else
//(hand-to-play void in the suit played by the leading hand) { if (trump contract and trump is equal to card move suit)
//weight = 30 - (rank of card move) + suitAdd
//else
//weight = 60 - (rank of card move) + suitAdd
//if (lowest card for partner to leading hand is higher than LHO played card) weight = 45 - (rank of card move)
//if (RHO has a card in the leading suit higher than the leading card but lower than the highest rank of the leading hand)
//weight = 60 - (rank of card move)
//if (LHO played card is higher than card played by the leading hand) {
//if (played card by LHO is lower than any card for RHO in the same suit) weight = 75 - (rank of card move)
//else if (LHO’s card by LHO beats any card in that suit for the leading hand) weight = 70 - (rank of card move)
//else {
//if (LHO move card has at least one equivalent card) {
//weight = 60 - (rank of card move)
//else
//weight = 45 - (rank of card move)
//} }
//(RHO is not void in the suit played by the leading hand) {
//else if
//if (LHO move card has at least one equivalent card)
//} else
//}
//weight = - (rank of card move)
//weight = 50 - (rank of card move)
//else
//weight = 45 - (rank of card move)
//11
//Hand-to-play is partner to trick leading hand
//if (trick winning card move) {
//} else
//}
//else {
//if
//weight = 60 - (rank of card move)
//// card move is not trick winning
//(hand-to-play void in the suit played by the leading hand) { if (hand-to-play is on top by ruffing)
//weight = 40 - (rank of card move) + suitAdd
//else if (hand-to-play underruffs */
//weight = -15 - (rank of card move) + suitAdd
//else
//weight = - (rank of card move) + suitAdd
//} }
//if
//(hand-to-play void in the suit played by the leading hand) { if (card played by the leading hand is highest so far) {
//if (card by hand-to-play is trump and the suit played by the leading hand is not trump)
//weight = 30 - (rank of card move) + suitAdd
//else
//weight = 60 - (rank of card move) + suitAdd
//}
//else if (hand-to-play is on top by ruffing)
//weight = 70 - (rank of card move) + suitAdd
//else if (hand-to-play discards a trump but still loses)
//weight = 15 - (rank of card move) + suitAdd
//else
//weight = 30 - (rank of card move) + suitAdd
//}
//else {
//if (the card by hand-to-play is highest so far) {
//if (rank of played card is second highest in the suit)
//weight = 25
//else if (hand-to-play card has at least one equivalent card)
//weight = 20 - (rank of card move)
//else
//weight = 10 - (rank of card move)
//weight = -10 - (rank of card move)
//} else
//12
//Hand-to-play is right hand opponent (RHO) to leading hand
//if  (hand-to-play is void in leading suit)  {
//if  (LHO has current highest rank of the trick)  {
//if  (card move ruffs)
//weight = 14- (rank of card move) + suitAdd
//else
//weight = 30- (rank of card move) + suitAdd
//}
//else if  (hand-to-play ruffs and wins)
//weight = 30- (rank of card move) + suitAdd
//else if  (card move suit is trump, but not winning)
//weight = - (rank of card move)
//else
//weight = 14- (rank of card move) + suitAdd
//}
//else if  (LHO has current winning move)  {
//if  (RHO ruffs LHO’s winner)
//weight = 24 - (rank of card move)
//else
//weight = 30- (rank of card move)
//}
//else if (card move superior to present winning move not by LHO) {
//weight = 30- (rank of card move)
//else  {
//if  (card move ruffs but still losing)
//weight = - (rank of card move)
//else
//weight = 14- (rank of card move)
//}
