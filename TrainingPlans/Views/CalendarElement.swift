//
//  CalendarElement.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 08.04.2022.
//

import SwiftUI

struct CalendarElement: View {
    @State var sessionName:String
    @State var date:Date
  
    @State var dayOfMonth:String = ""
    @State var day:String = ""
    @State var month:String = ""
    
    var body: some View {
        HStack {
            VStack {
                Text(day).font((Font.custom("DelaGothicOne-Regular", size: 26)))
                    
                Text(dayOfMonth+" "+month).font((Font.custom("DelaGothicOne-Regular", size: 26)))
            }
            .padding()
           
            Divider().frame(width: 4, height:130)
                    .background(Color.white)
                    
            Text(sessionName).font((Font.custom("DelaGothicOne-Regular", size: 26)))
                .padding()
        }
        .padding(.horizontal)
        .frame(maxWidth:.infinity)
        .background(
            Rectangle()
                .strokeBorder(Color.white,lineWidth: 5)
                
              
        )
        .onAppear {
            getDate()
        }
    }
    func getDate(){
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "E"
        day = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "dd"
        dayOfMonth = dateFormatter.string(from: date)
    }
}

struct CalendarElement_Previews: PreviewProvider {
    static var previews: some View {
        CalendarElement(sessionName: "Ftp Test",date: Date.now)
    }
}
