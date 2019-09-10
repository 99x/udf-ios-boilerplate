//
//  AddUserViewControllerTest.swift
//  UdfBaseTests
//
//  Created by Suren Rodrigo on 9/4/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//

@testable import Boilerplate_Udf_IOS
import UdfBase

class UserManagemenViewControllers: TestBase {
    var users: [TestUser] = getAllUsers(store.state)
    public var error: ApiError? = nil
//    override init() {
//        self.users = getAllUsers(store.state)
//        super.init()
//    }
    override func onStateUpdate(state: UdfBaseState<TestState>, action: BaseAction?) -> Bool {
        switch(action!) { // NB: How to handle action based state update
        case _ as AddTestUser:
            self.users = getAllUsers(state)
            return true
        case _ as RemoveTestUser:
            self.users = getAllUsers(state)
            return true
        default:
            return false
        }
    }
    
    override func onError(action: BaseAction) {
        self.error = action.getError()
    }
    
    public func addNewUser(name: String, age: Int, email: String) {
        dispatchAction(action: AddTestUser.request(name: name, age: age, email: email, id: getActionId()))
    }
    
    public func removeUser(email: String) {
        dispatchAction(action: RemoveTestUser.perform(email: email, id: getActionId()))
    }
    
    public func removeAllUsers() {
        dispatchAction(action: RemoveAllUsers.perform(id: getActionId()))
    }
}
