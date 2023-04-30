//
//  MeditationViewModel.swift
//  Meditation
//
//  Created by Vanilla on 29/04/2023.
//

import Foundation

final class MeditationViewModel: ObservableObject{
    private(set) var meditation: Meditation
    
    init(meditation: Meditation){
        self.meditation = meditation
    }
}

struct Meditation{
    let id = UUID()
    let title: String
    let description: String
    let duration: TimeInterval
    let track: String
    let image: String
    
    static let data = Meditation(title: "1 Minute Relaxing Meditation", description: "Clear your mind and embrace peace.", duration: 70, track: "moonshine", image: "image-stones")
}
