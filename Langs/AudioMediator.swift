//
//  AudioMediator.swift
//  Langs
//
//  Created by Chuan Ren on 11/29/15.
//  Copyright © 2015 mg526. All rights reserved.
//

import UIKit
import AVFoundation

private let _sharedAudioMediator = AudioMediator()

class AudioMediator: NSObject {

    var musicPlayer: AVAudioPlayer?
    var tapPlayer: AVAudioPlayer?
    var congPlayer: AVAudioPlayer?

    class var instance : AudioMediator {
        return _sharedAudioMediator
    }

    func playBackgroudMusic() {
        if (self.musicPlayer == nil) {
            let filePath = NSBundle.mainBundle().pathForResource("bg", ofType: "mp3")
            let fileUrl = NSURL(fileURLWithPath: filePath!)

            do {
                self.musicPlayer = try AVAudioPlayer(contentsOfURL: fileUrl)
            }
            catch _ {
                print("Music player error!")
            }

        }

        self.musicPlayer?.prepareToPlay()
        self.musicPlayer?.numberOfLoops = -1
        self.musicPlayer?.play()
    }

    func pauseBackgroudMusic() {
        if (self.musicPlayer != nil) {
            self.musicPlayer?.pause()
        }
    }

    func playSoundTap() {
        if (self.tapPlayer == nil) {
            let filePath = NSBundle.mainBundle().pathForResource("tap", ofType: "mp3")
            let fileUrl = NSURL(fileURLWithPath: filePath!)

            do {
                self.tapPlayer = try AVAudioPlayer(contentsOfURL: fileUrl)
            }
            catch _ {
                print("Tap player error!")
            }

        }

        self.tapPlayer?.prepareToPlay()
        self.tapPlayer?.play()
    }
    
    func playSoundCongrate() {
        if (self.congPlayer == nil) {
            let filePath = NSBundle.mainBundle().pathForResource("success", ofType: "mp3")
            let fileUrl = NSURL(fileURLWithPath: filePath!)

            do {
                self.congPlayer = try AVAudioPlayer(contentsOfURL: fileUrl)
            }
            catch _ {
                print("Congrate player error!")
            }

        }

        self.congPlayer?.prepareToPlay()
        self.congPlayer?.play()

    }
}
