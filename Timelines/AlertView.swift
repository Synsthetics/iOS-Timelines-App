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
    
}
