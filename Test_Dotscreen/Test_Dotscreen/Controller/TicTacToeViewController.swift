//
//  TicTacToeViewController.swift
//  Test_Dotscreen
//
//  Created by Guillaume Donzeau on 09/06/2022.
//

import UIKit

class TicTacToeViewController: UIViewController {
    
    var isFirstPLayersTurn = true {
        didSet {
            if isFirstPLayersTurn {
                playerOneLabel.textColor = .red
                playerTwoLabel.textColor = .black
            } else {
                playerOneLabel.textColor = .black
                playerTwoLabel.textColor = .red
            }
        }
    }
    var timer = Timer()
    var tempusFugit = 180
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
        begin()
    }
    
    func setupView() {
        timerLabel.text = "Temps restant : \(configurateClock())"
        playerOneLabel.text = "Joueur 1 : \(brain.scorePlayerOne)"
        playerTwoLabel.text = "Joueur 2 : \(brain.scorePlayerTwo)"
    }
    
    func begin() {
        timer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(timerDown), userInfo: nil, repeats: true)
        playerOneLabel.textColor = .red
        playerTwoLabel.textColor = .black
        brain.scorePlayerOne = 0
        brain.scorePlayerTwo = 0
        tempusFugit = 180
        setupView()
        activateNotifications()
        brain.newGame()
    }
    
    func activateNotifications() {
        let textComplete = Notification.Name(rawValue: "buttonsStateChanged")
                NotificationCenter.default.addObserver(self, selector: #selector(refreshButtons), name: textComplete, object: nil)
    }
    
    @objc func refreshButtons() {
        //timer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(timerDown), userInfo: nil, repeats: true)
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
            // Pendant la programmation, j'avais gardé dans un coin de ma tête qu'il fallait faire un chrono. Il me semblait que c'était le temps pour chaque joueur pour jouer. Après relecture c'était la fin de la partie. Je corrige mais je laisse l'ancien code en commentaire.
            /*
            if isFirstPLayersTurn {
                brain.scorePlayerTwo += 1
            } else {
                brain.scorePlayerOne += 1
            }
            newGame()
 */
            timer.invalidate()
            if brain.scorePlayerOne < brain.scorePlayerTwo {
                End(endMessage: "Joueur deux gagne")
            } else if brain.scorePlayerOne > brain.scorePlayerTwo {
                End(endMessage: "Joueur un gagne")
            } else {
                End(endMessage: "C'est une égalité")
            }
        }
    }
    
    func newGame() {
        brain.newGame()
        //timer.invalidate()
        //tempusFugit = 60
        setupView()
    }
    
    func pressButton(tag: Int) {
        print(tag)
        brain.pressButton(tag: tag, isFirstPlayerTurn: isFirstPLayersTurn)
        isFirstPLayersTurn.toggle()
        //timer.invalidate()
        //tempusFugit = 60
        setupView()
    }
    
    func configurateClock() -> String {
        minutes = tempusFugit/60
        secondes = tempusFugit%60
        return "\(minutes):\(secondes)"
    }
    
    private func End(endMessage: String) {
            let alertVC = UIAlertController(title: "Fin de la partie", message: endMessage, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertVC,animated: true,completion: nil)
        }
   
}
