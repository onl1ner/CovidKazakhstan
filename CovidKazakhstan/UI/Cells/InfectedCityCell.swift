//
//  InfectedCityCell.swift
//  CovidKazakhstan
//
//  Created by onl1ner onl1ner on 28/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

class InfectedCityCell: UIView {

    @IBOutlet var infectedCityLabel: UILabel!
    
    @IBOutlet var infectedAmount: UILabel!
    
    @IBOutlet var recoveredAmount: UILabel!
    
    @IBOutlet var deathsAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        
        self.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                         withOpacity: 0.2,
                         withOffset: CGSize(width: 0, height: 1))
    }
}
