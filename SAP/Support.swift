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
