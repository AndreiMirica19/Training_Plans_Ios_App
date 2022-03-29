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
    @Binding var signInSuccess: Bool
   @State var errorMessage = ""
    var body: some View {
        ScrollView {
            VStack {
                Text("Sign up")
                    
                    .font(Font.custom("DelaGothicOne-Regular", size: 90))
                    .bold()
                    .foregroundColor(.yellow)
                    .fontWeight(.black)
                Spacer()
                VStack {
                   FormFieldView(label: "Username")
                   FormFieldView(label: "Email")
                   FormFieldView(label: "Password")
                   FormFieldView(label: "Height")
                   FormFieldView(label: "Weight")
                   ToggleView(label: "Cyclist")
                   ToggleView(label: "Runner")
                        
                }.background( RoundedRectangle(cornerRadius: 30, style: .continuous).strokeBorder(Color.black,lineWidth: 5))
                    
               
                    Spacer()
                    Spacer()
                    Spacer()
              
                Button(action:{
                    if !appStore.is_Empty() {
                    self.signInSuccess = true
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
                        Capsule().strokeBorder(Color.black,lineWidth: 5)
                    )
                   
                }.alert(errorMessage, isPresented: $errorPopUp) {
                    Button("OK", role: .cancel) { }
                }
                .accentColor(Color.black)
              
               
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    @State static var signInSuccess = false
    static var previews: some View {
        SignUpView(signInSuccess:$signInSuccess)
    }
}
