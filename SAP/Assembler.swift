//
//  Assembler.swift
//  SAP
//
//  Created by Maxwell Little on 5/3/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

/*import Foundation


class Assembler {
    
    //Symbol table stored in dict.
    var symbolTable = [String: Int?]()
    var bin = [Int]()
    
    func passOne(_ tokens: [Token]) {
        var e = 0
        while e < tokens.count {
            let token = tokens[e]
            if token.type == .Directive {
                
            }
            else if token.type == .Instruction {
                switch String(describing: token.stringValue) {//Add command numbers too
                case "clrr": r(tokens[e + 1])
                e += 2
                case "clrx": r(tokens[e + 1])
                e += 2
                case "clrm": label(tokens[e + 1])
                e += 2
                case "clrb": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movir": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movrr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movrm": rLabel(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movmr": labelR(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movxr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movar": labelR(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movb": movb(tokens[e + 1], tokens[e + 2], tokens[e + 3])
                e += 4
                case "addir": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "addrr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "addmr": addmr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "addxr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "subir": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "subrr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "divrr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "submr": addmr(-(tokens[e + 1]), tokens[e + 2])
                e += 3
                case "divmr": divmr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "subxr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "divxr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "mulir": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "jmp": label(tokens[e + 1])
                e += 2
                case "sojz": aojnz(tokens[e + 1], tokens[e + 2])
                e += 3
                case "mulrr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "sojnz": aojnz(tokens[e + 1], tokens[e + 2])
                e += 3
                case "mulmr": mulmr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "aojz": aojz(tokens[e + 1], tokens[e + 2])
                e += 3
                case "mulxr": rr(tokens[e + 1], tokens[e + 2])
                case "aojnz": aojnz(tokens[e + 1], tokens[e + 2])
                e += 3
                case "divir": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "cmpir": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "cmprr": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "cmpmr": cmpmr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "jmpn": label(tokens[e + 1])
                e += 2
                case "jmpz": label(tokens[e + 1])
                e += 2
                case "jmpp": label(tokens[e + 1])
                e += 2
                case "jsr": label(tokens[e + 1])
                case "ret": ret()
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
                case "readln": readln(tokens[e + 1], tokens[e + 2])
                e += 3
                case "brk": brk()
                e += 1
                case "movrx": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "movxx": rr(tokens[e + 1], tokens[e + 2])
                e += 3
                case "outs": label(tokens[e + 1])
                e += 2
                case "nop": nop()
                e += 1
                case "jmpne": label(tokens[e + 1])
                default: print("Bad Command or something")
                    return
                }
                Command(rawValue: e)
            }
            else if token.type == .LabelDefinition {
                
            }
            else {
                print("Invalid token type at beginning of line: ", terminator: "")
                token.printThis()
                return
            }
        }
    }
    //Need Error Checking
    private func rr(_ r: Token, _ r2: Token){
        bin.append(r.intValue!)
        bin.append(r2.intValue!)
    }
    private func r(_ r: Token) {
        bin.append(r.intValue!)
    }
    private func label(_ label: Token) {
        if symbolTable[label.stringValue!] != nil {
            bin.append(symbolTable[label.stringValue!]!!)
        }
        else {
            print("Undeclared Label: " + label.stringValue! + " Used")
        }
    }
    private func rLabel(_ r: Token, _ label: Token) {
        if symbolTable[label.stringValue!] != nil {
            bin.append(r.intValue!)
            bin.append(symbolTable[label.stringValue!]!!)
        }
        else {
            print("Undeclared Label: " + label.stringValue! + " Used")
        }
    }
    private func labelR(_ label: Token, _ r: Token) {
        if symbolTable[label.stringValue!] != nil {
            bin.append(symbolTable[label.stringValue!]!!)
            bin.append(r.intValue!)
        }
        else {
            print("Undeclared Label: " + label.stringValue! + " Used")
        }
    }
}*/
