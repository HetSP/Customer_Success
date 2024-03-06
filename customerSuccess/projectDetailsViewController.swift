//
//  projectDetailsViewController.swift
//  customerSuccess
//
//  Created by promact on 06/03/24.
//

import UIKit

class projectDetailsViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var objectives: UITextView!
    @IBOutlet weak var goals: UITextView!
    @IBOutlet weak var purpose: UITextView!
    @IBOutlet weak var projectbrief: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
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
    }
    
    @IBAction func continueTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "inviteClientScreen") as! inviteClientViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
