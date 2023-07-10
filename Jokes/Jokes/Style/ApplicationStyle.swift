import Foundation
import UIKit

class ApplicationStyle {
    static let shared = ApplicationStyle()
    
    private init() {
        
    }
    
    struct colors {
        static func primary() -> UIColor { UIColor(named: "primary", in: Bundle.main, compatibleWith: nil)! }
        static func secondary() -> UIColor { UIColor(named: "secondary", in: Bundle.main, compatibleWith: nil)! }
        static func transparent() -> UIColor { UIColor.clear }
        static func white() -> UIColor { UIColor.white }
    }
    
    struct images {
        static func icon() -> UIImage { UIImage(named: "icon", in: Bundle.main, compatibleWith: nil)! }
    }
    
    struct fonts {
        public static func regular(size: CGFloat) -> UIFont {
            return UIFont(name: names.regular.rawValue, size: size)!
        }

        public static func bold(size: CGFloat) -> UIFont {
            return UIFont(name: names.bold.rawValue, size: size)!
        }

        public static func light(size: CGFloat) -> UIFont {
            return UIFont(name: names.light.rawValue, size: size)!
        }
        
        public enum names: String, CaseIterable {
            case regular = "Helvetica"
            case bold = "Helvetica-Bold"
            case light = "Helvetica-Light"
        }
    }
}
