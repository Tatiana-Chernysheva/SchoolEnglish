//
//  ChoiceTableViewController.swift
//  SchoolEnglish
//
//  Created by on 09.07.2021.
//

import UIKit
import CoreData

class ChoiceTableViewController: UITableViewController {
    
    var exercises: [NSManagedObject] = []
    var resultsUnwrapped :[Exercise] = []
    var res: [[String: String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        print("ChoiceTableViewController viewDidLoad" )
        
        // Do any additional setup after loading the view.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        fetchRequest.propertiesToFetch = ["title"]
        fetchRequest.returnsDistinctResults = true
        fetchRequest.resultType = .dictionaryResultType

        res = try! (managedContext.fetch(fetchRequest) as? [[String: String]])!
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return res.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MenuCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! MenuCell
        
        let exercise = res[indexPath.row]
        let title = exercise["title"]! as String
        let firstSpace = title.firstIndex(of: " ") ?? title.endIndex
        let clazz = String(title[..<firstSpace]) as String
        cell.title?.text = title
        cell.clazz?.text = clazz
        cell.addActionHandlerStudy = {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newVC = storyboard.instantiateViewController(withIdentifier: "study" ) as! StudyViewController
            newVC.clazz = (cell.clazz?.text)!
            self.present(newVC, animated: true, completion: nil )

        }
        cell.addActionHandlerTest = {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newVC = storyboard.instantiateViewController(withIdentifier: "test" ) as! TestViewController
            newVC.clazz = (cell.clazz?.text)!
            self.present(newVC, animated: true, completion: nil )
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("ChoiceTableViewController prepare" )
    }


}
