//
//  HomeViewModel.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import RxRelay

public class HomeViewModel {
    
    // MARK: - Repositories
    private let roomsListRepository: RoomsListRepository
    
    public var rooms: BehaviorRelay<[Room]> =
            BehaviorRelay(value: [])
    public let profile: UserProfile
    
    // MARK: - Methods
    public init(roomsListRepository: RoomsListRepository, profile: UserProfile) {
        self.roomsListRepository = roomsListRepository
        self.profile = profile
        getRooms()
    }
    
    func getRooms() {
        roomsListRepository.getRoomsList()
            .done({ rooms in
                self.rooms.accept(rooms)
            }).catch { (error) in }
    }
    
}

