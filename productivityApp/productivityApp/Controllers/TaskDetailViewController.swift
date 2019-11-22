//
//  TaskDetailViewController.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 21/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
	
	static func makeTaskDetailViewController() -> TaskDetailViewController {
		return UIStoryboard(name: "TaskDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: TaskDetailViewController.self)) as! TaskDetailViewController
	}
	
	@IBOutlet weak var contentView: UIView!
	@IBOutlet weak var dateTextField: UITextField!
	@IBOutlet weak var timeTextField: UITextField!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var titleUnderlineView: UIView!
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var tagsCollectionView: UICollectionView!
	@IBOutlet weak var priorityLabel: UILabel!
	@IBOutlet weak var priorityPickerView: UIView!
	@IBOutlet weak var timeToCompleteLabel: UILabel!
	@IBOutlet weak var timeToCompleteTextField: UITextField!
	
	var task = Task()
	var editingMode: Bool = true
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		
		self.view.backgroundColor = UIColor.color(for: .background)
		contentView.backgroundColor = UIColor.color(for: .background)
		tagsCollectionView.backgroundColor = UIColor.color(for: .background)
		titleTextField.backgroundColor = UIColor.color(for: .background)
		descriptionTextView.backgroundColor = UIColor.color(for: .background)
		
	}
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		descriptionTextView.delegate = self
		tagsCollectionView.dataSource = self
		tagsCollectionView.delegate = self
		
		tagsCollectionView.register(Identifiers.tagCell.getNib(), forCellWithReuseIdentifier: Identifiers.tagCell.rawValue)
		
		// TODO: collectionview horizontal layout
		
		setTaskData()
		
	}
	
	func setTaskData() {
		
		if task.title == "" {
			// We have a new task, so leave everything with a placeholder
		} else {
			// We have an existing task, so set it's info
			
			dateTextField.text = task.dueDate.getDayMonth()
			timeTextField.text = task.dueDate.getTime()
			titleTextField.text = task.title
			descriptionTextView.text = task.notes
			// TODO: collectionView = set selected tag
			// TODO: priorityPickerView = set selected priority
			timeToCompleteTextField.text = task.timeToComplete.getHoursMinutes()
			
			// TODO: Show button to start working on task (aka timer)
		}
		
	}
	
	// MARK: - UI Actions
	@IBAction func dateTextFieldEditingDidEnd(_ sender: Any) {
	}
	
	@IBAction func timeTextFieldEditingDidEnd(_ sender: Any) {
	}
	
	@IBAction func titleTextFieldEditingDidEnd(_ sender: Any) {
	}
	
	@IBAction func timeToCompleteTextFieldEditingDidEnd(_ sender: Any) {
	}
	
}

// MARK: - UITextView
extension TaskDetailViewController: UITextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		// TODO: Check if existing text, else, change font and remove placeholder
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		// TODO: Check if not empty, else, change to temp font and add placeholder
	}
	
}

// MARK: - UICollectionView
extension TaskDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.tagCell.rawValue, for: indexPath) as? TagCollectionViewCell else {
			return UICollectionViewCell()
		}
		
		cell.nameLabel.text = "TagName\(indexPath.row)"
		
		return cell
		
	}
	
}

// MARK: - ShowVC Extension
extension UIViewController {
	func showTaskDetailViewController(task: Task, isEditing: Bool, presenter: UIViewController) {
		
		let vc = TaskDetailViewController.makeTaskDetailViewController()
		
		vc.task = task
		vc.editingMode = isEditing
		vc.modalPresentationStyle = .overFullScreen
		
		presenter.present(vc, animated: true, completion: nil)
		
	}
}
