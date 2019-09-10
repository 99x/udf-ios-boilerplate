//
//  FactResponse.swift
//  CalculatorFeature
//
//  Created by Suren Rodrigo on 9/7/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//

import Foundation

public struct FactResponse: Codable {
    let text: String?
    let year: Int?
    let number: Int?
    let found: Bool?
    let type: String?
}
