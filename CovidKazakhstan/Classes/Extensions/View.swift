//
//  View.swift
//  CovidKazakhstan
//
//  Created by onl1ner onl1ner on 28/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

extension UIView{
    final func setupShadow(withColor color : CGColor, withOpacity opacity : Float, withOffset offset : CGSize) -> Void {
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
    }
}
