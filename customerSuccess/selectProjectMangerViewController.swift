//
//  selectProjectMangerViewController.swift
//  customerSuccess
//
//  Created by promact on 06/03/24.
//

import UIKit

struct ProjectManager: Codable{
    let name: String
}

enum ProjectManagerError: Error {
    case invalidURL
    case invalidResponse
}

class selectProjectMangerViewController: UIViewController {
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    var pm: [ProjectManager] = []
    override func viewDidLoad() {
        tblView.isHidden = true
        super.viewDidLoad()
        dropButton.layer.cornerRadius = 5
        dropButton.layer.borderWidth = 1
        dropButton.layer.borderColor = UIColor.black.cgColor
        Task {
            do {
                pm = try await self.getProjectManagers()
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            } catch {
                print("Error fetching projects: \(error)")
            }
        }
    }
    
    func getProjectManagers() async throws -> [ProjectManager] {
        var components = URLComponents(string: "http://localhost:8000/getManagers")!
        components.queryItems = [
            URLQueryItem(name: "role_id", value: "rol_qLO42FIvSNsdZEO4")
        ]

        guard let url = components.url else {
            print("Invalid URL components")
            throw ProjectManagerError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ProjectManagerError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let projectmanagers = try decoder.decode([ProjectManager].self, from: data)
            return projectmanagers
        } catch {
            print("Error fetching projects:", error)
            throw error
        }
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
        cell.textLabel?.text = pm[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropButton.setTitle("\(pm[indexPath.row])", for: .normal)
        animate(toggle: false)
    }
}
