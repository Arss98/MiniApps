import Foundation

struct ServerListResponse<T>: Decodable where T: Decodable {
    let response: ServerModelResponse<T>
}

struct ServerModelResponse<T>: Decodable where T: Decodable {
    let resultCount: Int
    let results: [T]
}

struct ServerResponse<T>: Decodable where T: Decodable {
    let response: [T]
}
