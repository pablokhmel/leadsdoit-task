import SwiftUI

extension Font {
    enum CustomFonts {
        static var largeTitle: Font {
            Font.system(size: 34, weight: .bold)
        }

        static var bodyTwo: Font {
            Font.system(size: 17, weight: .bold)
        }

        static var titleTwo: Font {
            Font.system(size: 22, weight: .bold)
        }

        static var title: Font {
            Font.system(size: 22, weight: .regular)
        }
    }
}
