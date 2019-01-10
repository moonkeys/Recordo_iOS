//
//  ViewController.swift
//  Recordo
//
//  Created by BLANCHARD Guillaume on 10/01/2019.
//  Copyright © 2019 BLANCHARD Guillaume. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var audioService: AudioService
        audioService.permissionWasGranted(result: { granted in
            if (granted) {
                print("we have mic access!")
                micOverlay.removeFromParent()
                audioService.initRecorder()
                audioService.start()
                audioService.startCalibration()
                initGame()
            } else {
                print("we don't have mic access :(")
                micOverlay.render(rect: self.calculateOverlayRect(), text: "no mic access...")
                addChild(self.micOverlay)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

