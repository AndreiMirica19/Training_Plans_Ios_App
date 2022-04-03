//
//  MainContentView.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 03.04.2022.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        ZStack{
        VStack{
            Text("Today's session")
                .font((Font.custom("DelaGothicOne-Regular", size: 36)))
                .foregroundColor(.yellow)
            Text("Cycling")
                .font((Font.custom("DelaGothicOne-Regular", size: 36)))
                .foregroundColor(.orange)
            HStack {
                Text("Duration:")
                    .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                .bold()
                Text ("00:00")
                    .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                .bold()
            }
            Text("Description")
                .font((Font.custom("DelaGothicOne-Regular", size: 26)))
                .foregroundColor(.mint)
            .bold()
            Text("10 minutes progressive warm-up \n 20 minutes at sweet spot (90% FTP) \n 5 minutes easy (zone one) \n20 minutes at sweet spot (90% FTP) \n 5 minutes cool down")
                .font((Font.custom("DelaGothicOne-Regular", size: 20)))
                .multilineTextAlignment(.center)
                .foregroundColor(.mint)
            Button {
                //
            } label: {
                HStack{
                    Text("Done")
                        .font((Font.custom("DelaGothicOne-Regular", size: 20)))
                        .foregroundColor(.orange)
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.orange)
                }
                .padding()
                .background( RoundedRectangle(cornerRadius: 30, style: .continuous).strokeBorder(Color.white,lineWidth: 5))
            }

        }
        }
       
        .frame(minWidth:0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity,alignment: .center)
        .background(Image("trainingWallpaper").blur(radius: 45))
        .cornerRadius(50)
        .padding(.horizontal,20)
        .padding(.vertical,20)
        
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
