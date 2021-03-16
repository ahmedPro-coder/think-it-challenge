//
//  MainViewState.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import Foundation

/**
    Enumeration for different states of the main scope
 */
public enum MainViewState: Equatable {
    case launch
    case welcome
    case home(profile: UserProfile)
}
