import Foundation

class JSONFileOperation<T>: AsynchronousOperation where T: Decodable {
    private var extensionType: String = "json"
    
    var model: Any?
    var completionHandler: ((Result<T, OperationError>) -> Void)
    
    init(model: Any? = nil, completionHandler: @escaping ((Result<T, OperationError>) -> Void)) {
        self.model = model
        self.completionHandler = completionHandler
        super.init()
    }
    
    open func fileName() -> String? {
        return nil
    }
    
    override func main() {
        DispatchQueue.global().async {
            guard let fileName = self.fileName() else {
                return self.noDataAvailableErrorBlock()
            }
            guard let url = Bundle.main.url(forResource: fileName, withExtension: self.extensionType) else {
                return self.noDataAvailableErrorBlock()
            }
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                self.successfulResultBlock(value: result)
            } catch {
                self.cannotParseResponseErrorBlock()
            }
        }
    }
    
    // MARK: - Successful result
    
    func successfulResultBlock(value: T) {
        self.completionHandler(Result.success(value))
        self.completeOperation()
    }
    
    // MARK: - Operation errors
    
    func noDataAvailableErrorBlock() {
        self.completionHandler(Result.failure(OperationError.noDataAvailable))
        self.completeOperation()
    }
    
    func cannotParseResponseErrorBlock() {
        self.completionHandler(Result.failure(OperationError.cannotParseResponse))
        self.completeOperation()
    }
}
