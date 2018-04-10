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
    var lastcmp = 0
    
    init(Program: String) {
        mem = splitStringIntoLines(expression: Program).map{Int($0)!}
        let programLength = mem[0]
        var programCounter = mem[1]
        mem.remove(at: 0)
        mem.remove(at: 0)
    }
    
    func Driver() {
        var num = mem[programCounter]
        
        while num != 0 {
            let command = NSSelectorFromString(String(describing: Command(rawValue: num)))
            
            
            num = mem[programCounter]
        }
        
    }
    
    mutating func movmr(label: Int, r: Int){
        registers[r] = mem[label]
    }
    func outs(label: Int){
        for i in 1...mem[label]{
            print(mem[label + i])
        }
    }
    func outcr(r: Int){
        print(registers[r])
    }
    mutating func movrr(r1: Int, r2: Int){
        registers[r2] = registers[r1]
    }
    mutating func addrr(r1: Int, r2: Int){
        registers[r2] += registers[r1]
    }
    func printi(r: Int){
        print(registers[r])
    }
    mutating func cmprr(r1: Int, r2: Int){
        lastcmp = registers[r2] - registers[r1]
    }
    mutating func addir(r: Int, int: Int){
        registers[r] += int
    }
    mutating func jmpne(label: Int){
        if lastcmp != 0{
            programCounter = mem[label]
        }
    }
}
