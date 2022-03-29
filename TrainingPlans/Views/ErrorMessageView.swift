//
//  ErrorMessageView.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 29.03.2022.
//

import SwiftUI

struct ErrorMessageView: View {
    @State var message:String
    var body: some View {
        Text(message).font((Font.custom("DelaGothicOne-Regular", size: 26)))
             .bold()
             .foregroundColor(.red)
    }
}

struct ErrorMessageView_Previews: PreviewProvider {
    @State static var message:String = "Bla bla bla"
    static var previews: some View {
        ErrorMessageView(message: message)
    }
}
