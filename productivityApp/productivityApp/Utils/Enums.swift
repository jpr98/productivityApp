//
//  Enums.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 19/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

enum Identifiers: String {
	
	case taskCell = "taskCell"
	case smartTaskCell = "smartTaskCell"
	case tagCell = "tagCell"
	case addTagCell = "addTagCell"
	
	case dueDateCell = "DueDateCell"
	case titleCell = "TitleCell"
	case notesCell = "NotesCell"
	case tagPickerCell = "TagPickerCell"
	case priorityCell = "PriorityCell"
	case timeToCompleteCell = "TimeToCompleteCell"
	case startCell = "StartCell"
	
	func getNib() -> UINib {
		
		switch self {
		case .taskCell:
			return UINib(nibName: "TaskTableViewCell", bundle: nil)
		case .smartTaskCell:
			return UINib(nibName: "SmartTaskTableViewCell", bundle: nil)
		case .tagCell:
			return UINib(nibName: "TagCollectionViewCell", bundle: nil)
		case .addTagCell:
			return UINib(nibName: "AddTagCollectionViewCell", bundle: nil)
		case .dueDateCell:
			return UINib(nibName: "DueDateCell", bundle: nil)
		case .titleCell:
			return UINib(nibName: "TitleCell", bundle: nil)
		case .notesCell:
			return UINib(nibName: "NotesCell", bundle: nil)
		case .tagPickerCell:
			return UINib(nibName: "TagPickerCell", bundle: nil)
		case .priorityCell:
			return UINib(nibName: "PriorityCell", bundle: nil)
		case .timeToCompleteCell:
			return UINib(nibName: "TimeToCompleteCell", bundle: nil)
		case .startCell:
			return UINib(nibName: "StartCell", bundle: nil)
		}
		
	}
	
}

enum Order {
	case time
	case priority
	case smart
	
	static func get(from index: Int) -> Order {
		if index == 0 {
			return time
		} else if index == 1 {
			return priority
		} else {
			return smart
		}
	}
}

enum Priority: Int {
	case low = 0
	case medium = 1
	case high = 2
	
	static func create(for number: Int) -> Priority {
		switch number {
		case 0:
			return .low
		case 1:
			return .medium
		case 2:
			return .high
		default:
			return .low
		}
	}
}

enum ViewType {
	case background
	case cell
	case priority(Priority)
	case complete
	case save
	case tag
}

enum Direction {
	case toLeft
	case toRight
	case unknown
}

enum FontType {
	case bold
	case book
	case light
	case medium
}
