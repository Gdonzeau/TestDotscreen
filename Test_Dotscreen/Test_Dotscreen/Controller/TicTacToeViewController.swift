//
//  TicTacToeViewController.swift
//  Test_Dotscreen
//
//  Created by Guillaume Donzeau on 09/06/2022.
//

import UIKit

class TicTacToeViewController: UIViewController {
    
    var isFirstPLayersTurn = true
    var timer = Timer()
    var tempusFugit = 60
    var minutes = 0
    var secondes = 0
    var brain = Brain()
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    
    @IBAction func pressButton(_ sender: UIButton) {
        pressButton(tag: sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activateNotifications()
        brain.newGame()
    }
    
    func setupView() {
        timerLabel.text = "Temps restant : \(tempusFugit)"
        playerOneLabel.text = "Joueur 1 : \(brain.scorePlayerOne)"
        playerTwoLabel.text = "Joueur 2 : \(brain.scorePlayerTwo)"
    }
    
    func activateNotifications() {
        let textComplete = Notification.Name(rawValue: "buttonsStateChanged")
                NotificationCenter.default.addObserver(self, selector: #selector(refreshButtons), name: textComplete, object: nil)
    }
    
    @objc func refreshButtons() {
        timer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(timerDown), userInfo: nil, repeats: true)
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
            
            setupView()
        }
    }
    
    @objc func timerDown() {
        if tempusFugit > 0 {
            tempusFugit -= 1
            setupView()
        } else {
            if isFirstPLayersTurn {
                brain.scorePlayerTwo += 1
            } else {
                brain.scorePlayerOne += 1
            }
            newGame()
        }
    }
    
    func newGame() {
        brain.newGame()
        timer.invalidate()
        tempusFugit = 60
        setupView()
    }
    
    func pressButton(tag: Int) {
        print(tag)
        brain.pressButton(tag: tag, isFirstPlayerTurn: isFirstPLayersTurn)
        isFirstPLayersTurn.toggle()
        timer.invalidate()
        tempusFugit = 60
        setupView()
    }
    
    func configurateClock() {
        
    }
    
    
   
}
