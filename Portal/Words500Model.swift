//
//  Words500Model.swift
//  Portal
//
//  Created by Lev Ivanov on 22.06.2021.
//

import UIKit

protocol Words500ModelProtocol: AnyObject {
    func itemsDownloaded(items: NSArray)
}

class Words500Model: NSObject {

    //properties
    weak var delegate: Words500ModelProtocol!
    
    let urlPath = "http://i91547zx.beget.tech/portal/get_all_words500iOS.php" //this will be changed to the path where service.php lives
 
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
        let words = NSMutableArray()
        
        //print("parseJSON")
        //print("jsonResult.count = \(jsonResult.count)")
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let word = WordModel()
    
            //the following insures none of the JsonElement values are nil through optional binding
            if let id = jsonElement["id"] as? String,
                let english = jsonElement["english"] as? String,
                let transcription = jsonElement["transcription"] as? String,
                let translation = jsonElement["translation"] as? String
            {
                
                word.id = Int16(id)
                word.english = english
                word.transcription = transcription
                word.translation = translation
            }
            words.add(word)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.itemsDownloaded(items: words)
        })
    }

}
