//
//  TempFile.swift
//
//  Created by kernel on 12/29/15.
//  Copyright © 2016 ReImpl. All rights reserved.
//

import Foundation

open class TemporaryFile {
	
	deinit {
		DispatchQueue.global(qos: .utility).async { [url = self.pathUrl] in
			try? FileManager.default.removeItem(at: url)
		}
	}
	
	required public init?(movingExistingFileAt originalUrl: URL) {
		guard originalUrl.isFileURL,
			let originalFileName = originalUrl.pathComponents.last,
			FileManager.default.isFileExistent(atPath: originalUrl.path) else {
				return nil
		}
		
		fileName = originalFileName
		pathUrl = TemporaryFile.uniquePath(withExtension: originalUrl.pathExtension)
		
		do {
			try FileManager.default.moveItem(at: originalUrl, to: pathUrl)
		} catch {
			assertionFailure()
			
			return nil
		}
	}
	
	public let fileName: String
	public let pathUrl: URL
	
//	#if swift(>=4.2)
//	@inlinable
//	#endif
	public var fileSize: UInt64 {
		guard let attributes = try? FileManager.default.attributesOfItem(atPath: pathUrl.path) else {
			return 0
		}
		
		return (attributes as NSDictionary).fileSize()
	}
	
	// MARK: - Internal
	
	static private let tempFolder = URL(fileURLWithPath: NSTemporaryDirectory())
	
	static private func uniquePath(withExtension ext: String) -> URL {
		let uniqueFileName = UUID().uuidString
		
		return tempFolder
			.appendingPathComponent(uniqueFileName)
			.appendingPathExtension(ext)
	}
	
}
