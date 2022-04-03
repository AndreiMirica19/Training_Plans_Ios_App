//
//  MainView.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 03.04.2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            MainContentView()
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
