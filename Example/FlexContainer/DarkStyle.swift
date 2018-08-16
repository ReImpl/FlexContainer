//
//  DarkStyle.swift
//  Example
//
//  Created by Anthony on 7/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Layoutless
import FlexContainer

final class DarkStyle: AppStyle {
	
	let background1 = Style<UIView> {
		$0.backgroundColor = .black
	}
	
	let background2 = Style<UIView> {
		$0.backgroundColor = .darkGray
	}
	
}
