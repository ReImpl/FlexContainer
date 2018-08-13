//
//  UIViewAdditions.swift
//  Styled
//
//  Created by kernel on 12/29/17.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit

// TODO: - base StyleContainer to contain styles on top of DeclarativeHub/Layoutless.


/**
	Aboslute. See TODO note above.

	How to create styles:

	Create your 'AppStyle' protocol that extends 'Styles'.

	In 'AppStyle' define {get}-only variables of 'Style' type.
	Than implement your own style(s) (using classes or structs) that realize AppStyle protocol.

	In this way you declare a contract for all styles that the app uses once in 'AppStyle'.
	And then provide various implementations. Two hypothetical examples are LightStyle and DarkStyle

	For instance, you may define:

	protocol AppStyle: Styles {
		var background: Style {get}
		var linktButton: Style {get}
	}

	struct LightStyle: AppStyle {
		let background: Style = {
			let props: Style.Props = [
				.backgroundColor: UIColor.white
			]

			return Style(props: props)
		}()

		let linktButton: Style = {
			let props: Style.Props = [
				.normalTextColor: UIColor.black
			]

			return Style(props: props)
		}()
	}

	struct LightStyle: AppStyle {
		let background: Style = {
			let props: Style.Props = [
				.backgroundColor: UIColor.black
			]

			return Style(props: props)
		}()

		let linktButton: Style = {
			let props: Style.Props = [
				.normalTextColor: UIColor.green
			]

			return Style(props: props)
		}()
	}
*/
public protocol Styles { }

public struct Style {
	
	public typealias Key = AttributedKey
	public typealias Props = [Key: Any]
	public let props: Props
	
	public init(props p: Props) {
		props = p
	}
	
}

public class StyleContainer {
	
	convenience public init(with style: Styles) {
		self.init(styles: allProps(from: style))
	}
	
	public let namedStyles: [String: Style]
	
	required public init(styles: [String: Style]) {
		namedStyles = styles
	}
	
}

public func allProps(from obj: Styles) -> [String: Style] {
	var props: [String: Style] = [:]
	let mirror = Mirror(reflecting: obj)
	
	for p in mirror.children {
		guard let propertyName = p.label,
			let style = p.value as? Style else {
				assertionFailure("Value of the property named: '\(String(describing: p.label))' should be a PropertyPolicy instance.")
				
				continue
		}
		
		props[propertyName] = style
	}
	
	return props
}

// MARK: -

protocol Styled {
	
	func applyStyle(_ style: Style)
	
}

