//
//  SingletonBDD.swift
//  Recordo
//
//  Created by BLANCHARD Guillaume on 11/01/2019.
//  Copyright © 2019 BLANCHARD Guillaume. All rights reserved.
//


import Foundation
import SQLite

class SingletonBdd{
    
    var database: Connection!
    
    let preset_table = Table("preset")
    let instrument_table = Table("instrument")

    
    let preset_id = Expression<Int>("id")
    let preset_nomPreset = Expression<String>("nomPreset")
    let preset_nomInstrument1 = Expression<String>("nomInstrument1")
    let preset_nomInstrument2 = Expression<String>("nomInstrument2")
    let preset_nomInstrument3 = Expression<String>("nomInstrument3")
    let preset_nomInstrument4 = Expression<String>("nomInstrument4")
    let preset_nomInstrument5 = Expression<String>("nomInstrument5")
    let preset_nomInstrument6 = Expression<String>("nomInstrument6")
    
    let preset_idI = Expression<Int>("idI")
    let preset_instru = Expression<String>("instru")
    let preset_nbdB = Expression<Double>("nbdB")

    

    var initiated = false;
    
    var pk = 0;    // valeur de départ pour la primary key
    var tablePresetExist = false   // false la table n'est encore pas créée
    var tableInstrumentExist = false   // false la table n'est encore pas créée
    
    static let shared = SingletonBdd()
    
