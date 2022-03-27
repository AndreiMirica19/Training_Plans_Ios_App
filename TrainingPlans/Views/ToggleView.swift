//
//  ToggleView.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 27.03.2022.
//

import SwiftUI

struct ToggleView: View {
   @State var isOn:Bool = false
    var label:String
    var body: some View {
        Toggle(isOn: $isOn) {
             Spacer()
                   Text(label)
                   .font((Font.custom("DelaGothicOne-Regular", size: 26)))
               }
        .onChange(of: isOn) { value in
                       // action...
            UserDefaults.standard.set(
                value, forKey: label.lowercased())
                   }
        .padding(.all)
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView(label: "Runner")
    }
}
