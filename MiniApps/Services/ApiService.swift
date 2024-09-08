//
//  ApiService.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 08.09.2024.
//

import Foundation
import Alamofire

final class ApiService {
    func fetchWeather(city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let parameters: [String: Any] = [
            "key": Consts.requestConsts.apiKey,
            "q": city,
            "days": 7,
            "aqi": "no",
            "alerts": "no"
        ]
        
        guard let url = constructURL(base: Consts.requestConsts.baseUrl, parameters: parameters) else {
            completion(.failure(NSError(domain: Consts.requestConsts.domain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        AF.request(url).responseDecodable(of: WeatherModel.self) { response in
            switch response.result {
            case .success(let weatherModel):
                completion(.success(weatherModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func constructURL(base: String, parameters: [String: Any]) -> URL? {
        var urlComponents = URLComponents(string: base)
        
        urlComponents?.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        
        return urlComponents?.url
    }
}
