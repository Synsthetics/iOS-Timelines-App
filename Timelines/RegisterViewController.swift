//
//  RegisterViewController.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/12/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var emailField: UITextField!
    @IBOutlet var userNameField: UITextField!
    @IBOutlet var pass1Field: UITextField!
    @IBOutlet var pass2Field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        userNameField.delegate = self
        pass1Field.delegate = self
        pass2Field.delegate = self
    }
    
    @IBAction func attemptRegistration() {
        emailField.resignFirstResponder()
        userNameField.resignFirstResponder()
        pass1Field.resignFirstResponder()
        pass2Field.resignFirstResponder()
        
        guard let registerRequest = verifyRegistrationInfo() else {
            return
        }
        
        let privateQueue = OperationQueue() 
        privateQueue.addOperation {
            API.register(body: registerRequest) { authResponse in
                guard let user = authResponse.user else {
                    guard let error = authResponse.errorMessage else {
                        OperationQueue.main.addOperation {
                            let alert = AlertView.createAlert(title: "Error", message: "Something unexpected happened", actionTitle: "Try again")
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        return
                    }
                    
                    OperationQueue.main.addOperation {
                        let alert = AlertView.createAlert(title: "Could not register", message: error, actionTitle: "OK")
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    return
                }
                
                self.loginSuccess(user: user)
            }
        }
        
    }
    
    private func verifyRegistrationInfo() -> RegisterRequest? {
        
        let emailReqSet = CharacterSet.init(charactersIn: "@")
        guard let email = emailField.text,
            email.rangeOfCharacter(from: emailReqSet) != nil else {
            let alert = AlertView.createAlert(title: "Error", message: "Please enter a valid email address", actionTitle: "OK")
            self.present(alert, animated: true, completion: nil)
            return nil
        }
        
        guard email.characters.count >= 5 else {
            let alert = AlertView.createAlert(title: "Error", message: "Email must have at least five characters", actionTitle: "OK")
            self.present(alert, animated: true, completion: nil)
            return nil
        }
        
        var usernameSet = CharacterSet.alphanumerics
        usernameSet.update(with: "_")
        usernameSet.update(with: "-")
        usernameSet.update(with: " ")
        guard let username = userNameField.text,
            username.rangeOfCharacter(from: usernameSet.inverted) == nil else {
            let alert = AlertView.createAlert(title: "Error", message: "Usernames may contain only alphanumerics, underscores, and dashes", actionTitle: "OK")
            self.present(alert, animated: true, completion: nil)
            return nil
        }
        
        let pass1 = pass1Field.text
        let pass2 = pass2Field.text
        
        guard pass1 == pass2 else {
            let alert = AlertView.createAlert(title: "Error", message: "Passwords must match", actionTitle: "OK")
            self.present(alert, animated: true, completion: nil)
            return nil
        }
        
        guard let password = pass2Field.text, password.characters.count >= 6 else {
            let alert = AlertView.createAlert(title: "Error", message: "Password must be 6 or more characters", actionTitle: "OK")
            self.present(alert, animated: true, completion: nil)
            return nil
        }
        
        return RegisterRequest(email: email, username: username, password: password)
    }
    
    private func loginSuccess(user: User) {
        UserStore.mainUser = user
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let appNav = storyboard.instantiateViewController(withIdentifier: "AppNavController") as! UINavigationController
        show(appNav, sender: nil)
    }
}
