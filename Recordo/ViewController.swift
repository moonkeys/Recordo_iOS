//
//  ViewController.swift
//  Recordo
//
//  Created by BLANCHARD Guillaume on 10/01/2019.
//  Copyright © 2019 BLANCHARD Guillaume. All rights reserved.
//

import UIKit
import AVFoundation

//test allo

class ViewController: UIViewController {
    
    @IBOutlet weak var labelDecibel: UILabel!
    var sonometre: AudioService!
    var decibel:Float = 0.0
    var decibelString:String = " "
    let db = SingletonBdd.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let test = "test"
        db.insertPreset(nomPreset: test, nomInstrument1: test, nomInstrument2: test, nomInstrument3: test, nomInstrument4: test, nomInstrument5: test, nomInstrument6: test)
        
        AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
            if granted {
                print("Permission acceptée pour le microphone");
                self.sonometre?.initRecorder()
                self.sonometre?.start()
                /*self.sonometre?.update()
                self.decibel? = (self.sonometre?.getDispersyPercent())!
                self.decibelString? = String(self.decibel!)
                self.labelDecibel.text = self.decibelString*/
                return
            } else {
                print("Permission refusée");
                //faire en sorte de bloquer l'utilisation du microphone, déjà fait de base ?
                return
            }
        })
    }
    func scheduledTimerWithTimeInterval(){
        var updateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateSonometre), userInfo: nil, repeats: true)
    }
    @objc func updateSonometre() {
        self.sonometre?.update()
        self.decibel = (self.sonometre?.getDispersyPercent())!
        print(decibel)
        self.decibelString = String(self.decibel)
        print(decibelString)
        self.labelDecibel.text = self.decibelString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
