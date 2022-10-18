//
//  ContentView.swift
//  RollingCounter
//
//  Created by Dong on 2022/10/17.
//

import SwiftUI

struct ContentView: View {
    
    @State var value: Int = 0
    
    var body: some View {
//        NavigationView {
            VStack(spacing: 25){
                RollingText(font: .system(size: 55), weight: .black, value: $value)
                    .padding()
                
                Button {
                    value = .random(in: 1200...1300)
                } label: {
                    Text("換一個數字")
                }

            }
            .padding(15)
            .navigationTitle("Rolling Counter")
            .ignoresSafeArea()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
