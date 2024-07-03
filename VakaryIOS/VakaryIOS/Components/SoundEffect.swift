//
//  SoundEffect.swift
//  VakaryIOS
//
//  Created by Thibaut  Humbert on 26/12/2023.
//

import SwiftUI
import AVFoundation

class SoundManager: ObservableObject {
    static let shared = SoundManager()

    @Published var volume: Float = 1.0

    private var audioPlayer: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "clic", withExtension: "mp3") else {
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = volume
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
