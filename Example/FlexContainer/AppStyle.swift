//
//  Style.swift
//  Example
//
//  Created by Anthony on 7/30/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Layoutless
import FlexContainer

protocol AppStyle: StyleContainer {
	
	var background1: Style<UIView> { get }
	var background2: Style<UIView> { get }
	
}
