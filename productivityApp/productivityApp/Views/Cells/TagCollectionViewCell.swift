//
//  TagCollectionViewCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var tagView: UIView!
	@IBOutlet weak var nameLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configure(tag: Tag, tagHasBeenSelected: Bool = false, selected: Bool = false) {
		nameLabel.text = tag.title
		if tagHasBeenSelected {
			tagView.backgroundColor = selected ? .red : .gray
		} else {
			tagView.backgroundColor = .red
		}
		tagView.layer.cornerRadius = self.frame.height / 2
	}
}
