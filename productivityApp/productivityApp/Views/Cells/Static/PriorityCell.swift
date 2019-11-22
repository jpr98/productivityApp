//
//  PriorityCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class PriorityCell: UITableViewCell {
	
	@IBOutlet weak var priorityLabel: UILabel!
	@IBOutlet weak var priorityPickView: PriorityView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configure() {
		priorityPickView.setSubViews()
		priorityPickView.delegate = self
	}
}

// MARK: - PriorityViewDelegate
extension PriorityCell: PriorityViewDelegate {
	func lowPrioritySelected() {
		print("low")
	}
	
	func mediumPrioritySelected() {
		print("med")
	}
	
	func highPrioritySelected() {
		print("high")
	}
	
	
}
