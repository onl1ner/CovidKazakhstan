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
    
    @IBOutlet var testAmountBackgroundView: UIView!
    @IBOutlet var testAmount: UILabel!
    
    @IBOutlet var infectedCitiesStackView: UIStackView!
    
    @IBOutlet var peopleOnQuarantineBackgroundView: UIView!
    @IBOutlet var peopleOnQuarantineAmount: UILabel!
    
    @IBOutlet var peopleOnHomeQuarantineBackgroundView: UIView!
    @IBOutlet var peopleOnHomeQuarantineAmount: UILabel!
    
    let characterSet = CharacterSet(charactersIn: "0123456789").inverted
    
    let url = URL(string: "https://www.coronavirus2020.kz/")!
    
    var viewsToCustomize : [UIView] = []
    
    var dataByCity : [(String, [Int])]?
    
    func updateData() -> Void {
        JSONData.getOnQuarantine() { (amount) in
            DispatchQueue.main.async {
                self.peopleOnQuarantineAmount.text = amount
            }
        }
        
        JSONData.getOnHomeQuarantine() { (amount) in
            DispatchQueue.main.async {
                self.peopleOnHomeQuarantineAmount.text = amount
            }
        }
        
        JSONData.getTotalTestAmount() { (amount) in
            DispatchQueue.main.async {
                self.testAmount.text = amount
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
                
                self.infectedCitiesStackView.subviews.forEach({ $0.removeFromSuperview() })
                
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateData()
    }
    
    override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        viewsToCustomize = [infectedBackgroundView, recoveredBackgroundView, deathsBackgroundView,
                            peopleOnQuarantineBackgroundView, peopleOnHomeQuarantineBackgroundView,
                            testAmountBackgroundView]
        
        for i in viewsToCustomize {
            i.layer.cornerRadius = 10
            i.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                          withOpacity: 0.2,
                          withOffset: CGSize(width: 0, height: 1))
        }
    }
}
