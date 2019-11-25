//
//  RealmHandler.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 25/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit
import RealmSwift

class RealmHandler {
	
	private var realm: Realm
	private var tagCount = 0
	private var taskCount = 0
	
	static var shared = RealmHandler()
	
	private init() {
		realm = try! Realm()
		print(realm.configuration.fileURL!)
	}
	
	// MARK: - Tasks
	func getTasks() -> [Task] {
		
		let resultTasks = realm.objects(Task.self)
		
		var tasks = [Task]()
		for task in resultTasks {
			let newTask = Task(with: task)
			tasks.append(newTask)
		}
		
		taskCount = tasks.count
		return tasks
		
	}
	
	func save(_ t: Task) {
		
		let predicate = NSPredicate(format: "id == \(t.id)")
		let sameIdTasks = realm.objects(Task.self).filter(predicate)
		
		if sameIdTasks.count > 0 {
			
			try! realm.write {
				sameIdTasks[0].id = t.id
				sameIdTasks[0].title = t.title
				sameIdTasks[0].notes = t.notes
				sameIdTasks[0].priorityNumber = t.priorityNumber
				sameIdTasks[0].dueDate = t.dueDate
				sameIdTasks[0].timeToComplete = t.timeToComplete
				sameIdTasks[0].completed = t.completed
				sameIdTasks[0].tag = t.tag
			}
			
		} else {
			
			try! realm.write {
				t.id = taskCount + 1
				realm.add(t)
			}
			
		}
		
	}
	
	func delete(_ task: Task) {
		
		try! realm.write {
			realm.delete(task)
		}
		
	}
	
	// MARK: - Tags
	func getTags() -> [Tag] {
		
		let resultTags = realm.objects(Tag.self)
		
		var tags = [Tag]()
		for tag in resultTags {
			tags.append(tag)
		}
		
		tagCount = tags.count
		
		return tags
		
	}
	
	func save(_ tagName: String) -> Bool {
		
		let predicate = NSPredicate(format: "title == %@", tagName)
		let sameNameTag = realm.objects(Tag.self).filter(predicate)
		
		if sameNameTag.count == 0 {
			
			try! realm.write {
				let tag = Tag(id: tagCount+1, title: tagName)
				realm.add(tag)
			}
			
			return true
			
		}
		
		return false
		
	}
	
}
