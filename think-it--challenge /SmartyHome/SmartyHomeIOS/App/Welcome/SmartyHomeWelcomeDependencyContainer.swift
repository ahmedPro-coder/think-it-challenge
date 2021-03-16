//
//  SmartyHomeWelcomeDependencyContainer.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import SmartyHomeKit
import PromiseKit

/**
    Non connected scope container
 */
public class SmartyHomeWelcomeDependencyContainer: WelcomeFactory {
    
    // MARK: - Long-lived dependencies
    private let sharedAuthRepository: AuthentificationRepository
    private let sharedWelcomeViewModel: WelcomeViewModel
    
    // MARK: - Methods
    public init(authResponder: AuthResponder, authRepository: AuthentificationRepository) {
        self.sharedAuthRepository = authRepository
        func makeWelcomeViewModel(authRepository: AuthentificationRepository) -> WelcomeViewModel {
            return WelcomeViewModel(authRepository: authRepository, authResponder: authResponder)
        }
        self.sharedWelcomeViewModel = makeWelcomeViewModel(authRepository: sharedAuthRepository)
    }
    
    public func makeWelcomeViewController() -> WelcomeViewController {
        return WelcomeViewController(welcomeViewModel: sharedWelcomeViewModel)
    }
}


