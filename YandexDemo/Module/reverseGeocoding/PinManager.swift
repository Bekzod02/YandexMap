//
//  PinManager.swift
//  YandexDemo
//
//  Created by sabgames on 13.08.2021.
//

import Foundation

struct PinManager {
    
    let searchURL = "https://geocode-maps.yandex.ru/1.x/?format=json&apikey=840ce362-ceda-4996-a12b-cd080a8d5a48"
    
    func fetchPinLocation(lan: Double, lon: Double) {
        let urlString = "\(searchURL)&geocode=\(lon),\(lan)&lang=ru_RU"
        performRequest(urlString: urlString)
        
    }
    
     func performRequest(urlString: String) {
        if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    parseJSON(safeData)
                }
            }
            task.resume()
        }
        
    }
    
     func parseJSON(_ locationData: Data) -> PinModule? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SearchData.self, from: locationData)
            let address = decodedData.response.GeoObjectCollection.featureMember[0].GeoObject.name
            print(address)
            let pin = PinModule(addressName: address)
            return pin
        } catch {
            print(error)
            return nil
        }
    }
    
}
