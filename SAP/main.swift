//
//  main.swift
//  SAP
//
//  Created by Maxwell Little on 4/9/18.
//  Copyright © 2018 Generic Organization. All rights reserved.
//

import Foundation

var SAP = Driver(Program: readTextFile("/Users/magosheehy/Desktop/Folder/Turing.bin").1!)
/*var assem = Assembler()

var file = readTextFile("/Users/maxwelllittle/Library/Autosave Information/SAP/SAP/Turing.txt")
for e in tokenizeilator(splitFile(file: file.fileText!)) {
    e.printThis()
}
assem.passOne(tokenizeilator(splitFile(file: file.fileText!)))

print(assem.bin)
print(assem.symbolTable)
*/
SAP.Driver()

