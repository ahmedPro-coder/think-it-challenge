//
//  SmartyHomeRoomsListRepository.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import Foundation
import PromiseKit

public class SmartyHomeRoomsListRepository: RoomsListRepository {
    
    // MARK: - Properties
    var _remoteAPI: RemoteRoomsListApi
    
    // MARK: - Methods
    public init(remoteAPI: RemoteRoomsListApi) {
        self._remoteAPI = remoteAPI
    }
    
    public func getRoomsList() -> Promise<[Room]> {
        return _remoteAPI.getRoomsList()
    }
    
}
