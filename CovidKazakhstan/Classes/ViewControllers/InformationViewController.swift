//
//  InformationViewController.swift
//  CovidKazakhstan
//
//  Created by onl1ner onl1ner on 30/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    @IBOutlet var aboutCoronaBox: UIView!
    
    @IBOutlet var symptomsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        aboutCoronaBox.layer.cornerRadius = 10
        
        aboutCoronaBox.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                   withOpacity: 0.2,
                                   withOffset: CGSize(width: 0, height: 1))
        
        symptomsCollectionView.dataSource = self
    }
}

extension InformationViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = symptomsCollectionView.dequeueReusableCell(withReuseIdentifier: "symptom\(indexPath.item)", for: indexPath)
        
        cell.layer.cornerRadius = 10
        cell.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                         withOpacity: 0.2,
                         withOffset: CGSize(width: 0, height: 2))
        
        return cell
    }
    
    
}
