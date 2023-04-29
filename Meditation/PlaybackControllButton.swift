//
//  PlayBackControll.swift
//  Meditation
//
//  Created by Vanilla on 29/04/2023.
//

import SwiftUI

struct PlaybackControllButton: View {
    var systemName: String = "play"
    var fontSize: CGFloat = 24
    var color: Color = .white
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .font(.system(size: fontSize))
                .foregroundColor(color)
        }

    }
}

struct PlayBackControll_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackControllButton(action: {})
            .preferredColorScheme(.dark)
    }
}
