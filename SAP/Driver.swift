//
//  Driver.swift
//  SAP
//
//  Created by Maxwell Little on 4/10/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

import Foundation

class Driver {
    
    var mem = [Int](repeating: 0, count: 10002)
    let programLength: Int
    var programCounter: Int
    var registers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var lastcmp = 0
    var stack = IntStack(size: 10000)
    var points = [0]
    var bool = true
    var sstep = false
    var num = 0
    
    init(Program: String) {
        var iter = 0
        for e in splitStringIntoLines(expression: Program).map({Int($0)!}) {
            mem[iter] = e
            iter += 1
        }
        self.programLength = mem[0]
        self.programCounter = mem[1]
        mem.remove(at: 0)
        mem.remove(at: 0)
    }
    
    func Driver() {//add quit when it gets to the end of memory
        num = mem[programCounter]
        while num != 0 {
            for i in points{
                if((i != programCounter) && (bool == true)){
                    //let command = NSSelectorFromString(String(describing: Command(rawValue: num)))
                    //perform(command)
                    //print(num)
                    let command = String(describing: Command(rawValue: num)!)
                    //print(command)
                    switch command {
                    case "clrr": clrr(mem[programCounter + 1])
                    programCounter += 2
                    case "clrx": clrx(mem[programCounter + 1])
                    programCounter += 2
                    case "clrm": clrx(mem[programCounter + 1])
                    programCounter += 2
                    case "clrb": clrb(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "movir": movir(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "movrr": movrr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "movrm": movrm(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "movmr": movmr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "movxr": movxr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "movar": movar(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "movb": movb(mem[programCounter + 1], mem[programCounter + 2], mem[programCounter + 3])
                    programCounter += 4
                    case "addir": addir(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "addrr": addrr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "addmr": addmr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "addxr": addxr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "subir": addir(-(mem[programCounter + 1]), mem[programCounter + 2])
                    programCounter += 3
                    case "subrr": subrr((mem[programCounter + 1]), mem[programCounter + 2])
                    programCounter += 3
                    case "divrr": divrr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "submr": addmr(-(mem[programCounter + 1]), mem[programCounter + 2])
                    programCounter += 3
                    case "divmr": divmr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "subxr": addxr(-(mem[programCounter + 1]), mem[programCounter + 2])
                    case "divxr": divxr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "mulir": mulir(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "jmp": jmp(mem[programCounter + 1])
                    case "sojz": aojnz(mem[programCounter + 1], mem[programCounter + 2])
                    case "mulrr": mulrr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "sojnz": sojnz(mem[programCounter + 1], mem[programCounter + 2])
                    case "mulmr": mulmr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "aojz": aojz(mem[programCounter + 1], mem[programCounter + 2])
                    case "mulxr": mulxr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "aojnz": aojnz(mem[programCounter + 1], mem[programCounter + 2])
                    case "divir": divir(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "cmpir": cmpir(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "cmprr": cmprr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "cmpmr": cmpmr(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "jmpn": jmpn(mem[programCounter + 1])
                    case "jmpz": jmpz(mem[programCounter + 1])
                    case "jmpp": jmpp(mem[programCounter + 1])
                    case "jsr": jsr(mem[programCounter + 1])
                    case "ret": ret()
                    case "push": push(mem[programCounter + 1])
                    programCounter += 2
                    case "pop": pop(mem[programCounter + 1])
                    programCounter += 2
                    case "stackc": stackc(mem[programCounter + 1])
                    programCounter += 2
                    case "outci": outci(mem[programCounter + 1])
                    programCounter += 2
                    case "outcr": outcr(mem[programCounter + 1])
                    programCounter += 2
                    case "outcx": outcx(mem[programCounter + 1])
                    programCounter += 2
                    case "outcb": outcb(mem[programCounter + 1], mem[programCounter])
                    programCounter += 3
                    case "readi": readi(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "printi": printi(mem[programCounter + 1])
                    programCounter += 2
                    case "readc": readc(_r: mem[programCounter + 1])
                    programCounter += 2
                    case "readln": readln(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "brk": brk()
                    programCounter += 1
                    case "movrx": movrx(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "movxx": movxx(mem[programCounter + 1], mem[programCounter + 2])
                    programCounter += 3
                    case "outs": outs(mem[programCounter + 1])
                    programCounter += 2
                    case "nop": nop()
                    programCounter += 1
                    case "jmpne": jmpne(mem[programCounter + 1])
                    default: print("Bad Command or something")
                        return
                    }
                    if (sstep){
                        sstep = false
                        brk()
                    }
                }
                else{
                    brk()
                }
            }
            num = mem[programCounter]
        }
        
    }
    
    func clrr(_ r: Int) {
        registers[r] = 0
    }
    func clrx(_ r: Int) {
        mem[registers[r]] = 0
    }
    func clrb(_ r: Int, _ b: Int) {
        for e in registers[r]..<(registers[r] + b){
            mem[e] = 0
        }
    }
    func movir(_ i: Int, _ r: Int) {
        registers[r] = i
    }
    func movrr(_ r1: Int, _ r2: Int){
        registers[r2] = registers[r1]
    }
    func movrm(_ r: Int, _ m: Int){
        mem[m] = registers[r]
    }
    func movmr(_ label: Int, _ r: Int){
        registers[r] = mem[label]
        //print(label)
    }
    func movxr(_ r1: Int, _ r2: Int) {
        registers[r2] = mem[registers[r1]]
    }
    func movar(_ label: Int, _ r: Int) {
        registers[r] = label
    }
    func movb(_ r1: Int, _ r2: Int, _ r3: Int) {
        var b = [Int](repeating: 0, count: r3)
        for e in r1..<(r1 + r3) {
            b[e] = mem[e]
        }
        for e in r2..<(r2 + r3) {
            mem[e] = b[e]
        }
    }
    func addir(_ num: Int, _ r: Int){
        registers[r] += num
    }
    func addrr(_ r1: Int, _ r2: Int){
        registers[r2] += registers[r1]
    }
    func addmr(_ m: Int, _ r: Int) {
        registers[r] += mem[m]
    }
    func addxr(_ r1: Int, _ r2: Int) {
        registers[r2] += mem[registers[r1]]
    }
    func subrr(_ r1: Int, _ r2: Int){
        registers[r2] -= registers[r1]
    }
    func mulir(_ i: Int, _ r: Int) {
        registers[r] *= i
    }
    func divrr(_ r1: Int, _ r2: Int){
        registers[2] /= registers[1]
    }
    func mulrr(_ r1: Int, _ r2: Int) {
        registers[r2] *= registers[r1]
    }
    func divmr(_ label: Int, _ r: Int){
        registers[r] /= mem[label]
    }
    func mulmr(_ m: Int, _ r: Int) {
        let x = registers[r] * mem[m]
        registers[r] = x
    }
    func divxr(_ r1: Int, _ r2: Int){
        registers[r2] /= mem[registers[r1]]
    }
    func mulxr(_ x: Int, _ r: Int) {
        registers[r] *= mem[registers[x]]
    }
    func jmp(_ label: Int){
        programCounter = label
        //print("jmp \(label)")
    }
    func divir(_ i: Int, _ r: Int) {
        registers[r] /= i
    }
    func sojz(_ r: Int, _ label: Int){
        addir(-1, r)
        if (registers[r] == 0){
            programCounter = label
        }
        else {
            programCounter += 3
        }
    }
    func sojnz(_ r: Int, _ label: Int){
        addir(-1, r)
        if (registers[r] != 0){
            programCounter = label
        }
        else {
            programCounter += 3
        }
    }
    func aojz(_ r: Int, _ label: Int){
        addir(1, r)
        if (registers[r] == 0){
            programCounter = label
        }
        else {
            programCounter += 3
        }
    }
    func aojnz(_ r: Int, _ label: Int){
        addir(1, r)
        if (registers[r] != 0){
            programCounter = label
        }
        else {
            programCounter += 3
        }
    }
    func cmpir(_ num: Int, _ r: Int){
        lastcmp = registers[r] - num
    }
    func cmprr(_ r1: Int, _ r2: Int){
        lastcmp = registers[r2] - registers[r1]
    }
    func cmpmr(_ label: Int, _ r: Int){
        lastcmp = registers[r] - mem[label]
    }
    func jmpn(_ label: Int){
        if lastcmp < 0{
            programCounter = label
        }
        else {
            programCounter += 2
        }
    }
    func jmpz(_ label: Int){
        if lastcmp == 0{
            programCounter = label
            //print("jmpz \(label)")
        }
        else {
            programCounter += 2
        }
    }
    func jmpp(_ label: Int){
        if lastcmp > 0{
            programCounter = label
        }
        else {
            programCounter += 2
        }
    }
    func jsr (_ label: Int){
        stack.push(element: registers[5])
        stack.push(element: registers[6])
        stack.push(element: registers[7])
        stack.push(element: registers[8])
        stack.push(element: registers[9])
        stack.push(element: programCounter)
        programCounter = label
    }
    func ret(){
        programCounter = stack.pop()! + 2
        registers[9] = stack.pop()!
        registers[8] = stack.pop()!
        registers[7] = stack.pop()!
        registers[6] = stack.pop()!
        registers[5] = stack.pop()!
    }
    func push(_ r: Int){
        stack.push(element: registers[r])
    }
    func pop(_ r: Int){
        registers[r] = stack.pop()!
    }
    func stackc(_ r: Int){
        if stack.isEmpty() {registers[r] = 2}
        else if stack.isFull() {registers[r] = 1}
        else{registers[r] = 0}
    }
    func outci(_ num: Int){
        print(String(uniToChar(num)), terminator:"")
    }
    func outcr(_ r: Int){
        print(String(uniToChar(registers[r])), terminator:"")
    }
    func outcx(_ r: Int){
        print(String(uniToChar(mem[registers[r]])), terminator:"")
    }
    func outcb(_ r1: Int, _ r2: Int){
        for i in 0..<registers[r2]{
            print(String(uniToChar(mem[registers[r1 + i]])), terminator:"")
        }
    }
    func readi(_ r1: Int, _ r2: Int){
        
    }
    func printi(_ r: Int){
        print(registers[r], terminator:"")
    }
    func readc(_r: Int){
        
    }
    func readln(_ label: Int, _ r: Int){
        for _ in 0..<r{
            
        }
    }
    func brk(){
        if let command = readLine(){
            var string = splitStringIntoParts(expression: command)
            switch string[0] {
            case "setbk": if(string.count == 2){
                if let point = Int(string[1]){
                    points.append(point)
                    return
                }
            }
            print("Bad Command or something")
            return
            case "rmbk": if(string.count == 2){
                if let point = Int(string[1]){
                    for i in 0..<points.count{
                        if points[i] == point{
                            points.remove(at: i)
                            return
                        }
                    }
                }
            }
            print("Bad Command or something")
            case "clrbk": if(string.count == 1){
                points = [0]
                return
            }
            print("Bad Command or something")
            return
            case "disbk": if(string.count == 1){
                bool = false
                return
            }
            print("Bad Command or something")
            return
            case "enbk": if(string.count == 1){
                bool = true
                return
            }
            print("Bad Command or something")
            return
            case "pbk": if(string.count == 1){
                print("Breakpoints: ", terminator:"")
                for i in points{
                    print(i, terminator:"")
                }
                return
            }
            print("Bad Command or something")
            return
            case "preg": if(string.count == 1){
                print("Registers: ", terminator:"")
                for i in 0..<registers.count{
                    print("r\(i):", terminator:"")
                    print(registers[i])
                }
                return
            }
            print("Bad Command or something")
            return
            case "wreg": if(string.count == 3){
                if let reg = Int(string[1]){
                    if((-1 < reg) && (reg < 10)){
                        if let val = Int(string[2]){
                            registers[reg] = val
                            return
                        }
                    }
                }
            }
            print("Bad Command or something")
            return
            case "wpc": if(string.count == 2){
                if let val = Int(string[1]){
                    programCounter = val
                    return
                }
            }
            print("Bad Command or something")
            return
            case "pmem": if(string.count == 3){
                if let val = Int(string[1]){
                    if((-1 < val) && (val < 10000)){
                        if let val2 = Int(string[2]){
                            if((val < val2) && (val2 < 10000)){
                                for i in val...val2{
                                    print(mem[i])
                                }
                                return
                            }
                        }
                    }
                }
            }
            print("Bad Command or something")
            return
            case "deas": print("lol")
            case "wmem": if(string.count == 3){
                if let val = Int(string[1]){
                    if((-1 < val) && (val < 10000)){
                        if let val2 = Int(string[2]){
                            registers[val] = val2
                            return
                        }
                    }
                }
            }
            print("Bad Command or something")
            return
            case "pst": if(string.count == 1){
                print("Symbol table: ")
                print(fullTable)
                return
            }
            print("Bad Command or something")
            return
            case "g": if(string.count == 1){
                let point = programCounter
                for i in 0..<points.count{
                    if points[i] == point{
                        points.remove(at: i)
                        return
                    }
                }
            }
            print("Bad Command or something")
            return
            case "s": if(string.count == 1){
                sstep = true
                return
            }
            print("Bad Command or something")
            return
            case "exit": if(string.count == 1){
                num = 0
                return
            }
            print("Bad Command or something")
            return
            case "help": if(string.count == 1){
                print(fit(s: "setbk <address>", size: 35), "|", "set breakpoint at <address>")
                print(fit(s: "rmbk <address>", size: 35), "|", "remove breakpoint at <address>")
                print(fit(s: "clrbk", size: 35), "|", "clear all breakpoints")
                print(fit(s: "disbk", size: 35), "|", "temporarily disable all breakpoints")
                print(fit(s: "enbk", size: 35), "|", "enable breakpoints")
                print(fit(s: "pbk", size: 35), "|", "print breakpoint table")
                print(fit(s: "preg", size: 35), "|", "print the registers")
                print(fit(s: "wreg <number> <value>", size: 35), "|", "write vale of register <number> to <value>")
                print(fit(s: "wpc <value>", size: 35), "|", "change value of PC to <value>")
                print(fit(s: "pmem <start address> <end address>", size: 35), "|", "print memory locations")
                print(fit(s: "deas <start address> <end address>", size: 35), "|", "deassemble memory locations")
                print(fit(s: "wmem <adress> <value>", size: 35), "|", "change value of memory at <address> to <value>")
                print(fit(s: "pst", size: 35), "|", "print symbol table")
                print(fit(s: "g", size: 35), "|", "continue program execution")
                print(fit(s: "s", size: 35), "|", "single step")
                print(fit(s: "exit", size: 35), "|", "terminate virtual machine")
                print(fit(s: "help", size: 35), "|", "print this table")
            }
            print("Bad Command or something")
            return
            default: print("Bad Command or something")
                return
            }
        }
        else{
            print("bad command")
            brk()
        }
    }
    func movrx(_ r1: Int, _ r2: Int){
        mem[registers[r2]] = registers[r1]
        //print(registers[r2])
        //print(mem[registers[r2]])
    }
    func movxx(_ r1: Int, _ r2: Int){
        mem[registers[r2]] = mem[registers[r1]]
    }
    func outs(_ label: Int){
        for i in 1...mem[label]{
            print(String(uniToChar(mem[label + i])), terminator:"")
        }
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

