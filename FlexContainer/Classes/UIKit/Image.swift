//
//  Image.swift
//
//  Created by kernel on 12/23/16.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import UIKit
import CoreGraphics

public extension UIImage {
	
	public class func pixel(from color: UIColor) -> UIImage? {
		let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
		UIGraphicsBeginImageContext(rect.size)
		
		let image: UIImage?
		if let context = UIGraphicsGetCurrentContext() {
			
			context.setFillColor(color.cgColor)
			context.fill(rect)
			
			image = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
		} else {
			image = nil
		}
		
		return image
	}
	
	func croppedImage(from rect: CGRect) -> UIImage? {
		guard let validCGImage = cgImage else {
			return nil
		}
		
		guard let cgImage = validCGImage.cropping(to: rect) else {
			return nil
		}
		
		return UIImage(cgImage: cgImage)
	}
	
	func imageByResettingOrientation(constrainedToLongestSide longestSide: CGFloat? = nil) -> UIImage? {
		let target: CGSize
		
		if let longestSide = longestSide {
			target = targetSize(from: self.size, constrainedTo: longestSide)
		} else {
			target = size
		}
		
		// Make image upright:
		// Rotate if Left/Right/Down, and then flip if Mirrored.
		var transform = CGAffineTransform.identity
		
		switch imageOrientation {
		case .down, .downMirrored:
			transform = transform.translatedBy(x: target.width, y: target.height)
			transform = transform.rotated(by: .pi)
			
		case .left, .leftMirrored:
			transform = transform.translatedBy(x: target.width, y: 0)
			transform = transform.rotated(by: CGFloat(Double.pi / 2))
			
		case .right, .rightMirrored:
			transform = transform.translatedBy(x: 0, y: target.height)
			transform = transform.rotated(by: -CGFloat(Double.pi / 2))
			
		case .up, .upMirrored:
			break
		}
		
		switch imageOrientation {
		case .upMirrored, .downMirrored:
			transform = transform.translatedBy(x: target.width, y: 0)
			transform = transform.scaledBy(x: -1, y: 1)
			
		case .leftMirrored, .rightMirrored:
			transform = transform.translatedBy(x: target.height, y: 0)
			transform = transform.scaledBy(x: -1, y: 1)
			
		case .up, .down, .left, .right:
			break
		}
		
		let bitsPerComponent = 8
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let alphaMask = CGImageAlphaInfo.premultipliedLast.rawValue
		let bitmapInfo: CGBitmapInfo = [.byteOrder32Little, CGBitmapInfo(rawValue: alphaMask)]
		
		guard let ctx = CGContext(data: nil, width: Int(target.width), height: Int(target.height), bitsPerComponent: bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
			return nil
		}
		
		ctx.concatenate(transform)
		ctx.setBlendMode(.copy)
		ctx.interpolationQuality = .default
		
		switch imageOrientation {
		case .left, .leftMirrored, .right, .rightMirrored:
			let rect = CGRect(origin: .zero, size: CGSize(width: target.height, height: target.width))
			ctx.draw(self.cgImage!, in: rect)
		default:
			let rect = CGRect(origin: .zero, size: CGSize(width: target.width, height: target.height))
			ctx.draw(self.cgImage!, in: rect)
		}
		
		guard let image = ctx.makeImage() else {
			return nil
		}
		
		return UIImage(cgImage: image)
	}
	
	func targetSize(from original: CGSize, constrainedTo longest: CGFloat) -> CGSize {
		let ratio = longest / max(original.height, original.width)
		
		guard ratio < 1 else {
			return original
		}
		
		let targetHeight = round(original.height * ratio)
		let targetWidth = round(original.width * ratio)
		
		return CGSize(width: targetWidth, height: targetHeight)
	}
	
}
