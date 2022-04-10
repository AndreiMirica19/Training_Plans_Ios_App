//
//  SignUpView.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 27.03.2022.
//

import SwiftUI

struct SignUpView: View {
    @State private var UsernameInput:String = ""
    @State private var isCycling:Bool = false
    @State private var errorPopUp:Bool = false
    @State var appStore:appStorageUtility=appStorageUtility()
    @ObservedObject var model = ViewModel()
    @Binding var signInSuccess: Bool
    @State var errorMessage = ""
    var body: some View {
       ScrollView {
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Text("Sign up")
                    
                    .font(Font.custom("DelaGothicOne-Regular", size: 90))
                    .bold()
                    .foregroundColor(Color("MainCycling"))
                    .fontWeight(.black)
                Spacer()
                VStack {
                   FormFieldView(label: "Username")
                        .foregroundColor(Color("MainCycling"))
                   FormFieldView(label: "Email")
                        .foregroundColor(Color("MainCycling"))
                   FormFieldView(label: "Password")
                        .foregroundColor(Color("MainCycling"))
                   FormFieldView(label: "Height")
                        .foregroundColor(Color("MainCycling"))
                   FormFieldView(label: "Weight")
                        .foregroundColor(Color("MainCycling"))
                   ToggleView(label: "Cyclist")
                        .foregroundColor(Color("MainCycling"))
                   ToggleView(label: "Runner")
                        .foregroundColor(Color("MainCycling"))
                        
                }.background( RoundedRectangle(cornerRadius: 30, style: .continuous).strokeBorder(Color.black,lineWidth: 5))
                    
               
                    Spacer()
                    Spacer()
                    Spacer()
                    
                Button(action:{
                    
                    if !appStore.is_Empty()  {
                       check()
                        if errorMessage == "" {
                            model.addData(athlete: Athlete(id: "", Username: appStore.username,Email: appStore.email, Password: appStore.password, Height: appStore.height, Weight: appStore.weight, Cyclist: true, Runner: true,lastWorkoutIndex: 0,startDate: Date.now,lastTimeOfTraining: Date.now))
                    self.signInSuccess = true
                        }
                            
                    }
                            
                        
                    
                    
                    else {
                    errorMessage = "All the fields must be completed"
                    errorPopUp = true
                    }
                }){
                    HStack(spacing:20) {
                        Text("Sign Up")
                            .font((Font.custom("DelaGothicOne-Regular", size: 36)))
                       Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 36, height: 36, alignment: .leading)
                    }
                    .padding(.horizontal,16)
                    .padding(.vertical,10)
                    .background(
                        Capsule().strokeBorder(Color("MainCycling"),lineWidth: 5)
                    )
                   
                }.alert(errorMessage, isPresented: $errorPopUp) {
                    Button("OK", role: .cancel) {
                        errorMessage = ""
                    }
                }
                
               
            }
            .accentColor(Color("MainCycling"))
            .ignoresSafeArea(.all, edges: .all)
            .scaledToFill()
            
       }
       
       .ignoresSafeArea(.all)
       .background(Image("loginWallpaper").scaledToFill())
   
            
    }
    init(signInSuccess: Binding<Bool>){
        self._signInSuccess = signInSuccess
        model.getData()
        
    }
    func check(){
        let RegEx = "\\w{7,28}"
        let usernamePred = NSPredicate(format:"SELF MATCHES %@", RegEx)
        let passwordPred = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let numberRegEX = "[0-9]+"
        let numberPred = NSPredicate(format:"SELF MATCHES %@", numberRegEX)
       
       
        
        if model.userExits(username: appStore.username){
            errorMessage = "User name already exists"
            errorPopUp = true
           
        }
        if model.emailAlreadyUsed(email: appStore.email){
                errorMessage = "Email already used"
                errorPopUp = true
            }
        if !numberPred.evaluate(with: appStore.weight){
            errorMessage = "Weight must be a number"
            errorPopUp = true
        }
        
        if !numberPred.evaluate(with: appStore.height){
            errorMessage = "Height must be a number"
            errorPopUp = true
        }
        if !passwordPred.evaluate(with: appStore.password) {
            errorMessage = "password must contains one special characters and is minimum six char long"
            errorPopUp = true
        }
        
        if !emailPred.evaluate(with: appStore.email){
            errorMessage = "Wrong email format"
            errorPopUp = true
        }
        if !usernamePred.evaluate(with: appStore.username){
            errorMessage = "Username does not contains between 7-28 characters"
            errorPopUp = true
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    @State static var signInSuccess = false
    static var previews: some View {
        SignUpView(signInSuccess:$signInSuccess)
    }
}
