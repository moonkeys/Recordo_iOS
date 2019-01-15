//
//  Enseignant.swift
//  if26project
//
//  Created by CACHARD MARC-ANTOINE on 10/01/2019.
//  Copyright © 2019 CACHARD MARC-ANTOINE. All rights reserved.
//

import Foundation

public class Preset  {
    
    var id: Int
    var nomPreset: String
    var nomInstrument1: String
    var nomInstrument2: String
    var nomInstrument3: String
    var nomInstrument4: String
    var nomInstrument5: String
    var nomInstrument6: String
    
    init() {
        id = 1
        nomPreset = "?"
        nomInstrument1 = "?"
        nomInstrument2 = "?"
        nomInstrument3 = "?"
        nomInstrument4 = "?"
        nomInstrument5 = "?"
        nomInstrument6 = "?"
        
    }
    init(nomPreset: String, nomInstrument1: String, nomInstrument2: String, nomInstrument3: String,nomInstrument4: String, nomInstrument5: String, nomInstrument6: String) {
        self.id = 1
        self.nomPreset = nomPreset
        self.nomInstrument1 = nomInstrument1
        self.nomInstrument2 = nomInstrument2
        self.nomInstrument3 = nomInstrument3
        self.nomInstrument4 = nomInstrument4
        self.nomInstrument5 = nomInstrument5
        self.nomInstrument6 = nomInstrument6
    }
    
    
    public var descriptor: String {
        return "Preset(\(nomPreset),\(nomInstrument1),\(nomInstrument2),\(nomInstrument3),\(nomInstrument4),\(nomInstrument5),\(nomInstrument6))"
    }
}
