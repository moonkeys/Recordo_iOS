//
//  AudioService.swift
//  Recordo
//
//  Created by BLANCHARD Guillaume on 10/01/2019.
//  Copyright © 2019 BLANCHARD Guillaume. All rights reserved.
//

import Foundation
import CoreAudio
import CoreAudioKit
import AVFoundation
import Foundation
import AVKit

class AudioService : UIViewController, AVAudioRecorderDelegate {
    
    private var recorder : AVAudioRecorder? = nil
    private var decibels : Float? = nil

    func getDocumentsDirectory() -> URL {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls.first!
        return documentDirectory.appendingPathComponent("recording.m4a")
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        recorder.stop()
        recorder.deleteRecording()
        recorder.prepareToRecord()
    }
    
    func initRecorder() {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            print("init AVAudioRecorder...")
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            try session.setActive(true)
            
            try recorder = AVAudioRecorder(url: getDocumentsDirectory(), settings: settings)
            recorder!.delegate = self
            recorder!.isMeteringEnabled = true
            if !recorder!.prepareToRecord() {
                print("Error: AVAudioRecorder prepareToRecord failed")
            }
        } catch {
            print("Error: AVAudioRecorder creation failed")
        }
    }
    
    func start() {
        recorder?.record()
        recorder?.updateMeters()
    }
    
    func update() {
        if let recorder = recorder {
            recorder.updateMeters()
        }
    }
    
    func getDispersyPercent() -> Float? {
        if let recorder = recorder {
            decibels = recorder.averagePower(forChannel: 0)
        }
        return decibels!
    }
}
