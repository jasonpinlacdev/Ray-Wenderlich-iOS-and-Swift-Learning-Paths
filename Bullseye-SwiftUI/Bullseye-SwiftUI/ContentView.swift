//
//  ContentView.swift
//  Bullseye-SwiftUI
//
//  Created by Jason Pinlac on 6/12/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content.shadow(color: .black, radius: 5, x: 2, y: 2)
        }
    }


    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(.custom("Arial Rounded MT Bold", size: 18))
                .modifier(ShadowStyle())
        }
    }


    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(.custom("Arial Rounded MT Bold", size: 24))
                .modifier(ShadowStyle())
        }
    }

    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(.black)
        }
    }


    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(.custom("Arial Rounded MT Bold", size: 12))
                .foregroundColor(.black)
        }
    }
    
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var targetValue = Int.random(in: 1...100)
    @State var totalScore = 0
    @State var round = 1
    
    let midnightBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
    
    
    var body: some View {
        
        VStack {
            Spacer()
            
            
            // target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                Text("\(targetValue)").modifier(ValueStyle())
            }
            Spacer()
            
            
            // slider row
            HStack {
                Text("1")
                    .modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100)
                    .accentColor(Color.green)
                Text("100")
                    .modifier(LabelStyle())
            }
            Spacer()
            
            
            // button row
            HStack {
                Button(action: {
                    self.alertIsVisible = true
                }) {
                    Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/)
                        .modifier(ButtonLargeTextStyle())
                }.alert(isPresented: $alertIsVisible) { () -> Alert in
                    let points = pointsForCurrentRound()
                    return Alert(title: Text(self.alertTitle()), message: Text("The slider's value is \(sliderValueRounded()).\nYou Scored \(points) points this round."), dismissButton: .default(Text("Okay"), action: {
                        self.totalScore += points
                        self.round += 1
                        
                        self.targetValue = Int.random(in: 1...100)
                        self.sliderValue = 50.0
                    }))
                }
                .background(Image("Button").modifier(ShadowStyle()), alignment: .center)
            }
            Spacer()
            
            
            // score row
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start Over")
                            .modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button").modifier(ShadowStyle()), alignment: .center)
                
                Spacer()
                
                Text("Score:")
                    .modifier(LabelStyle())
                Text("\(totalScore)")
                    .modifier(ValueStyle())
                
                Spacer()
                
                Text("Round:")
                    .modifier(LabelStyle())
                Text("\(round)")
                    .modifier(ValueStyle())
                
                Spacer()
                
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                            .modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button").modifier(ShadowStyle()), alignment: .center)
            }
            .padding(.bottom, 30.0)
            
            
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle(Text("Bullseye"))
    }
    
    
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    
    func pointsForCurrentRound() -> Int {
        let maximumPoints = 100
        let points = maximumPoints - abs(targetValue - sliderValueRounded())
        
        var bonusPoints = 0
        switch points {
        case 100:
            bonusPoints = 100
        case 99:
            bonusPoints = 50
        default:
            break
        }
        
        return points + bonusPoints
    }
    
    
    func alertTitle() -> String {
        switch pointsForCurrentRound() {
        case 200:
            return "Bullseye!"
        case 97..<150:
            return "So close!"
        case 90..<97:
            return "Not Bad."
        default:
            return "Not Even Close."
        }
    }
    
    
    func startNewGame() {
        alertIsVisible = false
        sliderValue = 50.0
        targetValue = Int.random(in: 1...100)
        totalScore = 0
        round = 1
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}



