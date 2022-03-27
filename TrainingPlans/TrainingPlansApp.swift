//
//  TrainingPlansApp.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 27.03.2022.
//

import SwiftUI

@main
struct TrainingPlansApp: App {
    @State var signInSuccess = false
    var body: some Scene {
        WindowGroup {
            if signInSuccess {
            MainView()
            }
            else {
                ContentView(signInSuccess: $signInSuccess)
            }
        }
    }
}
