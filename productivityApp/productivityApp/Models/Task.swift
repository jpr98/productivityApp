//
//  Task.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 19/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
	
	@objc dynamic var id: Int
	@objc dynamic var title: String
	@objc dynamic var notes: String
	@objc dynamic var priorityNumber: Int
	@objc dynamic var dueDate: Date
	@objc dynamic var timeToComplete: TimeInterval
	@objc dynamic var completed: Bool
	private var tagNumber: Int
	
	
	var priority: Priority {
		didSet {
			priorityNumber = priority.rawValue
		}
	}
	
	@objc dynamic var tag: Tag!
	
	required init() {
		
		id = -1
		title = ""
		notes = ""
		priorityNumber = 0
		dueDate = Date()
		timeToComplete = TimeInterval()
		completed = false
		tagNumber = 0
		priority = .low
		tag = Tag()
		
	}
	
	init(id: Int, title: String, notes: String, priority: Priority, dueDate: Date, timeToComplete: TimeInterval, completed: Bool, tag: Tag) {
		
		self.id = id
		self.title = title
		self.notes = notes
		self.priorityNumber = priority.rawValue
		self.dueDate = dueDate
		self.timeToComplete = timeToComplete
		self.completed = completed
		self.tagNumber = tag.id
		self.priority = priority
		self.tag = tag
		
	}
	
	init(with t: Task) {
		
		self.id = t.id
		self.title = t.title
		self.notes = t.notes
		self.priorityNumber = t.priorityNumber
		self.dueDate = t.dueDate
		self.timeToComplete = t.timeToComplete
		self.completed = t.completed
		self.tagNumber = t.tag.id
		self.priority = Priority.create(for: t.priorityNumber)
		self.tag = t.tag
		
	}
	
	// MARK: - Realm
	override static func ignoredProperties() -> [String] {
        return ["priority"]
    }
	
	// MARK: - Methods
	func calculateRemainingTime() -> TimeInterval {
		return 0
	}
	
}

// MARK: - Ordering methods (Static)
extension Task {
	static func order(array: [Task]? = nil, matrix: [[Task]]? = nil, by order: Order, showCompleted: Bool, completion: ([[Task]]) -> Void) {
		
		var taskArray = [Task]()
		
		if let t = convertToArray(matrix) {
			taskArray = t
		} else if let t = array {
			taskArray = t
		} else {
			fatalError("Task.order(by:) needs at least one valid array or matrix!")
		}
		
		switch order {
		case .priority:
			taskArray = orderByPriority(taskArray)
		case .time:
			taskArray = orderByTime(taskArray)
		case .smart:
			taskArray = orderBySmart(taskArray)
		}
		
		if !showCompleted {
			taskArray = taskArray.filter { (task) -> Bool in
				return !task.completed
			}
		}
		
		if order == .time {
			let timeOrder = prepareForTimeSections(taskArray)
			completion(timeOrder)
		} else {
			completion([taskArray])
		}
		
	}
	
	private static func orderByTime(_ tasks: [Task]) -> [Task] {
		
		var orderedTasks = tasks
		
		orderedTasks.sort { (first, second) -> Bool in
			return first.dueDate < second.dueDate
		}
		
		print("BY TIME")
		printHelper(t: orderedTasks)
		return orderedTasks
		
	}
	
	private static func prepareForTimeSections(_ tasks: [Task]) -> [[Task]] {
		
		var result = [[Task]]()
		var seenDays = Set<String>()
		
		for task in tasks {
			var sameDayTasks = [Task]()
			let currentTaskDay = task.dueDate.getString(for: .day)
			if !seenDays.contains(currentTaskDay) {
				for t in tasks {
					if currentTaskDay == t.dueDate.getString(for: .day) {
						sameDayTasks.append(t)
					}
				}
				seenDays.insert(currentTaskDay)
				result.append(sameDayTasks)
			}
		}
		
		printHelper(t: result)
		
		return result
	}
	
	private static func orderByPriority(_ tasks: [Task]) -> [Task] {
		
		var orderedTasks = tasks
		
		orderedTasks.sort { (first, second) -> Bool in
			return first.priority.rawValue > second.priority.rawValue
		}
		
		print("BY PRIORITY")
		printHelper(t: orderedTasks)
		return orderedTasks
		
	}
	
	private static func orderBySmart(_ tasks: [Task]) -> [Task] {
		
		var orderedTasks = tasks
		
		orderedTasks.sort { (first, second) -> Bool in
			return first.timeToComplete > second.timeToComplete
		}
		
		print("BY SMART")
		printHelper(t: orderedTasks)
		return orderedTasks
		
	}
	
	private static func convertToArray(_ matrix: [[Task]]?) -> [Task]? {
		
		if let m = matrix {
			var array = [Task]()
			
			for a in m {
				for t in a {
					array.append(t)
				}
			}
			
			return array
		}
		
		return nil
		
	}
	
}

// MARK: - Debugging helper functions
extension Task {
	static func printHelper(t: [Task]) {
		for task in t {
			print(task.title)
		}
		print("DONE1")
	}
	
	static func printHelper(t: [[Task]]) {
		for a in t {
			for task in a {
				print(task.title)
			}
			print("---------------")
		}
		print("DONE2")
	}
}
