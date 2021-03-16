//
//  RemoteRoomsListApi.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import Foundation
import PromiseKit

public protocol RemoteRoomsListApi {
    func getRoomsList() -> Promise<[Room]>
}
