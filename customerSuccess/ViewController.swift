//
//  ViewController.swift
//  customerSuccess
//
//  Created by promact on 04/03/24.
//

import UIKit

class Project {
    var name: String
    var date: String
    var status: String
    var manager: String
    var members: String
    
    init(name: String, date: String, status: String, manager: String, members: String) {
        self.name = name
        self.date = date
        self.status = status
        self.manager = manager
        self.members = members
    }
}

let project1 = Project(name: "Project Name", date: "Started On", status: "Status", manager: "Project Manager", members: "Members")
let project2 = Project(name: "Food on Time", date: "12 Feb 24", status: "On going", manager: "Dipa Manjumdar", members: "6")
let project3 = Project(name: "2023-01-01", date: "1 Jan 24", status: "Closed", manager: "Dipa Manjumdar", members: "12")
let project4 = Project(name: "2023-01-01", date: "Placeholder for...", status: "In progress", manager: "Dipa Manjumdar", members: "14")
let project5 = Project(name: "2023-01-01", date: "Placeholder for...", status: "In progress", manager: "Dipa Manjumdar", members: "4")
let project6 = Project(name: "2023-01-01", date: "Placeholder for...", status: "In progress", manager: "Rohit Shah", members: "30")
let project7 = Project(name: "2023-01-01", date: "Placeholder for...", status: "Hold", manager: "Rohit Shah", members: "20")
let project8 = Project(name: "2023-01-01", date: "Placeholder for...", status: "In progress", manager: "Rohit Shah", members: "13")
let project9 = Project(name: "2023-01-01", date: "Placeholder for...", status: "In progress", manager: "Rohit Shah", members: "9")
let project10 = Project(name: "2023-01-01", date: "Placeholder for...", status: "Closed", manager: "Rohit Shah", members: "100")
let project11 = Project(name: "2023-01-01", date: "Placeholder for...", status: "Closed", manager: "Rohit Shah", members: "100")
let project12 = Project(name: "2023-01-01", date: "Placeholder for...", status: "Closed", manager: "Rohit Shah", members: "100")
var projects: [Project] = [project1, project2, project3, project4, project5, project6, project7, project8, project9, project10, project11, project12]
let ongoingProjects = projects.filter { $0.status == "In progress" || $0.status == "On going" }
let closedProjects = projects.filter { $0.status == "Closed" }
let holdProjects = projects.filter { $0.status == "Hold" }


class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
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
    
