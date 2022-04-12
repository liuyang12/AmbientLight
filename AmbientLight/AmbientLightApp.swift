//
//  AmbientLightApp.swift
//  AmbientLight
//
//  Created by Yang Liu on 3/21/22.
//

import SwiftUI
import DarkModeBuddyCore

@main
struct AmbientLightApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(lightReader: DMBAmbientLightSensorReader(frequency: .realtime))
        }
    }
}
