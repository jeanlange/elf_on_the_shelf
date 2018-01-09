//
//  temperatureFetching.swift
//  Elf on a Shelf
//
//  Created by Jean Lange on 1/9/18.
//  Copyright © 2018 Jean Lange. All rights reserved.
//

import Foundation

protocol TemperatureFetching {
    var state: String { get }
    var city: String  { get }
    func fetchTemperature()
}

extension TemperatureFetching {
    func fetchTemperature() {
        guard let url = URL(string: "https://api.wunderground.com/api/b193c8afeeecdbb2/conditions/q/\(state)/\(city).json") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared

        session.dataTask(with: request) { data, response, error in
            if error != nil {
                print("😡😡😡😡😡\(error.debugDescription)")
            } else {
                print("🤩🤩🤩🤩🤩 Made It!\(String(describing: response))")
            }

            guard let newData = data else { return }
            let jsonString = String(data: newData, encoding: String.Encoding.utf8)
            print(jsonString ?? "😱😱😱😱😱 Unable to parse data as JSON")

            guard let jsonData = jsonString?.data(using: .utf8) else { return }
            let decoder = JSONDecoder()
            let decodedData = try? decoder.decode(CurrentObservation.self, from: jsonData)

            guard let weatherWeCareAbout = decodedData?.current_observation else { return }
            print("weather: \(weatherWeCareAbout.temperature_string) and \(weatherWeCareAbout.weather), windchill: \(weatherWeCareAbout.windchill_f)")
            }.resume()
    }
}

struct CurrentObservation: Codable {
    let current_observation: TemperatureInfo
}

struct TemperatureInfo: Codable {
    let weather: String
//    let temp_f: Double
    let windchill_f: String
    let temperature_string: String
}
