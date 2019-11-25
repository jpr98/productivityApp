//
//  TaskDetailTableViewController.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

protocol TaskDetailTableViewControllerDelegate: class {
	func willDissapear()
}

class TaskDetailTableViewController: UITableViewController {
	
	static func makeTaskDetailTableViewController() -> TaskDetailTableViewController {
		return UIStoryboard(name: "TaskDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: TaskDetailTableViewController.self)) as! TaskDetailTableViewController
	}
	
	weak var delegate: TaskDetailTableViewControllerDelegate?
	
	var task = Task()
	var newTask = true
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
		
		tableView.separatorStyle = .none
		tableView.rowHeight = UITableView.automaticDimension
		tableView.allowsSelection = false
		tableView.alwaysBounceVertical = false
		registerCells()
		
		tableView.keyboardDismissMode = .onDrag
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		if task.title != "" {
			RealmHandler.shared.save(task)
			delegate?.willDissapear()
		}
		
	}

	func registerCells() {
		
		self.tableView.register(Identifiers.dueDateCell.getNib(), forCellReuseIdentifier: Identifiers.dueDateCell.rawValue)
		self.tableView.register(Identifiers.titleCell.getNib(), forCellReuseIdentifier: Identifiers.titleCell.rawValue)
		self.tableView.register(Identifiers.notesCell.getNib(), forCellReuseIdentifier: Identifiers.notesCell.rawValue)
		self.tableView.register(Identifiers.tagPickerCell.getNib(), forCellReuseIdentifier: Identifiers.tagPickerCell.rawValue)
		self.tableView.register(Identifiers.priorityCell.getNib(), forCellReuseIdentifier: Identifiers.priorityCell.rawValue)
		self.tableView.register(Identifiers.timeToCompleteCell.getNib(), forCellReuseIdentifier: Identifiers.timeToCompleteCell.rawValue)
		
	}
	
	func presentAlertForTag(completionHandler: @escaping (String?) -> Void) {
		
		let alertController = UIAlertController(title: "Tag", message: "Add a new tag", preferredStyle: .alert)
		
		alertController.addTextField { textField in
			textField.placeholder = "Tag name"
		}
		
		let addAction = UIAlertAction(title: "Add", style: .default) { _ in
			completionHandler(alertController.textFields?[0].text)
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
			completionHandler(nil)
		}
		
		alertController.addAction(addAction)
		alertController.addAction(cancelAction)
		
		self.present(alertController, animated: true, completion: nil)
		
	}
	
}

// MARK: - UITableView
extension TaskDetailTableViewController {
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.section == 0 {
			
			guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.dueDateCell.rawValue) as? DueDateCell else {
				return UITableViewCell()
			}
			
			let date = newTask ? Date() : task.dueDate
			cell.configure(delegate: self, date: date)
			
			return cell
			
		} else if indexPath.section == 1 {
			
			if indexPath.row == 0 {
				
				guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.titleCell.rawValue) as? TitleCell else {
					return UITableViewCell()
				}
				
				cell.configure(delegate: self, title: task.title)
				
				return cell
				
			} else {
				
				guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.notesCell.rawValue) as? NotesCell else {
					return UITableViewCell()
				}
				
				cell.configure(delegate: self, notes: task.notes)
				
				return cell
				
			}
			
		} else if indexPath.section == 2 {
			
			guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.tagPickerCell.rawValue) as? TagPickerCell else {
				return UITableViewCell()
			}
			
			let tags = RealmHandler.shared.getTags()
			cell.configure(delegate: self, vc: self, tags: tags, selectedTag: task.tag)
			
			return cell
			
		} else if indexPath.section == 3 {
			
			if indexPath.row == 0 {
				
				guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.priorityCell.rawValue) as? PriorityCell else {
					return UITableViewCell()
				}
				
				let priority = newTask ? nil : task.priority
				cell.configure(delegate: self, prioritySelected: priority)
				
				return cell
				
			} else if indexPath.row == 1 {
				
				guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.timeToCompleteCell.rawValue) as? TimeToCompleteCell else {
					return UITableViewCell()
				}
				
				cell.configure(delegate: self, time: task.timeToComplete)
				
				return cell
				
			}
		}
		return UITableViewCell()
	}
	
}

// MARK: - DueDateCellDelegate
extension TaskDetailTableViewController: DueDateCellDelegate {
	
	func dueDateSelected(_ date: Date) {
		task.dueDate = date
	}
	
}

// MARK: - TitleCellDelegate
extension TaskDetailTableViewController: TitleCellDelegate {
	
	func titleSelected(title: String) {
		task.title = title
	}
	
}

// MARK: - NotesCellDelegate
extension TaskDetailTableViewController: NotesCellDelegate {
	
	func notesAdded(notes: String) {
		task.notes = notes
	}
	
}

// MARK: - TagPickerCellDelegate
extension TaskDetailTableViewController: TagPickerCellDelegate {
	
	func createTag(with title: String, completionHandler: (_ success: Bool, _ newTags: [Tag]) -> Void) {
		
		let status = RealmHandler.shared.save(title)
		let tags = RealmHandler.shared.getTags()
		
		completionHandler(status, tags)
		
	}
	
	func tagSelected(tag: Tag) {
		task.tag = tag
	}
	
}

// MARK: - PriorityCellDelegate
extension TaskDetailTableViewController: PriorityCellDelegate {
	
	func prioritySelected(_ priority: Priority) {
		task.priority = priority
	}
	
}

// MARK: - TimeToCompleteCellDelegate
extension TaskDetailTableViewController: TimeToCompleteCellDelegate {
	
	func timeToCompleteSelected(_ time: TimeInterval) {
		task.timeToComplete = time
	}
	
}

// MARK: - ShowVC Extension
extension UIViewController {
	func showTaskDetailTableViewController(delegate: TaskDetailTableViewControllerDelegate, task: Task?) {
		
		let vc = TaskDetailTableViewController.makeTaskDetailTableViewController()
		
		vc.delegate = delegate
		
		if let task = task {
			vc.task = task
			vc.newTask = false
		}
		
		present(vc, animated: true, completion: nil)
		
	}
}
