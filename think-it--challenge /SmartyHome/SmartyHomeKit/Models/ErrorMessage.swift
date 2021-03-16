//
//  ErrorMessage.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 15/03/2021.
//

public struct ErrorMessage: Error {
    
    // MARK: - Properties
    public let id: UUID
    public let title: String
    public let message: String
    public let code: Int?
    
    // MARK: - Methods
    public init(title: String, message: String, code: Int) {
        self.id = UUID()
        self.title = title
        self.message = message
        self.code = code
    }
    
    public init(title: String, message: String) {
        self.id = UUID()
        self.title = title
        self.message = message
        self.code = nil
    }
}

extension ErrorMessage: Equatable {
    
    public static func ==(lhs: ErrorMessage, rhs: ErrorMessage) -> Bool {
        return lhs.id == rhs.id
    }
}
