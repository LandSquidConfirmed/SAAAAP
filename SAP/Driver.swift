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
    var stack = IntStack(size: 10000)
    
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
            case "readln": readln(mem[programCounter + 1], mem[programCounter + 2])
                programCounter += 3
            case "brk": brk()
                programCounter += 1
            case "movrx": movrx(mem[programCounter + 1], mem[programCounter + 2])
                programCounter += 3
            case "movxx": movxx(mem[programCounter + 1], mem[programCounter + 2])
                programCounter += 3
            case "nop": nop()
                programCounter += 1
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
        for i in 1...mem[label]{
            print(String(uniToChar(mem[label + i])), terminator:"")
        }
    }
    func outcr(_ r: Int){
        print(String(uniToChar(registers[r])), terminator:"")
    }
    func movrr(_ r1: Int, _ r2: Int){
        registers[r2] = registers[r1]
    }
    func addrr(_ r1: Int, _ r2: Int){
        registers[r2] += registers[r1]
    }
    func printi(_ r: Int){
        print(registers[r], terminator:"")
    }
    func cmprr(_ r1: Int, _ r2: Int){
        lastcmp = registers[r2] - registers[r1]
    }
    func addir(_ num: Int, _ r: Int){
        registers[r] += num
    }
    func readln(_ label: Int, _ r: Int){
        for _ in 0..<r{
            
        }
    }
    func brk(){
        
    }
    func movrx(_ r: Int, _ x: Int){
        mem[x] = registers[r]
    }
    func movxx(_ x1: Int, _ x2: Int){
        mem[x2] = mem[x1]
    }
    func nop(){ }
    func jmpne(_ label: Int){
        if lastcmp != 0{
            programCounter = label
        }
        else {
            programCounter += 2
        }
    }
}
