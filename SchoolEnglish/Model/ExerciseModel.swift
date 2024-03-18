//
//  WordModel.swift
//
//  Created by  on 22.06.2021.
//

import UIKit

class ExerciseModel: NSObject {
    //properties
    var id: Int16?
    var clazz: Int16?
    var title: String?
    var ord: Int16?
    var question: String?
    var transcription: String?
    var answer: String?
    
    
    //empty constructor
    override init()
    {
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    init(id: Int16, clazz: Int16, title: String, ord: Int16, question: String, transcription: String, answer: String) {
        self.id = id
        self.clazz = clazz
        self.title = title
        self.ord = ord
        self.question = question
        self.transcription = transcription
        self.answer = answer
    }
    
    //prints object's current state
    override var description: String {
        return "Id: \(id), Clazz: \(clazz), Title: \(title), Ord: \(ord), Question: \(question), Transcription: \(transcription), Answer: \(answer)"
    }
    
}
