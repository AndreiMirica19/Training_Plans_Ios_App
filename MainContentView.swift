//
//  MainContentView.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 03.04.2022.
//

import SwiftUI

struct MainContentView: View {
    @AppStorage("currentUserIndex") var index:Int = -1
    @EnvironmentObject var db:ViewModel
    var body: some View {
        ZStack{
        VStack{
            Text("Today's session")
                .font((Font.custom("DelaGothicOne-Regular", size: 36)))
                .foregroundColor(Color("MainCycling"))
            Text((db.trainingPlan[db.users[index].lastWorkoutIndex].name))
                .font((Font.custom("DelaGothicOne-Regular", size: 36)))
                .foregroundColor(Color("SecondaryCycling"))
            HStack {
                Text("Duration")
                    .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                .bold()
                .foregroundColor(Color("MainCycling"))
                Text (db.trainingPlan[db.users[index].lastWorkoutIndex].duration)
                    .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                .bold()
                .foregroundColor(Color("MainCycling"))
            }
            Text("Description")
                .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                .foregroundColor(Color("SecondaryCycling"))
            .bold()
            Text((db.trainingPlan[db.users[index].lastWorkoutIndex].description))
                .font((Font.custom("DelaGothicOne-Regular", size: 20)))
                .multilineTextAlignment(.center)
                .foregroundColor(Color("SecondaryCycling"))
            Button {
                //
            } label: {
                HStack{
                    Text("Done")
                        .font((Font.custom("DelaGothicOne-Regular", size: 20)))
                        .foregroundColor(Color("SecondaryCycling"))
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(Color("SecondaryCycling"))
                }
                .padding()
                .background( RoundedRectangle(cornerRadius: 30, style: .continuous).strokeBorder(Color("MainCycling"),lineWidth: 5))
            }

        }
        }
       
        .frame(minWidth:0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity,alignment: .center)
        .background(
            Image("CyclingWallpaper")
                .resizable()
                            .scaledToFill()
                            .frame()
                
        )
        .cornerRadius(50)
        .padding(.horizontal,20)
        .padding(.vertical,20)
        
    }
    
}

struct MainContentView_Previews: PreviewProvider {
    @ObservedObject static var model:ViewModel = ViewModel()
    static var previews: some View {
        MainContentView()
    }
}
