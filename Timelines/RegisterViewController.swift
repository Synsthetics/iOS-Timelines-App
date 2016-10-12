//
//  RegisterViewController.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/12/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    private func attemptRegistration() {
        
    }
    
    private func loginSuccess(user: User) {
        UserStore.mainUser = user
        
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let appNav = storyboard.instantiateViewController(withIdentifier: "AppNavController") as! UINavigationController
        show(appNav, sender: nil)
    }
}
