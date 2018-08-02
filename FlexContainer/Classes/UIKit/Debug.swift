//
//  Debug.swift
//
//  Created by kernel on 12/23/16.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit

public extension UIView {
	
	func colorizeBorder(with color: UIColor, width: CGFloat = 1) {
		layer.borderColor = color.cgColor
		layer.borderWidth = width
	}
	
}
