//
//  ModelTicTacToe.swift
//  Test_Dotscreen
//
//  Created by Guillaume Donzeau on 09/06/2022.
//

import Foundation
import UIKit

class Brain {
    
    var buttonsState = [
        ButtonState.none,ButtonState.none,ButtonState.none,
        ButtonState.none,ButtonState.none,ButtonState.none,
        ButtonState.none,ButtonState.none,ButtonState.none
    ]
    
    var scorePlayerOne = 0
    
    var scorePlayerTwo = 0
    
    func pressButton(tag: Int, isFirstPlayerTurn: Bool) {
        // Les tags ont été assignés à partir de 1 et non 0 pour une meilleur lecture "humaine" du tableau
        // Normalement un bouton autre que .none est incatif, mais on sécurise
        guard buttonsState[tag-1] == .none else {
            return
        }
        if isFirstPlayerTurn {
            buttonsState[tag-1] = .player1
        } else {
            buttonsState[tag-1] = .player2
        }
        notifChangeButton()
        
        checkForVictoryConditions()
    }
    
    func newGame() {
        print("New game")
        for index in 0 ..< buttonsState.count {
            buttonsState[index] = .none
        }
        notifChangeButton()
    }
    
    func checkForVictoryConditions() {
        // Il y a 8 possibilités de gagner
        if buttonsState[1] == buttonsState[2], buttonsState[2] == buttonsState[3] { // La première ligne est remplie par le même joueur
            winnerIs(winner: buttonsState[1])
        }
    }
    
    func winnerIs(winner: ButtonState) {
        switch winner {
        case .player1:
            scorePlayerOne += 1
        case .player2:
            scorePlayerTwo += 1
        case .none:
            print("Error")
        }
        notifChangeButton()
    }
    
    private func notifChangeButton() { // Each time a button is pressed, let's send a notification to refresh the states
            let name = Notification.Name(rawValue: "buttonsStateChanged")
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
        }
    
}
