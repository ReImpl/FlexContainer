//
//  AppDelegate.swift
//  FlexContainer
//
//  Created by genkernel on 07/15/2018.
//  Copyright (c) 2018 genkernel. All rights reserved.
//

import UIKit
import FlexContainer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	
	typealias LaunchOptionKey = UIApplication.LaunchOptionsKey
	
	func application(_ app: UIApplication, willFinishLaunchingWithOptions opts: [LaunchOptionKey : Any]? = nil) -> Bool {
		toggleCurrentStyle()
		
		app.presentWindow(with: ScrollableContentFlow())
		
		return true
	}
	
	let lightStyleContainer = LightStyle()
	let darkStyleContainer = DarkStyle()
	
	private var oneOfStyles = true
	
	func toggleCurrentStyle() {
		oneOfStyles = !oneOfStyles
		
		#warning("Styled - impl live reload for view hierarchy when style changes.")
		
		UIApplication.shared.currentStyleContainer = oneOfStyles ? lightStyleContainer : darkStyleContainer
	}

}
