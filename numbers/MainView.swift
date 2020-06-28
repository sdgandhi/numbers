//
//  MainView.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/15/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import SwiftUI

enum SheetType {
    case None
    case Choices
    case TypeIn
    case Settings
}

struct MainView: View {
    @State var showSheet: Bool = false
    @State var sheet: SheetType = .None
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack {
                Spacer()
                Button(action: {
                    self.sheet = .Settings
                    self.showSheet.toggle()
                }) {
                    Image(systemName: "gear").imageScale(.large)
                }
                .accentColor(.gray)
                .buttonStyle(CircleButton(width: 25))
            }
            Spacer()
            Button("Choices") {
                self.sheet = .Choices
                self.showSheet.toggle()
            }
            .buttonStyle(CircleButton(width: 100))
            Spacer()
            Button("Type In") {
                self.sheet = .TypeIn
                self.showSheet.toggle()
            }
            .buttonStyle(CircleButton(width: 100))
            Spacer()
        }
        .sheet(isPresented: $showSheet) {
            if self.sheet == .Choices {
                ChoicesView()
            } else if self.sheet == .TypeIn {
                TypeInView()
            } else if self.sheet == .Settings {
                SettingsView()
            }
        }
        .padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
