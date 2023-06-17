//
//  ContentView.swift
//  AlamofireSSEExample
//
//  Created by isaced on 2023/6/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                NetworkService.request()
            } label: {
                Text("Request")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
