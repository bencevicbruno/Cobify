//
//  FileManager+.swift
//  Cobify
//
//  Created by Bruno Bencevic on 03.01.2023..
//

import Foundation

extension FileManager {
    
    func getPath(for file: String) -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
//        return URL(string: documentsDirectory.absoluteString + file)!
        return documentsDirectory.appending(path: file, directoryHint: .notDirectory)
    }
}
