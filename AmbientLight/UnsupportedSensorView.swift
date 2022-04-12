//
//  UnsupportedSensorView.swift
//  AmbientLight
//
//  Created by Yang Liu on 3/22/22.
//

import SwiftUI

struct UnsupportedSensorView: View {
    var body: some View {
        VStack {
            Text("Sorry, I couldn't find an ambient light sensor on your Mac.")
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .foregroundColor(Color(NSColor.secondaryLabelColor))
                .font(.system(size: 12, weight: .medium))
            
            Button(action: {
                NSApp.sendAction(#selector(NSApplication.terminate(_:)), to: nil, from: nil)
            }, label: {
                Text("Quit")
            })
        }
    }
}

struct UnsupportedSensorView_Previews: PreviewProvider {
    static var previews: some View {
        UnsupportedSensorView()
    }
}
