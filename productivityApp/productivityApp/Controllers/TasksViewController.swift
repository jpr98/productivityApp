//
//  TasksViewController.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 19/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var orderSegmentedControl: UISegmentedControl!
	@IBOutlet weak var tasksTableView: UITableView!
	@IBOutlet weak var optionsButton: UIButton!
	
	// Add Button View
	@IBOutlet weak var addButtonView: AddButton!
	@IBOutlet weak var addButton: UIButton!
	@IBOutlet weak var addButtonImage: UIImageView!
	@IBOutlet weak var addButtonText: UILabel!
	
	
	private var tasks = [Task]()
	private var sectionDays = [DaySection]()
	private var order = Order.time
	private var editMode: Bool = false
	private var showCompleted: Bool = false
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		// TODO: Set background color to view and tableView
		self.view.backgroundColor = UIColor.color(for: .background)
		self.tasksTableView.backgroundColor = UIColor.color(for: .background)
	}
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		tasks = Task.mock()
		Task.order(tasks, by: order) { orderedTasks in
			self.tasks = orderedTasks
			
		}
		sectionDays = Task.getSections(for: tasks)
		
		tasksTableView.delegate = self
		tasksTableView.dataSource = self
		tasksTableView.separatorStyle = .none
		
		tasksTableView.register(Identifiers.taskCell.getNib(), forCellReuseIdentifier: Identifiers.taskCell.rawValue)
		tasksTableView.register(Identifiers.smartTaskCell.getNib(), forCellReuseIdentifier: Identifiers.smartTaskCell.rawValue)
		
	}
	
	func displayAddButtonView() {
		
	}
	
	// MARK: - IBActions
	@IBAction func optionsButtonTapped(_ sender: Any) {
		
		let optionsVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		
		if showCompleted {
			let showCompletedAction = UIAlertAction(title: "Hide completed", style: .default) { _ in
				self.showCompleted = false // Maybe change to fetch only non-completed
			}
			optionsVC.addAction(showCompletedAction)
		} else {
			let showCompletedAction = UIAlertAction(title: "Show completed", style: .default) { _ in
				self.showCompleted = true // Maybe change to fetch all
			}
			optionsVC.addAction(showCompletedAction)
		}
		
		if editMode {
			let editModeAction = UIAlertAction(title: "Exit edit mode", style: .default) { _ in
				self.editMode = false
			}
			optionsVC.addAction(editModeAction)
		} else {
			let editModeAction = UIAlertAction(title: "Enter edit mode", style: .default) { _ in
				self.editMode = true
			}
			optionsVC.addAction(editModeAction)
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
			self.dismiss(animated: true, completion: nil)
		}
		optionsVC.addAction(cancelAction)
		
		present(optionsVC, animated: true, completion: nil)
	}
	
	@IBAction func orderSegmentedControlValueChanged(_ sender: Any) {
		
		order = Order.get(from: orderSegmentedControl.selectedSegmentIndex)
		
		Task.order(tasks, by: order) { orderedTasks in
			self.tasks = orderedTasks
			self.tasksTableView.reloadData()
		}
		
	}
	
}

// MARK: - UITableView
extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		if order == .time {
			return sectionDays.count
		}
		return 1
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if tableView.numberOfSections > 1 {
			return sectionDays[section].day
		}
		return nil
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if order == .time {
			return sectionDays[section].items
		}
		if section == 0 {
			return tasks.count
		}
		return 0
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if order == .time || order == .priority {
			
			guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.taskCell.rawValue, for: indexPath) as? TaskTableViewCell else {
				return UITableViewCell()
			}
			
			cell.task = tasks[indexPath.row]
			cell.setup()
			
			return cell
			
		} else if order == .smart {
			
			guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.smartTaskCell.rawValue, for: indexPath) as? SmartTaskTableViewCell else {
				return UITableViewCell()
			}
			
			cell.task = tasks[indexPath.row]
			cell.setup()
			
			return cell
			
		}
		
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 65
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// TODO: Navigate to cell's info and pass editMode
	}
	
	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let action = UIContextualAction(style: .normal, title: "Complete") { (_, _, _) in
			self.tasks[indexPath.row].completed = true // TODO: Mark as completed in coreData
			self.tasks.remove(at: indexPath.row)
			tableView.reload()
		}
		
		action.backgroundColor = .green // TODO: Change color and maybe add icon
		
		let configuration = UISwipeActionsConfiguration(actions: [action])
		return configuration
		
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let action = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
			// TODO: Delete from core Data
			self.tasks.remove(at: indexPath.row)
			tableView.reload()
		}
		
		let configuration = UISwipeActionsConfiguration(actions: [action])
		return configuration
		
	}
}
