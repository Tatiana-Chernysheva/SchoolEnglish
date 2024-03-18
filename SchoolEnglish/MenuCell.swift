//
//  MenuCellTableViewCell.swift
//  SchoolEnglish
//
//  Created by on 09.07.2021.
//

import UIKit

class MenuCell: UITableViewCell {
        
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var clazz: UILabel!
    @IBOutlet weak var addStudy: UIButton!
    @IBOutlet weak var addTest: UIButton!
    
    var addActionHandlerStudy: (() -> Void)?
    var addActionHandlerTest: (() -> Void)?
        
    @IBAction func goStudy(_ sender: Any) {
        self.addActionHandlerStudy?()
    }

    @IBAction func goTest(_ sender: Any) {
        self.addActionHandlerTest?()
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        //print("MenuCell awakeFromNib")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
