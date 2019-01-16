//
//  Instrument.swift
//  Recordo
//
//  Created by BLANCHARD Guillaume on 16/01/2019.
//  Copyright © 2019 BLANCHARD Guillaume. All rights reserved.
//

//
//  Instrument.swift
//  Recordo
//
//  Created by BLANCHARD Guillaume on 10/01/2019.
//  Copyright © 2019 BLANCHARD Guillaume. All rights reserved.
//

import Foundation

public class Instrument  {
    
    var id: Int
    var idP: Int
    var instru: String
    var nbdB : Double
    
    init() {
        id = 1
        idP = 0
        instru = "?"
        nbdB = 0
        
    }
    init(instru: String, nbdB:Double) {
        self.id = 1
        self.idP = 1
        self.instru = instru
        self.nbdB = nbdB
    }
}
