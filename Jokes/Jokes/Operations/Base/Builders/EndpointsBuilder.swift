import Foundation

public final class EndpointsBuilder {
    public static let shared = EndpointsBuilder()
    
    private init() { }
    
    // MARK: - Jokes
    
    public func jokesEndpoint() -> String {
        return BundleConfiguration.string(for: BundleConfiguration.Keys.jokesEndpoint)
    }
}
