//
//  Task.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 19/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import Foundation

class Task {
	
	var title: String
	var description: String
	var priority: Priority
	var dueDate: Date
	var timeToComplete: TimeInterval
	var completed: Bool
	
	init() {
		
		title = ""
		description = ""
		priority = .low
		dueDate = Date()
		timeToComplete = TimeInterval()
		completed = false
		
	}
	
	init(title: String, description: String, priority: Priority, dueDate: Date, timeToComplete: TimeInterval, completed: Bool) {
		
		self.title = title
		self.description = description
		self.priority = priority
		self.dueDate = dueDate
		self.timeToComplete = timeToComplete
		self.completed = completed
		
	}
	
	static func mock() -> [Task] {
		var mockData = [Task]()
		
		mockData.append(Task(title: "Walk the dog",
							 description: "",
							 priority: .low,
							 dueDate: Date(timeIntervalSince1970: 1574186400),
							 timeToComplete: 100,
							 completed: false))
		
		mockData.append(Task(title: "Finish work presentation",
							 description: "I need to finish the marketing presentation",
							 priority: .high,
							 dueDate: Date(timeIntervalSince1970: 1574200800),
							 timeToComplete: 100,
							 completed: false))
		
		mockData.append(Task(title: "Call mom",
							 description: "Talk about christmas vacation",
							 priority: .low,
							 dueDate: Date(timeIntervalSince1970: 1574193600),
							 timeToComplete: 100,
							 completed: false))
		
		mockData.append(Task(title: "Buy groceries",
							 description: "Check grocery list",
							 priority: .high,
							 dueDate: Date(timeIntervalSince1970: 1574262000),
							 timeToComplete: 100,
							 completed: true))
		
		mockData.append(Task(title: "Make dinner",
							 description: "Spaghetti for two",
							 priority: .medium,
							 dueDate: Date(timeIntervalSince1970: 1574280000),
							 timeToComplete: 100,
							 completed: false))
		
		return mockData
	}
	
	func order(by order: Order) {
		
	}
}
