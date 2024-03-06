//
//  inviteClientViewController.swift
//  customerSuccess
//
//  Created by promact on 06/03/24.
//

import UIKit

class inviteClientViewController: UIViewController {

    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var addButton: UIButton!
    var textFieldCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 5
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.black.cgColor
    }
    @IBAction func addTapped(_ sender: UIButton) {
        textFieldCount += 1
        let label1 = UILabel()
        label1.text = "Client name"
        let textField1 = UITextField()
        textField1.placeholder = "Name here"
        textField1.borderStyle = .roundedRect
        
        textFieldCount += 1
        let label2 = UILabel()
        label2.text = "Client email"
        let textField2 = UITextField()
        textField2.placeholder = "example@work.com"
        textField2.borderStyle = .roundedRect
        
        stackView.insertArrangedSubview(label1, at: stackView.arrangedSubviews.count - 2)
        stackView.insertArrangedSubview(textField1, at: stackView.arrangedSubviews.count - 2)
        stackView.insertArrangedSubview(label2, at: stackView.arrangedSubviews.count - 2)
        stackView.insertArrangedSubview(textField2, at: stackView.arrangedSubviews.count - 2)
    }
    @IBAction func sendinviteTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "selectProjectManagerScreen") as! selectProjectMangerViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
