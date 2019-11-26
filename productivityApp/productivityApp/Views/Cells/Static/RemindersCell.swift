//
//  RemindersCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 25/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

protocol RemindersCellDelegate: class {
	func setNotifications(on: Bool)
}
class RemindersCell: UITableViewCell {
	
	@IBOutlet weak var reminderLabel: UILabel!
	@IBOutlet weak var reminderSwitch: UISwitch!
	
	weak var delegate: RemindersCellDelegate?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}

	func configure(delegate: RemindersCellDelegate) {
		
		self.delegate = delegate
		
		reminderSwitch.setOn(false, animated: true)
		reminderLabel.font = UIFont.getFont(with: .light, size: 19)
		reminderLabel.text = "Reminders"
	}
	
	// MARK: - IBActions
	@IBAction func reminderSwitchToggled(_ sender: Any) {
		delegate?.setNotifications(on: reminderSwitch.isOn)
	}
	
}
