//
//  main.swift
//  SAP
//
//  Created by Maxwell Little on 4/9/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

import Foundation

var SAP = Driver(Program: readTextFile("/Users/magosheehy/Desktop/Folder/Turing.bin").1!)
//var assem = Assembler()

//var file = readTextFile("/Users/maxwelllittle/Library/Autosave Information/SAP/SAP/Turing.txt")
//for e in tokenizeilator(splitFile(file: file.fileText!)) {
    //e.printThis()
//}
//assem.passOne(tokenizeilator(splitFile(file: file.fileText!)))

//print(assem.bin)
//print(assem.symbolTable)
SAP.Driver()




/*
 79, 43, 0, 20, 10, 26, 65, 32, 80, 114, 111, 103, 114, 97, 109, 32, 84, 111, 32, 80, 114, 105, 110, 116, 32, 68, 111, 117, 98, 108, 101, 115, 12, 32, 68, 111, 117, 98, 108, 101, 100, 32, 105, 115, 32, 8, 0, 8, 8, 1, 9, 8, 2, 0, 55, 3, 45, 0, 6, 8, 1, 13, 8, 1, 49, 8, 55, 30, 49, 1, 45, 0, 34, 8, 9, 12, 1, 8, 57, 56, 0*/
