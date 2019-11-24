//
//  TimeToCompleteCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

protocol TimeToCompleteCellDelegate: class {
	func timeToCompleteSelected(_ time: TimeInterval)
}

class TimeToCompleteCell: UITableViewCell {
	
	@IBOutlet weak var timeToCompleteLabel: UILabel!
	@IBOutlet weak var timeToCompleteTextField: UITextField!
	
	private let timePicker = UIPickerView()
	private let toolBar = UIToolbar()
	private var selectedTime: TimeInterval = 0
	private var selectedHours: Double = 0
	private var selectedMinutes: Double = 0
	
	weak var delegate: TimeToCompleteCellDelegate?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configure(delegate: TimeToCompleteCellDelegate, time: TimeInterval) {
		
		self.delegate = delegate
		
		setToolBar()
		
		timePicker.delegate = self
		timePicker.dataSource = self
		
		if time != 0 {
			timeToCompleteTextField.text = time.getHoursMinutes()
		}
		
		timeToCompleteTextField.tintColor = .clear
		timeToCompleteTextField.inputView = timePicker
		timeToCompleteTextField.inputAccessoryView = toolBar
		
	}
	
	private func setToolBar() {
		
		toolBar.barStyle = UIBarStyle.default
		toolBar.isTranslucent = true
		toolBar.tintColor = .red
		toolBar.sizeToFit()

		let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(timeToCompleteTextFieldValueChanged))
		let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(timeToCompleteTextFieldCanceled))

		toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
		toolBar.isUserInteractionEnabled = true
		
	}
	
	// MARK: - IBActions
	@IBAction func timeToCompleteTextFieldEditingDidBegin(_ sender: Any) {
		timeToCompleteTextField.text = ""
		timePicker.selectRow(Int(selectedHours), inComponent: 0, animated: true)
		timePicker.selectRow(Int(selectedMinutes), inComponent: 1, animated: true)
	}
	
	@IBAction func timeToCompleteTextFieldValueChanged(_ sender: Any) {
		selectedTime = (selectedMinutes * 60) + (selectedHours * 60 * 60)
		
		let text = selectedHours == 1 ? "1 hr \(selectedMinutes.clean) min" : "\(selectedHours.clean) hrs \(selectedMinutes.clean) min"
		
		timeToCompleteTextField.text = text
		timeToCompleteTextField.placeholder = text
		
		self.endEditing(true)
	}
	
	@objc func timeToCompleteTextFieldCanceled(_ sender: Any) {
		if let placeholderValue = timeToCompleteTextField.placeholder {
			timeToCompleteTextField.text = placeholderValue
		}
		self.endEditing(true)
	}
	
	@IBAction func timeToCompleteTextFieldEditingDidEnd(_ sender: Any) {
		delegate?.timeToCompleteSelected(selectedTime)
	}
	
}

// MARK: - UIPickerView
extension TimeToCompleteCell: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 2
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if component == 0 {
			return 49
		} else {
			return 61
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if component == 0 {
			if row == 1 {
				return "1 hr"
			} else {
				return "\(row) hrs"
			}
		} else {
			return "\(row) min"
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if component == 0 {
			selectedHours = Double(row)
		} else {
			selectedMinutes = Double(row)
		}
	}
	
}
 
