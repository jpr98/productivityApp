//
//  DueDateCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class DueDateCell: UITableViewCell {
	
	@IBOutlet weak var dateTextFiedl: UITextField!
	@IBOutlet weak var timeTextField: UITextField!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	// MARK: - IBActions
	@IBAction func dateTextFieldEditingDidEnd(_ sender: Any) {
	}
	
	@IBAction func timeTextFieldEditingDidEnd(_ sender: Any) {
	}
	
}
