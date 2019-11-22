//
//  TaskDetailTableViewController.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
	
	static func makeTaskDetailTableViewController() -> TaskDetailTableViewController {
		return UIStoryboard(name: "TaskDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: TaskDetailTableViewController.self)) as! TaskDetailTableViewController
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.separatorStyle = .none
		tableView.rowHeight = UITableView.automaticDimension
		tableView.allowsSelection = false
		tableView.alwaysBounceVertical = false
		registerCells()
	}
	
	func registerCells() {
		self.tableView.register(Identifiers.dueDateCell.getNib(), forCellReuseIdentifier: Identifiers.dueDateCell.rawValue)
		self.tableView.register(Identifiers.titleCell.getNib(), forCellReuseIdentifier: Identifiers.titleCell.rawValue)
		self.tableView.register(Identifiers.notesCell.getNib(), forCellReuseIdentifier: Identifiers.notesCell.rawValue)
		self.tableView.register(Identifiers.tagPickerCell.getNib(), forCellReuseIdentifier: Identifiers.tagPickerCell.rawValue)
		self.tableView.register(Identifiers.priorityCell.getNib(), forCellReuseIdentifier: Identifiers.priorityCell.rawValue)
		self.tableView.register(Identifiers.timeToCompleteCell.getNib(), forCellReuseIdentifier: Identifiers.timeToCompleteCell.rawValue)
	}
	
}

// MARK: - UITableView
extension TaskDetailTableViewController {
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.dueDateCell.rawValue) as? DueDateCell else {
				return UITableViewCell()
			}
			cell.dateTextFiedl.text = "hello"
			return cell
		} else if indexPath.section == 1 {
			if indexPath.row == 0 {
				guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.titleCell.rawValue) as? TitleCell else {
					return UITableViewCell()
				}
				cell.titleTextField.text = "JP"
				return cell
			} else {
				guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.notesCell.rawValue) as? NotesCell else {
					return UITableViewCell()
				}
				cell.notesTextView.text = "Rskajhsdflakjsdhflkajdhsflakjshdflakj,shdflakj,shflkj,shdflakj,hsdlfka,nsbdlfjhmanhsld.kjf,mhanslkdjf,halsdk,nfbalkjs,fmhnlaksj,fdalkjs.,fmhalsdkj,fhansldkjf,hanldkfj,andfj.,amnsdf.ja,mdsnfajd"
				return cell
			}
		} else if indexPath.section == 2 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.tagPickerCell.rawValue) as? TagPickerCell else {
				return UITableViewCell()
			}
			cell.backgroundColor = .red
			return cell
		} else if indexPath.section == 3 {
			if indexPath.row == 0 {
				guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.priorityCell.rawValue) as? PriorityCell else {
					return UITableViewCell()
				}
				cell.configure()
				return cell
			} else if indexPath.row == 1 {
				guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.timeToCompleteCell.rawValue) as? TimeToCompleteCell else {
					return UITableViewCell()
				}
				return cell
			}
		}
		return UITableViewCell()
	}
	
}

// MARK: - ShowVC Extension
extension UIViewController {
	func showTaskDetailTableViewController() {
		
		let vc = TaskDetailTableViewController.makeTaskDetailTableViewController()
		
		present(vc, animated: true, completion: nil)
		
	}
}
