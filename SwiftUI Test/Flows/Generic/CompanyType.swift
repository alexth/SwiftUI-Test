//
//  CompanyType.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 24.11.2021.
//

import UIKit

enum CompanyType: CaseIterable {
    case undefined
    case single
    case multiple
    
    var localizedName: String {
        switch self {
        case .undefined: return NSLocalizedString("Any", comment: "Any")
        case .single: return NSLocalizedString("Single", comment: "Single")
        case .multiple: return NSLocalizedString("Multiple", comment: "Multiple")
        }
    }
    
    func editProfileTypes() -> [CompanyType] { [.multiple, .single] }
}
