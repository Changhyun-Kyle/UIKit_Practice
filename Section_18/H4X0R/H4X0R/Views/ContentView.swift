//
//  ContentView.swift
//  H4X0R
//
//  Created by 강창현 on 2023/04/27.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationStack {
            List(networkManager.posts) { post in
                HStack {
                    Text("\(post.points)")
                    Text(post.title)
                }
                
            }
            .navigationTitle("H4XOR NEWS")
        }
        .onAppear {
            networkManager.fetchData()
        }
        
    }
}

/*
struct Post: Identifiable {
    let id: String
    let title: String
}

let posts = [
    Post(id: "1", title: "Hello"),
    Post(id: "2", title: "Hello"),
    Post(id: "3", title: "Hello"),
    Post(id: "4", title: "Hello")
]
*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
