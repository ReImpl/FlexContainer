//
//  FileManager.swift
//
//  Created by kernel on 12/29/15.
//  Copyright © 2016 ReImpl. All rights reserved.
//

public extension FileManager {
	
	public func isFileExistent(atPath path: String) -> Bool {
		var isDirectory = false
		let exists = isExistent(atPath: path, isDirectory: &isDirectory)
		
		return exists && !isDirectory
	}
	
	public func isDirectoryExistent(atPath path: String) -> Bool {
		var isDirectory = false
		let exists = isExistent(atPath: path, isDirectory: &isDirectory)
		
		return exists && isDirectory
	}
	
	public func isExistent(atPath path: String, isDirectory: inout Bool) -> Bool {
		var directory = ObjCBool(false)
		let exists = FileManager.default.fileExists(atPath: path, isDirectory: &directory)
		
		isDirectory = directory.boolValue
		return exists
	}
	
	// MARK: -
	
	public func createDirectoryIfNotExists(atPath path: String) -> Bool {
		var created: Bool
		
		if isDirectoryExistent(atPath: path) {
			created = true
		} else {
			do {
				try createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
				
				created = true
			} catch let error as NSError {
				print("Failed to create directory at path: \(path). \(error)")
				
				created = false
			}
		}
		
		return created
	}
	
	public func deleteDirectoryAndItsContents(atPath path: String) -> Bool {
		var didDeleteAllContent = true
		
		enumerator(atPath: path)?.forEach {
			if let itemName = $0 as? String {
				let itemPath = path.appending("/\(itemName)")
				
				var isDirectory = ObjCBool(false)
				let _ = fileExists(atPath: itemPath, isDirectory: &isDirectory)
				
				let isThisDirectory = isDirectory.boolValue
				
				let isDeleted: Bool
				if isThisDirectory {
					isDeleted = deleteDirectoryAndItsContents(atPath: itemPath)
				} else {
					do {
						try removeItem(atPath: itemPath)
						
						isDeleted = true
					} catch {
						isDeleted = false
					}
				}
				
				didDeleteAllContent = didDeleteAllContent && isDeleted
			}
		}
		
		if fileExists(atPath: path, isDirectory: nil) {
			do {
				try removeItem(atPath: path)
			} catch {
				didDeleteAllContent = false
			}
		}
		
		return didDeleteAllContent
	}
	
}
