//
//  String.swift
//  CovidKazakhstan
//
//  Created by onl1ner onl1ner on 28/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

extension String {
    func deleteAllSpaces() -> String {
        return self.components(separatedBy: .whitespaces).joined()
    }
    
    func formatCityName() -> String {
        var formattedString = self
        
        if self.contains("область") {
            let range = self.range(of: "область")?.lowerBound
            formattedString.insert(" ", at: range!)
        } else {
            let range = self.range(of: "г.")?.upperBound
            formattedString.insert(" ", at: range!)
        }
        
        return formattedString
    }
}
