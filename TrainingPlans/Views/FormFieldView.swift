//
//  FormFieldView.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 27.03.2022.
//

import SwiftUI

struct FormFieldView: View {
    var label :String
    @State  public var input:String = ""
    
    var body: some View {
        if label.hasSuffix("input"){
            
            HStack {
                Spacer()
                Text(label.substring(to: label.firstIndex(of: "_")!))
                    .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                .bold()
                Spacer()
                TextField(label.substring(to: label.firstIndex(of: "_")!).lowercased(), text: $input,onCommit: {
                    UserDefaults.standard.set(
                        self.input, forKey: label.lowercased())
                })
                    .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                   
                
                
            }.padding(.all)
        }
        else{
        HStack {
            Spacer()
            Text(label)
                .font((Font.custom("DelaGothicOne-Regular", size: 26)))
            .bold()
            Spacer()
            TextField(label.lowercased(), text: $input,onCommit: {
                UserDefaults.standard.set(
                    self.input, forKey: label.lowercased())
            })
                .font((Font.custom("DelaGothicOne-Regular", size: 26)))
               
            
            
        }.padding(.all)
        }
    }
    func returnInput() {
    }
}

struct FormFieldView_Previews: PreviewProvider {
    static var previews: some View {
        FormFieldView(label:"Username")
    }
}
