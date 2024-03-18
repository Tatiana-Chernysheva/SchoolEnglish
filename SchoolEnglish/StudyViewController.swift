//
//  Word500ControllerViewController.swift
//
//  Created by  on 24.06.2021.
//

import UIKit
import CoreData

class StudyViewController: UIViewController {
    var clazz:String = ""
    var exercises: [NSManagedObject] = []
    var resultsUnwrapped :[Exercise] = []
    var i = 0
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var transcription: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var count: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("StudyViewController viewDidLoad")
        // Do any additional setup after loading the view.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Exercise>(entityName: "Exercise")
        fetchRequest.predicate = NSPredicate(format: "clazz == %@", clazz)
        print("StudyViewController viewDidLoad  \(clazz)")

        do {
          exercises = try managedContext.fetch(fetchRequest)
            resultsUnwrapped = (exercises as? [Exercise])!
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        setCard ()

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller
        print ("StudyViewController prepare")
    }
    
    @IBAction func nextExercise(_ sender: Any) {
        if (i == resultsUnwrapped.count){
            dismiss(animated: true, completion: nil)
        }else{
            setCard ()
        }

    }
    
    func setCard () -> Void {
        let test = resultsUnwrapped[i]
        self.question.text = test.question
        self.transcription.text = test.transcription
        self.answer.text = test.answer
        i+=1
        self.count.text = "Карточка \(i) из \(resultsUnwrapped.count)"
    }
}
