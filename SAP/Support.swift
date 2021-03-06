//
//  Support.swift
//  SAP
//
//  Created by Maxwell Little on 4/10/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

import Foundation

func charToUni(_ c: Character)-> Int {
    let s = String(c)
    return Int(s.unicodeScalars[s.unicodeScalars.startIndex].value)
}

func uniToChar(_ n: Int)-> Character {
    return Character(UnicodeScalar(n)!)
}

enum Command: Int{
    case halt, clrr, clrx, clmr, clrb, movir, movrr, movrm, movmr, movxr, movar, movb, addir, addrr, addmr, addxr, subir, subrr, submr, subxr, mulir, mulrr, mulmr, mulxr, divir, divrr, divmr, divxr, jmp, sojz, sojnz, aojz, aojnz, cmpir, cmprr, cmpmr, jmpn, jmpz, jmpp, jsr, ret, push, pop, stackc, outci, outcr, outcx, outcb, readi, printi, readc, readln, brk, movrx, movxx, outs, nop, jmpne
}

enum Directive: Int {
    case Start, Integer, String, end, allocate
}

func readTextFile(_ path: String) -> (message: String?, fileText: String?) {
    let text: String
    
    do {
        text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
    }
        
    catch {
        return ("\(error)", nil)
    }
    return (nil, text)
}

func splitStringIntoParts(expression: String) -> [String] {
    return expression.characters.split{$0 == " "}.map{ String($0) }
}

func splitStringIntoLines(expression: String) -> [String] {
    return expression.characters.split{$0 == "\n"}.map{ String($0) }
}

func fit(s: String, size: Int)-> String {
    var result = s
    while result.characters.count < size {
        if result.characters.count < size {
            result.append(" ")
        }
    }
    while result.characters.count > size {
        for e in 0..<result.characters.count {
            if result.characters.count > size {
                result.removeLast()
            }
        }
    }
    return result
}

struct IntStack: CustomStringConvertible {
    
    let size: Int
    
    var stack = [Int]()
    
    init(size: Int) {
        self.size = size
    }
    
    func isEmpty()-> Bool {return stack.count == 0}
    
    func isFull()-> Bool {return stack.count == size}
    
    mutating func push(element: Int) {
        if stack.count == size {
            print("Stack Overflow")
            return
        }
        stack.append(element)
    }
    
    mutating func pop()-> Int? {
        if stack.count == 0 {
            print("Stack Empty")
            return nil
        }
        return stack.removeLast()
    }
    
    var description: String {
        return "\(stack)"
    }
}

func writeFile(path: String, text: String) {
    do {
        try text.write(toFile: path, atomically: false, encoding: String.Encoding.utf8)
    }
    catch let E as NSError {
        print("Unable to save to given path: \(E)")
    }
}


