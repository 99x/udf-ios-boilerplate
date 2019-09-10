//
//  TestActions.swift
//  UdfBaseTests
//
//  Created by Suren Rodrigo on 9/2/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//

import UdfBase

enum AddTestUser: BaseAction {
    case request(name: String, age: Int, email: String, id: String?)
    case success
    case perform(testUser:TestUser, id: String?)
    case failure(error: ApiError, id: String?)
    func getState() -> ActionStatus {
        switch self {
        case .success:
            return ActionStatus.COMPLETED
        case .failure:
            return ActionStatus.ERROR
        default:
            return ActionStatus.INIT
        }
    }
    func getError() -> ApiError? {
        switch self {
        case .failure(let error, _?):
            return error
        default:
            return nil
        }
    }
}


enum RemoveTestUser: BaseAction {
    case success
    case perform(email: String, id: String?)
    case failure(error: ApiError, id: String?)
    func getState() -> ActionStatus {
        switch self {
        case .success:
            return ActionStatus.COMPLETED
        case .failure:
            return ActionStatus.ERROR
        default:
            return ActionStatus.INIT
        }
    }
    func getError() -> ApiError? {
        switch self {
        case .failure(let error, _?):
            return error
        default:
            return nil
        }
    }
}

enum RemoveAllUsers: BaseAction {
    case success
    case perform(id: String?)
    case failure(error: ApiError, id: String?)
    func getState() -> ActionStatus {
        switch self {
        case .success:
            return ActionStatus.COMPLETED
        case .failure:
            return ActionStatus.ERROR
        default:
            return ActionStatus.INIT
        }
    }
    func getError() -> ApiError? {
        switch self {
        case .failure(let error, _?):
            return error
        default:
            return nil
        }
    }
}
