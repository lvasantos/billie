//
//  SplashScreenView.swift
//  billie
//
//  Created by Pedro Muniz on 14/09/22.
//

import SwiftUI

struct SplashScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var recognizedContent = RecognizedContent()
    @State var showScanner = false
    @State private var isRecognized: Bool? = false
    @State var isEndedFirst: Bool = false
    @State var isEndedLast: Bool = false
    @State private var showingHelpAlert = false
    
    var body: some View {
        NavigationView{
            VStack (alignment: .center) {
                // MARK: This pushes the button  out of screen when using landscape mode. caused by height constant
                //  something happened and now the background won't follow the landscape mode anymore. Cries in WTF.
               
                ZStack(){ //embed here so a 2nd animation can come on top of the 1st
                    LottieView(isEnded: $isEndedFirst, filename: "moneyNewVersion")
                        .shadow(color: .indigo, radius: 2, x: 1, y: 2)

                    LottieView(isEnded: $isEndedLast, filename: colorScheme == .dark ? "billieLightMode" : "billieFinalAppearing")
                        .shadow(color: .indigo, radius: 2, x: 1, y: 2)
                }
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.midY)
                .ignoresSafeArea(.all)
                
                Button (action: {
                    showScanner = true

                    let impactGen = UIImpactFeedbackGenerator(style: .medium)
                    impactGen.impactOccurred()
                    
                }){
                    HStack{
                        Image(systemName: "doc.text.viewfinder")
                        Text("Escanear conta")
                            .fontWeight(.semibold)
                            .font(Font.title3)
                    }
                    .foregroundColor( colorScheme == .dark ? .blue: .white)
                    .padding(.all, 12)
                    .padding([.leading,.trailing])
                    
                    .opacity(isEndedLast ? 1
                             : 0).animation(.easeInOut(duration: 1), value: isEndedLast)
                    .background(colorScheme == .dark ? .white : .teal
                    ).opacity(isEndedLast ? 1 : 0).animation(.easeOut(duration: 1), value: isEndedLast)
                        
                }
                .buttonStyle(GrowingButton()).animation(.easeOut(duration: 1), value: isEndedLast)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colorScheme == .light ?
                        LinearGradient(gradient: Gradient(colors: [.cyan, .clear]), startPoint: .topLeading, endPoint: .bottomTrailing):
                            LinearGradient(gradient: Gradient(colors: [.blue, .clear]), startPoint: .top, endPoint: .bottom))
        }
        .sheet(isPresented: $showScanner, content: {
            ScannerView { result in
                switch result {
                case .success(let scannedImages):
                    
                    TextRecognition(scannedImages: scannedImages,
                                    recognizedContent: recognizedContent) {
                        // Text recognition is finished, hide the progress indicator.
                        isRecognized = true
                        print("RESULTADO:")
                        print(recognizedContent.items[0].text)
                        print("REGEX:")
                        let match = recognizedContent.items[0].text.matches(of: RegexNF.reg)
                        for matches in match {
                            let (_, codigo, produto, quantidade, valor, total) = matches.output
                            print(codigo)
                            print(produto)
                            print(quantidade)
                            print(valor)
                            print(total)
                        }
                    }.recognizeText()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                showScanner = false
                
            } didCancelScanning: {
                // Dismiss the scanner controller and the sheet.
                showScanner = false
                
                let cancelHap = UIImpactFeedbackGenerator(style: .rigid)
                cancelHap.impactOccurred()
            }
        })
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        
        SplashScreenView()
    }
}
