//
//  SettingsCell.swift
//  instagram
//
//  Created by Marwan Osama on 9/30/20.
//  Copyright © 2020 Marwan Osama. All rights reserved.
//




enum SettingsCell: Int, CaseIterable, CustomStringConvertible {
    case logout
    case termsOfUse
    case help
    case editProfile
    
    
    var description: String {
        switch self {
        case .logout: return "Logout"
        case.termsOfUse: return "Terms Of Use"
        case.help: return "Help/Feedback"
        case.editProfile: return "Edit Profile"
        }
    }
    
    static let allCases = [SettingsCell.logout, SettingsCell.termsOfUse, SettingsCell.help, SettingsCell.editProfile]
}
