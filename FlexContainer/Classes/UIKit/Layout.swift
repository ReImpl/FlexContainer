//
//  Layout.swift
//
//  Created by kernel on 12/23/16.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit

// MARK: - constraints

public extension UIView {
	
	typealias PinConstrains = (top: NSLayoutConstraint, right: NSLayoutConstraint, bottom: NSLayoutConstraint, left: NSLayoutConstraint)
	
	func constraintsToPinToSuperviewMargins() -> PinConstrains {
		let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .topMargin, multiplier: 1, constant: 0)
		
		let left = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .leftMargin, multiplier: 1, constant: 0)
		
		let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottomMargin, multiplier: 1, constant: 0)
		
		let right = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .rightMargin, multiplier: 1, constant: 0)
		
		return (top: top, right: right, bottom: bottom, left: left)
	}
	
	func constraintsToPinToSuperview() -> PinConstrains {
		let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: 0)
		
		let left = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leading, multiplier: 1, constant: 0)
		
		let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: 0)
		
		let right = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailing, multiplier: 1, constant: 0)
		
		return (top: top, right: right, bottom: bottom, left: left)
	}
	
	func pinToSuperviewEdges() {
		translatesAutoresizingMaskIntoConstraints = false
		
		let pins = constraintsToPinToSuperview()
		superview?.addConstraints([pins.top, pins.right, pins.bottom, pins.left])
	}
	
}
