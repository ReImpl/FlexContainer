//
//  FlexibleContainerView.swift
//  FlowController
//
//  Created by kernel on 12/23/16.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit

public protocol FlowController {
	var flow: Flow { get }
}

public typealias WindowLevel = UIWindow.Level
public var normalWindowLevel: WindowLevel {
	return .normal
}

public extension UIApplication {
	
	public enum WindowMode {
		case key
		case new
	}
	
	@inlinable @discardableResult
	public func presentWindow(
		with flow: Flow,
		rect: CGRect = UIScreen.main.bounds,
		level: WindowLevel = normalWindowLevel,
		mode: WindowMode = .key) -> UIWindow {
		
		let storyboard = UIStoryboard.load(flow.initialStoryboard)
		let ctrl = storyboard.instantiateInitialViewController()!
		
		ctrl.setFlowValue(flow)
		
		let displayWindow = window(rect: rect, level: level, mode: mode)
		displayWindow.rootViewController = ctrl
		
		if mode == .key {
			displayWindow.makeKeyAndVisible()
		} else {
			displayWindow.isHidden = false
		}
		
		return displayWindow
	}
	
	@usableFromInline
	internal func window(rect: CGRect, level: WindowLevel, mode: WindowMode) -> UIWindow {
		let window: UIWindow
		
		if mode == .key, let existingWindow = delegate?.window as? UIWindow {
			window = existingWindow
		} else {
			window = UIWindow(frame: rect)
			window.windowLevel = level
		}
		
		return window
	}
	
}

extension UIStoryboard {
	
	@usableFromInline
	static func load(_ storyboard: Storyboard) -> UIStoryboard {
		return UIStoryboard(name: storyboard.name, bundle: nil)
	}
	
}


extension UIViewController: FlowController {
	
	@inlinable
	public var flow: Flow {
		let flow: Flow
		
		if let thisFlow = getFlowValue() {
			flow = thisFlow
		} else {
			flow = parent!.flow
		}
		
		return flow
	}
	
}

// MARK: - Internal

fileprivate var flowKey = "flow"

extension UIViewController {
	
	// MARK: - 'flow'
	
	@usableFromInline
	func getFlowValue() -> Flow? {
		return objc_getAssociatedObject(self, &flowKey) as? Flow
	}
	
	@usableFromInline
	func setFlowValue(_ flow: Flow) {
		objc_setAssociatedObject(self, &flowKey, flow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
	}
	
}
