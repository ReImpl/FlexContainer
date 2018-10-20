//
//  Button.swift
//
//  Created by kernel on 12/23/16.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit

public extension UIButton {
	
	public func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
		setBackgroundImage(UIImage.pixel(from: color), for: state)
	}
	
}
