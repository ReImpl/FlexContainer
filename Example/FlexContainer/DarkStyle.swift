//
//  DarkStyle.swift
//  Example
//
//  Created by Anthony on 7/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import FlexContainer

final class DarkStyle: AppStyle {
	
	let background1: Style = {
		let props: Style.Props = [
			.backgroundColor: UIColor.black
		]
		
		return Style(props: props)
	}()
	
	var background2: Style = {
		let props: Style.Props = [
			.backgroundColor: UIColor.darkGray
		]
		
		return Style(props: props)
	}()
	
}
