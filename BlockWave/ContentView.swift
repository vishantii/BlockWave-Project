//
//  ContentView.swift
//  BlockWave
//
//  Created by Mohamad Farhan on 16/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                Text("AccentColor")
                    .foregroundColor(Color.theme.accent)
                
                Text("SecondaryColor")
                    .foregroundColor(Color.theme.secondaryText )
            }
        }

    }
}

#Preview {
    ContentView()
}
