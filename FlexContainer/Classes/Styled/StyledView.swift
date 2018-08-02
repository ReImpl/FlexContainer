//
//  UIViewAdditions.swift
//  Styled
//
//  Created by kernel on 12/29/17.
//  Copyright © 2016 ReImpl. All rights reserved.
//


// WARN: -  TODO - Remove asssertions

import UIKit

public extension UIApplication {
	
	var currentStyleContainer: StyleContainer? {
		get {
			return appStyleContainer
		}
		set {
			appStyleContainer = newValue
		}
	}
	
}

fileprivate var appStyleContainer: StyleContainer?

public extension UIView {
	
	@IBInspectable
	public var style: String? {
		get {
			return nil
		}
		set {
			guard let name = newValue else {
				assertionFailure("nil style. Styling skipped.")
				
				return
			}
			
			applyStyle(with: name)
		}
	}
	
	private func applyStyle(with name: String) {
		guard let style = styleByName(name) else {
			assertionFailure("Styled named '\(name)' not found.")
			
			return
		}
		
		applyStyle(style)
	}
	
	private func styleByName(_ name: String) -> Style? {
		return UIApplication.shared.currentStyleContainer?.namedStyles[name]
	}
	
}

//public enum A: String {
//	case b
//}

//extension NSAttributedString.Key: ExpressibleByStringLiteral {
//
//	public init(stringLiteral value: String) {
//
//	}
//
//}

public extension AttributedKey {
	static let tintColor = AttributedKey(rawValue: "tintColor")

	static let borderColor = AttributedKey(rawValue: "borderColor")
	static let borderWidth = AttributedKey(rawValue: "borderWidth")
}

// MARK: -

extension UIView: Styled {
	
	func applyStyle(_ style: Style) {
		style.props.forEach { prop in
			apply(prop.key, value: prop.value)
		}
	}
	
	@objc
	fileprivate func apply(_ key: Style.Key, value: Any) {
		switch key {
		case .backgroundColor:
			backgroundColor = value as? UIColor
			
		case .borderColor:
			layer.borderColor = (value as? UIColor)?.cgColor
		case .borderWidth:
			layer.borderWidth = (value as? CGFloat) ?? 0
			
		default:
			//				assertionFailure("Unknown style for UIView named '\(key)'")
			print("Unknown style for UIView named: '\(key)'")
			
			break
		}
	}
	
}

private extension UILabel {
	
	override func apply(_ key: Style.Key, value: Any) {
		switch key {
		case .font:
			font = value as? UIFont
		case .foregroundColor:
			textColor = value as? UIColor
		default:
			assertionFailure("Unknown style for UILabel")
			
			break
		}
	}
	
}

// MARK: - UIButton

private extension UIButton {
	
	override func apply(_ key: Style.Key, value: Any) {
		switch key {
		case .font:
			titleLabel?.font = value as? UIFont
			
		case .normalTextColor:
			if let color = value as? UIColor {
				setTitleColor(color, for: .normal)
			}
		case .highlightedTextColor:
			if let color = value as? UIColor {
				setTitleColor(color, for: .highlighted)
			}
		case .disabledTextColor:
			if let color = value as? UIColor {
				setTitleColor(color, for: .disabled)
			}
			
		case .normalBackgroundColor:
			if let color = value as? UIColor {
				setBackgroundColor(color, for: .normal)
			}
		case .highlightedBackgroundColor:
			if let color = value as? UIColor {
				setBackgroundColor(color, for: .highlighted)
			}
		case .disabledBackgroundColor:
			if let color = value as? UIColor {
				setBackgroundColor(color, for: .disabled)
			}
			
		default:
			super.apply(key, value: value)
			
			break
		}
	}
	
}

public extension AttributedKey {
	
	static let normalTextColor = AttributedKey(rawValue: "normalTextColor")
	static let highlightedTextColor = AttributedKey(rawValue: "highlightedTextColor")
	static let disabledTextColor = AttributedKey(rawValue: "disabledTextColor")
	
	static let normalBackgroundColor = AttributedKey(rawValue: "normalBackgroundColor")
	static let highlightedBackgroundColor = AttributedKey(rawValue: "highlightedBackgroundColor")
	static let disabledBackgroundColor = AttributedKey(rawValue: "disabledBackgroundColor")
	
}

// MARK: - UITextField

private extension UITextField {
	
	override func apply(_ key: Style.Key, value: Any) {
		switch key {
		case .font:
			font = value as? UIFont
		case .backgroundColor:
			backgroundColor = value as? UIColor
		case .foregroundColor:
			textColor = value as? UIColor
		default:
			super.apply(key, value: value)
			
			break
		}
	}
	
}

// MARK: - UITextInput

private extension UITextView {
	
	override func apply(_ key: Style.Key, value: Any) {
		switch key {
		case .font:
			font = value as? UIFont
		case .backgroundColor:
			backgroundColor = value as? UIColor
		case .foregroundColor:
			textColor = value as? UIColor
		default:
			super.apply(key, value: value)
			
			break
		}
	}
	
}

// MARK: - UINavigationBar

private extension UINavigationBar {
	
	override func apply(_ key: Style.Key, value: Any) {
		switch key {
		case .tintColor:
			tintColor = value as? UIColor
		case .barTintColor:
			barTintColor = value as? UIColor
		case .titleTextAttributes:
			guard let attrs = value as? Style.Props else {
				assertionFailure()
				
				return
			}
			
			titleTextAttributes = attrs
		default:
			super.apply(key, value: value)
			
			break
		}
	}
	
}

public extension AttributedKey {
	static let titleTextAttributes = AttributedKey(rawValue: "titleTextAttributes")
	static let barTintColor = AttributedKey(rawValue: "barTintColor")
}

// MARK: - UISegmentedControl

private extension UISegmentedControl {
	
	override func apply(_ key: Style.Key, value: Any) {
		switch key {
		case .inactiveTextColor:
			guard let attrs = value as? Style.Props else {
				assertionFailure()
				
				return
			}
			
			setTitleTextAttributes(attrs, for: .normal)
		case .selectedTextColor:
			guard let attrs = value as? Style.Props else {
				assertionFailure()
				
				return
			}
			
			setTitleTextAttributes(attrs, for: .selected)
		case .inactiveBackgroundColor:
			if let color = value as? UIColor {
				let img = UIImage.image(withColor: color)
				
				setBackgroundImage(img, for: .normal, barMetrics: .default)
			}
		case .selectedBackgroundColor:
			if let color = value as? UIColor {
				let img = UIImage.image(withColor: color)
				
				setBackgroundImage(img, for: .selected, barMetrics: .default)
			}
			
		default:
			super.apply(key, value: value)
			
			break
		}
	}
	
}

public extension AttributedKey {
	
	static let inactiveTextColor = AttributedKey(rawValue: "inactiveTextColor")
	static let selectedTextColor = AttributedKey(rawValue: "highlightedTextColor")
	
	static let inactiveBackgroundColor = AttributedKey(rawValue: "inactiveBackgroundColor")
	static let selectedBackgroundColor = AttributedKey(rawValue: "selectedBackgroundColor")
	
}
