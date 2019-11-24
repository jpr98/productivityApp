//
//  DueDateCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

protocol DueDateCellDelegate: class {
	func dueDateSelected(_ date: Date)
}

class DueDateCell: UITableViewCell {
	
	@IBOutlet weak var dateTextField: UITextField!
	@IBOutlet weak var timeTextField: UITextField!
	
	private let datePicker = UIDatePicker()
	private let toolBar = UIToolbar()
	
	weak var delegate: DueDateCellDelegate?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configure(delegate: DueDateCellDelegate) {
		
		self.delegate = delegate
		
		setToolBar()
		
		datePicker.tag = 0
		datePicker.datePickerMode = .dateAndTime
		
		dateTextField.text = ""
		dateTextField.placeholder = "Due date"
		dateTextField.tintColor = .clear
		dateTextField.inputView = datePicker
		dateTextField.inputAccessoryView = toolBar
		
		timeTextField.text = ""
		timeTextField.placeholder = "Due time"
		timeTextField.tintColor = .clear
		timeTextField.inputView = datePicker
		timeTextField.inputAccessoryView = toolBar
		
	}
	
	private func setToolBar() {
		
		toolBar.barStyle = UIBarStyle.default
		toolBar.isTranslucent = true
		toolBar.tintColor = .red
		toolBar.sizeToFit()

		let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dateTextFieldValueChanged))
		let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(endEditing(_:)))

		toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
		toolBar.isUserInteractionEnabled = true
		
	}
	
	// MARK: - IBActions
	@IBAction func dateTextFieldEditingDidBegin(_ sender: Any) {
		dateTextField.text = ""
		timeTextField.text = ""
	}
	
	@IBAction func dateTextFieldValueChanged(_ sender: Any) {
		dateTextField.text = datePicker.date.getDayMonth()
		timeTextField.text = datePicker.date.getTime()
		self.endEditing(true)
	}
	
	@IBAction func dateTextFieldEditingDidEnd(_ sender: Any) {
		delegate?.dueDateSelected(datePicker.date)
	}
	
}
