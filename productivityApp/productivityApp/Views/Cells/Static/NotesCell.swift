//
//  NotesCell.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

protocol NotesCellDelegate: class {
	func notesAdded(notes: String)
}

class NotesCell: UITableViewCell {
	
	@IBOutlet weak var notesTextView: UITextView!
	
	weak var delegate: NotesCellDelegate?
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configure(delegate: NotesCellDelegate, notes: String) {
		
		self.delegate = delegate
		
		notesTextView.delegate = self
		notesTextView.text = notes
		notesTextView.keyboardDismissable()
		prepareForNotEditing()
		
	}
	
	fileprivate func prepareForEditing() {
		
		if notesTextView.text == "Notes..." {
			notesTextView.text = ""
			notesTextView.textColor = .black
		}
		
	}
	
	fileprivate func prepareForNotEditing() {
		
		if notesTextView.text == "" {
			notesTextView.text = "Notes..."
			notesTextView.textColor = .lightGray
		}
		
	}
}

// MARK: - UITextView
extension NotesCell: UITextViewDelegate {
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		prepareForEditing()
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		prepareForNotEditing()
		delegate?.notesAdded(notes: textView.text)
	}
	
}

