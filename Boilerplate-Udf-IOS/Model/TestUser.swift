//
//  TestDTO.swift
//  UdfBaseTests
//
//  Created by Suren Rodrigo on 9/2/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//

struct TestUser {
    let name: String
    let age: Int
    let email: String
    
    public init(name: String = "", age: Int = 0, email: String = ""){
        self.name = name
        self.age = age
        self.email = email
    }
    
    public func copy(name: String? = nil, age: Int? = nil, email: String? = nil) -> TestUser {
        return TestUser(name: name ?? self.name, age: age ?? self.age, email: email ?? self.email)
    }
}
