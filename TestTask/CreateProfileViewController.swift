//
//  CreateProfileViewController.swift
//  TestTask
//
//  Created by Shruthi Joshi on 23/05/24.
//

import UIKit

class CreateProfileViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var postCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        postFormData()
    }
    
    private func postFormData() {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let postCode = postCodeTextField.text ?? ""
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonPayload: [String: Any] = ["firstName": firstName, "lastName": lastName, "phone": phone, "postCode": postCode]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: jsonPayload, options: []) else {
            print("Error serializing JSON")
            return
        }
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending request: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Server error: \(httpResponse.statusCode)")
                return
            }
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response data: \(responseString)")
            }
        }
        task.resume()
    }
    
}
