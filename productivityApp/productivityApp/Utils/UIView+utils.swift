//
//  UIView+utils.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 23/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

extension UIView {
	 
	func keyboardDissmisable() {
		let tap = UIGestureRecognizer(target: self, action: #selector(UIView.dismissKeyboard))
		self.addGestureRecognizer(tap)
	}
	
	@objc private func dismissKeyboard() {
		self.endEditing(true)
	}
	
}
