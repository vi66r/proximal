import SwiftUI

struct Glass {
    @ViewBuilder
    static func normal() -> some View {
        TransparentBlurView(removeAllFilters: true)
    }
    
    @ViewBuilder
    static func diffused() -> some View {
        TransparentBlurView(removeAllFilters: true)
            .blur(radius: 9, opaque: true)
            .background(.white.opacity(0.05))
    }
    
    @ViewBuilder
    static func frosted() -> some View {
        TransparentBlurView(removeAllFilters: true)
            .blur(radius: 15, opaque: true)
            .background(.white.opacity(0.25))
    }
    
    @ViewBuilder
    static func gaussed() -> some View {
        TransparentBlurView(removeAllFilters: true)
            .blur(radius: 30, opaque: true)
    }
}

struct TransparentBlurView: UIViewRepresentable {
    var removeAllFilters: Bool = false
    func makeUIView(context: Context) -> TransparentBlurViewHelper {
        return TransparentBlurViewHelper(removeAllFilters: removeAllFilters)
    }
    
    // disable behavior
    func updateUIView(_ uiView: TransparentBlurViewHelper, context: Context) { }
}


class TransparentBlurViewHelper: UIVisualEffectView {
    init(removeAllFilters: Bool) {
        super.init(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        if subviews.indices.contains(1) {
            subviews[1].alpha = 0
        }
        
        if let backdropLayer = layer.sublayers?.first {
            if removeAllFilters {
                backdropLayer.filters = []
            } else {
                backdropLayer.filters?.removeAll(where: { filter in
                    String(describing: filter) != "gaussianBlur"
                })
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // disable trait collection chages
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) { }
}

struct FlutedGlassView: View {
    var columns = 20
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<columns, id: \.self) { _ in
                Glass.gaussed()
                    .mask {
                        LinearGradient(
                            colors: [
                                .black.opacity(0.9),
                                .black.opacity(0.5),
                                .black.opacity(0.9),
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    }
                    .background(Glass.normal())
            }
        }
    }
}
