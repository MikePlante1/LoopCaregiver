//
//  LooperView.swift
//  LoopCaregiver
//
//  Created by Bill Gestrich on 11/18/22.
//

import SwiftUI

struct LooperView: View {
    
    @ObservedObject var looperService: LooperService
    @ObservedObject var looper: Looper
    @Binding var path: NavigationPath
    @State private var isPresentingConfirm: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Section {
                    LabeledContent {
                        Text(looper.nightscoutURL)
                    } label: {
                        Text("Nightscout")
                    }
                    LabeledContent {
                        Text(looper.otpCode)
                    } label: {
                        Text("OTP")
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button("Remove", role: .destructive) {
                            isPresentingConfirm = true
                        }
                        Spacer()
                    }
                }
            }
        }
        .confirmationDialog("Are you sure?",
                            isPresented: $isPresentingConfirm) {
            Button("Remove \(looper.name)?", role: .destructive) {
                do {
                    try looperService.removeLooper(looper)
                    path.removeLast()
                } catch {
                    //TODO: Show errors here
                    print("Error removing loop user")
                }
            }
            Button("Cancel", role: .cancel) {}
        }
        .navigationBarTitle(Text(looper.name), displayMode: .inline)
    }
}
