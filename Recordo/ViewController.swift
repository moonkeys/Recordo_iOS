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
    var decibel:Float?
    var decibelString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    func update(_currentTime: TimeInterval) {
        self.sonometre?.update()
        self.decibel? = (self.sonometre?.getDispersyPercent())!
        self.decibelString? = String(self.decibel!)
        self.labelDecibel.text = self.decibelString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
