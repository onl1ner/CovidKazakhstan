//
//  ContactPeopleData.swift
//  CovidKazakhstan
//
//  Created by onl1ner onl1ner on 28/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import Foundation

struct ResponseData : Codable {
    let id : Int
    let status : String
    let longtitude : String
    let latitude : String
}

final class ContactPeopleData {
    static let apiUrl = URL(string: "https://m.egov.kz/covid-proxy-app/api/v1/covid/patient")!
    
    private static func getData(from url : URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> Void {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    public static func getContactPeopleAmount(completion: @escaping (_ amount : String) -> ()) -> Void {
        getData(from: apiUrl){ (data, response, error) in
            if let data = data {
                if let jsonData = try? JSONDecoder().decode([ResponseData].self, from: data) {
                    completion(String(jsonData.count))
                }
            }
        }
    }
}
