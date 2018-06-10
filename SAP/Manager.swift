//
//  Manager.swift
//  SAP
//
//  Created by Maxwell Little on 6/10/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

import Foundation

class Manager {
    var assem = Assembler()
    var fileContents = ""
    var chunks = [Chunk]()
    var tokens = [Token]()
    
    func runAll(path: String) {
        loadFile(path: path)
        chunkFile()
        tokenizeFile()
        assembleFile()
        saveData(fileName: "Turing2")
        runVM()
    }
    
    func loadFile(path: String) {
        fileContents = readTextFile(path).fileText!
    }
    func chunkFile() {
        chunks = splitFile(file: fileContents)
    }
    func tokenizeFile() {
        tokens = tokenizeilator(chunks)
    }
    func assembleFile() {
        assem.passOne(tokens)
        assem.passOne(tokens)
    }
    func saveData(fileName: String) {
        assem.saveBin(fileName: fileName)
        assem.saveLst(fileName: fileName)
        assem.saveSym(fileName: fileName)
    }
    func runVM() {
        var fullBin = ""
        for e in assem.bin {
            fullBin += e!.description + "\n"
        }
        let driver = Driver(Program: fullBin)
        driver.Driver()
    }
}
