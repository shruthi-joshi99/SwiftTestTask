//
//  OTPViewController.swift
//  TestTask
//
//  Created by Shruthi Joshi on 22/05/24.
//

import UIKit

class OTPViewController: UIViewController {

    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var otpTextField1: UITextField!
    @IBOutlet weak var otpTextField2: UITextField!
    @IBOutlet weak var otpTextField3: UITextField!
    @IBOutlet weak var otpTextField4: UITextField!
    
    var mobileNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        setDelegates()
    }
    
    private func updateView() {
        mobileNumberTextField.text = mobileNumber
    }
    
    private func setDelegates() {
        otpTextField1.delegate = self
        otpTextField2.delegate = self
        otpTextField3.delegate = self
        otpTextField4.delegate = self
    }
    
    
    @IBAction func editMobileNumberButtonClicked(_ sender: Any) {
        mobileNumberTextField.text = "+91 "
        mobileNumberTextField.becomeFirstResponder()
    }
    
    
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        var text = mobileNumberTextField.text
        if (text?.isEmpty ?? false) {
            return
        }
        text = String(text?.dropFirst(4) ?? "")
        let firstTwo = String(text?.prefix(2) ?? "")
        let lastTwo = String(text?.suffix(2) ?? "")
        let otp = firstTwo + lastTwo
        let otp1 = otpTextField1.text ?? ""
        let otp2 = otpTextField2.text ?? ""
        let otp3 = otpTextField3.text ?? ""
        let otp4 = otpTextField4.text ?? ""
        let enteredOTP = otp1 + otp2 + otp3 + otp4
        if otp == enteredOTP {
            let createProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateProfileViewController") as! CreateProfileViewController
            self.navigationController?.pushViewController(createProfileViewController, animated: true)
        }
    }
    

}

extension OTPViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == otpTextField1 {
            if let text = textField.text {
                let newLength = text.count + string.count - range.length
                if newLength == 1 {
                    DispatchQueue.main.async {
                        self.otpTextField2.becomeFirstResponder()
                    }
                }
            }
            return true
        }
        if textField == otpTextField2 {
            if let text = textField.text {
                let newLength = text.count + string.count - range.length
                if newLength == 1 {
                    DispatchQueue.main.async {
                        self.otpTextField3.becomeFirstResponder()
                    }
                }
            }
            return true
        }
        if textField == otpTextField3 {
            if let text = textField.text {
                let newLength = text.count + string.count - range.length
                if newLength == 1 {
                    DispatchQueue.main.async {
                        self.otpTextField4.becomeFirstResponder()
                    }
                }
            }
            return true
        }
        if textField == otpTextField4 {
            if let text = textField.text {
                let newLength = text.count + string.count - range.length
                if newLength == 1 {
                    DispatchQueue.main.async {
                        self.otpTextField4.resignFirstResponder()
                    }
                }
            }
            return true
        }
        return false
     }
    
    
}
