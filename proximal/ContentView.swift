//
//  ContentView.swift
//  proximal
//
//  Created by Rafi Rizwan on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            AuroraView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            VStack {
                FriendDetailCell()
            }
            .padding()
        }
    }
}

let whiteToBlueGradient = LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0), location: 0.0), Gradient.Stop(color: Color(hue: 0.5269819512424699, saturation: 0.3252129612198795, brightness: 1.0, opacity: 1.0), location: 0.8011643629807692)]), startPoint: UnitPoint.top, endPoint: UnitPoint.bottom)

let blueToWhiteGradient = LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.5269819512424699, saturation: 0.3252129612198795, brightness: 1.0, opacity: 1.0), location: 0.0), Gradient.Stop(color: Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0), location: 0.7877403846153846)]), startPoint: UnitPoint.top, endPoint: UnitPoint.bottom)

let grayToWhiteGradient = LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.5269819512424699, saturation: 0.0, brightness: 0.7601568382906627, opacity: 1.0), location: 0.0), Gradient.Stop(color: Color(hue: 0.0, saturation: 0.0, brightness: 1.0, opacity: 1.0), location: 0.4774188701923077)]), startPoint: UnitPoint.top, endPoint: UnitPoint.bottom)

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color(hue: 0.5269819512424699, saturation: 0.3252129612198795, brightness: 1.0, opacity: 1.0),
                    lineWidth: 4
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color(red: 112/255, green: 195/255, blue: 255/55),
                    style: StrokeStyle(
                        lineWidth: 4,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)

        }
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

struct ReactionButton: View {
    
    enum Reaction: CaseIterable {
        case sendLove
        case thinkingOfYou
        case flowers
        case hug
        case concerned
        case callMe
        
        var image: String {
            switch self {
            case .sendLove:
                return "heart"
            case .thinkingOfYou:
                return "bubbles.and.sparkles"
            case .flowers:
                return "camera.macro.circle"
            case .hug:
                return "figure"
            case .concerned:
                return "flag"
            case .callMe:
                return "phone.badge.waveform"
            }
        }
        
        var filled: String {
                switch self {
                case .sendLove:
                    return "heart.fill"
                case .thinkingOfYou:
                    return "bubbles.and.sparkles.fill"
                case .flowers:
                    return "camera.macro.circle.fill"
                case .hug:
                    return "figure.2"
                case .concerned:
                    return "flag.fill"
                case .callMe:
                    return "phone.badge.waveform.fill"
                }
        }
        
        var urgent: Bool {
            switch self {
            case .concerned, .callMe:
                return true
            default:
                return false
            }
        }
        
        func symbol(_ alt: Bool = false) -> some View {
            Image(systemName: alt ? filled : image)
                .font(alt ? .headline.weight(.heavy) : .body.weight(.semibold))
        }
    }
    
    var reaction: Reaction
    @State var tapped: Bool = false
    
    var body: some View {
        Button(action: {
            withAnimation(.bouncy) {
                tapped = !tapped
            }
        }, label: {
            reaction.symbol(tapped)
                .symbolEffect(.bounce, value: tapped)
                .scaleEffect(tapped ? 1.25 : 1.0)
                .if(reaction.urgent, transform: { $0.rotationEffect(.degrees(tapped ? 360 : 0)) })
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .background(whiteToBlueGradient)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(blueToWhiteGradient, lineWidth: 2.0)
                }
                .shadow(color: .black.opacity(0.2), radius: 2, y: 2)
            
        })
    }
    
    static func fullset() -> some View {
        ForEach(ReactionButton.Reaction.allCases, id: \.self) { reaction in
            ReactionButton(reaction: reaction)
        }
    }
}

struct FriendDetailCell: View {
    
    @State var expanded: Bool = false
    @State var quickLiked: Bool = false
    @State var value: Double = 0.75
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                HStack {
                    VStack {
                        ZStack {
                            CircularProgressView(progress: value)
                                .frame(
                                    width: expanded ? 84 : 54,
                                    height: expanded ? 84 : 54
                                )
                            Image("profile-demo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(
                                    width: expanded ? 80 : 50,
                                    height: expanded ? 80 : 50
                                )
                        }
                    }
                    VStack {
                        Text("Renaise Kim")
                            .frame(maxWidth: .infinity,
                                   alignment: .leading)
                            .font(.headline)
                        Text("\"Got some banana bread at work today dude! Hell yea!\"")
                            .frame(maxWidth: .infinity,
                                   alignment: .leading)
                            .font(.subheadline.italic())
                            .lineLimit(expanded ? 3 : 1)
                    }
                    VStack {
                        Button(action: {
                            withAnimation(.bouncy) {
                                quickLiked = !quickLiked
                            }
                        }, label: {
                            Image(
                                systemName: quickLiked ? "hands.clap.fill" : "hands.clap"
                            )
                            .font(quickLiked ? .headline.weight(.heavy) : .body.weight(.semibold))
                            .symbolEffect(.bounce, value: quickLiked)
                            .scaleEffect(quickLiked ? 1.25 : 1.0)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                            .background(whiteToBlueGradient)
                            .clipShape(Circle())
                            .overlay {
                                Circle().stroke(blueToWhiteGradient, lineWidth: 2.0)
                            }
                            .shadow(color: .black.opacity(0.2), radius: 2, y: 2)
                            
                        })
                    }
                }
                .padding(.horizontal, 15)
                expanded ?
                HStack {
                    ReactionButton.fullset()
                } : nil
            }
            .frame(height: expanded ? 200 : 80)
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(
            cornerRadius: 25.0,
            style: .continuous
        ))
        .shadow(color: .black.opacity(0.2), radius: 4.0, y: 4.0)
        .onTapGesture(perform: {
            withAnimation(.bouncy, {
                expanded = !expanded
            })
        })
        
    }
}

#Preview {
    ContentView()
}
