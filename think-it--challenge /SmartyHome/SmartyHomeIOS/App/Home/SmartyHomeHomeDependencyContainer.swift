//
//  SmartyHomeHomeDependencyContainer.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import SmartyHomeKit
import PromiseKit

/**
    Connected Scope container
 */
public class SmartyHomeHomeDependencyContainer: HomeFactory {
    
    // MARK: - Long-lived dependencies
    private let sharedRoomsListRepository: RoomsListRepository
    private let sharedHomeViewModel: HomeViewModel
    
    // MARK: - Methods
    public init(profile: UserProfile) {
        func makeRoomsListRepository() -> RoomsListRepository {
            let remoteAPI = makeRemoteRoomsListApi()
            return SmartyHomeRoomsListRepository(remoteAPI: remoteAPI)
        }
        
        func makeRemoteRoomsListApi() -> RemoteRoomsListApi {
            return MockRemoteRoomsListApi()
        }
        
        self.sharedRoomsListRepository = makeRoomsListRepository()
        func makeHomeViewModel(roomsListRepository: RoomsListRepository, profile: UserProfile) -> HomeViewModel {
            return HomeViewModel(roomsListRepository: roomsListRepository, profile: profile)
        }
        self.sharedHomeViewModel = makeHomeViewModel(roomsListRepository: sharedRoomsListRepository, profile: profile)
    }
    
    public func makeHomeViewController() -> HomeViewController {
        return HomeViewController(homeViewModel: sharedHomeViewModel)
    }
}


