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
    
    var startDate: Date?
    var endDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changeDateStateToStart(_ sender: UIButton) {
        self.startDateLabel.text = self.datePicker.date.description(with: Locale.autoupdatingCurrent)
        self.startDate = self.datePicker.date
        
        let isoFormatter = ISO8601DateFormatter()
        print(isoFormatter.string(from: self.datePicker.date))
    }
    
    @IBAction func changeDateStateToEnd(_ sender: UIButton) {
        self.endDateLabel.text = self.datePicker.date.description(with: Locale.autoupdatingCurrent)
        print(self.datePicker.date.description)
        self.endDate = self.datePicker.date
        
        let isoFormatter = ISO8601DateFormatter()
        print(isoFormatter.string(from: self.datePicker.date))
    }
    
    @IBAction func attemptEventCreation(_ sender: UIButton) {
        let name = self.nameTextField.text
        let details = self.detailsTextView.text
        let start = self.startDate
        let end = self.endDate
        
        guard name != nil && !name!.isEmpty,
              details != nil && !details!.isEmpty,
              start != nil,
              end != nil,
              start! <= end! else {
            let alert = AlertView.createAlert(title: "Event creation error.", message: "Please fill out all the fields correctly to create an event.", actionTitle: "Ok")
            present(alert, animated: true, completion: nil)
            return
        }
    
        let alert = AlertView.createAlert(title: "Event creation success.", message: "Your event has been successfully created.", actionTitle: "Ok")
        present(alert, animated: true, completion: nil)
        
    }
    
    func eventCreationSuccess() {
        //        api stuff
    }
    
    func getViewDataInDictionary() -> [String: Any] {
        let data = [
            "name" : self.nameTextField.text,
            "details" : self.detailsTextView.text,
            "start" : self.startDate,
            "end" : self.endDate,
            "owner" : UserStore.mainUser
            ] as [String : Any]
        
        return data
    }
    
}
