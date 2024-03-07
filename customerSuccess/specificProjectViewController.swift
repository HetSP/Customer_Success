//
//  specificProjectViewController.swift
//  customerSuccess
//
//  Created by promact on 07/03/24.
//

import UIKit

class specificProjectViewController: UIViewController {
    var projectName = ""
    @IBOutlet weak var mainLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLbl.text = projectName
    }
}
