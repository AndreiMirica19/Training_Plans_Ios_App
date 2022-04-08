//
//  ContentView.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 27.03.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var UsernameInput:String = ""
    @State var isSignUpActive = false
    @AppStorage("username_input") var username: String = ""
    @AppStorage("password_input") var password: String = ""
    @AppStorage("validLogin")   var isValid:Bool = false
    @AppStorage("currentUserIndex") var index:Int = -1
    var appStore:appStorageUtility=appStorageUtility()
    @EnvironmentObject var db:ViewModel
    @Binding var signInSuccess: Bool
    var body: some View {
       
        NavigationView {
            ZStack{
        VStack {
            
            Text("Log In")
                
                .font(Font.custom("DelaGothicOne-Regular", size: 90))
                .bold()
                .foregroundColor(.black)
                .fontWeight(.black)
           
            VStack {
                FormFieldView(label:"username_input")
                    .foregroundColor(.white)
                FormFieldView(label: "password_input")
                    .foregroundColor(.white)
             
            }.background( RoundedRectangle(cornerRadius: 30, style: .continuous).strokeBorder(Color.black,lineWidth: 5))
           
                Spacer()
                Spacer()
                Spacer()
            Button(action:{
               
                for i in 0...db.users.count-1{
                    if username == db.users[i].Username && password == db.users[i].Password {
                        index = i
                    self.signInSuccess = true
                }
                    
                }
                if signInSuccess == false {
                    print("Invalid")
                }
            }){
                HStack(spacing:20) {
                    Text("Log In")
                        .font((Font.custom("DelaGothicOne-Regular", size: 36)))
                        .foregroundColor(.white)
                   Image(systemName: "arrow.right.circle")
                        .resizable()
                        .frame(width: 36, height: 36, alignment: .leading)
                        .foregroundColor(.white)
                }
                .padding(.horizontal,16)
                .padding(.vertical,10)
                .background(
                    Capsule().strokeBorder(Color.white,lineWidth: 5)
                )
            }
            .accentColor(Color.black)
            
                Button(action:{
                    appStore.emptyIt()
                   isSignUpActive = true
                }){
                    HStack(spacing:20) {
                        Text("Sign Up")
                            .font((Font.custom("DelaGothicOne-Regular", size: 36)))
                            .foregroundColor(.white)
                       Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 36, height: 36, alignment: .leading)
                            .foregroundColor(.white)
                    }
                    
                    .padding(.horizontal,16)
                    .padding(.vertical,10)
                    .background(
                        Capsule().strokeBorder(Color.white,lineWidth: 5)
                            
                    )
                }
                .accentColor(Color.yellow)
       
                       
                       .background(
                        NavigationLink(destination: SignUpView(signInSuccess: $signInSuccess), isActive: $isSignUpActive) {
                            SignUpView(signInSuccess:$signInSuccess)
                           }
                           .hidden()
                       )
                   }
        
        
            }
            .padding()
            .background(Image("wallpaper").blur(radius: 20))
         
                       
            
            
        }
        .onAppear(perform: {
            
        })
        
        .ignoresSafeArea(.all, edges: .all)
        
       
    
    }
   
    init(signInSuccess: Binding<Bool>){
        self._signInSuccess = signInSuccess
    //model.getData()
        //model.getTrainingPlan()
       
       
        
    }
}

struct ContentView_Previews: PreviewProvider {
     @State static var signInSuccess = false
    static var previews: some View {
        ContentView(signInSuccess: $signInSuccess)
    }
}
