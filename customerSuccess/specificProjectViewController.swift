//
//  specificProjectViewController.swift
//  customerSuccess
//
//  Created by promact on 07/03/24.
//

import UIKit

struct Budget: Codable{
    var type: String
    var typeValue: String
}
struct ProjectDetails: Codable{
    var _id: String
    var name: String
    var stack: String
    var scope: String
    var status: String
    var startDate: String
    var overview: String
    var timeline: String
    var associatedManager: AssociatedManager
    var budget: Budget
}

struct Myproject: Codable{
    var data: [ProjectDetails]
}
enum ProjectDetailsError: Error {
    case invalidURL
    case invalidResponse
}
var project: [ProjectDetails] = []
class specificProjectViewController: UIViewController, UITextViewDelegate {
    var projectName = ""
    var projectId = ""
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var objectives: UITextView!
    @IBOutlet weak var goals: UITextView!
    @IBOutlet weak var purpose: UITextView!
    @IBOutlet weak var projectbrief: UITextView!
    
    @IBOutlet weak var tblView3: UITableView!
    @IBOutlet weak var tblView2: UITableView!
    @IBOutlet weak var tblView1: UITableView!
    @IBOutlet weak var projectscope: UITextView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet var navigationButtons: [UIButton]!
    
    var initiallySelectedButtonIndex: Int = 0
    @IBOutlet weak var emview: UIView!
    @IBOutlet weak var ssview: UIView!
    @IBOutlet weak var poview: UIView!
    var technologies = ["Backend","Front-end","Mobile app","Database"]
    
    var escalationLevel = ["Escalation matrix","Level1","Level2","Level3"]
    var name = ["Name","Dipa Manjumdar","Dipa Manjumdar","Dipa Manjumdar"]
    var role = ["Role","Project Manager","Project Manager","Project Manager"]
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                project = try await self.getProjectDetails(projectId: projectId).data
                DispatchQueue.main.async {
                    self.mainLbl.text = project[0].name
                }
                print(project)
            } catch {
                print("Error fetching projects: \(error)")
            }
        }
        poview.alpha = 1
        ssview.alpha = 0
        emview.alpha = 0
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
        
        if initiallySelectedButtonIndex < navigationButtons.count {
                    let initiallySelectedButton = navigationButtons[initiallySelectedButtonIndex]
                    initiallySelectedButton.backgroundColor = UIColor(red: 204, green: 229, blue: 255)
                }
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
        if let title = tappedButton.titleLabel?.text {
            if(title == "Stack & scope"){
                poview.alpha = 0
                ssview.alpha = 1
                emview.alpha = 0
            }else if (title == "Escalation matrix"){
                poview.alpha = 0
                ssview.alpha = 0
                emview.alpha = 1
            }else if (title == "Project overview"){
                poview.alpha = 1
                ssview.alpha = 0
                emview.alpha = 0
            }
            }
    }

    @IBAction func pocontinue(_ sender: UIButton) {
        poview.alpha = 0
        ssview.alpha = 1
        emview.alpha = 0
    }
    
    
    @IBAction func sscontinue(_ sender: UIButton) {
        poview.alpha = 0
        ssview.alpha = 0
        emview.alpha = 1
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
//    func getProjectManagers() async throws -> ProjectDetails {
//        var components = URLComponents(string: "http://localhost:8000/getManagers")!
//        components.queryItems = [
//            URLQueryItem(name: "role_id", value: "rol_qLO42FIvSNsdZEO4")
//        ]
//
//        guard let url = components.url else {
//            print("Invalid URL components")
//            throw ProjectDetailsError.invalidURL
//        }
//        do {
//            let (data, response) = try await URLSession.shared.data(from: url)
//
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                throw ProjectDetailsError.invalidResponse
//            }
//
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//            let project_details = try decoder.decode(ProjectDetails.self, from: data)
//            return project_details
//        } catch {
//            print("Error fetching projects:", error)
//            throw error
//        }
//    }
    func getProjectDetails(projectId: String) async throws -> Myproject {
        guard let url = URL(string: "http://localhost:8000/project/\(projectId)/project_details") else {
            print("Invalid URL")
            throw ProjectDetailsError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ProjectDetailsError.invalidResponse
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let project_details = try decoder.decode(Myproject.self, from: data)
            return project_details
        } catch {
            print("Error fetching project managers:", error)
            throw error
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
        if tableView == tblView{
            return technologies.count
        }
        else{
            return escalationLevel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "techcell", for: indexPath)
            cell.textLabel?.text = technologies[indexPath.row]
            return cell
        }
        else if(tableView == tblView1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellone") as! commonTableViewCell1
            cell.column1.text = escalationLevel[indexPath.row]
            cell.column2.text = name[indexPath.row]
            cell.column3.text = role[indexPath.row]
            return cell
        }
        else if(tableView == tblView2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "celltwo") as! commonTableViewCell2
            cell.column1.text = escalationLevel[indexPath.row]
            cell.column2.text = name[indexPath.row]
            cell.column3.text = role[indexPath.row]
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellthree") as! commonTableViewCell3
            cell.column1.text = escalationLevel[indexPath.row]
            cell.column2.text = name[indexPath.row]
            cell.column3.text = role[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropButton.setTitle("\(technologies[indexPath.row])", for: .normal)
        animate(toggle: false)
    }
}
