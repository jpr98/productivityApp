//
//  UITextField+utils.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 23/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

extension UITextField {
	
	func keyboardDismissable() {
		
		let toolBar = UIToolbar()
		
		toolBar.barStyle = UIBarStyle.default
		toolBar.isTranslucent = true
		toolBar.sizeToFit()

		let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(endEditing(_:)))
		let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

		toolBar.setItems([spaceButton, doneButton], animated: false)
		toolBar.isUserInteractionEnabled = true
		
		self.inputAccessoryView = toolBar
		
	}
	
}
