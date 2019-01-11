//
//  ViewController.swift
//  Recordo
//
//  Created by BLANCHARD Guillaume on 10/01/2019.
//  Copyright © 2019 BLANCHARD Guillaume. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var labelDecibel: UILabel!
    var audioService: AudioService?
    var decibel:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioService?.permissionWasGranted(result: { granted in
            if (granted) {
                print("We have mic access!")
                self.audioService?.initRecorder()
                self.audioService?.start()
                self.audioService?.update()
                self.decibel = (self.audioService?.getDispersyPercent())!
                var decibelString = String(self.decibel)
                self.labelDecibel.text = decibelString
            } else {
                print("We don't have mic access")
            }
        })
    }

    /*override func update(_currentTime: TimeInterval) {
        audioService.update()
        decibel = audioService.getDispersyPercent()
        let decibelString = String(decibel)
        self.labelDecibel.text = decibelString
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
