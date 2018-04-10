//
//  main.swift
//  SAP
//
//  Created by Maxwell Little on 4/9/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

import Foundation

var SAP = Driver(Program: readTextFile("/Users/magosheehy/Documents/SAAAAP/SAP/Numbers.txt").1!)


if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    
    let fileURL = dir.appendingPathComponent(file)
    
    //writing
    do {
        try text.write(to: fileURL, atomically: false, encoding: .utf8)
    }
    catch {/* error handling here */}
    
    //reading
    do {
        let text2 = try String(contentsOf: fileURL, encoding: .utf8)
    }
    catch {/* error handling here */}
}
