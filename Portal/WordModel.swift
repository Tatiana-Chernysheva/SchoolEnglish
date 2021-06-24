//
//  WordModel.swift
//  Portal
//
//  Created by Lev Ivanov on 22.06.2021.
//

import UIKit

class WordModel: NSObject {
    //properties
    var id: Int16?
    var english: String?
    var transcription: String?
    var translation: String?
    
    
    //empty constructor
    override init()
    {
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    init(id: Int16, english: String, transcription: String, translation: String) {
        self.id = id
        self.english = english
        self.transcription = transcription
        self.translation = translation
    }
    
    //prints object's current state
    override var description: String {
        return "Name: \(id), Address: \(english), Latitude: \(transcription), Longitude: \(translation)"
    }
    
}
