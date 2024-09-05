import Foundation

enum Font {
    case nunitoSans(FontWeight)
  
    var font: String {
        switch self {
        case .nunitoSans(.regular): "NunitoSans10pt-Regular"
        case .nunitoSans(.semiBold): "NunitoSans10pt-SemiBold.ttf"
        }
        
    }
}
