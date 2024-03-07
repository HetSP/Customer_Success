//
//  selectProjectMangerViewController.swift
//  customerSuccess
//
//  Created by promact on 06/03/24.
//

import UIKit

class selectProjectMangerViewController: UIViewController {
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    var pm = ["Het Patel","Rinil Parmar","Shishir Jha","Atanu Panja","Deep Patel"]
    override func viewDidLoad() {
        tblView.isHidden = true
        super.viewDidLoad()
        dropButton.layer.cornerRadius = 5
        dropButton.layer.borderWidth = 1
        dropButton.layer.borderColor = UIColor.black.cgColor
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
    
    @IBAction func continueTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeScreen") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension selectProjectMangerViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = pm[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropButton.setTitle("\(pm[indexPath.row])", for: .normal)
        animate(toggle: false)
    }
}
