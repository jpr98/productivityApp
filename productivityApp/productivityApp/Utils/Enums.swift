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
	
	func getNib() -> UINib {
		
		switch self {
		case .taskCell:
			return UINib(nibName: "TaskTableViewCell", bundle: nil)
		case .smartTaskCell:
			return UINib(nibName: "SmartTaskTableViewCell", bundle: nil)
		}
		
	}
	
}

enum Order {
	case time
	case priority
	case smart
}

enum Priority: Int {
	case low = 0
	case medium = 1
	case high = 2
}

enum ViewType {
	case background
	case cell
	case priority(Priority)
}
