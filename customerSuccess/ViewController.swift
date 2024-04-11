//
//  ViewController.swift
//  customerSuccess
//
//  Created by promact on 04/03/24.
//

import UIKit

struct Projects: Codable {
    let _id: String
    let name: String
    let status: String
    let startDate: String
    let associatedManager: AssociatedManager
    struct AssociatedManager: Codable {
        let name: String
    }
        
}

struct MyProjects: Codable{
    let data: [Projects]
}

enum ProjectError: Error {
    case invalidURL
    case invalidResponse
}

var projects: [Projects] = []
let ongoingProjects = projects.filter { $0.status == "In progress" || $0.status == "On-Going" || $0.status == "Status" }
let CompletedProjects = projects.filter { $0.status == "Completed" || $0.status == "Status"}
let holdProjects = projects.filter { $0.status == "Hold" || $0.status == "Status"}

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newProject: UIButton!
    var sortCount = 0
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var tblLbl: UILabel!
    @IBOutlet weak var projectTableView: UITableView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var subLbl: UILabel!
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    var titleNames = ["Projects","Project Manager","Employees","Setting"]
    var images = ["office-bag","person","employees","settings"]
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var conatainerView: UIView!
    var viewOpen:Bool = true
    override func viewDidLoad(){
        super.viewDidLoad()
        registerTableCells()
        self.conatainerView.isHidden = true
        viewOpen = false
        searchBar.alpha = 1
        mainScrollView.alpha = 1
        profileImg.image = UIImage(named: "profile-pic")
        profileImg.layer.borderWidth=1.0
        profileImg.layer.masksToBounds = false
        profileImg.layer.borderColor = UIColor.white.cgColor
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2
        profileImg.clipsToBounds = true
        Task {
            do {
                projects = try await self.getProjects().data
                DispatchQueue.main.async {
                    self.projectTableView.reloadData()
                }
            } catch {
                print("Error fetching projects: \(error)")
            }
        }
    }

    func registerTableCells(){
        tableView1.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        projectTableView.register(UINib(nibName: "projectTableViewCell", bundle: nil), forCellReuseIdentifier: "projectTableViewCell")
    }
    
    func getProjects() async throws -> MyProjects {
        var components = URLComponents(string: "http://localhost:8000/projects")!
        components.queryItems = [
            URLQueryItem(name: "role", value: "Admin"),
            URLQueryItem(name: "id", value: "auth0|660ea405f5c5f28eda8b900a")
        ]

        guard let url = components.url else {
            print("Invalid URL components")
            throw ProjectError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ProjectError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let projects = try decoder.decode(MyProjects.self, from: data)
            return projects
        } catch {
            print("Error fetching projects:", error)
            throw error
        }
    }
   
    @IBAction func buttonTapped(_ sender: UIButton) {
        conatainerView.isHidden = false
        tableView1.isHidden = false
        if !viewOpen{
            searchBar.alpha = 0
            mainScrollView.alpha = 0
            viewOpen = true
            conatainerView.frame = CGRect(x: 0, y: 103, width: 0, height: 749)
            tableView1.frame = CGRect(x: 0, y: 0, width: 0, height: 749)
            newProject.frame = CGRect(x: 8, y: 74.7, width: 0, height: 50)
            profileImg.frame = CGRect(x: 8, y: 8, width: 0, height: 74)
            mainLbl.frame = CGRect(x: 98, y: 8, width: 0, height: 24)
            subLbl.frame = CGRect(x: 98, y: 44, width: 0, height: 20.33)
            UIView.animate(withDuration: 1.5){
                self.conatainerView.frame = CGRect(x: 0, y: 103, width: 282, height: 749)
                self.tableView1.frame = CGRect(x: 0, y: 0, width: 282, height: 749)
                self.newProject.frame = CGRect(x: 8, y: 74.7, width: self.conatainerView.frame.width - 16, height: 50)
                self.newProject.titleLabel?.frame = self.newProject.bounds
                self.profileImg.frame = CGRect(x: 8, y: 8, width: 74, height: 74)
            }
            UIView.animate(withDuration: 2.5, delay: 0.8, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5){
                self.mainLbl.frame = CGRect(x: 98, y: 8, width: 176, height: 24)
                self.subLbl.frame = CGRect(x: 98, y: 44, width: 176, height: 20.33)
            }
        }else{
            searchBar.alpha = 1
            mainScrollView.alpha = 1
            conatainerView.isHidden = true
            tableView1.isHidden = true
            viewOpen = false
            conatainerView.frame = CGRect(x: 0, y: 103, width: 282, height: 749)
            tableView1.frame = CGRect(x: 0, y: 0, width: 282, height: 749)
            UIView.animate(withDuration: 1){
                self.conatainerView.frame = CGRect(x: 0, y: 103, width: 0, height: 749)
                self.tableView1.frame = CGRect(x: 0, y: 0, width: 0, height: 749)
            }
        }
    }
    
    @IBAction func sortTapped(_ sender: UIButton) {
        sortCount += 1
        if (sortCount % 4 == 0) {
            tblLbl.text = "All projects"
        }
        else if(sortCount % 4 == 1){
            tblLbl.text = "In progress & On-Going"
        }
        else if(sortCount % 4 == 2){
            tblLbl.text = "Completed"
        }
        else{
            tblLbl.text = "Hold"
        }
        projectTableView.reloadData()
    }
    
    @IBAction func newProjectTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "projectDetailsScreen") as! projectDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
                    return titleNames.count
                } else {
                    if (sortCount % 4 == 0) {
                        return projects.count
                    }
                    else if(sortCount % 4 == 1){
                        return ongoingProjects.count
                    }
                    else if(sortCount % 4 == 2){
                        return CompletedProjects.count
                    }
                    else{
                        return holdProjects.count
                    }
                }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableView1{
            let cell = tableView1.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.titleLbl.text = titleNames[indexPath.row]
            cell.imageIcon.image = UIImage(named: images[indexPath.row])
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(red: 204, green: 229, blue: 255)
            cell.selectedBackgroundView = backgroundView
            return cell
        }else{
            let cell = projectTableView.dequeueReusableCell(withIdentifier: "projectTableViewCell") as! projectTableViewCell
            if (sortCount % 4 == 0){
                let project = projects[indexPath.row]
                cell.column1.text = project.name
                cell.column2.text = project.startDate
                cell.column3.text = project.status
                if project.status == "On-Going" || project.status == "In progress" {
                    cell.column3.backgroundColor = UIColor(red: 37, green: 135, blue: 79)
                    cell.column3.textColor = UIColor.white
                } else if project.status == "Completed" {
                        cell.column3.backgroundColor = UIColor(red: 216, green: 58, blue: 82)
                    cell.column3.textColor = UIColor.white
                    } else if project.status == "Hold" {
                        cell.column3.backgroundColor = UIColor(red: 50, green: 51, blue: 56)
                        cell.column3.textColor = UIColor.white
                    } else {
                        cell.column3.backgroundColor = UIColor.white
                        cell.column3.textColor = UIColor.black
                    }
                cell.column4.text = project.associatedManager.name
                return cell
            }else if(sortCount % 4 == 1){
                let project = ongoingProjects[indexPath.row]
                cell.column1.text = project.name
                cell.column2.text = project.startDate
                cell.column3.text = project.status
                if project.status == "On-Going" || project.status == "In progress" {
                    cell.column3.backgroundColor = UIColor(red: 37, green: 135, blue: 79)
                    cell.column3.textColor = UIColor.white
                } else if project.status == "Completed" {
                        cell.column3.backgroundColor = UIColor(red: 216, green: 58, blue: 82)
                    cell.column3.textColor = UIColor.white
                    } else if project.status == "Hold" {
                        cell.column3.backgroundColor = UIColor(red: 50, green: 51, blue: 56)
                        cell.column3.textColor = UIColor.white
                    } else {
                        cell.column3.backgroundColor = UIColor.white
                        cell.column3.textColor = UIColor.black
                    }
                cell.column4.text = project.associatedManager.name
                return cell
            }else if(sortCount % 4 == 2){
                let project = CompletedProjects[indexPath.row]
                cell.column1.text = project.name
                cell.column2.text = project.startDate
                cell.column3.text = project.status
                if project.status == "On-Going" || project.status == "In progress" {
                    cell.column3.backgroundColor = UIColor(red: 37, green: 135, blue: 79)
                    cell.column3.textColor = UIColor.white
                } else if project.status == "Completed" {
                        cell.column3.backgroundColor = UIColor(red: 216, green: 58, blue: 82)
                    cell.column3.textColor = UIColor.white
                    } else if project.status == "Hold" {
                        cell.column3.backgroundColor = UIColor(red: 50, green: 51, blue: 56)
                        cell.column3.textColor = UIColor.white
                    } else {
                        cell.column3.backgroundColor = UIColor.white
                        cell.column3.textColor = UIColor.black
                    }
                cell.column4.text = project.associatedManager.name
                return cell
            }else{
                let project = holdProjects[indexPath.row]
                cell.column1.text = project.name
                cell.column2.text = project.startDate
                cell.column3.text = project.status
                if project.status == "On-Going" || project.status == "In progress" {
                    cell.column3.backgroundColor = UIColor(red: 37, green: 135, blue: 79)
                    cell.column3.textColor = UIColor.white
                } else if project.status == "Completed" {
                        cell.column3.backgroundColor = UIColor(red: 216, green: 58, blue: 82)
                    cell.column3.textColor = UIColor.white
                    } else if project.status == "Hold" {
                        cell.column3.backgroundColor = UIColor(red: 50, green: 51, blue: 56)
                        cell.column3.textColor = UIColor.white
                    } else {
                        cell.column3.backgroundColor = UIColor.white
                        cell.column3.textColor = UIColor.black
                    }
                cell.column4.text = project.associatedManager.name
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == projectTableView{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "specificProjectScreen") as! specificProjectViewController
            let project = projects[indexPath.row]
            vc.projectId = project._id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let indexPath = NSIndexPath(row: 0, section: 0)
        tableView1.selectRow(at: indexPath as IndexPath, animated: false, scrollPosition: .none)
      }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
