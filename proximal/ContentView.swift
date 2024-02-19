//
//  ContentView.swift
//  proximal
//
//  Created by Rafi Rizwan on 1/30/24.
//

import SwiftUI

struct AnimatingCellHeight: AnimatableModifier {
    var height: CGFloat = 0

    var animatableData: CGFloat {
        get { height }
        set { height = newValue }
    }

    func body(content: Content) -> some View {
        content.frame(height: height)
    }
}

func randomDecimal() -> Double {
    Double.random(in: 0.0 ..< 1.0)
}

struct ContentView: View {
    var body: some View {
        ZStack {
            AuroraView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            Circle()
                .fill(
                    .linearGradient(colors: [
                        .blue,
                        .white
                    ], startPoint: .top, endPoint: .bottom)
                )
                .frame(width: 140, height: 140)
            
            // Using List
            
//            List {
//                ForEach((0..<606), id: \.self) { _ in
//                    FriendDetailCell()
//                        .listRowBackground(Color.clear)
//                        .listRowSeparator(.hidden)
//                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//                        .padding(.horizontal)
//                }
//            }
//            .scrollContentBackground(.hidden)
//            .background(.clear)
//            .listStyle(.plain)
            
            // Using LazyVStack inside of ScrollView - performance is the same LMAO
            
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach((0..<6), id: \.self) { _ in
                        FriendDetailCell(value: randomDecimal())
                    }
                }
                .padding()
            }
            
//            FriendDetailCell()
//                .padding()
        }
    }
}

extension Color {
  //Solid color
  static let aquaRed = Color(red: 0.9, green: 0.15, blue: 0.15)
  static let aquaYellow = Color(red: 0.9, green: 0.6, blue: 0)
  static let aquaGreen = Color(red: 0.5, green: 0.7, blue: 0.2)
  static let aquaBlue = Color(red: 0, green: 0.6, blue: 1)
  
  //Solid grayscale
  static let aquaGray = Color(white: 0.7)
  static let aquaLightGray = Color(white: 0.9)
  static let aquaCircularButtonHighlight = Color(white: 0.2)
  static let aquaBehindCircularButtonHighlight = Color(white: 0.8)
  static let aquaSegmentedControlOutlineStroke = Color(white: 0.4)
  
  //Transaprent grayscale
  static let aquaCircularButtonLowlight = Color(white: 0.4, opacity: 1)
  static let aquaTransparentWhite = Color(white: 1, opacity: 0.1)
  static let aquaTranslucentWhite = Color(white: 1, opacity: 0.5)
  static let aquaBrushedMetalStroke = Color(white: 0.65, opacity: 0.5)

}

let whiteToBlueGradient = LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0), location: 0.0), Gradient.Stop(color: Color(hue: 0.5269819512424699, saturation: 0.3252129612198795, brightness: 1.0, opacity: 1.0), location: 0.8011643629807692)]), startPoint: UnitPoint.top, endPoint: UnitPoint.bottom)

let blueToWhiteGradient = LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.5269819512424699, saturation: 0.3252129612198795, brightness: 1.0, opacity: 1.0), location: 0.0), Gradient.Stop(color: Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0), location: 0.7877403846153846)]), startPoint: UnitPoint.top, endPoint: UnitPoint.bottom)

let grayToWhiteGradient = LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.5269819512424699, saturation: 0.0, brightness: 0.7601568382906627, opacity: 1.0), location: 0.0), Gradient.Stop(color: Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0), location: 0.4774188701923077)]), startPoint: UnitPoint.top, endPoint: UnitPoint.bottom)



struct AquaHighAndLowlightView<T: Shape>: View {
  let shape: T
  let colors: [Color]
  var linearGradient: LinearGradient {
    LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
  }
  
  var body: some View {
    shape
      .stroke(linearGradient, lineWidth: 2.5)
  }
}


extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#Preview {
    ContentView()
}
