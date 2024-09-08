import Foundation

struct WeatherModel: Decodable {
    let location: Location?
    let current: Current?
    let forecast: Forecast?
}

struct Location: Decodable {
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
    }
}

struct Current: Decodable {
    let temperature: Double?
    let time: String?
    let condition: Condition?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp_c"
        case time 
        case condition
    }
}

struct Condition: Decodable {
    let description: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case description = "text"
        case icon
    }
}


struct Forecast: Decodable {
    let forecastday: [Forecastday]
}

struct Forecastday: Decodable {
    let day: Day
    let hour: [Current]

    enum CodingKeys: String, CodingKey {
        case day, hour
    }
}

struct Day: Codable {
    let maxtempC, mintempC: Double
  
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
    }
}
