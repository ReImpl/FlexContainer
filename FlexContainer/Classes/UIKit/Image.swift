//
//  UIViewAdditions.swift
//  UIKit
//
//  Created by kernel on 12/23/16.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit
import CoreGraphics

public extension UIImage {
	
	public class func image(withColor color: UIColor) -> UIImage? {
		let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
		UIGraphicsBeginImageContext(rect.size)
		
		let image: UIImage?
		if let context = UIGraphicsGetCurrentContext() {
			
			context.setFillColor(color.cgColor)
			context.fill(rect)
			
			image = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
		} else {
			image = nil
		}
		
		return image
	}
	
}
