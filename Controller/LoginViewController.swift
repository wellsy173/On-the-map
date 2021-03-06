//
//  ViewController.swift
//  On The Map
//
//  Created by Simon Wells on 2020/8/6.
//  Copyright © 2020 Simon Wells. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    var emailTextFieldIsEmpty = true
    var passwordTextFieldIsEmpty = true

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    emailTextField.text = ""
    passwordTextField.text = ""
    buttonEnabled(true, button: loginButton)
        
    }

    @IBAction func loginTapped(_ sender: Any) {
        setLoggingIn(true)
        UdacityClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
    }
  

    /*
     work out how to do the below tomorrow- udacity cloent bit, do i need both?
     */
    func handleLoginResponse(success: Bool, error: Error?) -> Void {
        setLoggingIn(false)
        if success {
                performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        }else{
            activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
    }
        
        func showLoginFailure(message: String) {
            let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            show(alertVC, sender: nil)
            
        }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            let currentText = emailTextField.text ?? ""
            guard let rangeString = Range(range, in: currentText)
                else {
                    return false }
            let updatedText = currentText.replacingCharacters(in: rangeString, with: string)
            
            if updatedText.isEmpty && updatedText == "" {
                emailTextFieldIsEmpty = true
            } else {
                emailTextFieldIsEmpty = false
            }
            }
        
        if textField == passwordTextField {
        let currentText = passwordTextField.text ?? ""
        guard let rangeString = Range(range, in: currentText)
            else {
                return false }
        let updatedText = currentText.replacingCharacters(in: rangeString, with: string)
        
        if updatedText.isEmpty && updatedText == "" {
            passwordTextFieldIsEmpty = true
        } else {
            passwordTextFieldIsEmpty = false
        
    }
    
}
        if emailTextFieldIsEmpty == false && passwordTextFieldIsEmpty == false {
            buttonEnabled(true, button: loginButton)
        } else {
            buttonEnabled(false, button: loginButton)
        }
        
        return true
        
    }
        
        
        
        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            buttonEnabled(false, button: loginButton)
            if textField == emailTextField {
                emailTextFieldIsEmpty = true
            }
            if textField == passwordTextField {
                passwordTextFieldIsEmpty = true
            }
            return true

}
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as?
            UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            loginTapped(loginButton)
        }
        return true 
    }
        
        
}
