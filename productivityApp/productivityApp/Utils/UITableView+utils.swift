//
//  UITableView+reload.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 20/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import UIKit

extension UITableView {
	func reload() {
		let range = NSMakeRange(0, self.numberOfSections)
		let sections = NSIndexSet(indexesIn: range)
		self.reloadSections(sections as IndexSet, with: .automatic)
	}
}
