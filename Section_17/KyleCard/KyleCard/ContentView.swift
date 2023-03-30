//
//  ContentView.swift
//  KyleCard
//
//  Created by 강창현 on 2023/03/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.44, green: 0.62, blue: 0.80)
                .ignoresSafeArea(.all)
            
            VStack {
                Image("kyle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 5)
                    }
                Text("Kyle")
                    .font(.custom("ShantellSans-Regular", size: 40))
                    .foregroundColor(.white)
                    .fontWeight(.bold )
                Text("iOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                Divider()
                InfoView(text: "010-3022-8276", imageName: "phone.fill")
                InfoView(text: "changhyun.kyle@gamil.com", imageName: "envelope.fill")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
