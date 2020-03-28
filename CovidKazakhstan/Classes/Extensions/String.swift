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
}