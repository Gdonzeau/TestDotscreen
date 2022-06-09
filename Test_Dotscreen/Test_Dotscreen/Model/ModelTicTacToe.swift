//
//  ModelTicTacToe.swift
//  Test_Dotscreen
//
//  Created by Guillaume Donzeau on 09/06/2022.
//

import Foundation

class Brain {
    
    var buttonsState = [
        ButtonState.none,ButtonState.none,ButtonState.none,
        ButtonState.none,ButtonState.none,ButtonState.none,
        ButtonState.none,ButtonState.none,ButtonState.none
    ]
    
    var scorePlayerOne = 0
    
    var scorePlayerTwo = 0
    
    func pressButton(tag: Int, isFirstPlayerTurn: Bool) {
        // Normalement un bouton autre que .none est inactif, mais on sécurise
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
        
        if buttonsState[0] == buttonsState[1] && buttonsState[1] == buttonsState[2] && buttonsState[0] != .none { // La première ligne est remplie par le même joueur
            print("L1")
                winnerIs(winner: buttonsState[0])
        }
        else if buttonsState[3] == buttonsState[4] && buttonsState[4] == buttonsState[5] && buttonsState[3] != .none{ // La deuxième ligne est remplie par le même joueur
            print("L2")
            winnerIs(winner: buttonsState[3])
        }
        else if buttonsState[6] == buttonsState[7] && buttonsState[7] == buttonsState[8] && buttonsState[6] != .none{ // La troisième ligne est remplie par le même joueur
            print("L3")
            winnerIs(winner: buttonsState[6])
        }
        else if buttonsState[0] == buttonsState[3] && buttonsState[3] == buttonsState[6] && buttonsState[0] != .none{ // La première colonne est remplie par le même joueur
            print("C1")
            winnerIs(winner: buttonsState[0])
        }
        else if buttonsState[1] == buttonsState[4] && buttonsState[4] == buttonsState[7] && buttonsState[1] != .none{ // La deuxième colonne est remplie par le même joueur
            print("C2")
            winnerIs(winner: buttonsState[1])
        }
        else if buttonsState[2] == buttonsState[5] && buttonsState[5] == buttonsState[8] && buttonsState[2] != .none{ // La troisième colonne est remplie par le même joueur
            print("C3")
            winnerIs(winner: buttonsState[2])
        }
        else if buttonsState[0] == buttonsState[4] && buttonsState[4] == buttonsState[8] && buttonsState[0] != .none{ // La première diagonale est remplie par le même joueur
            print("D1")
            winnerIs(winner: buttonsState[0])
        }
        else if buttonsState[2] == buttonsState[4] && buttonsState[4] == buttonsState[6] && buttonsState[2] != .none{ // La deuxième diagonale est remplie par le même joueur
            print("D2")
            winnerIs(winner: buttonsState[2])
        }
        
        // Et une égalité : toutes les cases pleines et aucune victoire
        for buttonState in buttonsState {
            if buttonState == .none {
                return
            }
        }
        winnerIs(winner: .none)
        
    }
    
    func winnerIs(winner: ButtonState) {
        print("Check : \(ButtonState.self)")
        switch winner {
        case .player1:
            print("player one wins")
            scorePlayerOne += 1
        case .player2:
            print("player two wins")
            scorePlayerTwo += 1
        case .none:
            print("Egalité")
        }
        notifChangeButton()
        newGame()
    }
    
    private func notifChangeButton() { // Each time a button is pressed, let's send a notification to refresh the states
            let name = Notification.Name(rawValue: "buttonsStateChanged")
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
        }
    
}
