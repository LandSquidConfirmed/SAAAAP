//
//  Driver.swift
//  SAP
//
//  Created by Maxwell Little on 4/10/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

import Foundation

struct Driver {
    
    var mem: [Int]
    let programLength: Int
    var programCounter: Int
    var registers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    init(Program: String) {
        mem = splitStringIntoParts(expression: Program).map{Int($0)!}
        let programLength = mem[0]
        var programCounter = mem[1]
        mem.remove(at: 0)
        mem.remove(at: 0)
    }
    
    func Driver() {
        var num = mem[programCounter]
        
        while num != 0 {
            
            
            num = mem[programCounter]
        }
        
        
        
        
    }
    
}
