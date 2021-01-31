//
//  capitalizingFirstLetter.swift
//  100DaysOfSwift-Project2
//
//  Created by João Gabriel Dourado Cervo on 26/01/21.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
