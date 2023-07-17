import Foundation

public protocol DefaultReuseIdentifier: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension DefaultReuseIdentifier {
    public static var defaultReuseIdentifier: String {
        get {
            return String(describing: self)
        }
    }
}
