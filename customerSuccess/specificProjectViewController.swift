//
//  specificProjectViewController.swift
//  customerSuccess
//
//  Created by promact on 07/03/24.
//

import UIKit

class specificProjectViewController: UIViewController, UITextViewDelegate {
    var projectName = ""
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var objectives: UITextView!
    @IBOutlet weak var goals: UITextView!
    @IBOutlet weak var purpose: UITextView!
    @IBOutlet weak var projectbrief: UITextView!
    
    @IBOutlet weak var projectscope: UITextView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet var navigationButtons: [UIButton]!
    
    
    @IBOutlet weak var ssview: UIView!
    @IBOutlet weak var poview: UIView!
    var technologies = ["Backend","Front-end","Mobile app","Database"]
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLbl.text = projectName
        poview.alpha = 1
        ssview.alpha = 0
        tblView.isHidden = true
        dropButton.layer.cornerRadius = 5
        dropButton.layer.borderWidth = 1
        dropButton.layer.borderColor = UIColor.black.cgColor
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
          projectbrief.layer.borderWidth = 0.5
        projectbrief.layer.borderColor = borderColor.cgColor
          projectbrief.layer.cornerRadius = 5.0
        
        purpose.layer.borderWidth = 0.5
      purpose.layer.borderColor = borderColor.cgColor
        purpose.layer.cornerRadius = 5.0
        
        goals.layer.borderWidth = 0.5
      goals.layer.borderColor = borderColor.cgColor
        goals.layer.cornerRadius = 5.0
        
        objectives.layer.borderWidth = 0.5
      objectives.layer.borderColor = borderColor.cgColor
        objectives.layer.cornerRadius = 5.0
        
        projectscope.layer.borderWidth = 0.5
      projectscope.layer.borderColor = borderColor.cgColor
        projectscope.layer.cornerRadius = 5.0
        
        projectbrief.text = "Write project brief here"
        projectbrief.textColor = UIColor.lightGray
        projectbrief.font = UIFont(name: "verdana", size: 13.0)
        projectbrief.delegate = self
        
        purpose.text = "Write project purpose here"
        purpose.textColor = UIColor.lightGray
        purpose.font = UIFont(name: "verdana", size: 13.0)
        purpose.delegate = self
        
        goals.text = "Write project goals here"
        goals.textColor = UIColor.lightGray
        goals.font = UIFont(name: "verdana", size: 13.0)
        goals.delegate = self
        
        objectives.text = "Write project objectives here"
        objectives.textColor = UIColor.lightGray
        objectives.font = UIFont(name: "verdana", size: 13.0)
        objectives.delegate = self
        
        projectscope.text = "Write here"
        projectscope.textColor = UIColor.lightGray
        projectscope.font = UIFont(name: "verdana", size: 13.0)
        projectscope.delegate = self
        
        for button in navigationButtons {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
            button.addGestureRecognizer(tapGesture)
        }
    }
    @objc func buttonTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedButton = sender.view as? UIButton else { return }
        for button in navigationButtons {
            button.backgroundColor = UIColor.white
        }
        tappedButton.backgroundColor = UIColor(red: 204, green: 229, blue: 255)
    }

    @IBAction func pocontinue(_ sender: UIButton) {
        poview.alpha = 0
        ssview.alpha = 1
    }
    @IBAction func dropButtonTapped(_ sender: UIButton) {
        if tblView.isHidden{
            animate(toggle: true)
        }else{
            animate(toggle: false)
        }
    }
    
    func animate(toggle: Bool){
        if toggle{
            UIView.animate(withDuration: 0.3){
                self.tblView.isHidden = false
            }
        } else{
            UIView.animate(withDuration: 0.3){
                self.tblView.isHidden = true
            }
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == "Write project brief here" || textView.text == "Write project purpose here" || textView.text == "Write project goals here" || textView.text == "Write project objectives here" {
                textView.text = ""
                textView.textColor = UIColor.black
                textView.font = UIFont(name: "verdana", size: 18.0)
            }
        }
    func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = "Please enter something"
                textView.textColor = UIColor.lightGray
                textView.font = UIFont(name: "verdana", size: 13.0)
            }
        }
}

extension specificProjectViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return technologies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "techcell", for: indexPath)
        cell.textLabel?.text = technologies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropButton.setTitle("\(technologies[indexPath.row])", for: .normal)
        animate(toggle: false)
    }
}
