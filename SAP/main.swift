//
//  main.swift
//  SAP
//
//  Created by Maxwell Little on 4/9/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

import Foundation

let bundle = Bundle.mainBundle()
let path = bundle.pathForResource("Numbers", ofType: "txt")
var error:NSError?
if let content = NSString.stringWithContentsOfFile(path, encoding: NSUTF8StringEncoding, error: &error) {
    var SAP = Driver(Program: readTextFile("/Users/maxwelllittle/Documents/SAAAAP/SAP/Numbers.txt").1!)
    SAP.Driver()
}

//var SAP = Driver(Program: readTextFile("/Users/maxwelllittle/Documents/SAAAAP/SAP/Numbers.txt").1!)
//SAP.Driver()
