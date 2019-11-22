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
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var titleUnderlineView: UIView!
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var tagsCollectionView: UICollectionView!
	@IBOutlet weak var priorityLabel: UILabel!
	@IBOutlet weak var priorityPickerView: UIView!
	@IBOutlet weak var timeToCompleteLabel: UILabel!
	@IBOutlet weak var timeToCompletePickerLabel: UILabel!
	
	var task = Task()
	var editingMode: Bool = true
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		descriptionTextView.delegate = self
		tagsCollectionView.dataSource = self
		tagsCollectionView.delegate = self
		
		tagsCollectionView.register(Identifiers.tagCell.getNib(), forCellWithReuseIdentifier: Identifiers.tagCell.rawValue)
		
		setTaskData()
		setInteractions()
		
	}
	
	func setTaskData() {
		
		if task.title == "" {
			// We have a new task, so leave everything with a placeholder
		} else {
			// We have an existing task, so set it's info
			
			dateLabel.text = task.dueDate.getDayMonth()
			timeLabel.text = task.dueDate.getTime()
			titleTextField.text = task.title
			descriptionTextView.text = task.notes
			// TODO: collectionView = set selected tag
			// TODO: priorityPickerView = set selected priority
			timeToCompletePickerLabel.text = task.timeToComplete.getHoursMinutes()
			
			// TODO: Show button to start working on task
		}
		
	}
	
	func setInteractions() {
		
		dateLabel.isUserInteractionEnabled = editingMode
		let dateTap = UITapGestureRecognizer(target: self, action: #selector(dateTapHandler))
		dateLabel.addGestureRecognizer(dateTap)
		
		timeLabel.isUserInteractionEnabled = editingMode
		let timeTap = UITapGestureRecognizer(target: self, action: #selector(timeTapHandler))
		timeLabel.addGestureRecognizer(timeTap)
		
		timeToCompletePickerLabel.isUserInteractionEnabled = editingMode
		let timeToCompleteTap = UITapGestureRecognizer(target: self, action: #selector(timeToCompleteHandler))
		timeToCompletePickerLabel.addGestureRecognizer(timeToCompleteTap)
		
	}
	
	@objc func dateTapHandler() {
		print("dateTap")
	}
	
	@objc func timeTapHandler() {
		print("timeTap")
	}
	
	@objc func timeToCompleteHandler() {
		print("timeToCompleteTap")
	}
	
	// MARK: - UI Actions
	@IBAction func titleTextFieldEditingDidEnd(_ sender: Any) {
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
	func showTaskDetailViewController(task: Task, isEditing: Bool) {
		
		let vc = TaskDetailViewController.makeTaskDetailViewController()
		
		vc.task = task
		vc.editingMode = isEditing
		
		present(vc, animated: true, completion: nil)
	}
}
