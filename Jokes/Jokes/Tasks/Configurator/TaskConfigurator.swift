import Foundation

class TaskConfigurator {
    static let shared = TaskConfigurator()
    
    var environment: TaskEnvironment = .memory
    
    init() {
        
    }
    
    func jokesTask() -> JokesTaskProtocol {
        return JokesTask(environment: self.environment)
    }
    
    func imageTask() -> ImageTaskProtocol {
        return ImageTask(environment: self.environment)
    }
}
