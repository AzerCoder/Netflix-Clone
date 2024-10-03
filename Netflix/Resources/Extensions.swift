//
//  Extensions.swift
//  Netflix
//
//  Created by A'zamjon Abdumuxtorov on 03/10/24.
//

import Foundation

extension String{
    
    func capitalizeFirstLetter()->String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
