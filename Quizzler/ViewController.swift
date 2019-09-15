//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let question = allQuestions.list[questionNumber]
        questionLabel.text = question.questionText
        progressLabel.text = "\(questionNumber + 1)/13"
        scoreLabel.text = String(score)
        
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        checkAnswer(tag: sender.tag)
        questionNumber += 1
        nextQuestion()
  
    }
    
    
    func updateUI() {
        
        scoreLabel.text = String(score)
        progressLabel.text = "\(questionNumber + 1)/13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
        
    }
    

    func nextQuestion() {
        
        if questionNumber == allQuestions.list.count {
            let alert = UIAlertController(title: "Awesome", message: "You have finished all question, do you want to start over?", preferredStyle:.alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {(UIAlertAction) in self.startOver()})
            alert.addAction(restartAction)
            present(alert,animated: true,completion: nil)
            
            
            
        }else {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }
       
        
    }
    
    
    func checkAnswer(tag : Int) {
        if tag == 1 {
            pickedAnswer = true
        }else {
            pickedAnswer = false
        }
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        if pickedAnswer == correctAnswer {
            ProgressHUD.showSuccess("Correct!")
            score += 10
            
        }else {
           ProgressHUD.showError("Sorry, You're wrong!")
            score -= 5
        }
        
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    

    
}
