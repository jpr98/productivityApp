//
//  Date+utils.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 21/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import Foundation

extension Date {
	func getString(for component: Calendar.Component) -> String {
		let formatter = DateFormatter()
		if component == .day {
			formatter.dateFormat = "EEEE"
			return formatter.string(from: self)
		} else {
			fatalError("Date.getString(for:.\(component)) not implemented yet!")
		}
	}
	
	func getDayMonth() -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "EEEE, MMMM dd"
		return formatter.string(from: self)
	}
	
	func getTime() -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "hh:mm a"
		formatter.amSymbol = "am"
		formatter.pmSymbol = "pm"
		return formatter.string(from: self)
	}
}
