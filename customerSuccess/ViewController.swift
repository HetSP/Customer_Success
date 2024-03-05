//
//  ViewController.swift
//  customerSuccess
//
//  Created by promact on 04/03/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var projectTableView: UITableView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var subLbl: UILabel!
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    var titleNames = ["New Project","Projects","Project Manager","Employees","Setting"]
    var images = ["add","office-bag","person","employees","settings"]
    var projectName = ["Project Name","Food on Time","2023-01-01","2023-01-01","2023-01-01","2023-01-01","2023-01-01","2023-01-01","2023-01-01","2023-01-01","2023-01-01","2023-01-01"]
    var startedOn = ["Started On","12 Feb 24","1 Jan 24","Placeholder for...","Placeholder for...","Placeholder for...","Placeholder for...","Placeholder for...","Placeholder for...","Placeholder for...","Placeholder for...","Placeholder for..."]
    var status = ["Status","On going","Closed","In progress","In progress","In progress","Hold","In progress","In progress","Closed","Closed","Closed"]
    var pm = ["Project Manager","Dipa Manjumdar","Dipa Manjumdar","Dipa Manjumdar","Dipa Manjumdar","Rohit Shah","Rohit Shah","Rohit Shah","Rohit Shah","Rohit Shah","Rohit Shah","Rohit Shah"]
    var members = ["Members","6","12","14","4","30","20","13","9","100","100","100"]
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var conatainerView: UIView!
    var viewOpen:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
                    return titleNames.count
                } else {
                    return projectName.count
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
            cell.column1.text = projectName[indexPath.row]
            cell.column2.text = startedOn[indexPath.row]
            cell.column3.text = status[indexPath.row]
            if status[indexPath.row] == "On going" || status[indexPath.row] == "In progress" {
                cell.column3.backgroundColor = UIColor(red: 37, green: 135, blue: 79)
                cell.column3.textColor = UIColor.white
            } else if status[indexPath.row] == "Closed" {
                    cell.column3.backgroundColor = UIColor(red: 216, green: 58, blue: 82)
                cell.column3.textColor = UIColor.white
                } else if status[indexPath.row] == "Hold" {
                    cell.column3.backgroundColor = UIColor(red: 50, green: 51, blue: 56)
                    cell.column3.textColor = UIColor.white
                } else {
                    cell.column3.backgroundColor = UIColor.white
                }
            cell.column4.text = pm[indexPath.row]
            cell.column5.text = members[indexPath.row]
            return cell
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
