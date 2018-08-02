//
//  Color.swift
//
//  Created by kernel on 12/23/16.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit

public extension UIColor {
	
	convenience init(hex: Int, alpha: CGFloat = 1) {
		let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
		let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
		let blue = CGFloat((hex & 0xFF)) / 255.0
		
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
	
	static var random: UIColor {
		#if swift(>=4.2)
		let r = CGFloat.random(in: 0...1)
		let g = CGFloat.random(in: 0...1)
		let b = CGFloat.random(in: 0...1)
		#else
		let r = CGFloat(arc4random()) / CGFloat.greatestFiniteMagnitude
		let g = CGFloat(arc4random()) / CGFloat.greatestFiniteMagnitude
		let b = CGFloat(arc4random()) / CGFloat.greatestFiniteMagnitude
		#endif
		
		return UIColor(red: r, green: g, blue: b, alpha: 1)
	}
	
}
