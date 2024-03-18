//
//  TestViewController.swift
//  SchoolEnglish
//
//  Created by Lev Ivanov on 09.07.2021.
//

import UIKit
import CoreData

class TestViewController: UIViewController {
    var clazz:String = ""
    var exercises: [NSManagedObject] = []
    var resultsUnwrapped :[Exercise] = []
    var i = 0
    var right = 0 as Int
    var right_count = 0 as Int
    var res = 0 as Int
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var transcription: UILabel!
    

    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    @IBOutlet weak var count: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Exercise>(entityName: "Exercise")
        fetchRequest.predicate = NSPredicate(format: "clazz == %@", clazz)
        
        do {
          exercises = try managedContext.fetch(fetchRequest)
            resultsUnwrapped = (exercises as? [Exercise])!
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        print("exercises.count \(exercises.count)" )
        
        makeQestion ()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func answer1(_ sender: Any) {
        checkAnswer(1);
        makeQestion();
    }
    
    @IBAction func answer2(_ sender: Any) {
        checkAnswer(2);
        makeQestion();
    }
    @IBAction func answer3(_ sender: Any) {
        checkAnswer(3);
        makeQestion();
    }
    @IBAction func answer4(_ sender: Any) {
        checkAnswer(4);
        makeQestion();
    }
    
    func makeQestion () -> Int {
        var index = 0 as Int
        

        if (i == resultsUnwrapped.count) {
            return -1;
        }
        if (resultsUnwrapped.count != 0) {

            right = Int.random(in: 1..<5)
            question.text = resultsUnwrapped[i].question
            transcription.text = resultsUnwrapped[i].transcription
            if (right == 1) {
                answer1.setTitle(resultsUnwrapped[i].answer, for: .normal)
                index = i+1 < resultsUnwrapped.count ? i+1 : 0;
                answer2.setTitle(resultsUnwrapped[index].answer, for: .normal)
                index = i+2 < resultsUnwrapped.count ? i+2 : 0;
                answer3.setTitle(resultsUnwrapped[index].answer, for: .normal)
                index = i+3 < resultsUnwrapped.count ? i+3 : 0;
                answer4.setTitle(resultsUnwrapped[index].answer, for: .normal)

            }
            if (right == 2) {
                index = i+1 < resultsUnwrapped.count ? i+1 : 0;
                answer1.setTitle(resultsUnwrapped[index].answer, for: .normal)
                answer2.setTitle(resultsUnwrapped[i].answer, for: .normal)
                index = i+2 < resultsUnwrapped.count ? i+2 : 0;
                answer3.setTitle(resultsUnwrapped[index].answer, for: .normal)
                index = i+3 < resultsUnwrapped.count ? i+3 : 0;
                answer4.setTitle(resultsUnwrapped[index].answer, for: .normal)

            }
            if (right == 3) {
                index = i+1 < resultsUnwrapped.count ? i+1 : 0;
                answer1.setTitle(resultsUnwrapped[index].answer, for: .normal)
                index = i+2 < resultsUnwrapped.count ? i+2 : 0;
                answer2.setTitle(resultsUnwrapped[index].answer, for: .normal)
                answer3.setTitle(resultsUnwrapped[i].answer, for: .normal)
                index = i+3 < resultsUnwrapped.count ? i+3 : 0;
                answer4.setTitle(resultsUnwrapped[index].answer, for: .normal)
            }
            if (right == 4) {
                index = i+1 < resultsUnwrapped.count ? i+1 : 0;
                answer1.setTitle(resultsUnwrapped[index].answer, for: .normal)
                index = i+2 < resultsUnwrapped.count ? i+2 : 0;
                answer2.setTitle(resultsUnwrapped[index].answer, for: .normal)
                index = i+3 < resultsUnwrapped.count ? i+3 : 0;
                answer3.setTitle(resultsUnwrapped[index].answer, for: .normal)
                answer4.setTitle(resultsUnwrapped[i].answer, for: .normal)
            }
        }
        i+=1
        count.text = "Карточка \(i) из \(resultsUnwrapped.count)"
        return 0;
    }
    
    func checkAnswer(_ answer: Int16) -> Void{
        if (answer == right){
            right_count+=1;
        }
        if (i == resultsUnwrapped.count){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newVC = storyboard.instantiateViewController(withIdentifier: "result" ) as! ResultViewController
            newVC.resultValue = "Количество правильных ответов \(right_count) из \(resultsUnwrapped.count)"
            self.present(newVC, animated: true, completion: nil )
            //self.dismiss(animated: true, completion: nil)
        }
    }
}
