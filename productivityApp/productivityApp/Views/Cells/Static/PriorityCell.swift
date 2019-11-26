//
//  PriorityCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

protocol PriorityCellDelegate: class {
	func prioritySelected(_ priority: Priority)
}

class PriorityCell: UITableViewCell {
	
	@IBOutlet weak var priorityLabel: UILabel!
	@IBOutlet weak var priorityPickView: UIView!
	@IBOutlet weak var priorityPickStackView: UIStackView!
	@IBOutlet weak var lowPriorityButton: UIButton!
	@IBOutlet weak var mediumPriorityButton: UIButton!
	@IBOutlet weak var highPriorityButton: UIButton!
	
	weak var delegate: PriorityCellDelegate?
	var prioritySelected: Priority?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configure(delegate: PriorityCellDelegate, prioritySelected: Priority? = nil) {
		
		self.delegate = delegate
		self.prioritySelected = prioritySelected
		
		priorityLabel.font = UIFont.getFont(with: .medium, size: 19)
		
		configureButtonsCorners()
		configureButtonsColor()
		
	}
	
	private func configureButtonsColor() {
		
		if let priority = prioritySelected {
			
			lowPriorityButton.backgroundColor = .gray
			mediumPriorityButton.backgroundColor = .gray
			highPriorityButton.backgroundColor = .gray
			
			switch priority {
			case .low:
				lowPriorityButton.backgroundColor = UIColor.color(for: .priority(.low))
			case .medium:
				mediumPriorityButton.backgroundColor = UIColor.color(for: .priority(.medium))
			case .high:
				highPriorityButton.backgroundColor = UIColor.color(for: .priority(.high))
			}
			
		} else {
			lowPriorityButton.backgroundColor = UIColor.color(for: .priority(.low))
			mediumPriorityButton.backgroundColor = UIColor.color(for: .priority(.medium))
			highPriorityButton.backgroundColor = UIColor.color(for: .priority(.high))
		}
		
	}
	
	private func configureButtonsCorners() {
		
		lowPriorityButton.layer.cornerRadius = lowPriorityButton.frame.height / 2
		mediumPriorityButton.layer.cornerRadius = mediumPriorityButton.frame.height / 2
		highPriorityButton.layer.cornerRadius = highPriorityButton.frame.height / 2
		
	}
	
	// MARK: - IBActions
	@IBAction func lowPriorityButtonTapped(_ sender: Any) {
		prioritySelected = .low
		configureButtonsColor()
		delegate?.prioritySelected(.low)
	}
	
	@IBAction func mediumPriorityButtonTapped(_ sender: Any) {
		prioritySelected = .medium
		configureButtonsColor()
		delegate?.prioritySelected(.medium)
	}
	
	@IBAction func highPriorityButtonTapped(_ sender: Any) {
		prioritySelected = .high
		configureButtonsColor()
		delegate?.prioritySelected(.high)
	}
	
}


