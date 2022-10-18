//
//  RollingText.swift
//  RollingCounter
//
//  Created by Dong on 2022/10/17.
//

// 偏移量沒致中

import SwiftUI

struct RollingText: View {
    
    var font: Font = .largeTitle
    var weight: Font.Weight = .regular
    @Binding var value: Int
    
    @State var animationRange: [Int] = []
    
    var body: some View {
        HStack(spacing: 0){
            ForEach(0..<animationRange.count ,id: \.self) { index in
                // MARK: To Find Text Size for Given Font
                // Random Number
                
                Text("7")
                    .font(font)
                    .fontWeight(weight)
                    .opacity(0)
                    .padding(.horizontal ,2)
                    .overlay{
                        GeometryReader{ proxy in
                            let size = proxy.size
                            
                            VStack(spacing: 0){
                                ForEach(0...9 ,id: \.self) { number in
                                    Text("\(number)")
                                        .font(font)
                                        .fontWeight(weight)
                                        
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                        
                                }
                            }
                           
                            .offset(y: -CGFloat(animationRange[index]) * size.height)
                          
                        }
                        .clipped()
                    }
            }
        }
        .onAppear{
            animationRange = Array(repeating: 0, count: "\(value)".count)
//            updateText()
            // Starting with little Delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.06){
                updateText()
            }
        }
        .onChange(of: value) { newValue in
            // MARK: Handling Addtion/Removal to Extra Value
            let extra = "\(value)".count - animationRange.count
            if extra > 0{
                // add
                for _ in 0..<extra{
                    withAnimation(.easeIn(duration: 0.1)){ animationRange.append(0) }
                }
            } else {
                // remove
                for _ in 0..<(-extra){
                    withAnimation(.easeIn(duration: 0.1)){ animationRange.removeLast() }
                }
            
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                updateText()
            }
        }
        .overlay {
            Text(animationRange.first != .none ? "\(animationRange[0])" : "")
                .offset(y: -100)
        }
    }
    
    func updateText(){
        let staringValue = "\(value)"
        
        // 利用 zip 結合 tuple
        for (index ,value) in zip(0..<staringValue.count ,staringValue){
            // if first value = 1
            // Then Offset will be applied for - 1
            // so the text will move up to show - 1 value
            
            // MARK: 阻尼係數 根據 value 而不同
            var fraction = Double(index) * 0.15
            // 最大0.5 總和最大 1.5
            fraction = (fraction > 0.5 ? 0.5 : fraction)
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 1 + fraction, blendDuration: 1 + fraction)){
                animationRange[index] = (String(value) as NSString).integerValue
            }
        }
    }
}

struct RollingText_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
