//
//  Tag.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import Foundation

class Tag {
	
	var id: Int
	var title: String
	
	init() {
		id = 0
		title = ""
	}
	
	init(id: Int, title: String) {
		self.id = id
		self.title = title
	}
	
}
