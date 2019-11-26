//
//  SmartTaskTableViewCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 19/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class SmartTaskTableViewCell: UITableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var progressView: UIView!
	@IBOutlet weak var priorityColorView: UIView!
	@IBOutlet weak var taskView: UIView!
	@IBOutlet weak var timeLeftLabel: UILabel!
	@IBOutlet weak var completedLineView: UIView!
	
	
	var task: Task!
	
	override func awakeFromNib() {
		
		super.awakeFromNib()
		
		self.contentView.backgroundColor = UIColor.color(for: .background)
		
		taskView.backgroundColor = UIColor.color(for: .cell)
		taskView.layer.cornerRadius = 9
		taskView.layer.masksToBounds = true
		taskView.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
		taskView.layer.borderWidth = 0.5
		
		setProgressView()
		self.progressView.setNeedsDisplay()
		
	}
	
	func setup() {
		
		titleLabel.text = task.title
		priorityColorView.backgroundColor = UIColor.color(for: .priority(task.priority))
		timeLeftLabel.text = task.timeToComplete.getHoursMinutes()
		completedLineView.isHidden = !task.completed
		
	}
	
	func setProgressView() {
		
		let shapeLayer = CAShapeLayer()
		let center = progressView.center
		let radius = progressView.frame.width / 2
		let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi * 2, clockwise: true)
		shapeLayer.path = circularPath.cgPath
		
		shapeLayer.strokeColor = UIColor.red.cgColor
		shapeLayer.lineWidth = 10
		
		shapeLayer.lineCap = CAShapeLayerLineCap.round
		
		
		progressView.layer.addSublayer(shapeLayer)
		
	}
	
}
