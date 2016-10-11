//
//  LoginViewController.swift
//  Timelines
//
//  Created by Rodney Sampson on 10/11/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func attemptLogin(_ sender: UIButton) {
        
    }
    
    private func loginSuccess(user: User) {
        UserStore.mainUser = user
        
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let appNav = storyboard.instantiateViewController(withIdentifier: "AppNavController") as! UINavigationController
        show(appNav, sender: nil)
    }
    
}
