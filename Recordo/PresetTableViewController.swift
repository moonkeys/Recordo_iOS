//
//  EnseignantTableViewController.swift
//  if26project
//
//  Created by CACHARD MARC-ANTOINE on 11/01/2019.
//  Copyright © 2019 CACHARD MARC-ANTOINE. All rights reserved.
//

import UIKit
import os.log

class PresetTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    //MARK: Properties
    var presets = [Preset]()
    var filteredPresets = [Preset]()
    let db = SingletonBdd.shared
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.rightBarButtonItem = editButtonItem
        
        // Load the sample data.
        loadData()
        
        filteredPresets = presets
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        //Initialize search bar
        //searchController.searchBar.scopeButtonTitles = ["All", "Small", "Medium", "Large"]
        //searchController.searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EnseignantTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PresetTableViewCell else{
            fatalError("The dequeued cell is not an instance of EnseignantTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let preset = presets[indexPath.row]
        
        cell.nomPreset.text = preset.nomPreset

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let preset = presets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            db.deletePreset(rowid: db.getIdPreset(nomPreset: preset.nomPreset))
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new preset.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let enseignantDetailViewController = segue.destination as? PresetViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedEnseignantCell = sender as? PresetTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedEnseignantCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedPreset = presets[indexPath.row]
            enseignantDetailViewController.preset = selectedPreset
            
        default:
            print("")
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToEnseignantsList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? PresetViewController, let preset = sourceViewController.preset {
            //print(enseignant.descriptor)
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing enseignant.
                presets[selectedIndexPath.row] = preset
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
                db.updatePreset(id: preset.id, nomPreset: preset.nomPreset, instru1: preset.nomInstrument1, instru2: preset.nomInstrument1, instru3: preset.nomInstrument1, instru4: preset.nomInstrument1, instru5: preset.nomInstrument1, instru6: preset.nomInstrument1)
                
            }else {
                // Add a new meal.
                print(presets.count)
                let newIndexPath = IndexPath(row: presets.count, section: 0)
                
                presets.append(preset)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                db.insertPreset(nomPreset: preset.nomPreset, nomInstrument1: preset.nomInstrument1, nomInstrument2: preset.nomInstrument2, nomInstrument3: preset.nomInstrument3, nomInstrument4: preset.nomInstrument4, nomInstrument5: preset.nomInstrument5, nomInstrument6: preset.nomInstrument6)
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            filteredPresets = presets
        } else {
            // Filter the results
            filteredPresets = presets.filter { $0.nomPreset.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.tableView.reloadData()
    }

    
    //MARK: Private Methods
    
    private func loadData() {
        // le = ListeEnseignants()
        //db.createTableEnseignant()
        //db.createTableEtudiant()
        //db.createTableEnseignant()
        presets = db.selectAllPresets()
    }

}
