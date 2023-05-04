//
//  PlayerView.swift
//  Meditation
//
//  Created by Vanilla on 29/04/2023.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    var meditationVM: MeditationViewModel
    var isPreview: Bool = false
    @State private var value: Double = 0.0
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack{
            
            //MARK: Background Image
            
            Image(meditationVM.meditation.image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            //MARK: Blur View
            
            Rectangle()
                .background(.thinMaterial)
                .opacity(0.25)
                .ignoresSafeArea()
            
            VStack(spacing: 32){
                
                //MARK: Dismiss Button
                
                HStack {
                    Button {
                        audioManager.stop()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                
                //MARK: Title
                
                Text(meditationVM.meditation.title)
                    .font(.title)
                    .foregroundColor(.white)
                Spacer()
                
                //MARK: Playback
                
                if let player = audioManager.player {
                    VStack(spacing: 5){
                        
                        //MARK: Playback Timeline
                        
                        Slider(value: $value, in: 0...player.duration){
                            editing in
                            
                            print("editing", editing)
                            isEditing = editing
                            if !editing{
                                player.currentTime = value
                            }
                        }
                        .tint(.white)
                        
                        
                        
                        //MARK: Playback Time
                        
                        HStack{
                            Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                            
                            Spacer()
                            
                            Text(DateComponentsFormatter.positional.string(from: player.duration - player.currentTime) ?? "0:00")
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                    }
                    
                    //MARK: Playback Controls
                    
                    HStack{
                        
                        //MARK: Repeat Button
                        
                        PlaybackControllButton(systemName: "repeat"){
                            
                        }
                        
                        Spacer()
                        
                        //MARK: Backward Button
                        
                        PlaybackControllButton(systemName: "gobackward.10"){
                            
                        }
                        
                        Spacer()
                        
                        //MARK: Play/Pause Button
                        
                        PlaybackControllButton(systemName: audioManager.isPlaying ? "pause.circle.fill": "play.circle.fill", fontSize: 44){
                            audioManager.playPause()
                        }
                        
                        Spacer()
                        
                        //MARK: Forward Button
                        
                        PlaybackControllButton(systemName: "goforward.10"){
                            
                        }
                        
                        Spacer()
                        
                        //MARK: Stop Button
                        
                        PlaybackControllButton(systemName: "stop.fill"){
                            audioManager.stop()
                            dismiss()
                        }
                    }
                }
            }
            .padding(20)
        }
        .onAppear{
//            AudioManager.shared.startPlayer(track: meditationVM.meditation.track, isPreview: isPreview)
            audioManager.startPlayer(track: meditationVM.meditation.track, isPreview: isPreview)
        }
        .onReceive(timer) { _ in
            guard let player = audioManager.player, !isEditing else {return}
            value = player.currentTime
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let meditationVM = MeditationViewModel(meditation: Meditation.data)
    static var previews: some View {
        PlayerView(meditationVM: meditationVM, isPreview: true)
            .environmentObject(AudioManager())
    }
}
