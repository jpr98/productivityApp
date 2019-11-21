//
//  TaskTableViewCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 19/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var dueTimeLabel: UILabel!
	@IBOutlet weak var priorityColorView: UIView!
	@IBOutlet weak var taskView: UIView!
	
	var task: Task!
	
	override func awakeFromNib() {
		
		super.awakeFromNib()
		
		self.contentView.backgroundColor = UIColor.color(for: .cell)
		
		taskView.layer.cornerRadius = 9
		taskView.layer.masksToBounds = true
		taskView.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
		taskView.layer.borderWidth = 0.5
		
	}
	
	func setup() {
		titleLabel.text = task.title
		dueTimeLabel.text = formatDate()
		priorityColorView.backgroundColor = UIColor.color(for: .priority(task.priority))
	}
	
	private func formatDate() -> String {
		
		let formatter = DateFormatter()
		formatter.dateFormat = "hh:mm a"
		formatter.amSymbol = "am"
		formatter.pmSymbol = "pm"
		
		return formatter.string(from: task.dueDate)
		
	}
	
}
