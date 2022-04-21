//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Anđelko on 21.Apr.22.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
