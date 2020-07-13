//
//  Question.swift
//  05-Quiz App
//
//  Created by Ricardo Sanchez on 7/1/20.
//  Copyright © 2020 Ricardo Sanchez. All rights reserved.
//

import Foundation

class Question : CustomStringConvertible, Codable {
    
    
    
    let question: String
    let answer : Bool
    let image : String?
    let tema : String
    
//    enum CodinKeys : String, CodingKey {
//        case questionText = "question"
//        case answer = "answer"
//    }
    
    var description : String {
        let respuesta = (answer ? "Verdadera" : "Falso")
        if image != nil{
            return """
                Pregunta:
                -\(question)
                -   Respuesta : \(respuesta)
                - imagen : \(image!)
                - tema : \(tema)
            """ }
            
            
            else {return """
                Pregunta:
                -\(question)
                -   Respuesta : \(respuesta)
                -   Tema : \(tema)
            """ }
        
    }
    
    
    init(text: String, correctAnswer: Bool , imagen: String?, tema: String) {
        self.question = text
        self.answer = correctAnswer
        self.image = imagen
        self.tema = tema
    }
}


struct QuestionsBank : Codable {
    var questions : [Question]
    
    
    
}

