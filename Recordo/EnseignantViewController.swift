//
//  EnseignantViewController.swift
//  if26project
//
//  Created by CACHARD MARC-ANTOINE on 11/01/2019.
//  Copyright © 2019 CACHARD MARC-ANTOINE. All rights reserved.
//

import UIKit
import os.log

class PresetViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource   {
    
    @IBOutlet weak var et_nomPreset: UITextField!
    @IBOutlet weak var et_instru1: UITextField!
    @IBOutlet weak var et_instru2: UITextField!
    @IBOutlet weak var et_instru3: UITextField!
    @IBOutlet weak var et_instru4: UITextField!
    @IBOutlet weak var et_instru5: UITextField!
    @IBOutlet weak var et_instru6: UITextField!
    //@IBOutlet weak var image: UIImageView!
    @IBOutlet weak var id: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var preset: Preset?
    let db = SingletonBdd.shared
    var oldName: String = ""
    let types = ["Rock", "Pop", "Folk", "Rap", "Blues"]
    //var photoHasChanged: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        et_nomPreset.delegate = self
        et_instru1.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        updateSaveButtonState()
        
        if let preset = self.preset {
            navigationItem.title = preset.nomPreset
            oldName = preset.nomPreset
            et_nomPreset.text   = preset.nomPreset
            et_instru1.text   = preset.nomInstrument1
            /*
             switch(preset.type) {
             
             case "Rock":
             pickerView.selectRow(0, inComponent: 0, animated: true)
             case "Folk":
             pickerView.selectRow(1, inComponent: 0, animated: true)
             case "Blues":
             pickerView.selectRow(2, inComponent: 0, animated: true)
             default:
             print("")
             }*/
            
            /*
             let e = db.getPresetById(id: db.getIdEnseignant(nom: oldName))
             //print(e.descriptor)
             if(e.photo != "?"){
             let dataDecoded : Data = Data(base64Encoded: e.photo, options: .ignoreUnknownCharacters)!
             let decodedimage = UIImage(data: dataDecoded)
             image.image = decodedimage
             }*/
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    //This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = et_nomPreset.text ?? ""
        let instru1 = et_instru1.text ?? ""
        let instru2 = et_instru2.text ?? ""
        let instru3 = et_instru3.text ?? ""
        let instru4 = et_instru4.text ?? ""
        let instru5 = et_instru5.text ?? ""
        let instru6 = et_instru6.text ?? ""
        //let selectedType = types[pickerView.selectedRow(inComponent: 0)]
        
        // Set the enseignant to be passed to EnseignantTableViewController after the unwind segue.
        
        preset = Preset(nomPreset: name, nomInstrument1: instru1, nomInstrument2: instru2, nomInstrument3: instru3, nomInstrument4: instru4, nomInstrument5: instru5, nomInstrument6: instru6)
        preset?.id = db.getIdPreset(nomPreset: oldName)
        
    }
    
    //MARK: Actions comment in ViewController.swift
    /*
     @IBAction func selectImage(_ sender: UIButton) {
     
     // UIImagePickerController is a view controller that lets a user pick media from their photo library.
     let imagePickerController = UIImagePickerController()
     
     // Only allow photos to be picked, not taken.
     imagePickerController.sourceType = .photoLibrary
     
     // Make sure ViewController is notified when the user picks an image.
     imagePickerController.delegate = self
     present(imagePickerController, animated: true, completion: nil)
     }
     
     //MARK: UIImagePickerControllerDelegate
     
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     // Dismiss the picker if the user canceled.
     dismiss(animated: true, completion: nil)
     }
     
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
     // The info dictionary may contain multiple representations of the image. You want to use the original.
     guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
     fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
     }
     image.image = selectedImage
     photoHasChanged = true
     updateSaveButtonState()
     
     // Dismiss the picker.
     dismiss(animated: true, completion: nil)
     }*/
    
    //MARK: UIPickerDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //photoHasChanged = true
        updateSaveButtonState()
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let name = et_nomPreset.text ?? ""
        let instru1 = et_instru1.text ?? ""
        let instru2 = et_instru2.text ?? ""
        saveButton.isEnabled = (!name.isEmpty && !instru1.isEmpty && !instru2.isEmpty)
    }
}
