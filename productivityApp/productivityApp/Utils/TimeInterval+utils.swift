//
//  TimeInterval+utils.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 21/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import Foundation

extension TimeInterval {
	func getHoursMinutes() -> String {
		let time = NSInteger(self)

		let minutes = (time / 60) % 60
		let hours = (time / 3600)
		
		let hourString = hours > 1 ? "hrs" : "hr"
		return String(format: "%0.2d \(hourString) %0.2d min", hours, minutes)
	}
}
