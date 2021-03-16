//
//  MockRemoteRoomsListApi.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import Foundation
import PromiseKit

public class MockRemoteRoomsListApi: RemoteRoomsListApi {
    
    // MARK: - Methods
    public init(){}
    
    public func getRoomsList() -> Promise<[Room]> {
        return Promise { seal in
            seal.fulfill([Room(name: "Living Room", picture: "livingroom", devices: 4),
                          Room(name: "Media Room", picture: "mediaroom", devices: 6),
                          Room(name: "Bathroom", picture: "bathroom", devices: 1),
                          Room(name: "Bedroom", picture: "bedroom", devices: 3)])
        }
    }
}
