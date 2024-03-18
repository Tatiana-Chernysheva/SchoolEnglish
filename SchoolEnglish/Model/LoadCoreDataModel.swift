//
//  Words500Model.swift
//
//  Created by  on 22.06.2021.
//

import UIKit

protocol LoadCoreDataModelProtocol: AnyObject {
    func itemsDownloaded(items: NSArray)
}

class LoadCoreDataModel: NSObject {

    //properties
    weak var delegate: LoadCoreDataModelProtocol!
    
    let urlPath = "http://i91547zx.beget.tech/SchoolEnglish/get_all_exercises_iOS.php"
 
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["User-Agent": "Mozilla/5.0"]
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }

    func parseJSON(_ data:Data) {
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let exercises = NSMutableArray()
        
        //print("parseJSON")
        //print("jsonResult.count = \(jsonResult.count)")
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let exercise = ExerciseModel()
    
            //the following insures none of the JsonElement values are nil through optional binding
            if let id = jsonElement["id"] as? String,
                let clazz = jsonElement["class"] as? String,
                let title = jsonElement["title"] as? String,
                let ord = jsonElement["ord"] as? String,
                let question = jsonElement["question"] as? String,
                let transcription = jsonElement["transcription"] as? String,
                let answer = jsonElement["answer"] as? String
            {
                
                exercise.id = Int16(id)
                exercise.clazz = Int16(clazz)
                exercise.title = title
                exercise.ord = Int16(ord)
                exercise.question = question
                exercise.transcription = transcription
                exercise.answer = answer
                
                exercises.add(exercise)
            }
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.itemsDownloaded(items: exercises)
        })
    }

}
