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

#if swift(>=4.2)
public typealias WindowLevel = UIWindow.Level
public var normalWindowLevel: WindowLevel {
	return .normal
}
#else
public typealias WindowLevel = UIWindowLevel
public var normalWindowLevel: WindowLevel {
	return UIWindowLevelNormal
}
#endif

public extension UIApplication {
	
	public enum WindowMode {
		case key
		case new
	}
	
//	#if swift(>=4.2)
//	@inlinable
//	#endif
	@discardableResult
	public func presentWindow(with flow: Flow, rect: CGRect = UIScreen.main.bounds, level: WindowLevel = normalWindowLevel, mode: WindowMode = .key) -> UIWindow {
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
	
	private func window(rect: CGRect, level: WindowLevel, mode: WindowMode) -> UIWindow {
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
	
//	#if swift(>=4.2)
//	@usableFromInline
//	#endif
	static func load(_ storyboard: Storyboard) -> UIStoryboard {
		return UIStoryboard(name: storyboard.name, bundle: nil)
	}
	
}


extension UIViewController: FlowController {
	
//	#if swift(>=4.2)
//	@inlinable
//	#endif
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
	
//	#if swift(>=4.2)
//	@usableFromInline
//	#endif
	func getFlowValue() -> Flow? {
		return objc_getAssociatedObject(self, &flowKey) as? Flow
	}
	
//	#if swift(>=4.2)
//	@usableFromInline
//	#endif
	func setFlowValue(_ flow: Flow) {
		objc_setAssociatedObject(self, &flowKey, flow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
	}
	
}
