//
//  AudioService.swift
//  Cobify
//
//  Created by Bruno Bencevic on 12.12.2022..
//

import Foundation
import AVFoundation

enum AudioServiceError: Error {
    case fileNotFound(fileName: String)
}

final class AudioService {
    
    private let audioSession = AVAudioSession.sharedInstance()
    private var player: AVAudioPlayer?
    
    init() {
        
    }

    func playFromBundle() throws -> Double {
        let path = Bundle.main.path(forResource: "intro", ofType: "mp3")!
        let url = URL(string: path)!
        
        try audioSession.setCategory(.playback, mode: .default)
        try audioSession.setActive(true)
        
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        player?.prepareToPlay()
        player?.play()
        
        return player?.duration ?? 0
    }
    
    func play(file: String) throws -> Double {
        let fileURL = FileManager.default.getPath(for: file)
        
        try audioSession.setCategory(.playback, mode: .default)
        try audioSession.setActive(true)
        
        do {
            player = try AVAudioPlayer(contentsOf: fileURL, fileTypeHint: AVFileType.mp3.rawValue)
        } catch {
            print(error)
        }
        
        
        player?.prepareToPlay()
        player?.play()
        
        return player?.duration ?? 0
    }
    
    func resumeSound() {
        player?.play()
    }
    
    func playSound(named fileName: String) throws {
        let url = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask)[0].appendingPathComponent("\(fileName)")
        
        try audioSession.setCategory(.playback, mode: .default)
        try audioSession.setActive(true)
        
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        player?.play()
    }
    
    func playFrom(percentage: Double) {
        guard let duration = player?.duration else { return }
        let timeToStartFrom = duration * percentage
        
        player?.currentTime = timeToStartFrom
    }
    
    func pauseSound() {
        player?.pause()
        
    }
    
    func stopSound() {
        player?.stop()
        player = nil
    }
}
