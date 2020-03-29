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
    
    var dataByCity : [(String, [Int])]?
    
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
                    let scrappedData = WebScrapper(fromData: data)
                    
                    self.infectedAmount.text = scrappedData.getTotalInfectedAmount()
                    self.recoveredAmount.text = scrappedData.getTotalRecoveredAmount()
                    self.deathsAmount.text = scrappedData.getTotalDeathsAmount()
                    
                    self.dataByCity = scrappedData.getInfectedAndRecoveredAmountByCity()
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
        return dataByCity!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infectedCitiesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InfectedCityCell
        
        cell.infectedAmount.text = String(dataByCity![indexPath.row].1[0])
        cell.infectedCityLabel.text = dataByCity![indexPath.row].0
        
        cell.recoveredAmount.text = String(dataByCity![indexPath.row].1[1])
        
        return cell
    }
}
