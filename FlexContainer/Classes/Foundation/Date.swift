//
//  Date.swift
//
//  Created by kernel on 12/29/15.
//  Copyright © 2016 ReImpl. All rights reserved.
//

extension Date {
	
	func startOfDay() -> Date {
		return Calendar.current.startOfDay(for: self)
	}
	
	func endOfDay() -> Date {
		var components = DateComponents()
		components.day = 1
		components.minute = -1
		return Calendar.autoupdatingCurrent.date(byAdding: components, to: startOfDay())!
	}
	
}
