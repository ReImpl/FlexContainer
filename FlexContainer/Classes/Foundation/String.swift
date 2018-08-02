//
//  String.swift
//
//  Created by kernel on 12/29/15.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import Foundation

#if swift(>=4.2)
public typealias AttributedKey = NSAttributedString.Key
#else
public typealias AttributedKey = NSAttributedStringKey
#endif

public extension NSAttributedString {
	
	public convenience init(from strings: [String], attributes: Array<[AttributedKey: Any]>) {
		assert(strings.count == attributes.count)
		
		let attributedString = NSMutableAttributedString()
		
		for i in 0..<strings.count {
			let pair = (strings[i], attributes[i])
			
			let string = NSAttributedString(string: pair.0, attributes: pair.1)
			attributedString.append(string)
		}
		
		self.init(attributedString: attributedString)
	}
	
}
