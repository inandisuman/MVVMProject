//
//  UtilityService.swift
//  MVVMProject
//
//  Created by Deboleena on 06/03/23.
//

import Foundation
import UIKit

struct K {
    struct APIEndpoints {
        static let getUserList = "https://jsonplaceholder.typicode.com/users"
    }
    struct WarningMessage {
        static let passwordRuleMsg = "Your password is too short."
        static let usernameMissingMsg = "Username cannot be empty."
        static let countrySelectionMsg = "Please select a country."
        static let registrationErrorMsg = "Registration failed."
        static let loginErrorMsg = "Login failed."
    }
}

struct Helper {
    
    static func addImageToLeftOfTextField(txtField: UITextField, andImage img: UIImage) {
        let leftImgeView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImgeView.image = img
        txtField.leftView = leftImgeView
        txtField.leftViewMode = .always
    }
}

extension Locale {

    public var counrtyNames: [String] {
        return Locale.counrtyNames(for: self)
    }
    
    public static func counrtyNames(for locale: Locale) -> [String] {
        let nsLocale = locale as NSLocale
        let result: [String] = NSLocale.isoCountryCodes.compactMap {
            return nsLocale.displayName(forKey: .countryCode, value: $0)
        }
        return result
    }
}
