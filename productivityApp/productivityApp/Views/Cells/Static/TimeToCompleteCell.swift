//
//  TimeToCompleteCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class TimeToCompleteCell: UITableViewCell {
	
	@IBOutlet weak var timeToCompleteLabel: UILabel!
	@IBOutlet weak var timeToCompleteTextField: UITextField!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	// MARK: - IBActions
	@IBAction func timeToCompleteTextFieldEditingDidEnd(_ sender: Any) {
	}
	
}
