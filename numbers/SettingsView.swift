//
//  Settings.swift
//  numbers
//
//  Created by Sidhant Gandhi on 2/1/20.
//  Copyright © 2020 newnoetic. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settings = Settings()
    @State private var showAlert: Bool = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    Toggle("Enable timer", isOn: self.$settings.enableTimer)
                }
                #if DEBUG
                Section(header: Text("Development")) {
                    Text("Hello")
                }
                #endif
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close")
                })
                .alert(isPresented: self.$showAlert) { () -> Alert in
                    Alert(title: Text("Something happened"), message: Text(self.alertMessage))
            }
        }
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
