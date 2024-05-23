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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func requestOTPButtonClicked(_ sender: Any) {
        let text = mobileNumberTextField.text
        if text?.count == 10 {
            showOTPView(mobileNumber: text ?? "")
        }
    }
    
    private func showOTPView(mobileNumber: String) {
        let firstTwo = String(mobileNumber.prefix(2))
        let lastTwo = String(mobileNumber.suffix(2))
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
            var text = mobileNumberTextField.text
            text = "+91 " + (text ?? "")
            otpViewController.mobileNumber = text
            self.navigationController?.pushViewController(otpViewController, animated: true)
    }
    
}
