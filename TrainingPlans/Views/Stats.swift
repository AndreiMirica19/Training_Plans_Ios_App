//
//  Stats.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 03.04.2022.
//

import SwiftUI
import SwiftPieChart
struct Stats: View {
    @AppStorage("currentUserIndex") var index:Int = -1
    @EnvironmentObject  var db:ViewModel
    
    var body: some View {
        
        ScrollView {
            VStack{
                
                Text("Workouts Done")
                    .font((Font.custom("DelaGothicOne-Regular", size: 36)))
                HStack{
                PieChartView(
                    values: [Double(db.users[index].trainingDays.count-1), Double((db.lastTrainingIndex))],
                    names: [" skipped"," workouts done "],
                    formatter: {value in String(format: "%.f", value)},
                    widthFraction: 0.4
                )
                }
               Spacer(minLength: 300)
                
               
                
                Text("Progress")
                    .font((Font.custom("DelaGothicOne-Regular", size: 36)))
                HStack{
                PieChartView(
                    values: [Double((db.lastTrainingIndex)), Double(db.trainingPlan.count)],
                    names: ["done"," remaining "],
                    formatter: {value in String(format: "%.f", value)},
                    widthFraction: 0.4
                    
                )
                }
               
            }
            .padding()
            
        }
        
    }

}
struct Stats_Previews: PreviewProvider {
    static var previews: some View {
        Stats()
    }
}
