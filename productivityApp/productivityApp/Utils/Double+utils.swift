//
//  Double+utils.swift
//  productivityApp
//
//  Created by Juan Pablo Ramos on 23/11/19.
//  Copyright © 2019 Juan Pablo Ramos. All rights reserved.
//

import Foundation

extension Double {
	var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
