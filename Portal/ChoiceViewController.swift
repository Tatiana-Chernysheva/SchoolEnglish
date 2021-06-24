//
//  ChoiceViewController.swift
//  Portal
//
//  Created by Lev Ivanov on 20.06.2021.
//

import UIKit
import CoreData

class ChoiceViewController: UIViewController, Words500ModelProtocol {
    //Properties
    var feedItems: NSArray = NSArray()
    //@IBOutlet weak var listTableView: UITableView!
    
    var exercises: [NSManagedObject] = []
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        print ("feedItems \(feedItems.count)")
        self.save(objects: feedItems)
        //self.listTableView.reloadData()
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
            let words500Model = Words500Model()
            words500Model.delegate = self
            words500Model.downloadItems()
        }
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func get500(_ sender: Any) {
    }
    
    @IBAction func get1000(_ sender: Any) {
    }
    
    func save(word: WordModel) {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }

      let managedContext = appDelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)!
      let exercise = NSManagedObject(entity: entity, insertInto: managedContext)
        exercise.setValue(word.id, forKeyPath: "id")
        exercise.setValue(word.english, forKeyPath: "english")
        exercise.setValue(word.transcription, forKeyPath: "transcription")
        exercise.setValue(word.translation, forKeyPath: "translation")

      do {
        try managedContext.save()
        exercises.append(exercise)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    //-------------------------------------------------------------------------------
    func save(objects: NSArray) {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
        
        for word in (objects as NSArray as! [WordModel]) {
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)!
            let exercise = NSManagedObject(entity: entity, insertInto: managedContext)
              exercise.setValue(word.id, forKeyPath: "id")
              exercise.setValue(word.english, forKeyPath: "english")
              exercise.setValue(word.transcription, forKeyPath: "transcription")
              exercise.setValue(word.translation, forKeyPath: "translation")
            do {
              try managedContext.save()
              exercises.append(exercise)
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
        print("exercises.count after save =  \(exercises.count)" )
        
    }
    //-------------------------------------------------------------------------------
}
