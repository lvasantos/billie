//
//  SliderButton.swift
//  billie
//
//  Created by Otávio Albuquerque on 14/09/22.
//

import SwiftUI
import CoreHaptics

struct SliderButton: View {
    
    @State var engine: CHHapticEngine?
    @State var translation = CGSize.zero.width
    @State var success = false
    
    let screen = UIScreen.main.bounds
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Color.gray.opacity(0.7)
                .frame(width: screen.width, height: 80)
                .mask {
                    RoundedRectangle(cornerRadius: 80, style: .circular)
                }
                
                SwipeButton(translation: $translation, sucess: $success)
                    .animation(.spring(),value: self.translation)
                    .gesture(DragGesture().onChanged({ value in
                        if(value.translation.width < 0){
                            self.translation = CGSize.zero.width
                            self.success = false
                        }else {
                            if(value.translation.width > 250) {
                                self.translation = screen.width - 100
                                self.success = true
                            }else{
                                self.translation = value.translation.width
                            }
                        }
                        
                    })
                        .onEnded({ value in
                            if(value.translation.width < 200) {
                                self.translation = CGSize.zero.width
                                self.success = false
                            }else{
                                self.translation = screen.width - 100
                                self.success = true
                            }
                            
                        })
                    )
                    
            }
        }
        
    }
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        }catch {
            print(error)
        }
    }
//    func complexSucess() {
//        guard
//    }
}

struct SwipeButton: View {
    
    @Binding var translation: CGFloat
    @Binding var sucess : Bool
    var body: some View {
        ZStack(alignment: .trailing){
            
            Color.blue.opacity(0.7)
                .frame(width: 100 + translation, height: 80)
                .mask({
                    RoundedRectangle(cornerRadius: 60, style: .circular)
                })
                .overlay(alignment: .trailing) {
                    Image(systemName: "ruler").font(.custom( "grande", size: 50))
                        .foregroundColor(.white)
                        .padding()
                        .opacity(self.sucess ? 0 : 1)

                    Image(systemName: "ruler.fill").font(.custom( "grande", size: 50))
                        .foregroundColor(.white)
                        .padding()
                        .opacity(self.sucess ? 1 : 0)
                }
                
        }
    }
}

struct SliderButton_Previews: PreviewProvider {
    static var previews: some View {
        SliderButton()
    }
}
