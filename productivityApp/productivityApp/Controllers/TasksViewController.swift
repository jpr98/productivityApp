//
//  TasksViewController.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 19/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

enum Identifiers: String {
	case taskCell = "taskCell"
	
	func getNib() -> UINib {
		switch self {
		case .taskCell:
			return UINib(nibName: "TaskTableViewCell", bundle: nil)
		}
	}
}

class TasksViewController: UIViewController {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var orderSegmentedControl: UISegmentedControl!
	@IBOutlet weak var tasksTableView: UITableView!
	@IBOutlet weak var optionsButton: UIButton!
	
	private var tasks = [Task]()
	private var order = Order.time
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		tasks = Task.mock()
		
		tasksTableView.delegate = self
		tasksTableView.dataSource = self
		tasksTableView.separatorStyle = .none
		
		tasksTableView.register(Identifiers.taskCell.getNib(), forCellReuseIdentifier: Identifiers.taskCell.rawValue)
		
	}
	
	
	// MARK: - IBActions
	@IBAction func optionsButtonTapped(_ sender: Any) {
		// TODO: Show options
	}
	
	@IBAction func orderSegmentedControlValueChanged(_ sender: Any) {
		// TODO: Change order of tableView
	}
	
}

// MARK: - UITableView
extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tasks.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if order == .time || order == .priority {
			
			guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.taskCell.rawValue, for: indexPath) as? TaskTableViewCell else {
				return UITableViewCell()
			}
			
			cell.task = tasks[indexPath.row]
			cell.setup()
			
			return cell
			
		} else {
			
		}
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	
}
