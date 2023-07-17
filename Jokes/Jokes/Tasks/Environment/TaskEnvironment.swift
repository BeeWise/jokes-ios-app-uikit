import Foundation

enum TaskEnvironment: String {
    case production = "production"
    case development = "development"
    case memory = "memory"
    
    static func from(value: String) -> TaskEnvironment {
        return TaskEnvironment(rawValue: value) ?? .memory
    }
}
