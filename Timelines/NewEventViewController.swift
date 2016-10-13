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
        self.nameTextField.delegate = self
        self.detailsTextView.delegate = self
    }
    
    @IBAction func changeDateStateToStart(_ sender: UIButton) {
        self.startDateLabel.text = self.datePicker.date.description(with: Locale.autoupdatingCurrent)
        self.startDate = self.datePicker.date
    }
    
    @IBAction func changeDateStateToEnd(_ sender: UIButton) {
        self.endDateLabel.text = self.datePicker.date.description(with: Locale.autoupdatingCurrent)
        self.endDate = self.datePicker.date
    }
    
    @IBAction func attemptEventCreation(_ sender: UIButton) {
        let name = self.nameTextField.text
        let details = self.detailsTextView.text
        let start = self.startDate
        let end = self.endDate
        
        self.nameTextField.resignFirstResponder()
        self.detailsTextView.resignFirstResponder()
        
        guard name != nil && !name!.isEmpty,
              details != nil && !details!.isEmpty,
              start != nil,
              end != nil,
              start! < end! else {
            let alert = AlertView.createAlert(title: "Event creation error", message: "Please fill out all the fields correctly to create an event.", actionTitle: "OK")
            present(alert, animated: true, completion: nil)
            return
        }
        
        let isoStart = DateTools.gmtFormatter.string(from: start!)
        let isoEnd = DateTools.gmtFormatter.string(from: end!)
        
        print(isoStart)
        print(isoEnd)
        
        print(TimeZone
            .autoupdatingCurrent.abbreviation()!)
        let request = AddEventRequest(name: name!, start: isoStart, end: isoEnd, owner: UserStore.mainUser!.id!, details: details!, timeZoneCreatedIn: TimeZone
            .autoupdatingCurrent.abbreviation()!)
        
        print("✅\(request)")
        
        API.addEvent(body: request) { addEventResponse in
            guard addEventResponse.created == true else {
                let alert = AlertView.createAlert(title: "Event creation error", message: addEventResponse.errorMessage ?? "Internal server error.", actionTitle: "OK")
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension NewEventViewController: UITextFieldDelegate {

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension NewEventViewController: UITextViewDelegate {
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
}
