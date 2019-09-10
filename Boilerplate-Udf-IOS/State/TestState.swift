//
//  TestState.swift
//  UdfBaseTests
//
//  Created by Suren Rodrigo on 9/2/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//
import UdfBase

struct TestState {
    let users: [TestUser]
    let count: Int
    let date: Int
    let month: Int
    let fact: "
    
    public init(users: [TestUser] = [], count: Int = 0){
        self.users = users
        self.count = count
    }
    
    public func copy(users: [TestUser]? = nil, count: Int? = nil) -> TestState {
        return TestState(users: users ?? self.users, count: count ?? self.count)
    }
    
    
}

let getAllUsers = {(state: UdfBaseState<TestState>) -> [TestUser] in return state.appState.users }
let getUsersCount = {(state: UdfBaseState<TestState>) -> Int in return state.appState.count }
