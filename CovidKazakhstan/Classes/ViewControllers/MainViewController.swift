//
//  MainViewController.swift
//  CovidKazakhstan
//
//  Created by onl1ner onl1ner on 28/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit
import Kanna
import Foundation

class MainViewController: UIViewController {
    
    @IBOutlet var infectedBackgroundView: UIView!
    @IBOutlet var infectedAmount: UILabel!
    
    @IBOutlet var infectedCityCollectionView: UICollectionView!
    
    
    let url = URL(string: "https://www.coronavirus2020.kz/")!
    
    var infectedCities : [String: Int] = [:]
    
    override func viewDidLoad() -> Void {
        super.viewDidLoad()

        infectedBackgroundView.layer.cornerRadius = 20
        
        infectedBackgroundView.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                           withOpacity: 0.2,
                                           withOffset: CGSize(width: 0, height: 1))
        
        infectedCityCollectionView.delegate = self
        infectedCityCollectionView.dataSource = self
        
        infectedCityCollectionView.register(UINib(nibName: "InfectedCityCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        
        guard let html = try? String(contentsOf: url) else { return }
        
        if let data = try? HTML(html: html, encoding: .utf8) {
            infectedAmount.text = data.xpath("//span[@class=\"number_cov marg_med\"]")[0].text?.deleteAllSpaces()
            
            let cities = data.xpath("//div[@class=\"city_cov\"]")[0].text?.deleteAllSpaces()
            
            for i in ((cities?.components(separatedBy: .newlines))!) {
                if i.count > 0 {
                    var city = i.components(separatedBy: .decimalDigits).joined()
                    
                    let characterSet = CharacterSet(charactersIn: "0123456789").inverted
                    var amountOfInfected = Int(i.components(separatedBy: characterSet).joined())
                    
                    if city.contains("область") {
                        let range = city.range(of: "область")?.lowerBound
                        city.insert(contentsOf: " ", at: range!)
                    }
                    
                    city.removeLast()
                    
                    infectedCities[city] = amountOfInfected
                }
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infectedCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infectedCityCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! InfectedCityCell
        
        let sortedDictionary = infectedCities.sorted(by: { $0.value > $1.value })
        
        cell.infectedCityLabel.text = sortedDictionary[indexPath.row].key
        cell.infectedAmount.text = String(sortedDictionary[indexPath.row].value)
        
        return cell
    }
    
}
