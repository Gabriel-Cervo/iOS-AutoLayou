//
//  ViewController.swift
//  100DaysOfSwift-Project2
//
//  Created by João Gabriel Dourado Cervo on 25/01/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    
        // layer = CALayer... Modificar views
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        // CALayer nao reconhece UIColor, entao é necessário chamar especificamente, e tambem é necessário passar um cgColor (CALayer nao reconhece UIColor...), chamamos então essa propriedade do UIColor
        // Criar proprias cores:
        // UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0)
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    // o action é necessário para poder ser usado como handler no botao
    // default = nil
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle() // Sorteia os paises
        // Existe tambem o metodo .shuffled(), que retorna um array novo
        
        // Seta imagem para os botoes
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2) // Numero aleatorio
        title = "\(countries[correctAnswer].uppercased())"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
    }
    
    func resetGame(action: UIAlertAction!) {
        score = 0
        questionsAnswered = 0
        
        askQuestion()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var answerResponse: String
        let message: String
        
        questionsAnswered += 1
        
        if sender.tag == correctAnswer {
            answerResponse = "Correct"
            message = ""
            score += 1
        } else {
            answerResponse = "Wrong"
            message = "That's the flag of \(countries[sender.tag].capitalizingFirstLetter())"
            score = (score - 1) < 0 ? 0 : (score - 1)
        }
        
        let alertMessage = questionsAnswered < 10 ? message : "Your final score is \(score)!"
        let alertAction = questionsAnswered < 10 ?
            UIAlertAction(title: "Continue", style: .default, handler: askQuestion) :
            UIAlertAction(title: "Reset Game", style: .default, handler: resetGame) // Aqui o style tem 3 opcoes, .default, .cancel e .destructive
        
        // Cria um alerta
        let alertController = UIAlertController(title: answerResponse, message: alertMessage, preferredStyle: .alert)
        // O preferredStyle tem duas opcoes, o alert (da um alerta) e o .actionSheet, que desliza as opcoes debaixo
        // Quando usar: alert para mostrar quando algo mudar e actionSheet para perguntar um set de opcoes
        
        // adiciona o botao de continuar / resetar
        alertController.addAction(alertAction)
        
        // Chama o alerta
        present(alertController, animated: true)
    }
    
    @objc func showScore() {
        let scoreAlert = UIAlertController(title: "Your score is:", message: "\(score) points!", preferredStyle: .alert)
        let closeAlert = UIAlertAction(title: "Ok", style: .default, handler: .none)
        
        scoreAlert.addAction(closeAlert)
        
        present(scoreAlert, animated: true, completion: .none)
    }
    
}

