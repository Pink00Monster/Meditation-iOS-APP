//
//  MeditationApp.swift
//  Meditation
//
//  Created by Vanilla on 29/04/2023.
//

import SwiftUI

@main
struct MeditationApp: App {
    @StateObject var audioManager = AudioManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
