//
//  WhiteStyle.swift
//  Example
//
//  Created by Anthony on 7/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import FlexContainer

struct LightStyle: AppStyle {
	
	let background1: Style = {
		let props: Style.Props = [
			.backgroundColor: UIColor.white
		]
		
		return Style(props: props)
	}()
	
	var background2: Style = {
		let props: Style.Props = [
			.backgroundColor: UIColor.gray
		]
		
		return Style(props: props)
	}()
	
}
