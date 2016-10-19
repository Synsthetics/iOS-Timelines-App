//
//  AlertViews.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/12/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

struct AlertView {
    
    static func createAlert(title: String, message: String, actionTitle: String) -> UIAlertController{
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: actionTitle, style: .default) { action in
            controller.dismiss(animated: true) {
            }
        })
        return controller
    }
    
    static func createAlertWithTextField(title: String, message: String, actionTitle: String, completionForText: @escaping (String) -> Void) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addTextField(configurationHandler: nil)
        let textfield = controller.textFields?[0]
        controller.addAction(UIAlertAction(title: actionTitle, style: .default){ _ in
            completionForText((textfield?.text)!)
            controller.dismiss(animated: true, completion: nil)
        })
        return controller
    }
    
}
