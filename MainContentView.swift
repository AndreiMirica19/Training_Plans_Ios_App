//
//  MainContentView.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 03.04.2022.
//

import SwiftUI

struct MainContentView: View {
    @AppStorage("currentUserIndex") var index:Int = -1
    @EnvironmentObject  var db:ViewModel
    @State var title = "Today's session"
    @State var duration = "Duration"
    @State var description = "Description"
    @State var durationInput = ""
    @State var descriptionInput = ""
    @State var nameInput = ""
    @State var bkgImg = "CyclingWallpaper"
    @State var btnDisabled = false
    @State var isTrainingDay = false
    @State var trainingSessionAlreadyDone = false
    var body: some View {
        
        ZStack{
        if isTrainingDay{
        VStack{
            Text(title)
                .font((Font.custom("DelaGothicOne-Regular", size: 36)))
                .foregroundColor(Color("MainCycling"))
            Text(nameInput)
                .font((Font.custom("DelaGothicOne-Regular", size: 36)))
                .foregroundColor(Color("SecondaryCycling"))
            HStack {
                Text(duration)
                    .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                .bold()
                .foregroundColor(Color("MainCycling"))
                Text (durationInput)
                    .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                .bold()
                .foregroundColor(Color("MainCycling"))
            }
            Text(description)
                .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                .foregroundColor(Color("SecondaryCycling"))
            .bold()
            Text(descriptionInput)
                .font((Font.custom("DelaGothicOne-Regular", size: 20)))
                .multilineTextAlignment(.center)
                .foregroundColor(Color("SecondaryCycling"))
            if isTrainingDay && !trainingSessionAlreadyDone{
            Button {
                
                db.updateLastWorkout()
                title = ""
                description = ""
                duration = ""
                nameInput = ""
                durationInput = ""
                descriptionInput = ""
                bkgImg = "Sleep"
                btnDisabled = true
                trainingSessionAlreadyDone = true
                
                
            
                    
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
            .disabled(btnDisabled)
            }
        }
        }
        }
       
        .frame(minWidth:0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity,alignment: .center)
        .background(
            Image(bkgImg)
                .resizable()
                            .scaledToFill()
                            .frame()
                
        )
        .cornerRadius(50)
        .padding(.horizontal,20)
        .padding(.vertical,20)
        .onAppear {
           
           
            isTrainingDay = db.isTrainingDay()
            
            trainingSessionAlreadyDone = db.trainingSessionAlreadyDone()
            
            if !isTrainingDay||trainingSessionAlreadyDone{
                bkgImg = "Sleep"
                title = ""
                description = ""
                duration = ""
                nameInput = ""
                durationInput = ""
                descriptionInput = ""
            }
            else
                if bkgImg != "Sleep"
            {
                durationInput = db.trainingPlan[db.trainingIndex].duration
                descriptionInput = (db.trainingPlan[db.trainingIndex].description)
                nameInput = (db.trainingPlan[db.trainingIndex].name)
            }
            
        }
    }
 
    
}

struct MainContentView_Previews: PreviewProvider {
    @ObservedObject static var model:ViewModel = ViewModel()
    static var previews: some View {
        MainContentView()
    }
}
