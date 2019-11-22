//
//  PriorityView.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

protocol PriorityViewDelegate: class {
	func lowPrioritySelected()
	func mediumPrioritySelected()
	func highPrioritySelected()
}

class PriorityView: UIView {

    weak var delegate: PriorityViewDelegate?
	let stackView = UIStackView()
	
	func setSubViews() {
		
		prepareStack()
		stackView.backgroundColor = .blue
		self.addSubview(stackView)
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		let horizontalConstraint = stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		let verticalConstraint = stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		let widthConstraint = stackView.widthAnchor.constraint(equalToConstant: self.frame.width)
		let heightConstraint = stackView.heightAnchor.constraint(equalToConstant: self.frame.height)
		
		NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
		
	}
	
	private func prepareStack() {
		
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fill
		stackView.spacing = 8
		
		let lowButton = UIButton()
		lowButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
		lowButton.layer.cornerRadius = 0.5 * lowButton.bounds.size.width
		lowButton.clipsToBounds = true
		lowButton.backgroundColor = UIColor.color(for: .priority(.low))
		lowButton.addTarget(self, action: #selector(lowButtonTapped), for: .touchUpInside)
		stackView.addArrangedSubview(lowButton)
		
		let mediumButton = UIButton()
		mediumButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
		mediumButton.layer.cornerRadius = 0.5 * mediumButton.bounds.size.width
		mediumButton.clipsToBounds = true
		mediumButton.backgroundColor = UIColor.color(for: .priority(.low))
		mediumButton.addTarget(self, action: #selector(mediumButtonTapped), for: .touchUpInside)
		stackView.addArrangedSubview(mediumButton)
		
		let highButton = UIButton()
		highButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
		highButton.layer.cornerRadius = 0.5 * highButton.bounds.size.width
		highButton.clipsToBounds = true
		highButton.backgroundColor = UIColor.color(for: .priority(.low))
		highButton.addTarget(self, action: #selector(highButtonTapped), for: .touchUpInside)
		stackView.addArrangedSubview(highButton)
		
		let lowMedWidth = lowButton.widthAnchor.constraint(equalToConstant: mediumButton.frame.width)
		let medHighWidth = mediumButton.widthAnchor.constraint(equalToConstant: highButton.frame.width)
		
		NSLayoutConstraint.activate([lowMedWidth, medHighWidth])
		
	}
	
	@objc func lowButtonTapped() {
		self.delegate?.lowPrioritySelected()
	}
	
	@objc func mediumButtonTapped() {
		self.delegate?.mediumPrioritySelected()
	}
	
	@objc func highButtonTapped() {
		self.delegate?.highPrioritySelected()
	}
	
}
