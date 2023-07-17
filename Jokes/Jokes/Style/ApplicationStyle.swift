import Foundation
import UIKit

class ApplicationStyle {
    static let shared = ApplicationStyle()
    
    private init() {
        
    }
    
    struct colors {        
        static func transparent() -> UIColor { UIColor.clear }
        static func white() -> UIColor { UIColor(hex: 0xFFFFFF) }
        static func black() -> UIColor { UIColor(hex: 0x000000) }
                
        static func primary() -> UIColor { UIColor(hex: 0x201D2E) }
        static func secondary() -> UIColor { UIColor(hex: 0xBC2753) }
                
        static func lightPrimary() -> UIColor { UIColor(hex: 0x6FE9ED) }
        static func lightPrimaryShade15() -> UIColor { UIColor(hex: 0x6FE9ED4D) }
                
        static func lightSecondary() -> UIColor { UIColor(hex: 0xE64E7A) }
        static func lightSecondaryShade15() -> UIColor { UIColor(hex: 0xE64E7A4D) }
                
        static func gray() -> UIColor { UIColor(hex: 0x697882) }
        static func lightGray() -> UIColor { UIColor(hex: 0xE1E8ED) }
                
        static func backgroundColor() -> UIColor { UIColor(hex: 0xFFFFFF) }
                
        static func gold() -> UIColor { UIColor(hex: 0xFFD700) }
        static func silver() -> UIColor { UIColor(hex: 0xC0C0C0) }
        static func bronze() -> UIColor { UIColor(hex: 0xCD7F32) }
                        
        static func neonDarkGreen() -> UIColor { UIColor(hex: 0x20CC00) }
        static func neonOrange() -> UIColor { UIColor(hex: 0xFBB23F) }
        static func neonPurple() -> UIColor { UIColor(hex: 0xE64E7A) }

    }
    
    struct images {
        static func navigationBarBackgroundImage() -> UIImage { UIImage(named: "navigation_bar_background_image", in: Bundle.main, compatibleWith: nil)! }
        static func userAvatarPlaceholderSmallImage() -> UIImage { UIImage(named: "user_avatar_placeholder_small_image", in: Bundle.main, compatibleWith: nil)! }
        
        static func likeSmallImage() -> UIImage { UIImage(named: "like_small_image", in: Bundle.main, compatibleWith: nil)! }
        static func dislikeSmallImage() -> UIImage { UIImage(named: "dislike_small_image", in: Bundle.main, compatibleWith: nil)! }
        
        static func wallBackgroundImage() -> UIImage { UIImage(named: "wall_background_image", in: Bundle.main, compatibleWith: nil)! }
        static func neonLogoMediumImage() -> UIImage { UIImage(named: "neon_medium_logo_image", in: Bundle.main, compatibleWith: nil)! }
        static func answerSmallImage() -> UIImage { UIImage(named: "answer_small_image", in: Bundle.main, compatibleWith: nil)! }
        static func buttonBackgroundImage() -> UIImage { UIImage(named: "button_wall_background_image", in: Bundle.main, compatibleWith: nil)! }
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
        
        public static func oblique(size: CGFloat) -> UIFont {
            return UIFont(name: names.oblique.rawValue, size: size)!
        }
        
        public enum names: String, CaseIterable {
            case regular = "Helvetica"
            case bold = "Helvetica-Bold"
            case light = "Helvetica-Light"
            case oblique = "Helvetica-Oblique"
        }
    }
}
