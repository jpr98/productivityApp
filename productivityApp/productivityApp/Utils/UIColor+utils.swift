//
//  UIColor+hex.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 19/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

extension UIColor {
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	convenience init(rgb: Int) {
		self.init(
			red: (rgb >> 16) & 0xFF,
			green: (rgb >> 8) & 0xFF,
			blue: rgb & 0xFF
		)
	}
	
	static func color(for viewType: ViewType) -> UIColor? {
		
		switch viewType {
		case .background:
			return UIColor(rgb: 0xEEEEEE)
		case .cell:
			return UIColor(rgb: 0xF9F9F9)
		case .priority(.low):
			return UIColor(rgb: 0xFCBF49)
		case .priority(.medium):
			return UIColor(rgb: 0xF77F00)
		case .priority(.high):
			return UIColor(rgb: 0xD62828)
		case .complete:
			return UIColor(rgb: 0x5E8732)
		case .save:
			return UIColor(rgb: 0x7E92B5)
		case .tag:
			return UIColor(rgb: 0x99B2DD)
		}
		
	}
}
