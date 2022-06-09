//
//  TicTacToeViewController.swift
//  Test_Dotscreen
//
//  Created by Guillaume Donzeau on 09/06/2022.
//

import UIKit

class TicTacToeViewController: UIViewController {
    
    var isFirstPLayersTurn = true
    
    var brain = Brain()
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    
    @IBAction func pressButton(_ sender: UIButton) {
        print(sender.tag)
        brain.pressButton(tag: sender.tag, isFirstPlayerTurn: isFirstPLayersTurn)
        isFirstPLayersTurn.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateNotifications()
        brain.newGame()
    }
    
    func activateNotifications() {
        let textComplete = Notification.Name(rawValue: "buttonsStateChanged")
                NotificationCenter.default.addObserver(self, selector: #selector(refreshButtons), name: textComplete, object: nil)
    }
    
    @objc func refreshButtons() {
        for index in 0 ..< brain.buttonsState.count {
            switch brain.buttonsState[index] {
            
            case .player1:
                buttons[index].setTitle("X", for: .normal)
                buttons[index].isEnabled = false
            case .player2:
                buttons[index].setTitle("O", for: .normal)
                buttons[index].isEnabled = false
            case .none:
                buttons[index].setTitle("", for: .normal)
                buttons[index].isEnabled = true
            }
        }
    }
    
    
   
}
