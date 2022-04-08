//
//  MainView.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 03.04.2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var db:ViewModel
    var body: some View {
        TabView{
            MainContentView()
                .environmentObject(db)
                .tabItem{
                    Image(systemName:"doc.plaintext")
                    Text("Today's session")
                        .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                        
                    .bold()
                }
            Calendar()
                .tabItem{
                    Image(systemName:"calendar")
                    Text("Calendar")
                        .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                    .bold()
                }
            
            Stats()
                .tabItem{
                    Image(systemName:"chart.pie")
                    Text("Statistics")
                        .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                    .bold()
                }
        }
      
        
        
    }
    
   
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
