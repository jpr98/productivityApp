//
//  TagPickerCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

protocol TagPickerCellDelegate: class {
	func createTag(with title: String, completionHandler: (_ success: Bool, _ newTags: [Tag]) -> Void)
	func tagSelected(tag: Tag)
}

class TagPickerCell: UITableViewCell {
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	weak var vc: TaskDetailTableViewController?
	weak var delegate: TagPickerCellDelegate?
	
	var tags = [Tag]()
	
	private var selectedTag: Int = -1 {
		didSet {
			if selectedTag == -1 {
				tagHasBeenSelected = false
			} else {
				tagHasBeenSelected = true
			}
		}
	}
	
	private var tagHasBeenSelected: Bool = false
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configure(delegate: TagPickerCellDelegate, vc: TaskDetailTableViewController, tags: [Tag], selectedTag: Tag) {
		
		self.delegate = delegate
		self.vc = vc
		self.tags = tags
		
		collectionView.delegate = self
		collectionView.dataSource = self
		
		collectionView.register(Identifiers.tagCell.getNib(), forCellWithReuseIdentifier: Identifiers.tagCell.rawValue)
		collectionView.register(Identifiers.addTagCell.getNib(), forCellWithReuseIdentifier: Identifiers.addTagCell.rawValue)
		
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.reloadData()
		
		if selectedTag.id != -1 {
			self.selectedTag = selectedTag.id
		}
	}
}

// MARK: - UICollectionView
extension TagPickerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return tags.count + 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if indexPath.row < tags.count {
			
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.tagCell.rawValue, for: indexPath) as? TagCollectionViewCell else {
				return UICollectionViewCell()
			}
			
			if tagHasBeenSelected {
				let selected = selectedTag == tags[indexPath.row].id
				cell.configure(tag: tags[indexPath.row], tagHasBeenSelected: true, selected: selected)
			} else {
				cell.configure(tag: tags[indexPath.row])
			}
			
			return cell
			
		} else {
			
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.addTagCell.rawValue, for: indexPath) as? AddTagCollectionViewCell else {
				return UICollectionViewCell()
			}
			
			if tagHasBeenSelected {
				cell.configure(delegate: self, tagHasBeenSelected: tagHasBeenSelected)
			} else {
				cell.configure(delegate: self)
			}
			
			return cell
			
		}
		
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if indexPath.row < tags.count {
			
			delegate?.tagSelected(tag: tags[indexPath.row])
			
			if tags[indexPath.row].id == selectedTag {
				selectedTag = -1
			} else {
				selectedTag = tags[indexPath.row].id
			}
			
			collectionView.reloadData()
			
		}
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		if indexPath.row < tags.count {
			return CGSize(width: 80, height: 30)
		} else {
			return CGSize(width: 30, height: 30)
		}
		
	}
	
}

// MARK: - AddTagCollectionViewCellDelegate
extension TagPickerCell: AddTagCollectionViewCellDelegate {
	
	func askedToAddTag() {
		vc?.presentAlertForTag(completionHandler: { tagName in
			if let name = tagName {
				
				self.delegate?.createTag(with: name, completionHandler: { (success, newTags) in
					if success {
						self.tags = newTags
						self.collectionView.reloadData()
					}
				})
				
			}
		})
	}
	
}
