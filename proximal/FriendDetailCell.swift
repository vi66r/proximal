import SwiftUI

struct FriendDetailCell: View {
    
    @State var expanded: Bool = false
    @State var quickLiked: Bool = false
    @State var value: Double = 0.75
    
    @State private var offset: CGSize = .zero
    @State private var isDragging = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                HStack(spacing: 10) {
                    VStack {
                        Image("profile-demo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(
                                width: expanded ? 80 : 50,
                                height: expanded ? 80 : 50
                            )
                            .overlay {
                                CircularProgressView(progress: value)
                                    .frame(
                                        width: expanded ? 84 : 54,
                                        height: expanded ? 84 : 54
                                    )
                            }
                            .shadow(color: .black.opacity(0.2), radius: 2, y: 2)
                    }
                    VStack {
                        Text("Makka Pakka")
                            .frame(maxWidth: .infinity,
                                   alignment: .leading)
                            .font(.headline)
//                            .foregroundStyle(.white, .black)
                        Text("\"Makka pakka appa yakka mikka makka moo!\"")
                            .frame(maxWidth: .infinity,
                                   alignment: .leading)
                            .font(.subheadline.italic())
                            .lineLimit(expanded ? 3 : 1)
//                            .foregroundStyle(.white, .black)
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
        .background {
//            if expanded {
//                Glass.frosted()
//            } else {
//                Glass.diffused()
//            }
            Glass.diffused()
        }
        .clipShape(RoundedRectangle(
            cornerRadius: expanded ? 30.0 : 25.0,
            style: .continuous
        ))
        .overlay {
            RoundedRectangle(cornerRadius: expanded ? 30.0 : 25.0, style: .continuous)
                .stroke(.white.opacity(0.3), lineWidth: 1.5)
        }
        .shadow(color: .black.opacity(0.2), radius: 4.0, y: 4.0)
        .offset(offset)
        .gesture(
            TapGesture()
                .onEnded {
                    withAnimation(.bouncy, {
                        expanded.toggle()
                    })
                }
                .simultaneously(with: DragGesture()
                    .onChanged { value in
                        let xTranslation = value.translation.width
                        offset.width = xTranslation
                    }
                    .onEnded { _ in
                        withAnimation(.easeOut, {
                            offset = .zero
                        })
                    }
                )
        )
        .modifier(AnimatingCellHeight(height: expanded ? 200 : 80))
        
    }
}

#Preview {
    FriendDetailCell()
}
