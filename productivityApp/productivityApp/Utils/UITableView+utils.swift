//
//  UITableView+reload.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 20/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

extension UITableView {
	func reload(sections: Int, _ direction: Direction = .unknown, reloadData: Bool = false) {
		
		if reloadData {
			self.reloadData()
		}
		
		let range = NSMakeRange(0, sections)
		let sections = NSIndexSet(indexesIn: range)
		
		switch direction {
		case .toLeft:
			self.reloadSections(sections as IndexSet, with: .right)
		case .toRight:
			self.reloadSections(sections as IndexSet, with: .left)
		case .unknown:
			self.reloadSections(sections as IndexSet, with: .automatic)
		}
		
	}
}
