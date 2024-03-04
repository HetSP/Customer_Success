//
//  ViewController.swift
//  customerSuccess
//
//  Created by promact on 04/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var subLbl: UILabel!
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    var titleNames = ["New Project","Projects","Project Manager","Employees","Setting"]
    var images = ["add","office-bag","person","employees","settings"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var conatainerView: UIView!
    var viewOpen:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerTableCells()
        self.conatainerView.isHidden = true
        viewOpen = false
        profileImg.image = UIImage(named: "profile-pic")
        profileImg.layer.borderWidth=1.0
        profileImg.layer.masksToBounds = false
        profileImg.layer.borderColor = UIColor.white.cgColor
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2
        profileImg.clipsToBounds = true
    }

    func registerTableCells(){
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        conatainerView.isHidden = false
        tableView.isHidden = false
        if !viewOpen{
            viewOpen = true
            conatainerView.frame = CGRect(x: 0, y: 103, width: 0, height: 749)
            tableView.frame = CGRect(x: 0, y: 0, width: 0, height: 749)
            UIView.animate(withDuration: 1){
                self.conatainerView.frame = CGRect(x: 0, y: 103, width: 282, height: 749)
                self.tableView.frame = CGRect(x: 0, y: 0, width: 282, height: 749)
            }
            profileImg.alpha = 1
            mainLbl.alpha = 1
            subLbl.alpha = 1
        }else{
            conatainerView.isHidden = true
            tableView.isHidden = true
            viewOpen = false
            conatainerView.frame = CGRect(x: 0, y: 103, width: 0, height: 749)
            tableView.frame = CGRect(x: 0, y: 0, width: 0, height: 749)
            UIView.animate(withDuration: 1){
                self.conatainerView.frame = CGRect(x: 0, y: 103, width: 282, height: 749)
                self.tableView.frame = CGRect(x: 0, y: 0, width: 282, height: 749)
            }
        }
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
        cell.titleLbl.text = titleNames[indexPath.row]
        cell.imageIcon.image = UIImage(named: images[indexPath.row])
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.systemBlue
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let indexPath = NSIndexPath(row: 0, section: 0)
        tableView.selectRow(at: indexPath as IndexPath, animated: false, scrollPosition: .none)
      }
}
