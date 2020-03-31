//
//  WebScraper.swift
//  CovidKazakhstan
//
//  Created by onl1ner onl1ner on 29/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import Foundation
import Kanna

final class WebScrapper {
    private let characterSet = CharacterSet(charactersIn: "0123456789").inverted
    
    private let data : HTMLDocument
    
    private func getInfectedByCity() -> [String : Int] {
        let infected = data.xpath("//div[@class=\"city_cov\"]")[0].text?.deleteAllSpaces()
        
        var infectedDict : [String : Int] = [:]
        
        for i in (infected?.components(separatedBy: .newlines))! {
            if i.count > 0 {
                let infectedAmount = Int(i.components(separatedBy: characterSet).joined())!

                var infectedCity = i.components(separatedBy: .decimalDigits).joined()
                infectedCity.removeLast()

                infectedDict[infectedCity] = infectedAmount
            }
        }
        
        return infectedDict
    }
    
    private func getRecoveredByCity() -> [String : Int] {
        let recovered = data.xpath("//div[@class=\"city_cov\"]")[1].text?.deleteAllSpaces()
        
        var recoveredDict : [String : Int] = [:]
        
        for i in (recovered?.components(separatedBy: .newlines))! {
            if i.count > 0 {
                let recoveredAmount = Int(i.components(separatedBy: characterSet).joined())
                
                var recoveredCity = i.components(separatedBy: .decimalDigits).joined()
                recoveredCity.removeLast()
                
                recoveredDict[recoveredCity] = recoveredAmount
            }
        }
        
        return recoveredDict
    }
    
    public func getTotalInfectedAmount() -> String {
        return (data.xpath("//span[@class=\"number_cov marg_med\"]")[0].text?.deleteAllSpaces())!
    }
    
    public func getTotalRecoveredAmount() -> String {
        let downloadedData = (data.xpath("//div[@class=\"recov_bl\"]")[0].text?.deleteAllSpaces())!
        return downloadedData.components(separatedBy: characterSet).joined()
    }
    
    public func getTotalDeathsAmount() -> String {
        let downloadedData = (data.xpath("//div[@class=\"deaths_bl\"]")[0].text?.deleteAllSpaces())!
        return downloadedData.components(separatedBy: characterSet).joined()
    }
    
    public func getInfectedAndRecoveredAmountByCity() -> [(String, [Int])] {
        let infectedData = getInfectedByCity()
        let recoveredData = getRecoveredByCity()
        
        var output : [String : [Int]] = [:]
        
        /// Мы проверяем количество выздоровевших из зараженных, поэтому идем циклом по словарю с данными зараженных городов
        for infectedCityData in infectedData {
            if recoveredData.keys.contains(infectedCityData.key) {
                output[infectedCityData.key.formatCityName()] = [infectedCityData.value, recoveredData[infectedCityData.key]!]
            } else {
                output[infectedCityData.key.formatCityName()] = [infectedCityData.value, 0]
            }
        }
        return output.sorted(by: { $0.value[0] > $1.value[0] })
    }
    
    init(fromData data : HTMLDocument) {
        self.data = data
    }
}
