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
    
    func Driver() {//add quit when it gets to the end of memory
        var num = mem[programCounter]
        
        while num != 0 {
            //let command = NSSelectorFromString(String(describing: Command(rawValue: num)))
            //perform(command)
            let command = String(describing: Command(rawValue: num)!)
            //print(command)
            switch command {
            case "movmr": movmr(mem[programCounter + 1], mem[programCounter + 2])
                programCounter += 3
            case "outs": outs(mem[programCounter + 1])
                programCounter += 2
            case "outcr": outcr(mem[programCounter + 1])
                programCounter += 2
            case "movrr": movrr(mem[programCounter + 1], mem[programCounter + 2])
                programCounter += 3
            case "addrr": addrr(mem[programCounter + 1], mem[programCounter + 2])
                programCounter += 3
            case "printi": printi(mem[programCounter + 1])
                programCounter += 2
            case "cmprr": cmprr(mem[programCounter + 1], mem[programCounter + 2])
                programCounter += 3
            case "addir": addir(mem[programCounter + 1], mem[programCounter + 2])
                programCounter += 3
            case "jmpne": jmpne(mem[programCounter + 1])
            default: print("Bad Command or something")
                return
            }
            num = mem[programCounter]
        }
        
    }
    
    func movmr(_ label: Int, _ r: Int){
        registers[r] = mem[label]
    }
    func outs(_ label: Int){
        var string = ""
        for i in 1...mem[label]{
            string += String(uniToChar(mem[label + i]))
        }
        print(string)
    }
    func outcr(_ r: Int){
        print(String(uniToChar(registers[r])))
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
        else {
            programCounter += 2
        }
    }
}
