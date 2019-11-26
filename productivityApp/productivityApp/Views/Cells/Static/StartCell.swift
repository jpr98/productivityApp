//
//  StartCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 25/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

protocol StartCellDelegate: class {
	func startPressed()
}

class StartCell: UITableViewCell {
	
	@IBOutlet weak var startButton: UIButton!
	
	weak var delegate: StartCellDelegate?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configure(delegate: StartCellDelegate, shouldHide: Bool) {
		
		self.delegate = delegate
		
		startButton.isHidden = shouldHide
		startButton.layer.cornerRadius = 8
		startButton.setTitle("Start", for: .normal)
		startButton.layer.backgroundColor = UIColor.color(for: .complete)?.cgColor
		startButton.setTitleColor(.white, for: .normal)
		
	}
	
	// MARK: - IBActions
	@IBAction func startButtonTapped(_ sender: Any) {
		delegate?.startPressed()
	}
	
}
