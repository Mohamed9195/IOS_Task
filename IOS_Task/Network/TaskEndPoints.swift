
import Foundation
import Moya
import RxSwift


protocol TaskEndPointsProtocol: class {
    func syncNews(apiKey: String) -> Observable<IOSTaskModel>
}

// MARK: - Provider support
final class TaskEndPoints {

    let provider = MoyaProvider<TaskEndpointSpecifications>(plugins: [CompleteUrlLoggerPlugin()])
}

//MARK:- Network  Provider Protocol extension.
extension TaskEndPoints: TaskEndPointsProtocol {
    func syncNews(apiKey: String) -> Observable<IOSTaskModel> {
        self.provider.rx
            .request(.syncNews(apiKey: apiKey))
            .filterSuccessfulStatusCodes()
            .timeout(.seconds(60), scheduler: MainScheduler.instance)
            .retry(2)
            .map(IOSTaskModel.self)
            .observeOn(MainScheduler.instance)
            .asObservable()
    }
}

class CompleteUrlLoggerPlugin : PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        print("##URL", request.request?.url?.absoluteString ?? "Something is wrong","  ##Body", request.request?.httpBody ?? "Something is wrong", "  ##header", request.request?.headers as Any)
    }
}


