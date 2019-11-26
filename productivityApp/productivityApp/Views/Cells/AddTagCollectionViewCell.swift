//
//  AddTagCollectionViewCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 23/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

protocol AddTagCollectionViewCellDelegate: class {
	func askedToAddTag()
}

class AddTagCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var addTagView: UIView!
	@IBOutlet weak var addTagButton: UIButton!
	@IBOutlet weak var addTagImageView: UIImageView!
	
	weak var delegate: AddTagCollectionViewCellDelegate?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configure(delegate: AddTagCollectionViewCellDelegate, tagHasBeenSelected: Bool = false) {
		
		self.delegate = delegate
		
		addTagImageView.tintColor = .black
		addTagView.backgroundColor = tagHasBeenSelected ? .gray : UIColor.color(for: .tag)
		addTagImageView.contentMode = .scaleAspectFill
		
		addTagView.clipsToBounds = true
		addTagView.layer.cornerRadius = self.frame.height / 2
	}
	
	// MARK: - IBActions
	@IBAction func addTaggButtonTapped(_ sender: Any) {
		delegate?.askedToAddTag()
	}
	
}
