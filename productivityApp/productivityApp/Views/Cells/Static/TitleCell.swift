//
//  TitleCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var separatorView: UIView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	// MARK: - IBActions
	@IBAction func titleTextFieldEditingDidEnd(_ sender: Any) {
	}
	
}
