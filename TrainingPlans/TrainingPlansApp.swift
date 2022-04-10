//
//  TrainingPlansApp.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 27.03.2022.
//

import SwiftUI
import Firebase
@main
struct TrainingPlansApp: App {
    @State var signInSuccess = false
    @State var signUpScreen = false
   @StateObject var db = ViewModel()
    init(){
        FirebaseApp.configure()
        
        
      
    }
    var body: some Scene {
        WindowGroup {
            
            
                if signInSuccess {
            MainView()
                    .environmentObject(db)
            }
                else {
                    ContentView(signInSuccess: $signInSuccess,signUpScreen: $signUpScreen)
                        .environmentObject(db)
                }
            }
           
        
    }
    
}
