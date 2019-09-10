//
//  TestUserManagementSideEffects.swift
//  UdfBaseTests
//
//  Created by Suren Rodrigo on 9/2/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//
import ReSwift
import UdfBase

func addTestUserSideEffect(dataService: TestAppDataService) -> MiddlewareItem {
    return { (action: Action, dispatch: @escaping DispatchSideEffect) in
        // descruct the request instance and extract the variables
        guard let action = action as? AddTestUser,
            case .request (let name, let age, let email, let id?) = action else { return }
        // call the backend service
        dataService.addUserApiService(name: name, age: age, email: email)
            .done {testUser in // Handle success
                dispatch(AddTestUser.perform(testUser: testUser,  id: id))
            }
            .catch { error in // Handle error
                let apiError = ApiError(code: error._code, message: error.localizedDescription)
                dispatch(AddTestUser.failure(error: apiError, id: id))
        }
    }
    
}

