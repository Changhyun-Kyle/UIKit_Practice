//
//  ContentView.swift
//  Dicee
//
//  Created by 강창현 on 2023/03/30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var leftDiceNumber: Int = 1
    @State private var rightDiceNumber: Int = 1
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                Image("diceeLogo")
                Spacer()
                HStack {
                    DiceView(n: leftDiceNumber)
                    DiceView(n: rightDiceNumber)
                }
                Spacer()
                Button {
                    leftDiceNumber = Int.random(in: 1...6)
                    rightDiceNumber = Int.random(in: 1...6)
                } label: {
                    Text("Roll")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                .background(.red)
                Spacer()
            }
        }
    }
}

// MARK: - DiceView
struct DiceView: View {
    
    let n: Int
    
    var body: some View {
        Image("dice\(n)")
            .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
