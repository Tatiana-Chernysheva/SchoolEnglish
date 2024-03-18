//
//  ResultViewController.swift
//  SchoolEnglish
//
//  Created by Lev Ivanov on 09.07.2021.
//

import UIKit

class ResultViewController: UIViewController {

    var resultValue:String = ""
    @IBOutlet weak var result: UILabel!
    
    var i = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        self.result.text = resultValue
 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
