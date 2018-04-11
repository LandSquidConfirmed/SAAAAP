//
//  Driver.swift
//  SAP
//
//  Created by Maxwell Little on 4/10/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

import Foundation

class Driver: NSObject {
    
    var mem: [Int]
    let programLength: Int
    var programCounter: Int
    var registers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var lastcmp = 0
    
    init(Program: String) {
        mem = splitStringIntoLines(expression: Program).map{Int($0)!}
        self.programLength = mem[0]
        self.programCounter = mem[1]
        mem.remove(at: 0)
        mem.remove(at: 0)
    }
    
    func Driver() {
        var num = mem[programCounter]
        
        while num != 0 {
            //let command = NSSelectorFromString(String(describing: Command(rawValue: num)))
            //perform(command)
            let command = String(describing: Command(rawValue: num)!)
            
            switch command {
            case "movmr": movmr(mem[programCounter + 1], mem[programCounter + 2])
            case "outs": outs(mem[programCounter + 1])
            case "outcr": outcr(mem[programCounter + 1])
            case "movrr": movrr(mem[programCounter + 1], mem[programCounter + 2])
            case "addrr": addrr(mem[programCounter + 1], mem[programCounter + 2])
            case "printi": printi(mem[programCounter + 1])
            case "cmprr": cmprr(mem[programCounter + 1], mem[programCounter + 2])
            case "addir": addir(mem[programCounter + 1], mem[programCounter + 2])
            case "jmpne": jmpne(mem[programCounter + 1])
            default: print("Bad Command or something")
            }
            programCounter += 1
            num = mem[programCounter]
        }
        
    }
    
    func movmr(_ label: Int, _ r: Int){
        registers[r] = mem[label]
    }
    func outs(_ label: Int){
        for i in 1...mem[label]{
            print(mem[label + i])
        }
    }
    func outcr(_ r: Int){
        print(registers[r])
    }
    func movrr(_ r1: Int, _ r2: Int){
        registers[r2] = registers[r1]
    }
    func addrr(_ r1: Int, _ r2: Int){
        registers[r2] += registers[r1]
    }
    func printi(_ r: Int){
        print(registers[r])
    }
    func cmprr(_ r1: Int, _ r2: Int){
        lastcmp = registers[r2] - registers[r1]
    }
    func addir(_ r: Int, _ int: Int){
        registers[r] += int
    }
    func jmpne(_ label: Int){
        if lastcmp != 0{
            programCounter = mem[label]
        }
    }
}
