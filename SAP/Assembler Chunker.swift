//
//  Assembler Chunker.swift
//  SAP
//
//  Created by Maxwell Little on 5/2/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

import Foundation


func splitFile(file: String)-> [Chunk] {//doesn't account for comment mid line
    let lines = splitStringIntoLines(expression: file)
    var chunks = [Chunk]()
    var lineCounter = 0
    for l in lines {
        let parts = splitStringIntoParts(expression: l)
        var stringFound = false
        if l.first == ";" {continue;}
        for p in parts {
            let first = p.first
            if first != nil {
                if stringFound {
                    chunks[chunks.count-1].stringValue += " " + p
                    continue
                }
                if first == "\"" {
                    stringFound = true
                    chunks.append(Chunk(type: .ImmediateString, line: lineCounter, stringValue: p))
                    continue
                }
                let last = p.last!
                if first == "." {chunks.append(Chunk(type: .Directive, line: lineCounter, stringValue: p)); continue}
                if first == "#" {chunks.append(Chunk(type: .ImmediateInteger, line: lineCounter, stringValue: p)); continue}
                if first == "r" && charToUni(last) < 58 && charToUni(last) > 47 {chunks.append(Chunk(type: .Register, line: lineCounter, stringValue: p)); continue}
                if last == ":" {chunks.append(Chunk(type: .LabelDefinition, line: lineCounter, stringValue: p)); continue}
                var foundInstruction = false
                for e in 0...57 {
                    if String(describing: Command(rawValue: e)!) == (p) {
                        chunks.append(Chunk(type: .Instruction, line: lineCounter, stringValue: p))
                        foundInstruction = true
                        break
                    }
                }
                if foundInstruction {continue}
                else {chunks.append(Chunk(type: .Label, line: lineCounter, stringValue: p))}
            }
        }
        lineCounter += 1
    }
    return chunks
}


func tokenizeilator(_ chunks: [Chunk])->[Token]{
    var tokens = [Token]()
    for c in chunks {
        if c.type == .Register {
            guard c.stringValue.characters.count == 2 else {
                print("Incorrect number of characters in register definition")
                break
            }
            tokens.append(Token(type: c.type, intValue: Int(String(describing: c.stringValue.characters.last!)), stringValue: nil, tupleValue: nil, line: c.line, description: c.stringValue))
            continue
        }
        if c.type == .LabelDefinition {
            tokens.append(Token(type: c.type, intValue: nil, stringValue: String(c.stringValue.dropLast()), tupleValue: nil, line: c.line, description: c.stringValue))
            continue
        }
        if c.type == .Label {
            tokens.append(Token(type: c.type, intValue: nil, stringValue: c.stringValue, tupleValue: nil, line: c.line, description: c.stringValue))
            continue
        }
        if c.type == .ImmediateString {
            tokens.append(Token(type: c.type, intValue: nil, stringValue: String(c.stringValue.dropLast().dropFirst()), tupleValue: nil, line: c.line, description: c.stringValue))
            continue
        }
        if c.type == .ImmediateInteger {
            if let v = Int(c.stringValue.dropFirst()) {
                tokens.append(Token(type: c.type, intValue: v, stringValue: nil, tupleValue: nil, line: c.line, description: c.stringValue))
            }
            else {
                print("Integer provided is not a number")
            }
            continue
        }
        if c.type == .ImmediateTuple {
            print("Welcome to Hell!")
            continue
        }
        if c.type == .Instruction {
            for e in 0...57 {
                if String(describing: Command(rawValue: e)!) == c.stringValue {
                    tokens.append(Token(type: c.type, intValue: e, stringValue: c.stringValue, tupleValue: nil, line: c.line, description: c.stringValue))
                    break
                }
            }
            continue
        }
        if c.type == .Directive {
            let startCount = tokens.count
            var str: String = c.stringValue
            str.removeFirst()
            for e in 0...4 {
                if String(describing: Directive(rawValue: e)!) == str {
                    tokens.append(Token(type: c.type, intValue: e, stringValue: c.stringValue, tupleValue: nil, line: c.line, description: c.stringValue))
                    break
                }
            }
            if tokens.count == startCount {
                print("Invalid assembler directive")
                break
            }
            continue
        }
        tokens.last?.printThis()
    }
    return tokens
}


enum TokenType {
    case Register
    case LabelDefinition
    case Label
    case ImmediateString
    case ImmediateInteger
    case ImmediateTuple
    case Instruction
    case Directive
}

struct Chunk {
    let type: TokenType
    let line: Int
    var stringValue: String
    func printThis() {
        print(stringValue + " " + String(describing: type))
    }
}

struct Token: CustomStringConvertible {
    let type: TokenType
    let intValue: Int?
    let stringValue: String?
    let tupleValue: Tuple?
    let line: Int
    
    func printThis() {
        print(stringValue as Any)
        print(String(describing: type))
        print(intValue as Any)
        print("_____________________________________________")
    }
    
    var description: String
}

struct Tuple: CustomStringConvertible {
    let currentState: Int
    let inputCharachter: Int
    let newState: Int
    let outputCharacter: Int
    let direction: Int
    
    var description = "Oeehoo"
}



