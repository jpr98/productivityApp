//
//  TitleCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

protocol TitleCellDelegate: class {
	func titleSelected(title: String)
}

class TitleCell: UITableViewCell {

	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var separatorView: UIView!
	
	weak var delegate: TitleCellDelegate?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configure(delegate: TitleCellDelegate, title: String) {
		
		self.delegate = delegate
		
		titleTextField.font = UIFont.getFont(with: .medium, size: 20)
		titleTextField.text = title
		titleTextField.placeholder = "Title"
		titleTextField.keyboardDismissable()
		
	}
	
	// MARK: - IBActions
	@IBAction func titleTextFieldEditingDidEnd(_ sender: Any) {
		if let title = titleTextField.text {
			delegate?.titleSelected(title: title)
		}
	}
	
}
