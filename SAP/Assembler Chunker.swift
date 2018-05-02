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
    var tokens = [Token]()
    for l in lines {
        var parts = splitStringIntoParts(expression: l)
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
                    chunks.append(Chunk(type: .ImmediateString, stringValue: p))
                    continue
                }
                let last = p.last!
                if first == "." {chunks.append(Chunk(type: .Directive, stringValue: p)); continue}
                if first == "#" {chunks.append(Chunk(type: .ImmediateInteger, stringValue: p)); continue}
                if first == "r" && charToUni(last) < 58 && charToUni(last) > 47 {chunks.append(Chunk(type: .Register, stringValue: p)); continue}
                if last == ":" {chunks.append(Chunk(type: .LabelDefinition, stringValue: p)); continue}
                var foundInstruction = false
                for e in 0...57 {
                    if String(describing: Command(rawValue: e)) == (p + "/n") {
                        chunks.append(Chunk(type: .Instruction, stringValue: p))
                        foundInstruction = true
                        break
                    }
                }
                if foundInstruction {continue}
                else {chunks.append(Chunk(type: .Label, stringValue: p))}
            }
        }
        
    }
    return chunks
}


func tokenizeilator(_ chunks: [Chunk]){
    for c in chunks {
        
    }
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
    
    var description = "Henlo"
}

struct Tuple: CustomStringConvertible{
    let currentState: Int
    let inputCharachter: Int
    let newState: Int
    let outputCharacter: Int
    let direction: Int
    
    var description = "Hnelo"
}



