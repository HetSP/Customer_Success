//
//  selectProjectMangerViewController.swift
//  customerSuccess
//
//  Created by promact on 06/03/24.
//

import UIKit

struct ProjectManager: Codable{
    var name: String
}

enum ProjectManagerError: Error {
    case invalidURL
    case invalidResponse
}

struct AssociatedManager: Codable {
    var _id: String
    var name: String
    var designation: String
}
struct Project: Codable {
    var _id: String
    var name: String
    var status: String
    var start_date: String
    var associatedManager: AssociatedManager
}
class selectProjectMangerViewController: UIViewController {
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var tblView: UITableView!
    var pName = ""
    var projectManager = ProjectManager(name: "")
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
    
    func postProject() {
        guard let url = URL(string: "http://localhost:8000/addProject") else {
            return
        }
        
        print("Making api call...")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let result = dateFormatter.string(from: date)
        
        // Convert UUIDs to strings
        let projectId = UUID().uuidString
        let managerId = UUID().uuidString
        
        // Assuming projectManager is accessible and has a valid name
        let projectManagerName = projectManager.name
        
        // Create the project body with converted UUIDs
        let associatedManager = AssociatedManager(_id: managerId, name: projectManagerName, designation: "Manager")
        let body = Project(_id: projectId, name: pName, status: "On-Going", start_date: result, associatedManager: associatedManager)
        
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase // Use snake_case for keys if needed
            let jsonData = try encoder.encode(body)
            
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "Unknown error")
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(Project.self, from: data)
                    print("Success:\(response)")
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
            
        } catch {
            print(error.localizedDescription)
        }
    }

    @IBAction func continueTapped(_ sender: UIButton) {
        postProject()
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
        dropButton.setTitle("\(pm[indexPath.row].name)", for: .normal)
        projectManager.name = pm[indexPath.row].name
        animate(toggle: false)
    }
}
