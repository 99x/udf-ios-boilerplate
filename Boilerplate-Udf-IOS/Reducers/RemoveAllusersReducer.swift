//
//  RemoveAllusersReducer.swift
//  UdfBaseTests
//
//  Created by Suren Rodrigo on 9/4/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//

import ReSwift
import UdfBase

func removeAllUsersReducer(action: Action, state: UdfBaseState<TestState>) -> UdfBaseState<TestState> {
    switch(action as! RemoveAllUsers) {
    case .perform(let id):
        let newUsersList: [TestUser] = []
        let newAppState = state.appState.copy(users: newUsersList, count: newUsersList.count)
        return reducerUtil.updateActionsStateStatus(state: state, actionId: id, action: RemoveAllUsers.success, localState: newAppState)
    case .failure(let error, let id):
        return reducerUtil.updateActionsStateStatus(state: state, actionId: id, action: RemoveAllUsers.failure(error: error, id: id))
    default:
        return state
    }
}

