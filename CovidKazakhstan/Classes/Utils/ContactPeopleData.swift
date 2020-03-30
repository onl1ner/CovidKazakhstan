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

struct UniqueIDField : Codable {
    let name : String
    let isSystemMaintained : Bool
}

struct SpatialReference : Codable {
    let wkid : Int
    let latestWkid : Int
}

struct Field : Codable {
    let name : String
    let type : String
    let alias : String
    let sqlType : String
    let domain : String?
    let defaultValue : String?
}

struct Attributes : Codable {
    let value : Int
}

struct Features : Codable {
    let attributes : Attributes
}

struct Response : Codable {
    let objectIdFieldName : String
    let uniqueIdField : UniqueIDField
    let globalIdFieldName : String
    let geometryType : String
    let spatialReference : SpatialReference
    let fields : [Field]
    let features : [Features]
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

final class JSONData {
    private static func getData(from url : URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> Void {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    public static func getTotalTestAmount(completion: @escaping (_ amount : String) -> ()) -> Void {
        let apiURL = URL(string: "https://services7.arcgis.com/faoKMQyLSRoeuXdT/arcgis/rest/services/%D0%94%D0%B0%D0%BD%D0%BD%D1%8B%D0%B5_%D0%BD%D0%B0_%D0%BA%D0%B0%D1%80%D1%82%D1%83_COVID_19/FeatureServer/0/query?f=json&where=1%3D1&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&outStatistics=%5B%7B%22statisticType%22%3A%22sum%22%2C%22onStatisticField%22%3A%22%D0%9F%D0%BE%D1%82%D0%B5%D0%BD%D1%86%D0%B8%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%B0%D0%BA%D1%82_%D0%BD%D0%B0_%D0%B1%D0%BE%D1%80%D1%82%D1%83%22%2C%22outStatisticFieldName%22%3A%22value%22%7D%5D&cacheHint=true")!
        
        getData(from: apiURL){ (data, response, error) in
            if let data = data {
                if let jsonData = try? JSONDecoder().decode(Response.self, from: data) {
                    completion(String(jsonData.features[0].attributes.value))
                }
            }
        }
    }
    
    public static func getOnQuarantine(completion: @escaping (_ amount : String) -> ()) -> Void {
        let apiURL = URL(string: "https://services7.arcgis.com/faoKMQyLSRoeuXdT/arcgis/rest/services/%D0%94%D0%B0%D0%BD%D0%BD%D1%8B%D0%B5_%D0%BD%D0%B0_%D0%BA%D0%B0%D1%80%D1%82%D1%83_COVID_19/FeatureServer/0/query?f=json&where=1%3D1&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&outStatistics=%5B%7B%22statisticType%22%3A%22sum%22%2C%22onStatisticField%22%3A%22F2_%D0%BA%D0%B0%D1%82%D0%B5%D0%B3%D0%BE%D1%80%D0%B8%D1%8F_%D0%93%D0%BE%D1%81%D0%BF%D0%B8%D1%82%D0%B0%D0%BB%D0%B8%D0%B7%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D1%8B%22%2C%22outStatisticFieldName%22%3A%22value%22%7D%5D&cacheHint=true")!
        
        getData(from: apiURL){ (data, response, error) in
            if let data = data {
                if let jsonData = try? JSONDecoder().decode(Response.self, from: data) {
                    completion(String(jsonData.features[0].attributes.value))
                }
            }
        }
    }
    
    public static func getOnHomeQuarantine(completion: @escaping (_ amount : String) -> ()) -> Void {
        let apiURL = URL(string: "https://services7.arcgis.com/faoKMQyLSRoeuXdT/arcgis/rest/services/%D0%94%D0%B0%D0%BD%D0%BD%D1%8B%D0%B5_%D0%BD%D0%B0_%D0%BA%D0%B0%D1%80%D1%82%D1%83_COVID_19/FeatureServer/0/query?f=json&where=1%3D1&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&outStatistics=%5B%7B%22statisticType%22%3A%22sum%22%2C%22onStatisticField%22%3A%22%D0%91%D0%BB%D0%B8%D0%B7%D0%BA%D0%B8%D0%B9_%D0%BA%D0%BE%D0%BD%D1%82%D0%B0%D0%BA%D1%82_%D0%BD%D0%B0_%D0%B1%D0%BE%D1%80%D1%82%D1%83%22%2C%22outStatisticFieldName%22%3A%22value%22%7D%5D&cacheHint=true")!
        
        getData(from: apiURL){ (data, response, error) in
            if let data = data {
                if let jsonData = try? JSONDecoder().decode(Response.self, from: data) {
                    completion(String(jsonData.features[0].attributes.value))
                }
            }
        }
    }
}
