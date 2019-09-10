//
//  AddTestUserReducer.swift
//  UdfBaseTests
//
//  Created by Suren Rodrigo on 9/2/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//

import ReSwift
import UdfBase

func addTestUserReducer(action: Action, state: UdfBaseState<TestState>) -> UdfBaseState<TestState> {
    switch(action as! AddTestUser) {
    case .perform(let testUser, let id):
        var usersList = state.appState.users
        usersList.append(testUser)
        let newAppState = state.appState.copy(users: usersList, count: usersList.count)
        return reducerUtil.updateActionsStateStatus(state: state, actionId: id, action: AddTestUser.success, localState: newAppState)
    case .failure(let error, let id):
        return reducerUtil.updateActionsStateStatus(state: state, actionId: id, action: AddTestUser.failure(error: error, id: id))
    default:
        return state
    }
}

