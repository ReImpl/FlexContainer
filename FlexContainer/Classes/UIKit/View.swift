//
//  View.swift
//
//  Created by kernel on 12/23/16.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit

public extension UIView {
	
	func removeAllSubviews() {
		subviews.forEach { $0.removeFromSuperview() }
	}
	
	func removeAllGestureRecognizers() {
		gestureRecognizers?.forEach { self.removeGestureRecognizer($0) }
	}
	
}
