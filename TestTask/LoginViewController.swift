//
//  LoginViewController.swift
//  TestTask
//
//  Created by Shruthi Joshi on 22/05/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var otpLabel: UILabel!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var scrollContentView: UIView!
    
    private var mobileNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()
    }
    
    private func setUpDelegates() {
        mobileNumberTextField.delegate = self
    }


    @IBAction func requestOTPButtonClicked(_ sender: Any) {
        let text = mobileNumberTextField.text
        if text?.count == 20  { // because space is appended
            showOTPView(mobileNumber: text ?? "")
        }
    }
    
    private func showOTPView(mobileNumber: String) {
          for char in mobileNumber {
            if char != " " {
                self.mobileNumber.append(char)
            }
          }
        let firstTwo = String(self.mobileNumber.prefix(2))
        let lastTwo = String(self.mobileNumber.suffix(2))
        let otp = firstTwo + lastTwo
        scrollContentView.backgroundColor = .gray
        otpLabel.text = otp
        otpView.layer.cornerRadius = 10
        otpView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.showOTPViewController()
        }
    }
    
    private func showOTPViewController() {
            let otpViewController = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            var text = mobileNumber
            text = "+91 " + text
            otpViewController.mobileNumber = text
            self.navigationController?.pushViewController(otpViewController, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard !string.isEmpty else {
                return true
            }
            let updatedString = string + " "
            let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: updatedString) ?? updatedString
            textField.text = updatedText
            if let newPosition = textField.position(from: textField.beginningOfDocument, offset: range.location + updatedString.count) {
                textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            }
            return false
        }
}
