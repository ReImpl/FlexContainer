//
//  UIViewAdditions.swift
//  Styled
//
//  Created by kernel on 12/29/17.
//  Copyright © 2016 ReImpl. All rights reserved.
//

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
			assertionFailure("Named styled '\(name)' not found.")
			
			return
		}
		
		applyStyle(style)
	}
	
	private func styleByName(_ name: String) -> Style? {
		return UIApplication.shared.currentStyleContainer?.namedStyles[name]
	}
	
}

public extension NSAttributedString.Key {
	
//	public enum StyledViewKeys: Key, Hashable, Equatable, RawRepresentable {
//		public init?(rawValue: NSAttributedString.Key) {
//			<#code#>
//		}
//
//		public typealias RawValue = Key
//
//		var rawValue: NSAttributedString.Key
		
//		case tintColor
//
//		case borderColor
//		case borderWidth
//	}
	
	static let tintColor = NSAttributedString.Key(rawValue: "tintColor")

	static let borderColor = NSAttributedString.Key(rawValue: "borderColor")
	static let borderWidth = NSAttributedString.Key(rawValue: "borderWidth")
	
}

// MARK: -

extension UIView: Styled {
	
	func applyStyle(_ style: Style) {
		applyViewStyle(style)
		
		if let label = self as? UILabel {
			label.applyLabelStyle(style)
		} else if let button = self as? UIButton {
			button.applyButtonStyle(style)
		} else if let textField = self as? UITextField {
			textField.applyInputStyle(style)
		} else if let textView = self as? UITextView {
			textView.applyInputStyle(style)
		} else if let control = self as? UISegmentedControl {
			control.applySegmentedStyle(style)
		} else if let navBar = self as? UINavigationBar {
			navBar.applyNavigationBarStyle(style)
		}
	}
	
	fileprivate func applyViewStyle(_ style: Style) {
		style.props.forEach { key, value in
			switch key {
			case .backgroundColor:
				backgroundColor = value as? UIColor
				
			case .borderColor:
				layer.borderColor = (value as? UIColor)?.cgColor
			case .borderWidth:
				layer.borderWidth = (value as? CGFloat) ?? 0
				
			default:
				//				assertionFailure("Unknown style for UIView named '\(key)'")
				
				break
			}
		}
	}
	
}

private extension UILabel {
	
	func applyLabelStyle(_ style: Style) {
		style.props.forEach { key, value in
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
	
}

// MARK: - UIButton

private extension UIButton {
	
	func applyButtonStyle(_ style: Style) {
		style.props.forEach { key, value in
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
				//				assertionFailure("Unknown style for UIButton")
				
				break
			}
		}
	}
	
}

extension NSAttributedString.Key {
	
	static let normalTextColor = NSAttributedString.Key(rawValue: "normalTextColor")
	static let highlightedTextColor = NSAttributedString.Key(rawValue: "highlightedTextColor")
	static let disabledTextColor = NSAttributedString.Key(rawValue: "disabledTextColor")
	
	static let normalBackgroundColor = NSAttributedString.Key(rawValue: "normalBackgroundColor")
	static let highlightedBackgroundColor = NSAttributedString.Key(rawValue: "highlightedBackgroundColor")
	static let disabledBackgroundColor = NSAttributedString.Key(rawValue: "disabledBackgroundColor")
	
}

// MARK: - UITextField

private extension UITextField {
	
	func applyInputStyle(_ style: Style) {
		style.props.forEach { key, value in
			switch key {
			case .font:
				font = value as? UIFont
			case .backgroundColor:
				backgroundColor = value as? UIColor
			case .foregroundColor:
				textColor = value as? UIColor
			default:
				assertionFailure("Unknown style for UITextField")
				
				break
			}
		}
	}
	
}

// MARK: - UITextInput

private extension UITextView {
	
	func applyInputStyle(_ style: Style) {
		style.props.forEach { key, value in
			switch key {
			case .font:
				font = value as? UIFont
			case .backgroundColor:
				backgroundColor = value as? UIColor
			case .foregroundColor:
				textColor = value as? UIColor
			default:
				assertionFailure("Unknown style for UITextView")
				
				break
			}
		}
	}
	
}

// MARK: - UINavigationBar

private extension UINavigationBar {
	
	func applyNavigationBarStyle(_ style: Style) {
		style.props.forEach { key, value in
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
				assertionFailure("Unknown style for UINavigationBar")
				
				break
			}
		}
	}
	
}

extension NSAttributedString.Key {
	
	static let titleTextAttributes = NSAttributedString.Key(rawValue: "titleTextAttributes")
	static let barTintColor = NSAttributedString.Key(rawValue: "barTintColor")
	
}

// MARK: - UISegmentedControl

private extension UISegmentedControl {
	
	func applySegmentedStyle(_ style: Style) {
		style.props.forEach { key, value in
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
				assertionFailure("Unknown style for UISegmentedControl")
				
				break
			}
		}
	}
	
}

extension NSAttributedString.Key {
	
	static let inactiveTextColor = NSAttributedString.Key(rawValue: "inactiveTextColor")
	static let selectedTextColor = NSAttributedString.Key(rawValue: "highlightedTextColor")
	
	static let inactiveBackgroundColor = NSAttributedString.Key(rawValue: "inactiveBackgroundColor")
	static let selectedBackgroundColor = NSAttributedString.Key(rawValue: "selectedBackgroundColor")
	
}
