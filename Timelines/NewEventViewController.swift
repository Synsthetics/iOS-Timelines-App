//
//  NewEventViewController.swift
//  Timelines
//
//  Created by Princess Sampson on 10/12/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var detailsTextView: UITextView!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    
    static var testDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changeDateStateToStart(_ sender: UIButton) {
        self.startDateLabel.text = self.datePicker.date.description(with: Locale.autoupdatingCurrent)
        
        print(self.datePicker.date.description(with: Locale.autoupdatingCurrent))
    }
    
    @IBAction func changeDateStateToEnd(_ sender: UIButton) {
        self.endDateLabel.text = self.datePicker.date.description
        
        print(self.datePicker.date.description)
        
        let isoFormatter = ISO8601DateFormatter()
        
        print(isoFormatter.string(from: self.datePicker.date))
    }

}
