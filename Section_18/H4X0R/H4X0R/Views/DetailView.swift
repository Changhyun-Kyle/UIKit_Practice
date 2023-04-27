//
//  DetailView.swift
//  H4X0R
//
//  Created by 강창현 on 2023/04/27.
//

import SwiftUI

struct DetailView: View {
    
    let url: String? 
    
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "www.google.com")
    }
}
