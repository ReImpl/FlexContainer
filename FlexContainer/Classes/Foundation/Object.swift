//
//  Object.swift
//
//  Created by kernel on 12/29/15.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import Foundation

public extension NSObjectProtocol {
	
//	#if swift(>=4.2)
//	@inlinable
//	#endif
	public var className: String {
		return type(of: self).className
	}
	
//	#if swift(>=4.2)
//	@inlinable
//	#endif
	public static var className: String {
		return NSStringFromClass(self).components(separatedBy: ".").last!
	}
	
}
