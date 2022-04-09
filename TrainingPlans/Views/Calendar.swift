//
//  Calendar.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 03.04.2022.
//

import SwiftUI

struct Calendar: View {
    @EnvironmentObject var db:ViewModel
    var body: some View {
        ScrollView{
        Spacer()
            Divider().frame(width: .infinity, height:5)
                .background(Color.white)
        VStack {
            ForEach(0..<db.trainingPlan.count) { i in
                CalendarElement(sessionName: db.trainingPlan[i].name,date: db.trainingDays[i])
              
                
                  }
                  
               }
        .background(
            Rectangle()
                .strokeBorder(Color.white,lineWidth: 5)
                
              
        )
            
        
    }
        .onAppear {
           
        }
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}
