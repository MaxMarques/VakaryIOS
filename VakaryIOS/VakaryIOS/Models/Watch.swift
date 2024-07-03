//
//  Watch.swift
//  Vakary
//
//  Created by Marques on 01/05/2023.
//

import Foundation

class Watch: ObservableObject {
    @Published var elapsedTime = 0.0
    private var timer: Timer?
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.updateTimer()
        }
    }
    
    private func updateTimer() {
        elapsedTime += 0.1
    }
    
    func reset() {
        timer?.invalidate()
        timer = nil
        elapsedTime = 0.0
    }
    
    var timeString: String {
        let hours = Int(elapsedTime / 3600)
        let minutes = Int((elapsedTime.truncatingRemainder(dividingBy: 3600)) / 60)
        let seconds = Int(elapsedTime.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d h %02d min %02d s", hours, minutes, seconds)
    }
}
