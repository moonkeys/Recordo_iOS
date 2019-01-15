//
//  SingletonBDD.swift
//  if26project
//
//  Created by CACHARD MARC-ANTOINE on 11/01/2019.
//  Copyright © 2019 CACHARD MARC-ANTOINE. All rights reserved.
//


import Foundation
import SQLite

class SingletonBdd{
    
    var database: Connection!
    
    let preset_table = Table("preset")
    let preset_id = Expression<Int>("id")
    let preset_nomPreset = Expression<String>("nomPreset")
    let preset_nomInstrument1 = Expression<String>("nomInstrument1")
    let preset_nomInstrument2 = Expression<String>("nomInstrument2")
    let preset_nomInstrument3 = Expression<String>("nomInstrument3")
    let preset_nomInstrument4 = Expression<String>("nomInstrument4")
    let preset_nomInstrument5 = Expression<String>("nomInstrument5")
    let preset_nomInstrument6 = Expression<String>("nomInstrument6")
    

    var initiated = false;
    
    var pk = 1000;    // valeur de départ pour la primary key
    var tablePresetExist = false   // false la table n'est encore pas créée   // false la table n'est encore pas créée

    
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
        
        
        let test = "test"
        insertPreset(nomPreset: test, nomInstrument1: test, nomInstrument2: test, nomInstrument3: test, nomInstrument4: test, nomInstrument5: test, nomInstrument6: test)
        
    }
    /*
    func createTableModule() {
        print ("--> createTableModule debut")
        if !self.tableModuleExist {
            self.tableModuleExist = true
            // Instruction pour faire un drop de la table USERS
            let dropTable = self.etudiant_table.drop(ifExists: true)
            // Instruction pour faire un create de la table USERS
            let createTable = self.etudiant_table.create { table in
                table.column(self.attribut_id, primaryKey: true)
                table.column(self.attribut_sigle)
                table.column(self.attribut_parcours)
                table.column(self.attribut_categorie)
                table.column(self.attribut_credit)
            }
            do {// Exécution du drop et du create
                try self.database.run(dropTable)
                try self.database.run(createTable)
                print ("Table module est créée")
            }catch {
                print (error)
            }
        }
        print ("--> createTableModule fin")
        
        
        let test = "test"
        insertModule(sigle: test, parcours: test, categorie: test, credit: 0)
    }
    
    func createTableEnseignant() {
        print ("--> createTableEnseignant debut")
        if !self.tableEnseignantExist {
            self.tableEnseignantExist = true
            // Instruction pour faire un drop de la table USERS
            let dropTable = self.enseignant_table.drop(ifExists: true)
            // Instruction pour faire un create de la table USERS
            let createTable = self.enseignant_table.create { table in
                table.column(self.attribut_id, primaryKey: true)
                table.column(self.attribut_nom)
                table.column(self.attribut_prenom)
                table.column(self.attribut_type)
                table.column(self.attribut_photo)
            }
            do {// Exécution du drop et du create
                try self.database.run(dropTable)
                try self.database.run(createTable)
                print ("Table enseignant est créée")
            }catch {
                print (error)
            }
        }
        print ("--> createTableEnseignants fin")
        
        
        let test = "test"
        insertEnseignant(nom: test, prenom: test, type: test, photo: "?")
    }*/
    
    func getPKPreset() -> Int {
        var count: Int = 1
        do {try         count = self.database.scalar(preset_table.count)+1 }
        catch{
            
        }
        let pk = self.pk + count
        return pk
    }
    /*
    func getPKEtudiant() -> Int {
        var count: Int = 1
        do {try         count = self.database.scalar(etudiant_table.count)+1 }
        catch{
            
        }
        
        let pk = self.pk + count
        return pk
    }
    
    func getPKModule() -> Int {
        var count: Int = 1
        do {try         count = self.database.scalar(module_table.count)+1 }
        catch{
            
        }
        
        let pk = self.pk + count
        return pk
    }*/
    
    func deletePreset(rowid:Int)  {
        
        let presetTest = preset_table.filter(preset_id == rowid )
        //try database.run(alice.update(email <- email.replace("mac.com", with: "me.com")))
        // UPDATE "users" SET "email" = replace("email", 'mac.com', 'me.com')
        // WHERE ("id" = 1)
        
        
        do {
            try database.run(presetTest.delete())
            
        }
        catch {
            print (error)
            print ("--> delete epreset failed")
        }
        // DELETE FROM "users" WHERE ("id" = 1)
        
        return
    }
    /*
    func deleteEtudiant(rowid:Int)  {
        
        let alice = etudiant_table.filter(attribut_id == rowid )
        
        //try database.run(alice.update(email <- email.replace("mac.com", with: "me.com")))
        // UPDATE "users" SET "email" = replace("email", 'mac.com', 'me.com')
        // WHERE ("id" = 1)
        
        
        do {
            try database.run(alice.delete())
            
        }
        catch {
            print (error)
            print ("--> delete etudiant failed")
        }
        // DELETE FROM "users" WHERE ("id" = 1)
        
        return
    }
    
    func deleteModule(rowid:Int)  {
        
        let alice = module_table.filter(attribut_id == rowid )
        
        //try database.run(alice.update(email <- email.replace("mac.com", with: "me.com")))
        // UPDATE "users" SET "email" = replace("email", 'mac.com', 'me.com')
        // WHERE ("id" = 1)
        
        
        do {
            try database.run(alice.delete())
            
        }
        catch {
            print (error)
            print ("--> delete module failed")
        }
        // DELETE FROM "users" WHERE ("id" = 1)
        
        return
    }*/
    
    
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
    /*
    func insertEtudiant(nom:String, prenom:String, niveau:String, filiere: String, photo: String) {
        print ("--> insertTableEtudiant debut")
        let insert = self.etudiant_table.insert(self.attribut_id <- getPKEtudiant(), self.attribut_nom <- nom, self.attribut_prenom <- prenom, self.attribut_niveau <- niveau, self.attribut_filiere <- filiere, self.attribut_filiere <- photo)
        //print(insert)
        do {try self.database.run(insert)
            print ("Insert ok")
            
        }catch {
            print (error)
            print ("--> insertEnseignant failed")
        }
    }
    
    func insertModule(sigle:String, parcours:String, categorie:String, credit: Int) {
        print ("--> insertTableModules debut")
        let insert = self.module_table.insert(self.attribut_id <- getPKModule(), self.attribut_sigle <- sigle, self.attribut_parcours <- parcours, self.attribut_categorie <- categorie, self.attribut_credit <- credit)
        //print(insert)
        do {try self.database.run(insert)
            print ("Insert ok")
            
        }catch {
            print (error)
            print ("--> insertModule failed")
        }
    }*/
    
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
    /*
    func updateEtudiant(id:Int, nom:String, prenom:String, niveau:String, filiere: String){
        print ("--> updateTableEtudiant debut")
        let etudiant = self.etudiant_table.filter(attribut_id == id)
        let update = etudiant.update(self.attribut_nom <- nom, self.attribut_prenom <- prenom, self.attribut_niveau <- niveau, self.attribut_filiere <- filiere)
        do {try self.database.run(update)
            print ("Update ok")
            
        }catch {
            print (error)
            print ("--> updateEtudiant failed")
        }
    }
    
    func updateModule(id:Int, sigle:String, parcours:String, categorie:String, credit: Int){
        print ("--> updateTableModules debut")
        let module = self.module_table.filter(attribut_id == id)
        let update = module.update(self.attribut_sigle <- sigle, self.attribut_categorie <- categorie, self.attribut_parcours <- parcours, self.attribut_credit <- credit)
        do {try self.database.run(update)
            print ("Update ok")
            
        }catch {
            print (error)
            print ("--> updateEnseignant failed")
        }
    }*/
    
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
    /*
    func getIdEnseignant(nom: String) -> Int{
        print ("--> getRowIdEnseignant debut")
        var id: Int = -1
        print(nom)
        let filteredTable = self.enseignant_table.filter(attribut_nom == nom)
        
        do {
            let res = try self.database.prepare(filteredTable)
            for enseignant in res{
                id = enseignant[attribut_id]
                print("id", enseignant[attribut_id])
            }
            print ("getIdEnseignant ok")
            
        }catch {
            print (error)
            print ("--> getIdEnseignant failed")
        }
        return id
    }
    
    func getIdEtudiant(nom: String) -> Int{
        print ("--> getRowIdEtudiant debut")
        var id: Int = -1
        print(nom)
        let filteredTable = self.etudiant_table.filter(attribut_nom == nom)
        
        do {
            let res = try self.database.prepare(filteredTable)
            for etudiant in res{
                id = etudiant[attribut_id]
                print("id", etudiant[attribut_id])
            }
            print ("getIdEtudiant ok")
            
        }catch {
            print (error)
            print ("--> getIdEtudiant failed")
        }
        return id
    }
    
    func getIdModule(sigle: String) -> Int{
        print ("--> getRowIdSigle debut")
        var id: Int = -1
        print(sigle)
        let filteredTable = self.enseignant_table.filter(attribut_sigle == sigle)
        
        do {
            let res = try self.database.prepare(filteredTable)
            for module in res{
                id = module[attribut_id]
                print("id", module[attribut_id])
            }
            print ("getIdSigle ok")
            
        }catch {
            print (error)
            print ("--> getIdSigle failed")
        }
        return id
    }*/
    
    
    

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
    /*
    func getEnseignantById(id: Int) -> Enseignant{
        print ("--> getEnseignantById debut")
        
        let filteredTable = self.enseignant_table.filter(attribut_id == id)
        var ans: Enseignant = Enseignant.init()
        do {
            let res = try self.database.prepare(filteredTable)
            for enseignant in res{
                ans = Enseignant.init(nom: enseignant[self.attribut_nom], prenom: enseignant[self.attribut_prenom], type: enseignant[self.attribut_type])
                ans.id = id
                ans.photo = enseignant[self.attribut_photo]
                print("id", enseignant[attribut_id])
            }
            print ("getIdEnseignant ok")
            
        }catch {
            print (error)
            print ("--> getIdEnseignant failed")
        }
        return ans
    }
    
    func getEtudiantById(id: Int) -> Etudiant{
        print ("--> getEtudiantById debut")
        
        let filteredTable = self.etudiant_table.filter(attribut_id == id)
        var ans: Etudiant = Etudiant.init()
        do {
            let res = try self.database.prepare(filteredTable)
            for etudiant in res{
                ans = Etudiant.init(nom: etudiant[self.attribut_nom], prenom: etudiant[self.attribut_prenom], niveau: etudiant[self.attribut_niveau], filiere: etudiant[self.attribut_filiere])
                ans.id = id
                ans.photo = etudiant[self.attribut_photo]
                print("id", etudiant[attribut_id])
            }
            print ("getIdEtudiant ok")
            
        }catch {
            print (error)
            print ("--> getIdEtudiant failed")
        }
        return ans
    }
    
    func getModuleById(id: Int) -> Module{
        print ("--> getModuleById debut")
        
        let filteredTable = self.module_table.filter(attribut_id == id)
        var ans: Module = Module.init()
        do {
            let res = try self.database.prepare(filteredTable)
            for module in res{
                ans = Module.init(sigle: module[self.attribut_sigle], parcours: module[self.attribut_parcours], categorie: module[self.attribut_categorie], credit: module[self.attribut_credit])
                ans.id = id
                print("id", module[attribut_id])
            }
            print ("getIdModule ok")
            
        }catch {
            print (error)
            print ("--> getIdModule failed")
        }
        return ans
    }*/
    
    func countPreset() {
    }
    
    func selectAllPresets() ->  [Preset] {
        print("---> SelectAll debut")
        
        var listePresets: [Preset] = []
        //var preset: Preset;
        
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
    
    /*
    func selectAllEtudiants() ->  [Etudiant] {
        print("---> SelectAll debut")
        
        var listeEtudiants: [Etudiant] = []
        //var enseignant: Enseignant;
        
        do{
            let etudiants = try self.database.prepare(self.etudiant_table)
            for etudiant in etudiants{
                print("id: ", etudiant[self.attribut_id], ", nom: ", etudiant[self.attribut_nom], ", prenom: ", etudiant[self.attribut_prenom], ", niveau: ", etudiant[self.attribut_niveau],  ", filiere: ", etudiant[self.attribut_filiere])
                
                listeEtudiants.append((Etudiant.init(nom: etudiant[self.attribut_nom], prenom: etudiant[self.attribut_prenom], niveau: etudiant[self.attribut_niveau], filiere: etudiant[self.attribut_filiere])))
            }
            
        }catch{
            print(error)
        }
        print("---> SelectAll fin")
        print( "size", listeEtudiants.count)
        return listeEtudiants
    }
    
    func selectAllModules() ->  [Module] {
        print("---> SelectAll debut")
        
        var listeModules: [Module] = []
        //var enseignant: Enseignant;
        
        do{
            let modules = try self.database.prepare(self.module_table)
            for module in modules{
                listeModules.append(Module.init(sigle: module[self.attribut_sigle], parcours: module[self.attribut_parcours], categorie: module[self.attribut_categorie], credit: module[self.attribut_credit]))
            }
            
        }catch{
            print(error)
        }
        print("---> SelectAll fin")
        print( "size", listeModules.count)
        return listeModules
    }*/
}
