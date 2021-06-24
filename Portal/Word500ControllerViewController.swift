//
//  Word500ControllerViewController.swift
//  Portal
//
//  Created by Lev Ivanov on 24.06.2021.
//

import UIKit
import CoreData

class Word500ControllerViewController: UIViewController {
    
    var exercises: [NSManagedObject] = []
    var resultsUnwrapped :[Exercise] = []
    var i = 0
    @IBOutlet weak var english: UILabel!
    @IBOutlet weak var transcription: UILabel!
    @IBOutlet weak var translation: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Exercise>(entityName: "Exercise")

        do {
          exercises = try managedContext.fetch(fetchRequest)
            resultsUnwrapped = (exercises as? [Exercise])!
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        print("exercises.count at 500 screen \(exercises.count)" )
        
        
        let word = resultsUnwrapped.randomElement()
        self.english.text = word?.english
        self.transcription.text = word?.transcription
        //translation

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func nextExercise(_ sender: Any) {
        let word = resultsUnwrapped.randomElement()
        self.english.text = word?.english
        self.transcription.text = word?.transcription
    }
    
}
