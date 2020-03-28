//
//  LastDataViewController.swift
//  CovidKazakhstan
//
//  Created by onl1ner onl1ner on 28/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import Kanna
import Foundation

class LastDataViewController: UIViewController {
    
    @IBOutlet var infectedBackgroundView: UIView!
    @IBOutlet var infectedAmount: UILabel!
    
    @IBOutlet var recoveredBackgroundView: UIView!
    @IBOutlet var recoveredAmount: UILabel!
    
    @IBOutlet var deathsBackgroundView: UIView!
    @IBOutlet var deathsAmount: UILabel!
    
    @IBOutlet var contactPeopleBackgroundView: UIView!
    @IBOutlet var contactPeopleAmount: UILabel!
    
    @IBOutlet var infectedCitiesCollectionView: UICollectionView!
    
    let characterSet = CharacterSet(charactersIn: "0123456789").inverted
    
    let url = URL(string: "https://www.coronavirus2020.kz/")!
    
    var infectedCities : [String : Int] = [:]
    
    func getTotalInfectedAmount(from data : HTMLDocument) -> String {
        return (data.xpath("//span[@class=\"number_cov marg_med\"]")[0].text?.deleteAllSpaces())!
    }
    
    func getInfectedAmountByCity(from data : HTMLDocument) -> [String : Int] {
        let cities = data.xpath("//div[@class=\"city_cov\"]")[0].text?.deleteAllSpaces()
        
        var output : [String : Int] = [:]
        
        for i in ((cities?.components(separatedBy: .newlines))!) {
            if i.count > 0 {
                let amountOfInfected = Int(i.components(separatedBy: characterSet).joined())
                
                var city = i.components(separatedBy: .decimalDigits).joined()
                
                if city.contains("область") {
                    let range = city.range(of: "область")?.lowerBound
                    city.insert(contentsOf: " ", at: range!)
                }
                
                city.removeLast()
                
                output[city] = amountOfInfected
            }
        }
        return output
    }
    
    func getTotalRecoveredAmount(from data : HTMLDocument) -> String {
        let downloadedData = (data.xpath("//div[@class=\"recov_bl\"]")[0].text?.deleteAllSpaces())!
        return downloadedData.components(separatedBy: characterSet).joined()
    }
    
    func getTotalDeathsAmount(from data : HTMLDocument) -> String {
        let downloadedData = (data.xpath("//div[@class=\"deaths_bl\"]")[0].text?.deleteAllSpaces())!
        return downloadedData.components(separatedBy: characterSet).joined()
    }
    
    override func viewDidLoad() -> Void {
        super.viewDidLoad()

        infectedBackgroundView.layer.cornerRadius = 10
        infectedBackgroundView.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                           withOpacity: 0.2,
                                           withOffset: CGSize(width: 0, height: 1))
        
        recoveredBackgroundView.layer.cornerRadius = 10
        recoveredBackgroundView.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                            withOpacity: 0.2,
                                            withOffset: CGSize(width: 0, height: 1))
        
        deathsBackgroundView.layer.cornerRadius = 10
        deathsBackgroundView.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                         withOpacity: 0.2,
                                         withOffset: CGSize(width: 0, height: 1))
        
        contactPeopleBackgroundView.layer.cornerRadius = 10
        contactPeopleBackgroundView.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                                withOpacity: 0.2,
                                                withOffset: CGSize(width: 0, height: 1))
        
        ContactPeopleData.getContactPeopleAmount() { (amount) in
            DispatchQueue.main.async {
                self.contactPeopleAmount.text = amount
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            guard let html = try? String(contentsOf: self.url) else { return }
            
            DispatchQueue.main.async {
                if let data = try? HTML(html: html, encoding: .utf8) {
                    self.infectedAmount.text = self.getTotalInfectedAmount(from: data)
                    self.infectedCities = self.getInfectedAmountByCity(from: data)
                    
                    self.recoveredAmount.text = self.getTotalRecoveredAmount(from: data)
                    
                    self.deathsAmount.text = self.getTotalDeathsAmount(from: data)
                }
                
                self.infectedCitiesCollectionView.delegate = self
                self.infectedCitiesCollectionView.dataSource = self
                
                self.infectedCitiesCollectionView.register(UINib(nibName: "InfectedCityCell", bundle: nil), forCellWithReuseIdentifier: "cell")
            }
        }
        
        
    }
}

extension LastDataViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infectedCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infectedCitiesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InfectedCityCell
        
        let sortedDictionary = infectedCities.sorted(by: { $0.value > $1.value })
        
        cell.infectedCityLabel.text = sortedDictionary[indexPath.row].key
        cell.infectedAmount.text = String(sortedDictionary[indexPath.row].value)
        
        return cell
    }
    
    
}
