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
    @IBOutlet weak var profilePicButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        postFormData()
    }
    
    
    @IBAction func cameraButtonClicked(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // Use .camera if you want to take a photo
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func postFormData() {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let postCode = postCodeTextField.text ?? ""
        guard let imageData = profilePicButton.imageView?.image?.jpegData(compressionQuality: 0.8) else {
            print("Error converting image to data")
            return
        }
        let base64Image = imageData.base64EncodedString()
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonPayload: [String: Any] = ["firstName": firstName, 
                                          "lastName": lastName,
                                          "phone": phone,
                                          "postCode": postCode,
                                          "profilePic": base64Image]
        
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

extension CreateProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                let scaledImage = pickedImage.scaledToFit(within: CGSize(width: 120, height: 120))
                profilePicButton.setImage(scaledImage, for: .normal)
                profilePicButton.imageView?.contentMode = .scaleAspectFit
            }
            dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