    init(){
        if(self.initiated){}
        else{
            // Do any additional setup after loading the view, typically from a nib.
            print ("-->  Singleton initialized")
            // Il est possible de créer des fichiers dans le répertoire "Documents" de votre application.
            // Ici, création d'un fichier users.sqlite3
            do {let documentDirectory = try
                FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask, appropriateFor: nil, create: true)
                let fileUrl = documentDirectory.appendingPathComponent("if26projectBDD").appendingPathExtension("sqlite3")
                let base = try Connection(fileUrl.path)
                self.database = base;
            }catch {
                print (error)
                print ("--> viewDidLoad fin")
            }
            self.initiated = true;
        }
    }
    
    func getConnection() -> Connection{
        return self.database;
    }
    
    func createTablePreset() {
        print ("--> createTablePreset debut")
        if !self.tablePresetExist {
            self.tablePresetExist = true
            // Instruction pour faire un drop de la table USERS
            let dropTable = self.preset_table.drop(ifExists: true)
            // Instruction pour faire un create de la table USERS
            let createTable = self.preset_table.create { table in
                table.column(self.preset_id, primaryKey: true)
                table.column(self.preset_nomPreset)
                table.column(self.preset_nomInstrument1)
                table.column(self.preset_nomInstrument2)
                table.column(self.preset_nomInstrument3)
                table.column(self.preset_nomInstrument4)
                table.column(self.preset_nomInstrument5)
                table.column(self.preset_nomInstrument6)
            }
            do {// Exécution du drop et du create
                try self.database.run(dropTable)
                try self.database.run(createTable)
                print ("Table preset est créée")
            }catch {
                print (error)
            }
        }
        print ("--> createTablePreset fin")
        
        /*
        let test = "test"
        insertPreset(nomPreset: test, nomInstrument1: test, nomInstrument2: test, nomInstrument3: test, nomInstrument4: test, nomInstrument5: test, nomInstrument6: test)*/
        
    }
    func createTableInstrument() {
        print ("--> createTableInstrument debut")
        if !self.tableInstrumentExist {
            self.tableInstrumentExist = true
            // Instruction pour faire un drop de la table USERS
            let dropTable = self.instrument_table.drop(ifExists: true)
            // Instruction pour faire un create de la table USERS
            let createTable = self.instrument_table.create { table in
                table.column(self.preset_idI, primaryKey: true)
                table.column(self.preset_id)
                table.column(self.preset_instru)
                table.column(self.preset_nbdB)
            }
            do {// Exécution du drop et du create
                try self.database.run(dropTable)
                try self.database.run(createTable)
                print ("Table instrument est créée")
            }catch {
                print (error)
            }
        }
        print ("--> createTableInstrument fin")
    }
    
    func getPKPreset() -> Int {
        var count: Int = 1
        do {try         count = self.database.scalar(preset_table.count)+1 }
        catch{
            
        }
        let pk = self.pk + count
        return pk
    }
    
    func getPKInstru() -> Int {
        var count: Int = 1
        do {try         count = self.database.scalar(instrument_table.count)+1 }
        catch{
            
        }
        let pk = self.pk + count
        return pk
    }
    
    func deleteInstru(rowid:Int)  {
        
        let InstruTest = instrument_table.filter(preset_idI == rowid )
        
        
        do {
            try database.run(InstruTest.delete())
            
        }
        catch {
            print (error)
            print ("--> delete instrument failed")
        }
        return
    }
    
    func deletePreset(rowid:Int)  {
        
        let presetTest = preset_table.filter(preset_id == rowid )
        
        
        do {
            try database.run(presetTest.delete())
            
        }
        catch {
            print (error)
            print ("--> delete preset failed")
        }
        return
    }
    
    func insertPreset(nomPreset: String, nomInstrument1: String, nomInstrument2: String, nomInstrument3: String, nomInstrument4: String, nomInstrument5: String, nomInstrument6: String) {
        print ("--> insertTablePreset debut")
        // Insertion de 2 tuples exemples (sera réalisé à chaque click sur le bouton)
        let insert = self.preset_table.insert(self.preset_id <- getPKPreset(), self.preset_nomPreset <- nomPreset, self.preset_nomInstrument1 <- nomInstrument1, self.preset_nomInstrument2 <- nomInstrument2, self.preset_nomInstrument3 <- nomInstrument3, self.preset_nomInstrument4 <- nomInstrument4, self.preset_nomInstrument5 <- nomInstrument5, self.preset_nomInstrument6 <- nomInstrument6)
        
        do {try self.database.run(insert)
            print ("Insert ok")
        }catch {
            print (error)
            print ("--> insertTablePreset fin")
        }
    }
    func insertInstru(instru: String, nbdB: Double) {
        print ("--> insertTableInstru debut")
        // Insertion de 2 tuples exemples (sera réalisé à chaque click sur le bouton)
        let insert = self.instrument_table.insert(self.preset_idI <- getPKInstru(),self.preset_id <- getPKPreset(), self.preset_instru <- instru, self.preset_nbdB <- nbdB )
        
        do {try self.database.run(insert)
            print ("Insert ok")
        }catch {
            print (error)
            print ("--> insertTableInstru fin")
        }
    }
    
    func updatePreset(id:Int, nomPreset:String, instru1: String, instru2: String, instru3: String, instru4: String, instru5: String, instru6: String){
        print ("--> updateTablePresets debut")
        let preset = self.preset_table.filter(preset_id == id)
        let update = preset.update(self.preset_nomPreset <- nomPreset, self.preset_nomInstrument1 <- instru1, self.preset_nomInstrument2 <- instru2, self.preset_nomInstrument3 <- instru3, self.preset_nomInstrument4 <- instru4, self.preset_nomInstrument5 <- instru5, self.preset_nomInstrument6 <- instru6)
        do {try self.database.run(update)
            print ("Update ok")
            
        }catch {
            print (error)
            print ("--> updatePreset failed")
        }
    }
    
    func updateInstru(idI:Int,id: Int, instru:String, nbdB: Int){
        print ("--> updateTableInstruments debut")
        let instrument = self.instrument_table.filter(preset_idI == idI)
        let update = instrument.update(self.preset_instru <- instru)
        do {try self.database.run(update)
            print ("Update ok")
            
        }catch {
            print (error)
            print ("--> updateInstruments failed")
        }
    }
    
    func getIdPreset(nomPreset: String) -> Int{
        print ("--> getRowIdPreset debut")
        var id: Int = -1
        print(nomPreset)
        let filteredTable = self.preset_table.filter(preset_nomPreset == nomPreset)
        
        do {
            let res = try self.database.prepare(filteredTable)
            for preset in res{
                id = preset[preset_id]
                print("id", preset[preset_id])
            }
            print ("getIdPreset ok")
            
        }catch {
            print (error)
            print ("--> getIdPreset failed")
        }
        return id
    }
    
    func getIdInstru(instru: String) -> Int{
        print ("--> getRowIdInstru debut")
        var id: Int = -1
        print(instru)
        let filteredTable = self.instrument_table.filter(preset_instru == instru)
        
        do {
            let res = try self.database.prepare(filteredTable)
            for instru in res{
                id = instru[preset_idI]
                print("idI", instru[preset_idI])
            }
            print ("getIdInstrument ok")
            
        }catch {
            print (error)
            print ("--> getIdInstru failed")
        }
        return id
    }

    func getPresetById(id: Int) -> Preset {
        print ("--> getPresetById debut")
        
        let filteredTable = self.preset_table.filter(preset_id == id)
        var ans: Preset = Preset.init()
        do {
            let res = try self.database.prepare(filteredTable)
            for preset in res{
                ans = Preset.init(nomPreset: preset[self.preset_nomPreset],
                                  nomInstrument1: preset[self.preset_nomInstrument1],
                                  nomInstrument2: preset[self.preset_nomInstrument2],
                                  nomInstrument3: preset[self.preset_nomInstrument3],
                                  nomInstrument4: preset[self.preset_nomInstrument4],
                                  nomInstrument5: preset[self.preset_nomInstrument5],
                                  nomInstrument6: preset[self.preset_nomInstrument6])
                ans.id = id
                print("id", preset[preset_id])
            }
            print ("getIdPresetok")
            
        }catch {
            print (error)
            print ("--> getIdPreset failed")
        }
        return ans
    }
    
    func getInstruById(id: Int) -> Instrument {
        print ("--> getInstruById debut")
        
        let filteredTable = self.instrument_table.filter(preset_idI == id)
        var ans: Instrument = Instrument.init()
        do {
            let res = try self.database.prepare(filteredTable)
            for instru in res{
                ans = Instrument.init(instru: instru[self.preset_instru],nbdB: instru[self.preset_nbdB])
                ans.id = id
                print("id", instru[preset_idI])
            }
            print ("getIdInstruok")
            
        }catch {
            print (error)
            print ("--> getIdPreset failed")
        }
        return ans
    }
    
    func countPreset() -> Int {
        print("---> countPreset debut")
        var listePresets: [Preset] = []
        do {
        let presets = try self.database.prepare(self.preset_table)
        for preset in presets{
        listePresets.append(Preset.init(nomPreset: preset[self.preset_nomPreset],
                                        nomInstrument1:preset[self.preset_nomInstrument1],
                                        nomInstrument2:preset[self.preset_nomInstrument2],
                                        nomInstrument3:preset[self.preset_nomInstrument3],
                                        nomInstrument4:preset[self.preset_nomInstrument4],
                                        nomInstrument5:preset[self.preset_nomInstrument5],
                                        nomInstrument6:preset[self.preset_nomInstrument6]))
            }
        }catch{
            print(error)
        }
        return listePresets.count
    }
    
    func countInstru() -> Int {
        print("---> countInstru debut")
        var listeInstrus: [Instrument] = []
        do {
            let instruments = try self.database.prepare(self.instrument_table)
            for instrument in instruments{
                listeInstrus.append(Instrument.init(instru: instrument[self.preset_instru], nbdB: instrument[self.preset_nbdB]))
            }
        }catch{
            print(error)
        }
        return listeInstrus.count
    }
    
    
    func selectAllPresets() ->  [Preset] {
        print("---> SelectAll debut")
        
        var listePresets: [Preset] = []
        
        do{
            let presets = try self.database.prepare(self.preset_table)
            for preset in presets{
                print("id: ", preset[self.preset_id], "preset: ",preset[self.preset_nomPreset],
                      "Instrument 1: ", preset[self.preset_nomInstrument1],
                      "Instrument 2: ", preset[self.preset_nomInstrument2],
                      "Instrument 3: ", preset[self.preset_nomInstrument3],
                      "Instrument 4: ", preset[self.preset_nomInstrument4],
                      "Instrument 5: ", preset[self.preset_nomInstrument5],
                      "Instrument 6: ", preset[self.preset_nomInstrument6])
                
                listePresets.append(Preset.init(nomPreset: preset[self.preset_nomPreset],
                                                nomInstrument1:preset[self.preset_nomInstrument1],
                                                nomInstrument2:preset[self.preset_nomInstrument2],
                                                nomInstrument3:preset[self.preset_nomInstrument3],
                                                nomInstrument4:preset[self.preset_nomInstrument4],
                                                nomInstrument5:preset[self.preset_nomInstrument5],
                                                nomInstrument6:preset[self.preset_nomInstrument6]))
            }
        }catch{
            print(error)
        }
        print("---> SelectAll fin")
        print( "Preset size", listePresets.count)
        return listePresets
    }
    
    func selectAllInstruments() ->  [Instrument] {
        print("---> SelectAllInstru debut")
        
        var listeInstrus: [Instrument] = []
        
        do{
            let instrus = try self.database.prepare(self.preset_table)
            for instru in instrus{
                print("idI: ", instru[self.preset_idI],"id: ", instru[self.preset_id], "instru: ", instru[self.preset_instru],"nbdB: ", instru[self.preset_nbdB])
                
                listeInstrus.append(Instrument.init(instru: instru[self.preset_instru], nbdB: instru[self.preset_nbdB]))
            }
        }catch{
            print(error)
        }
        print("---> SelectAllInstru fin")
        print( "Instru size", listeInstrus.count)
        return listeInstrus
    }
}
