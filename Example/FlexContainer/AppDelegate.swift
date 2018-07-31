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
	
	func application(_ app: UIApplication, willFinishLaunchingWithOptions opts: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		toggleCurrentStyle()
		
		return true
	}
	
	let lightStyleContainer = StyleContainer(with: LightStyle())
	let darkStyleContainer = StyleContainer(with: DarkStyle())
	
	private var oneOfStyles = true
	
	func toggleCurrentStyle() {
		oneOfStyles.toggle()
		
		#warning("Styled - impl live reload for view hierarchy when style changes.")
		
		UIApplication.shared.currentStyleContainer = oneOfStyles ? lightStyleContainer : darkStyleContainer
	}

}

