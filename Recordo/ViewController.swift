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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    @IBAction func rewindButtonTapped(_ sender: Any) {
        setOnPause()
        buttonStatusLabel.text="Rewinding..."
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        
        if !isPlaying
        {
            setOnPlay()
        } else {
            setOnPause()
        }
    }
    
    @IBAction func fastForwardButtonTapped(_ sender: Any) {
        setOnPause()
        buttonStatusLabel.text="Fast forwarding..."
    }
    
    func setOnPause()
    {
        var items = self.myToolBar.items
        items![2] = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.play, target: self, action: #selector(ViewController.playButtonTapped(_:)))
        isPlaying = false
        buttonStatusLabel.text = "On pause..."
        self.myToolBar.setItems(items, animated: true)
    }
    
    func setOnPlay()
    {
        var items = self.myToolBar.items
        items![2] = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.pause, target: self, action: #selector(ViewController.playButtonTapped(_:)))
        isPlaying = true
        buttonStatusLabel.text = "Playing..."
        self.myToolBar.setItems(items, animated: true)
    }
*/
}

