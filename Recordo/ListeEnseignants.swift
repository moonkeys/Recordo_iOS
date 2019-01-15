//
//  ListeEnseignants.swift
//  if26project
//
//  Created by CACHARD MARC-ANTOINE on 10/01/2019.
//  Copyright © 2019 CACHARD MARC-ANTOINE. All rights reserved.
//

import Foundation

public class ListePresets {
    var presets: [Preset]
    
    func ajoute(m: Preset) {
        presets.append(m)
    }
    
    init() {
        presets = []
        ajoute(m:Preset.init(nomPreset: "Petit Déjeuner", nomInstrument1: "Guitare 1", nomInstrument2: "Guitare 2", nomInstrument3: "Basse", nomInstrument4: "Piano", nomInstrument5: "Chant", nomInstrument6: "Batterie"))
        ajoute(m:Preset.init(nomPreset: "Groupe 2", nomInstrument1: "Guitare 1", nomInstrument2: "Chant", nomInstrument3: "Basse", nomInstrument4: "?", nomInstrument5: "?", nomInstrument6: "?"))
        ajoute(m:Preset.init(nomPreset: "Groupe 3", nomInstrument1: "Guitare 1", nomInstrument2: "Basse", nomInstrument3: "?", nomInstrument4: "?", nomInstrument5: "?", nomInstrument6: "?"))
        ajoute(m:Preset.init(nomPreset: "Groupe 4", nomInstrument1: "Guitare 1", nomInstrument2: "Basse", nomInstrument3: "Batterie", nomInstrument4: "Piano", nomInstrument5: "?", nomInstrument6: "?"))
    }
    
    func getPresets() -> [String] {
        var res: [String] = []
        for preset in presets {
            res.append (preset.nomPreset)
        }
        return res;
    }
    
    func getPreset(position: Int) -> Preset {
        let preset: Preset = presets[position]
        return preset;
    }
    
    func getPresets() -> [Preset] {
        return presets;
    }
    
    func count() -> Int {
        return presets.count
    }
}
