//
//  Tag.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 22/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import Foundation
import RealmSwift

class Tag: Object {
	
	@objc dynamic var id: Int
	@objc dynamic var title: String
	
	required init() {
		id = -1
		title = ""
	}
	
	init(id: Int, title: String) {
		self.id = id
		self.title = title
	}
	
}
