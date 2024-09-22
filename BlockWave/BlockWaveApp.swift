//
//  BlockWaveApp.swift
//  BlockWave
//
//  Created by Mohamad Farhan on 16/08/24.
//

import SwiftUI

@main
struct BlockWaveApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
        
    }
}
