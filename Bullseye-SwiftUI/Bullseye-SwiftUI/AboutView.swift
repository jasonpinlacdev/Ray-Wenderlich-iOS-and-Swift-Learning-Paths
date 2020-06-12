//
//  AboutView.swift
//  Bullseye-SwiftUI
//
//  Created by Jason Pinlac on 6/12/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import SwiftUI


struct HeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.black)
            .font(.custom("Arial Rounded MT Bold", size: 30))
            .padding(.top, 20)
            .padding(.bottom, 20)
    }
}


struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.black)
            .font(.custom("Arial Rounded MT Bold", size: 16))
            .padding(.leading, 60)
            .padding(.trailing, 60)
    }
}


struct AboutView: View {
    
    var beige = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
    var body: some View {
        Group {
            VStack {
                       Text("🎯 Bullseye 🎯")
                           .modifier(HeaderStyle())
                       Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                           .modifier(TextStyle())
                       Text("Your goal is to place the slider as close as possible to the target value.")
                           .modifier(TextStyle())
                       Text("The closer you are, the more points you score.")
                           .modifier(TextStyle())
                       Text("Enjoy!")
                           .modifier(TextStyle())
                           .padding(.bottom, 20)
                   }
                   .navigationBarTitle(Text("About Bullseye"))
                   .background(beige)
                   .cornerRadius(10)
            .shadow(color: .black, radius: 5, x: 2, y: 2)
        }
        .background(Image("Background"), alignment: .center)
       
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 891, height: 414))
    }
}
