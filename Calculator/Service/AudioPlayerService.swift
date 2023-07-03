//
//  AudioPlayerService.swift
//  Calculator
//
//  Created by user on 2023/6/30.
//

import AVFoundation
import Foundation

protocol AudioPlayerService {
    func playSound()
}

final class AudioPlayer: AudioPlayerService {
    private var player: AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource: "click", ofType: "m4a")!
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        catch (let error) {
            print(error.localizedDescription)
        }
    }
}