//    var projectName = ["Project Name","Food on Time","2023-01-01","2023-01-01","2023-01-01","2023-01-01","2023-01-01","2023-01-01","2023-01-01","2023-01-01","2023-01-01","2023-01-01"]
//    var startedOn = ["Started On","12 Feb 24","1 Jan 24","Placeholder for...","Placeholder for...","Placeholder for...","Placeholder for...","Placeholder for...","Placeholder for...","Placeholder for...","Placeholder for...","Placeholder for..."]
//    var status = ["Status","On going","Closed","In progress","In progress","In progress","Hold","In progress","In progress","Closed","Closed","Closed"]
//    var pm = ["Project Manager","Dipa Manjumdar","Dipa Manjumdar","Dipa Manjumdar","Dipa Manjumdar","Rohit Shah","Rohit Shah","Rohit Shah","Rohit Shah","Rohit Shah","Rohit Shah","Rohit Shah"]
//    var members = ["Members","6","12","14","4","30","20","13","9","100","100","100"]
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var conatainerView: UIView!
    var viewOpen:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        registerTableCells()
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
    }

    func registerTableCells(){
        tableView1.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
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
            UIView.animate(withDuration: 1){
                self.conatainerView.frame = CGRect(x: 0, y: 103, width: 282, height: 749)
                self.tableView1.frame = CGRect(x: 0, y: 0, width: 282, height: 749)
            }
            profileImg.alpha = 1
            mainLbl.alpha = 1
            subLbl.alpha = 1
        }else{
            searchBar.alpha = 1
            mainScrollView.alpha = 1
            conatainerView.isHidden = true
            tableView1.isHidden = true
            viewOpen = false
            conatainerView.frame = CGRect(x: 0, y: 103, width: 0, height: 749)
            tableView1.frame = CGRect(x: 0, y: 0, width: 0, height: 749)
            UIView.animate(withDuration: 1){
                self.conatainerView.frame = CGRect(x: 0, y: 103, width: 282, height: 749)
                self.tableView1.frame = CGRect(x: 0, y: 0, width: 282, height: 749)
            }
        }
    }
    
    @IBAction func sortTapped(_ sender: UIButton) {
        sortCount += 1
        if (sortCount % 4 == 0) {
            tblLbl.text = "All projects"
        }
        else if(sortCount % 4 == 1){
            tblLbl.text = "In progress & On going"
        }
        else if(sortCount % 4 == 2){
            tblLbl.text = "Closed"
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
                        return closedProjects.count
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
            let cell = projectTableView.dequeueReusableCell(withIdentifier: "cell") as! projectTableViewCell
            if (sortCount % 4 == 0){
                let project = projects[indexPath.row]
                cell.column1.text = project.name
                cell.column2.text = project.date
                cell.column3.text = project.status
                if project.status == "On going" || project.status == "In progress" {
                    cell.column3.backgroundColor = UIColor(red: 37, green: 135, blue: 79)
                    cell.column3.textColor = UIColor.white
                } else if project.status == "Closed" {
                        cell.column3.backgroundColor = UIColor(red: 216, green: 58, blue: 82)
                    cell.column3.textColor = UIColor.white
                    } else if project.status == "Hold" {
                        cell.column3.backgroundColor = UIColor(red: 50, green: 51, blue: 56)
                        cell.column3.textColor = UIColor.white
                    } else {
                        cell.column3.backgroundColor = UIColor.white
                        cell.column3.textColor = UIColor.black
                    }
                cell.column4.text = project.manager
                cell.column5.text = project.members
                return cell
            }else if(sortCount % 4 == 1){
                let project = ongoingProjects[indexPath.row]
                cell.column1.text = project.name
                cell.column2.text = project.date
                cell.column3.text = project.status
                if project.status == "On going" || project.status == "In progress" {
                    cell.column3.backgroundColor = UIColor(red: 37, green: 135, blue: 79)
                    cell.column3.textColor = UIColor.white
                } else if project.status == "Closed" {
                        cell.column3.backgroundColor = UIColor(red: 216, green: 58, blue: 82)
                    cell.column3.textColor = UIColor.white
                    } else if project.status == "Hold" {
                        cell.column3.backgroundColor = UIColor(red: 50, green: 51, blue: 56)
                        cell.column3.textColor = UIColor.white
                    } else {
                        cell.column3.backgroundColor = UIColor.white
                        cell.column3.textColor = UIColor.black
                    }
                cell.column4.text = project.manager
                cell.column5.text = project.members
                return cell
//                if status[indexPath.row] == "In progress" || status[indexPath.row] == "On going" || status[indexPath.row] == "Status" {
//                    cell.column1.text = projectName[indexPath.row]
//                    cell.column2.text = startedOn[indexPath.row]
//                    cell.column3.text = status[indexPath.row]
//                    if status[indexPath.row] == "On going" || status[indexPath.row] == "In progress" {
//                        cell.column3.backgroundColor = UIColor(red: 37, green: 135, blue: 79)
//                        cell.column3.textColor = UIColor.white
//                    } else if status[indexPath.row] == "Closed" {
//                            cell.column3.backgroundColor = UIColor(red: 216, green: 58, blue: 82)
//                        cell.column3.textColor = UIColor.white
//                        } else if status[indexPath.row] == "Hold" {
//                            cell.column3.backgroundColor = UIColor(red: 50, green: 51, blue: 56)
//                            cell.column3.textColor = UIColor.white
//                        } else {
//                            cell.column3.backgroundColor = UIColor.white
//                            cell.column3.textColor = UIColor.black
//                        }
//                    cell.column4.text = pm[indexPath.row]
//                    cell.column5.text = members[indexPath.row]
//                    return cell
//                }else{
//                    return UITableViewCell()
//                }
                
            }else if(sortCount % 4 == 2){
                let project = closedProjects[indexPath.row]
                cell.column1.text = project.name
                cell.column2.text = project.date
                cell.column3.text = project.status
                if project.status == "On going" || project.status == "In progress" {
                    cell.column3.backgroundColor = UIColor(red: 37, green: 135, blue: 79)
                    cell.column3.textColor = UIColor.white
                } else if project.status == "Closed" {
                        cell.column3.backgroundColor = UIColor(red: 216, green: 58, blue: 82)
                    cell.column3.textColor = UIColor.white
                    } else if project.status == "Hold" {
                        cell.column3.backgroundColor = UIColor(red: 50, green: 51, blue: 56)
                        cell.column3.textColor = UIColor.white
                    } else {
                        cell.column3.backgroundColor = UIColor.white
                        cell.column3.textColor = UIColor.black
                    }
                cell.column4.text = project.manager
                cell.column5.text = project.members
                return cell
//                if status[indexPath.row] == "Closed" || status[indexPath.row] == "Status" {
//                    cell.column1.text = projectName[indexPath.row]
//                    cell.column2.text = startedOn[indexPath.row]
//                    cell.column3.text = status[indexPath.row]
//                    if status[indexPath.row] == "On going" || status[indexPath.row] == "In progress" {
//                        cell.column3.backgroundColor = UIColor(red: 37, green: 135, blue: 79)
//                        cell.column3.textColor = UIColor.white
//                    } else if status[indexPath.row] == "Closed" {
//                            cell.column3.backgroundColor = UIColor(red: 216, green: 58, blue: 82)
//                        cell.column3.textColor = UIColor.white
//                        } else if status[indexPath.row] == "Hold" {
//                            cell.column3.backgroundColor = UIColor(red: 50, green: 51, blue: 56)
//                            cell.column3.textColor = UIColor.white
//                        } else {
//                            cell.column3.backgroundColor = UIColor.white
//                            cell.column3.textColor = UIColor.black
//                        }
//                    cell.column4.text = pm[indexPath.row]
//                    cell.column5.text = members[indexPath.row]
//                    return cell
//                }else{
//                    return UITableViewCell()
//                }
                
            }else{
                let project = holdProjects[indexPath.row]
                cell.column1.text = project.name
                cell.column2.text = project.date
                cell.column3.text = project.status
                if project.status == "On going" || project.status == "In progress" {
                    cell.column3.backgroundColor = UIColor(red: 37, green: 135, blue: 79)
                    cell.column3.textColor = UIColor.white
                } else if project.status == "Closed" {
                        cell.column3.backgroundColor = UIColor(red: 216, green: 58, blue: 82)
                    cell.column3.textColor = UIColor.white
                    } else if project.status == "Hold" {
                        cell.column3.backgroundColor = UIColor(red: 50, green: 51, blue: 56)
                        cell.column3.textColor = UIColor.white
                    } else {
                        cell.column3.backgroundColor = UIColor.white
                        cell.column3.textColor = UIColor.black
                    }
                cell.column4.text = project.manager
                cell.column5.text = project.members
                return cell
//                if status[indexPath.row] == "Hold" || status[indexPath.row] == "Status" {
//                    cell.column1.text = projectName[indexPath.row]
//                    cell.column2.text = startedOn[indexPath.row]
//                    cell.column3.text = status[indexPath.row]
//                    if status[indexPath.row] == "On going" || status[indexPath.row] == "In progress" {
//                        cell.column3.backgroundColor = UIColor(red: 37, green: 135, blue: 79)
//                        cell.column3.textColor = UIColor.white
//                    } else if status[indexPath.row] == "Closed" {
//                            cell.column3.backgroundColor = UIColor(red: 216, green: 58, blue: 82)
//                        cell.column3.textColor = UIColor.white
//                        } else if status[indexPath.row] == "Hold" {
//                            cell.column3.backgroundColor = UIColor(red: 50, green: 51, blue: 56)
//                            cell.column3.textColor = UIColor.white
//                        } else {
//                            cell.column3.backgroundColor = UIColor.white
//                            cell.column3.textColor = UIColor.black
//                        }
//                    cell.column4.text = pm[indexPath.row]
//                    cell.column5.text = members[indexPath.row]
//                    return cell
//                }else{
//                    return UITableViewCell()
//                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == projectTableView{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "specificProjectScreen") as! specificProjectViewController
//            vc.projectName = projectName[indexPath.row]
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
