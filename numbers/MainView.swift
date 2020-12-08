//
//  MainView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/15/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var showSettings: Bool = false
    @State var showChoices: Bool = false
    @State var showTypeIn: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Spacer()
                Button(action: {
                    self.showSettings = true
                }) {
                    Image(systemName: "gear").imageScale(.large)
                }
                .accentColor(.gray)
                .buttonStyle(CircleButton(width: 25))
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                }
            }
            Spacer()
            Button("Choices") {
                self.showChoices = true
            }
            .buttonStyle(CircleButton(width: 100))
            .sheet(isPresented: $showChoices) {
                ChoicesView()
            }
            Spacer()
            Button("Type In") {
                self.showTypeIn = true
            }
            .buttonStyle(CircleButton(width: 100))
            .sheet(isPresented: $showTypeIn) {
                TypeInView()
            }
            Spacer()
        }
        .padding()




    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
