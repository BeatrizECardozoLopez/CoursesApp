//
//  Day12_FormsApp.swift
//  Day12-Forms
//
//  Created by Beatriz Cardozo on 13/8/24.
//

import SwiftUI

@main
struct Day12_FormsApp: App {
    
    //Framework Combine
    var settings = SettingsFactory()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(self.settings)
        }
    }
}
