import SwiftUI

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
    @State var startAnimation: CGFloat = 0
    var progress: Double {
        tapped ? 1.0 : 0.0
    }
    
    var body: some View {
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
            .shadow(color: .black.opacity( tapped ? 0.4 : 0.2), radius: 2, y: tapped ? 0 : 2)
            .onTapGesture {
                withAnimation(.bouncy) {
                    tapped = !tapped
                }
            }
    }
    
    static func fullset() -> some View {
        ForEach(ReactionButton.Reaction.allCases, id: \.self) { reaction in
            ReactionButton(reaction: reaction)
        }
    }
}

