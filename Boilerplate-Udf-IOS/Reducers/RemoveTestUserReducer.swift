//
//  RemoveTestUserReducer.swift
//  UdfBaseTests
//
//  Created by Suren Rodrigo on 9/4/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//

import ReSwift
import UdfBase

func removeTestUserReducer(action: Action, state: UdfBaseState<TestState>) -> UdfBaseState<TestState> {
    switch(action as! RemoveTestUser) {
    case .perform(let email, let id):
        let newUsersList = getAllUsers(state).filter({ $0.email != email})
        let newAppState = state.appState.copy(users: newUsersList, count: newUsersList.count)
        return reducerUtil.updateActionsStateStatus(state: state, actionId: id, action: RemoveTestUser.success, localState: newAppState)
    case .failure(let error, let id):
        return reducerUtil.updateActionsStateStatus(state: state, actionId: id, action: RemoveTestUser.failure(error: error, id: id))
    default:
        return state
    }
}
