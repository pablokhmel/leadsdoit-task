import SwiftUI

struct UnevenRoundedRectangle: Shape {
    var topLeadingRadius: CGFloat
    var topTrailingRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY + topLeadingRadius))
        path.addArc(center: CGPoint(x: rect.minX + topLeadingRadius, y: rect.minY + topLeadingRadius), radius: topLeadingRadius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX - topTrailingRadius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - topTrailingRadius, y: rect.minY + topTrailingRadius), radius: topTrailingRadius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}
