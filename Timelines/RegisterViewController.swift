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
        
        let email = emailField.text
        let emailReqSet = CharacterSet.init(charactersIn: "@")
        guard email?.rangeOfCharacter(from: emailReqSet) != nil else {
            let alert = AlertView.createAlert(title: "Error", message: "Email Must Include @ symbol", actionTitle: "Okay")
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard (email?.characters.count)! >= 5 else {
            let alert = AlertView.createAlert(title: "Error", message: "Email Must Have 5 Characters", actionTitle: "Okay")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        let userNameSet = CharacterSet.init(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 _-")
        let userName = userNameField.text
        guard userName?.rangeOfCharacter(from: userNameSet.inverted) == nil else {
            let alert = AlertView.createAlert(title: "Error", message: "User Name Must Only contain AlphaNum characters and ' _-'", actionTitle: "Okay")
            self.present(alert, animated: true, completion: nil)
            return
        }
        let pass1 = pass1Field.text
        let pass2 = pass2Field.text
        guard pass1 == pass2 else {
            let alert = AlertView.createAlert(title: "Error", message: "Passwords Do Not Match", actionTitle: "Okay")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let privateQueue = OperationQueue.init()
        privateQueue.addOperation {
            API.register(body: RegisterRequest(email: email!, username: userName!, password: pass1!)) { authResponse in
                guard let user = authResponse.user else {
                    guard let error = authResponse.errorMessage else {
                        OperationQueue.main.addOperation {
                            let alert = AlertView.createAlert(title: "Error", message: "Something Unexpected Happened, Please Try Again", actionTitle: "Okay")
                            self.present(alert, animated: true, completion: nil)
                        }
                        return
                    }
                    OperationQueue.main.addOperation {
                        let alert = AlertView.createAlert(title: "Invalid Registration", message: error, actionTitle: "Okay")
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                self.loginSuccess(user: user)
            }
        }
        
    }
    
    private func loginSuccess(user: User) {
        UserStore.mainUser = user
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let appNav = storyboard.instantiateViewController(withIdentifier: "AppNavController") as! UINavigationController
        show(appNav, sender: nil)
    }
}
