//
//  ViewController.swift
//  05-Quiz App
//
//  Created by Ricardo Sanchez on 6/29/20.
//  Copyright © 2020 Ricardo Sanchez. All rights reserved.
//

import UIKit
import ProgressHUD
import AVFoundation

class ViewController: UIViewController {
    
    let soundsArray  = ["true","false","finish","Soundtrack"]
    var audioPlayer : AVAudioPlayer!
    var audioSountrack : AVAudioPlayer!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelQeustion: UILabel!
    @IBOutlet weak var labelQuestionNumber: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
    @IBOutlet weak var progressBar: UIView!
    var currentScore = 0
    var currentQuestionID = 0
    var correctQuestionsAnswer = 0
    var countQuestionCategory = 0
    var category: String!
    let factory = QuestionsFactory()
    var finish : Bool = false
    
    
    
    var currentQuestion : Question!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        startGame()
        
    }
    
    func startGame() {
        currentScore = 0
        currentQuestionID = 0
        correctQuestionsAnswer = 0
        //shuffle reordena el arreglo
        self.countQuestionCategory = self.factory.getCountQuestionCategory(category: self.category)
        self.factory.questionsBank.questions.shuffle()
        
        
        let fileName = soundsArray[3]
        if let soundURL : URL = Bundle.main.url(forResource: fileName, withExtension: "mp3"){
            
            do {
                audioSountrack = try AVAudioPlayer(contentsOf: soundURL)
            } catch {
                print(error)
            }
            audioSountrack.play()
        }
        
        askNextQuestion()
        updateUIElements()
    }
    
    func askNextQuestion() {
        
        if let newQuestion = factory.getQuestionAt(index: currentQuestionID,category: self.category) , currentQuestionID < self.countQuestionCategory-1 {
            self.currentQuestion = newQuestion
            self.labelQeustion.text = self.currentQuestion.question
            
        } else {
            gameOver()
        }
    }
    
    func gameOver() {
        let fileName = soundsArray[2]
        if let soundURL : URL = Bundle.main.url(forResource: fileName, withExtension: "mp3"){
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            } catch {
                print(error)
            }
            audioSountrack.stop()
            audioPlayer.play()
        }
        
        let alert = UIAlertController(title: NSLocalizedString("game.over.title", comment: "Titulo del pop up de Game Over"), message: "\(NSLocalizedString("game.over.message1", comment: "")) \(correctQuestionsAnswer) /\(self.countQuestionCategory). \(NSLocalizedString("game.over.message2", comment: ""))", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.audioPlayer.stop()
            
            self.finish = true
            self.navigationController?.popViewController(animated: true)
            
        }
        
        alert.addAction(okAction)
        present(alert,animated: true,completion: nil)
    }
    
    
    
    func updateUIElements() {
        self.imageView.isHidden = true
        self.labelScore.text = "Puntuación: \(self.currentScore)"
        self.labelQuestionNumber.text = "\(self.currentQuestionID+1)/\(self.countQuestionCategory)"
        
        if let imagen = self.factory.questionsBank.questions[self.currentQuestionID].image{
            self.imageView.isHidden = false
            self.imageView.image = UIImage(named: imagen)
        }
        
        for constraint in self.progressBar.constraints {
            if constraint.identifier == "barWidth" {
                constraint.constant = (self.view.frame.size.width/CGFloat(self.countQuestionCategory-1))*CGFloat(self.currentQuestionID)
            }
        }
        self.currentQuestionID += 1
      }

    @IBAction func buttonPress(_ sender: UIButton) {
        var isCorrect : Bool
        if (sender.tag == 1) {
            
            isCorrect = (self.currentQuestion.answer == true)
            
        }else {
            isCorrect = (self.currentQuestion.answer == false)
            
        }
        
        if isCorrect {
            self.correctQuestionsAnswer += 1
            let fileName = soundsArray[0]
            if let soundURL : URL = Bundle.main.url(forResource: fileName, withExtension: "mp3"){
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                } catch {
                    print(error)
                }
                audioPlayer.play()
            }
            self.currentScore += 100 * self.correctQuestionsAnswer
            ProgressHUD.showSucceed("Genial", interaction: true)
        }else {
            let fileName = soundsArray[1]
            if let soundURL : URL = Bundle.main.url(forResource: fileName, withExtension: "mp3"){
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                } catch {
                    print(error)
                }
                audioPlayer.play()
            }
            ProgressHUD.showFailed("NOOO!!!", interaction: true)
        }
        askNextQuestion()
        updateUIElements()
     }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

