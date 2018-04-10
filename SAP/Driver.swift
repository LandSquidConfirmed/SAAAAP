//
//  Driver.swift
//  SAP
//
//  Created by Maxwell Little on 4/10/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

import Foundation

struct Driver {
    
    var ProgramMemory: [Int]
    
    init(Program: String) {
        ProgramMemory = splitStringIntoParts(expression: Program).map{Int($0)!}
    }
    
    
}
