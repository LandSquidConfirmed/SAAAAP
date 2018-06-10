//
//  Assembler.swift
//  SAP
//
//  Created by Maxwell Little on 5/3/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

import Foundation


class Assembler {
    
    //Symbol table stored in dict.
    var symbolTable = [String: Int?]()
    var bin = [Int?]()
    var programSize = 0
    var passTwo = false
    var lst = [String]()
    
    func passOne(_ tokens: [Token]) {
        bin.append(programSize)
        bin.append(nil)
        var e = 0
        var lstLine = tokens[e].line.description + ": "
        var lastLine = tokens[e].line
        var lastE = 0
        var lastBin = 0
        while e < tokens.count {
            
            lastLine = tokens[e].line
            lastE = e
            lastBin = bin.count
            
            let token = tokens[e]
            if token.type == .Directive {
                switch String(describing: token.stringValue!) {
                case ".Start": start(tokens[e + 1], e)
                e += 2
                case ".Integer": bin.append(tokens[e + 1].intValue!)
                e += 2
                case ".String": string(tokens[e + 1])
                e += 2
                case ".end": bin[0] = bin.count - 2
                if passTwo {
                    return
                }
                passTwo = true
                bin = [Int?]()
                lst = [String]()
                    return
                case ".allocate": allocate(tokens[e + 1])
                e += 2
                default: print("————————————Invalid Directive: " + token.stringValue! + "————————————")
                }
            }
            else if token.type == .Instruction {
                bin.append(token.intValue!)
                switch String(describing: token.stringValue!) {
                case "halt": e += 1
                case "clrr": r(tokens[e + 1])
                e += 2
                case "clrx": r(tokens[e + 1])
                e += 2
                case "clrm": label(tokens[e + 1], e)
                e += 2
                case "clrb": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movir": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movrr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movrm": rLabel(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "movmr": labelR(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "movxr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movar": labelR(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "movb": bin.append(tokens[e + 1].intValue!)
                bin.append(tokens[e + 2].intValue!)
                bin.append(tokens[e + 3].intValue!)
                e += 4
                case "addir": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "addrr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "addmr": labelR(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "addxr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "subir": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "subrr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "divrr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "submr": labelR(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "divmr": labelR(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "subxr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "divxr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "mulir": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "jmp": label(tokens[e + 1], e)
                e += 2
                case "sojz": rLabel(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "mulrr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "sojnz": rLabel(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "mulmr": labelR(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "aojz": rLabel(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "mulxr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "aojnz": rLabel(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "divir": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "cmpir": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "cmprr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "cmpmr": labelR(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "jmpn": label(tokens[e + 1], e)
                e += 2
                case "jmpz": label(tokens[e + 1], e)
                e += 2
                case "jmpp": label(tokens[e + 1], e)
                e += 2
                case "jsr": label(tokens[e + 1], e)
                e += 2
                case "ret": kachow()
                e += 1
                case "push": r(tokens[e + 1])
                e += 2
                case "pop": r(tokens[e + 1])
                e += 2
                case "stackc": r(tokens[e + 1])
                e += 2
                case "outci": r(tokens[e + 1])
                e += 2
                case "outcr": r(tokens[e + 1])
                e += 2
                case "outcx": r(tokens[e + 1])
                e += 2
                case "outcb": rr(tokens[e + 1], tokens[e])
                e += 3
                case "readi": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "printi": r(tokens[e + 1])
                e += 2
                case "readc": r(tokens[e + 1])
                e += 2
                case "readln": labelR(tokens[e + 1], tokens[e + 2], e)
                e += 3
                case "brk": kachow()
                e += 1
                case "movrx": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movxx": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "outs": label(tokens[e + 1], e)
                e += 2
                case "nop": kachow()
                e += 1
                case "jmpne": label(tokens[e + 1], e)
                e += 2
                default: print("Bad Command or something")
                    return
                }
            }
            else if token.type == .LabelDefinition {
                symbolTable[token.stringValue!] = bin.count - 2
                e += 1
            }
            else {
                print("Invalid token type at beginning of line: ", terminator: "")
                token.printThis()
                return
            }
            
            if passTwo {
                if lastLine != tokens[e].line {
                    for x in lastBin..<bin.count {
                        lstLine += bin[x]!.description + " "
                    }
                    for x in lastE..<e {
                        lstLine += tokens[x].description + " "
                    }
                    lst.append(lstLine)
                    lstLine = ""
                    lstLine = tokens[e].line.description + ": "
                }
            }
        }
    }
    
    
    
    
    
    
    //Need Error Checking
    private func start(_ label: Token, _ e: Int) {
        if passTwo {
            bin[1] = symbolTable[label.stringValue!]!
        }
        else {
            bin[1] = nil
        }
    }
    private func string(_ string: Token) {
        bin.append(string.stringValue!.count)
        for e in string.stringValue!.characters {
            bin.append(charToUni(e))
        }
    }
    private func allocate(_ size: Token) {
        for e in 1...size.intValue! {
            bin.append(0)
        }
    }
    private func rr(_ r: Token, _ r2: Token){
        bin.append(r.intValue!)
        bin.append(r2.intValue!)
    }
    private func r(_ r: Token) {
        bin.append(r.intValue!)
    }
    private func label(_ label: Token, _ e: Int) {
        if passTwo {
            bin.append(symbolTable[label.stringValue!]!!)
        }
        else {
            if symbolTable[label.stringValue!] != nil {
                bin.append(symbolTable[label.stringValue!]!!)
            }
            else {
                bin.append(nil)
            }
        }
    }
    private func rLabel(_ r: Token, _ label: Token, _ e: Int) {
        if passTwo {
            bin.append(r.intValue!)
            bin.append(symbolTable[label.stringValue!]!!)
        }
        else {
            if symbolTable[label.stringValue!] != nil {
                bin.append(r.intValue!)
                bin.append(symbolTable[label.stringValue!]!!)
            }
            else {
                bin.append(r.intValue!)
                bin.append(nil)
            }
        }
    }
    private func labelR(_ label: Token, _ r: Token, _ e: Int) {
        if passTwo {
            bin.append(symbolTable[label.stringValue!]!!)
            bin.append(r.intValue!)
        }
        else {
            if symbolTable[label.stringValue!] != nil {
                bin.append(symbolTable[label.stringValue!]!!)
                bin.append(r.intValue!)
            }
            else {
                bin.append(nil)
                bin.append(r.intValue!)
            }
        }
    }
    private func kachow() {}
}

