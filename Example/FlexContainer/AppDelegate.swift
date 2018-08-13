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
	
	#if swift(>=4.2)
	public typealias LaunchOptionKey = UIApplication.LaunchOptionsKey
	#else
	public typealias LaunchOptionKey = UIApplicationLaunchOptionsKey
	#endif
	
	func application(_ app: UIApplication, willFinishLaunchingWithOptions opts: [LaunchOptionKey : Any]? = nil) -> Bool {
		toggleCurrentStyle()
		
		return true
	}
	
	let lightStyleContainer = StyleContainer(with: LightStyle())
	let darkStyleContainer = StyleContainer(with: DarkStyle())
	
	private var oneOfStyles = true
	
	func toggleCurrentStyle() {
		oneOfStyles = !oneOfStyles
		
		#if swift(>=4.2)
		#warning("Styled - impl live reload for view hierarchy when style changes.")
		#endif
		
		UIApplication.shared.currentStyleContainer = oneOfStyles ? lightStyleContainer : darkStyleContainer
	}

}
