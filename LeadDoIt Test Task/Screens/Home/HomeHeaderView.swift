//
//  HomeHeaderView.swift
//  LeadDoIt Test Task
//
//  Created by MacBook on 27.06.2024.
//

import SwiftUI

struct HomeHeaderView: View {
    private var plusButtonSide: CGFloat = 38

    var body: some View {
        ZStack {
            Color.accentOne
                .ignoresSafeArea()

            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("MARS.CAMERA")
                            .font(Font.CustomFonts.largeTitle)

                        Text(getCurrentDateAsString())
                            .font(Font.CustomFonts.bodyTwo)
                    }

                    Spacer()

                    Image.calendar
                }

                HStack(spacing: 23) {
                    HStack(spacing: 12) {
                        FilterButton(image: Image.rover)

                        FilterButton(image: Image.camera)
                    }

                    Button {

                    } label: {
                        Image.addCircle
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.backgroundOne)
                                    .frame(width: plusButtonSide, height: plusButtonSide)
                            }
                    }
                }
            }
            .padding([.leading, .trailing], 20)
        }
        .foregroundStyle(Color.layerOne)
    }

    private func getCurrentDateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.dateFormat = "dd MMMM, y"
        return formatter.string(from: Date())
    }

}

#Preview {
    HomeHeaderView()
}

struct FilterButton: View {
    let image: Image

    var body: some View {
        Button {
            
        } label: {
            HStack(spacing: 6) {
                image

                Text("All")
                    .font(Font.CustomFonts.bodyTwo)
                
                Spacer()
            }
            .padding(7)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.backgroundOne)
            }
        }
    }
}
