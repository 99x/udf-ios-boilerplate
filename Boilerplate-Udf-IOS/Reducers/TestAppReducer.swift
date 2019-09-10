//
//  TestAppReducer.swift
//  UdfBaseTests
//
//  Created by Suren Rodrigo on 9/2/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//

import ReSwift
import UdfBase

let reducerUtil = ReducerUtil<TestState>()

func testAppReducer(action: Action, state: UdfBaseState<TestState>?) -> UdfBaseState<TestState> {
    let state = state ?? UdfBaseState<TestState>(state: TestState())
    switch action {
    case _ as AddTestUser:
        return addTestUserReducer(action: action, state: state)
    case _ as RemoveTestUser:
        return removeTestUserReducer(action: action, state: state)
    case _ as RemoveAllUsers:
        return removeAllUsersReducer(action: action, state: state)
    case _ as RemoveStateStatus:
        return reducerUtil.removeStateStatusReducer(action: action, state: state)
    default:
        return state
    }
}
