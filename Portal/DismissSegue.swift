//
//  DismissSegue.swift
//  Portal
//
//  Created by Lev Ivanov on 20.06.2021.
//

import UIKit

class DismissSegue: UIStoryboardSegue {
    override func perform() {
        self.source.presentingViewController?.dismiss(animated: true, completion: nil)
   }
}
