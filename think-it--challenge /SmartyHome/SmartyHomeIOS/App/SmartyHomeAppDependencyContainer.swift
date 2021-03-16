//
//  SmartyHomeAppDependencyContainer.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import SmartyHomeKit
import PromiseKit

/**
    App Dependency Container
 */
public class SmartyHomeAppDependencyContainer: MainFactory {
    
    // MARK: - Long-lived dependencies
    private let sharedAuthRepository: AuthentificationRepository
    private let sharedMainViewModel: MainViewModel
    
    // MARK: - Methods
    public init() {
        func makeAuthentificationRepository() -> AuthentificationRepository {
            let remoteAPI = makeRemoteAuthApi()
            return SmartyHomeAuthentificationRepository(remoteAPI: remoteAPI)
        }
        
        func makeRemoteAuthApi() -> RemoteAuthApi {
            return MockRemoteAuthApi()
        }
        
        self.sharedAuthRepository = makeAuthentificationRepository()
        func makeMainViewModel() -> MainViewModel {
            return MainViewModel()
        }
        self.sharedMainViewModel = makeMainViewModel()
    }
    
    public func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: sharedMainViewModel, mainFactory: self)
    }
    
    func makeLaunchViewController() -> LaunchViewController {
        let launchViewModel = makeLaunchViewModel()
        return LaunchViewController(launchViewModel: launchViewModel)
    }
    
    func makeLaunchViewModel() -> LaunchViewModel {
        return LaunchViewModel(authRepository: sharedAuthRepository, authResponder: sharedMainViewModel)
    }
    
    func makeWelcomeViewController() -> WelcomeViewController {
        let welcomeDependencyContainer = SmartyHomeWelcomeDependencyContainer(authResponder: sharedMainViewModel, authRepository: sharedAuthRepository)
        return welcomeDependencyContainer.makeWelcomeViewController()
    }
    
    func makeHomeViewController(with profile: UserProfile) -> HomeViewController {
        let homeDependencyContainer = SmartyHomeHomeDependencyContainer(profile: profile)
        return homeDependencyContainer.makeHomeViewController()
    }
}

