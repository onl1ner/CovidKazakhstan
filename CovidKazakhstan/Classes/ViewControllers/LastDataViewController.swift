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
    
    @IBOutlet var infectedCitiesStackView: UIStackView!
    
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
                
                for cell in self.dataByCity! {
                    let newCell = UINib(nibName: "InfectedCityCell", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! InfectedCityCell
                    
                    newCell.heightAnchor.constraint(equalToConstant: 90).isActive = true
                    
                    newCell.infectedCityLabel.text = cell.0
                    newCell.infectedAmount.text = String(cell.1[0])
                    
                    newCell.recoveredAmount.text = String(cell.1[1])
                    
                    self.infectedCitiesStackView.addArrangedSubview(newCell)
                }
            }
        }
    }
}
