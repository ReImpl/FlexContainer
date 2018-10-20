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
	
	func constraintsToPinToSuperviewEdges() -> PinConstrains {
		let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: 0)
		
		let left = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: superview, attribute: .left, multiplier: 1, constant: 0)
		
		let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: 0)
		
		let right = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: superview, attribute: .right, multiplier: 1, constant: 0)
		
		return (top: top, right: right, bottom: bottom, left: left)
	}
	
	func constraintsToPinToSuperviewMargins() -> PinConstrains {
		let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .topMargin, multiplier: 1, constant: 0)
		
		let left = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leadingMargin, multiplier: 1, constant: 0)
		
		let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottomMargin, multiplier: 1, constant: 0)
		
		let right = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailingMargin, multiplier: 1, constant: 0)
		
		return (top: top, right: right, bottom: bottom, left: left)
	}
	
	func pinToSuperviewEdges() {
		pin(to: constraintsToPinToSuperviewEdges())
	}
	
	func pinToSuperviewMargins() {
		pin(to: constraintsToPinToSuperviewMargins())
	}
	
	private func pin(to pins: PinConstrains) {
		translatesAutoresizingMaskIntoConstraints = false
		
		superview?.addConstraints([
			pins.top, pins.right, pins.bottom, pins.left]
		)
	}
	
}
