//
//  LoginViewController.swift
//  Timelines
//
//  Created by Rodney Sampson on 10/11/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var userNameField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func attemptLogin(_ sender: UIButton) {
        
        self.userNameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        
        let userName = userNameField.text
        let pass = passwordField.text
        let privateQueue = OperationQueue()
        privateQueue.addOperation {
            API.login(body: LoginRequest(username: userName!, password : pass!)) { authResponse in
                guard let user = authResponse.user else {
                    guard let error = authResponse.errorMessage else {
                        OperationQueue.main.addOperation {
                        let alert = AlertView.createAlert(title: "Error", message: "Something Unexpected Happened, Please Try Again", actionTitle: "Okay")
                        self.present(alert, animated: true, completion: nil)
                        }
                        return
                    }
                    OperationQueue.main.addOperation {
                    let alert = AlertView.createAlert(title: "Invalid Login", message: error, actionTitle: "Okay")
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
}
