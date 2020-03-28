//
//  InfectedCityCell.swift
//  CovidKazakhstan
//
//  Created by onl1ner onl1ner on 28/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

class InfectedCityCell: UICollectionViewCell {

    @IBOutlet var mainView: UIView!
    
    @IBOutlet var infectedCityLabel: UILabel!
    @IBOutlet var infectedAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = 10
        
        mainView.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                             withOpacity: 0.2,
                             withOffset: CGSize(width: 0, height: 1))
        // Initialization code
    }
}
