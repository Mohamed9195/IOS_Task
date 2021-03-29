

import Foundation
import Moya

// MARK: - Provider Specifications
enum TaskEndpointSpecifications {
    case syncNews(apiKey: String)
}

// MARK: - Provider release url
let releaseURL = "https://newsapi.org/v2/everything?q=tesla&from=2021-02-28&sortBy=publishedAt"

// MARK: - Provider target type
extension TaskEndpointSpecifications: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: releaseURL)!
        }
    }

    var path: String {
        switch self {
        case .syncNews:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .syncNews:
            return .get
        }
    }

    // header
    var headers: [String : String]? {
        switch self {
        case .syncNews:
            return  nil
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)! as Data
    }

    var task: Task {
        switch self {

        case .syncNews(let apiKey):
            return .requestParameters(parameters: ["apiKey" : apiKey], encoding: URLEncoding.queryString)
        }
    }
}
