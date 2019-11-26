//
//  UIFont+util.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 25/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

extension UIFont {
	
	static func getFont(with type: FontType, size: CGFloat) -> UIFont? {
		
		switch type {
		case .bold:
			return UIFont(name: "GothamRounded-Bold", size: size)
		case .book:
			return UIFont(name: "GothamRounded-Book", size: size)
		case .light:
			return UIFont(name: "GothamRounded-Light", size: size)
		case .medium:
			return UIFont(name: "GothamRounded-Medium", size: size)
		}
		
	}
	
}
