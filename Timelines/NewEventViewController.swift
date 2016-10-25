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
    @IBOutlet var startDateTextField: UITextField!
    @IBOutlet var endDateTextField: UITextField!
    @IBOutlet var eventIsPublic: UISwitch!
    @IBOutlet var topViewConstraint: NSLayoutConstraint!
    @IBOutlet var bottomViewConstraint: NSLayoutConstraint!
    
    var topViewConstraintConstant: CGFloat?
    var bottomViewConstraintConstant: CGFloat?
    
    var startDatePickerView: UIDatePicker?
    var endDatePickerView: UIDatePicker?
    var selectedTextField: UITextField?
    
    var timeblockIndex: Int?
    var timeblock: Timeblock?
    var startDate: Date?
    var endDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        self.detailsTextView.delegate = self
        self.startDateTextField.delegate = self
        self.endDateTextField.delegate = self
        
        self.startDatePickerView = UIDatePicker()
        self.endDatePickerView = UIDatePicker()
        
        self.setUp(datePicker: &self.startDatePickerView!)
        self.setUp(datePicker: &self.endDatePickerView!)
        
        self.startDateTextField.inputView = self.startDatePickerView
        self.endDateTextField.inputView = self.endDatePickerView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
        
        self.topViewConstraintConstant = self.topViewConstraint.constant
        self.bottomViewConstraintConstant = self.bottomViewConstraint.constant

    }
    
    func dismissKeyboard() {
        self.selectedTextField?.resignFirstResponder()
    }
    
    private func setUp(datePicker: inout UIDatePicker) {
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        datePicker.minimumDate = self.timeblock?.start
        datePicker.maximumDate = self.timeblock?.end
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .short
        timeFormatter.timeStyle = .short
        
        if sender == self.startDatePickerView {
            self.startDateTextField.text = timeFormatter.string(for: sender.date)
            self.startDate = sender.date
        } else if sender == endDatePickerView {
            endDateTextField.text = timeFormatter.string(for: sender.date)
            self.endDate = sender.date
        }
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
        
        let request = AddEventRequest(name: name!, start: isoStart, end: isoEnd, owner: UserStore.mainUser!, details: details!, timeZoneCreatedIn: TimeZone
            .autoupdatingCurrent.abbreviation()!, isPublic: !eventIsPublic.isOn)
        
        API.addEvent(body: request) { addEventResponse in
            OperationQueue.main.addOperation {
                guard let event = addEventResponse.event else {
                    let alert = AlertView.createAlert(title: "Event creation error", message: addEventResponse.errorMessage ?? "Internal server error.", actionTitle: "OK")
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
//                TimeblockStore.insert(timeblock: event, at: self.timeblockIndex!)
                let _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

extension NewEventViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let _ = textField.inputView as? UIDatePicker {
            self.selectedTextField = textField
            
            UIView.animate(withDuration: 0.5) {
                self.topViewConstraint.constant -= ((self.selectedTextField?.inputView?.frame.height)! + 10)
                self.bottomViewConstraint.constant += ((self.selectedTextField?.inputView?.frame.height)! + 10)
            }
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let _ = textField.inputView as? UIDatePicker {
            self.selectedTextField = textField
            
            UIView.animate(withDuration: 0.5) {
                self.topViewConstraint.constant = self.topViewConstraintConstant!
                self.bottomViewConstraint.constant = self.bottomViewConstraintConstant!

            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension NewEventViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
}
