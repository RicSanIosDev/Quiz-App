//
//  QuestionsFactory.swift
//  05-Quiz App
//
//  Created by Ricardo Sanchez on 7/2/20.
//  Copyright © 2020 Ricardo Sanchez. All rights reserved.
//

import Foundation

class QuestionsFactory {
    var questionsBank : QuestionsBank!
    
    init() {
//        PROCESADO MANUAL DE PLIST
//        if let path = Bundle.main.path(forResource: "QuestionsBank", ofType: "plist") {
//            if let plist = NSDictionary(contentsOfFile: path) {
//                let questionsData = plist["questions"] as! [AnyObject]
//                for question in questionsData {
//                    if let text = question["question"], let ans = question["answer"] {
//                        let q = Question(text: text as! String, correctAnswer: ans as! Bool)
//                        questions.append(q)
//                    }
//                }
//         }
//        }
//      PROCESADO AUTOMATICO CON CODABLE
        do{
            
            if let url = Bundle.main.url(forResource: "QuestionsBank", withExtension: "plist") {
                let data = try Data(contentsOf: url)
                self.questionsBank = try PropertyListDecoder().decode(QuestionsBank.self, from: data)
                
                
            }
        }catch{
            print(error)
        }
        
                
    }
    
    func getQuestionAt(index: Int, category: String) -> Question? {
        
        let maxQuestion = getCountQuestionCategory(category: category)
        if index < 0 || index >= maxQuestion{
            return nil
        }
        getQuestionCategory(category: category)
        
            
          
        return questionsBank.questions[index]
    }
    
    func getCountQuestionCategory(category: String) -> Int {
        var index = 0
        for question in questionsBank.questions{
            if question.tema == category {
                index += 1
                
            }
        }
        return index
    }
    
    func getQuestionCategory(category: String) -> Void {
        var questionsArray = [Question]()
        for question in questionsBank.questions {
            if question.tema == category {
                questionsArray.append(question)
            }
        }
        questionsBank.questions = questionsArray
        
    }
    
    func getRandomQuestion() -> Question {
        let index  = Int(arc4random_uniform(UInt32(self.questionsBank.questions.count)))
        return self.questionsBank.questions[index]
    }
    
}
