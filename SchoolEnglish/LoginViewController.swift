//
//  ViewController.swift
//
//  Created by  on 19.06.2021.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, LoadCoreDataModelProtocol  {
    //Properties
    var feedItems: NSArray = NSArray()
    var exercises: [NSManagedObject] = []
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        self.save(objects: feedItems)
        print ("LoginViewController func itemsDownloaded")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")

        do {
          exercises = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        print("exercises.count at start \(exercises.count)" )
        if (exercises.count == 0){
            // Do any additional setup after loading the view.
            print ("LoginViewController call LoadCoreDataModel")
            let coreDataModel = LoadCoreDataModel()
            coreDataModel.delegate = self
            coreDataModel.downloadItems()
        }
        print ("LoginViewController func viewDidLoad")
        
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

    }
    
    func save(exerciseToSave: ExerciseModel) {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }

      let managedContext = appDelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)!
      let exercise = NSManagedObject(entity: entity, insertInto: managedContext)
        exercise.setValue(exerciseToSave.id, forKeyPath: "id")
        exercise.setValue(exerciseToSave.clazz, forKeyPath: "clazz")
        exercise.setValue(exerciseToSave.title, forKeyPath: "title")
        exercise.setValue(exerciseToSave.ord, forKeyPath: "ord")
        exercise.setValue(exerciseToSave.question, forKeyPath: "question")
        exercise.setValue(exerciseToSave.transcription, forKeyPath: "transcription")
        exercise.setValue(exerciseToSave.answer, forKeyPath: "answer")

      do {
        try managedContext.save()
        exercises.append(exercise)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func save(objects: NSArray) {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
        
        for exerciseFor in (objects as NSArray as! [ExerciseModel]) {
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)!
            let exercise = NSManagedObject(entity: entity, insertInto: managedContext)
            exercise.setValue(exerciseFor.id, forKeyPath: "id")
            exercise.setValue(exerciseFor.clazz, forKeyPath: "clazz")
            exercise.setValue(exerciseFor.title, forKeyPath: "title")
            exercise.setValue(exerciseFor.ord, forKeyPath: "ord")
            exercise.setValue(exerciseFor.question, forKeyPath: "question")
            exercise.setValue(exerciseFor.transcription, forKeyPath: "transcription")
            exercise.setValue(exerciseFor.answer, forKeyPath: "answer")
            do {
              try managedContext.save()
              exercises.append(exercise)
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
        print("exercises.count after save =  \(exercises.count)" )
        
    }
    
    @IBAction func doLogin(_ sender: Any) {
        print ("LoginViewController func do login")
    }
    
    

}

