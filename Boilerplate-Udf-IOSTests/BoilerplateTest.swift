//
//  UdfBaseQuickTest.swift
//  UdfBaseTests
//
//  Created by Suren Rodrigo on 9/4/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//

@testable import Boilerplate_Udf_IOS
import ReSwift
import Quick
import Nimble
import UdfBase

let sideEffects = injectService(service: TestRemoteDataService(), receivers: dataServiceSideEffects)
let middleware = createMiddleware(appState: TestState(), items: sideEffects)
let store = Store<UdfBaseState<TestState>>(reducer: testAppReducer, state: nil, middleware: [middleware])

class BoilerplateTest: QuickSpec {
    let userManagerController = UserManagemenViewControllers()
    override func spec() {
        beforeSuite {
            store.subscribe(self.userManagerController)
        }
        afterSuite {
            store.unsubscribe(self.userManagerController)
        }
        describe("UdfBase Tests") {
            context("UserManagementViewController") {
               
                beforeEach {
                    
                    self.userManagerController.addNewUser(name: "Suren Rodrigo", age: 38, email: "surenr@99x.lk")
                    self.userManagerController.addNewUser(name: "Dinuka Rodrigo", age: 38, email: "dinuka@99x.lk")
                }
                
                afterEach {
                    self.userManagerController.removeAllUsers()
                }
                it("Add new users") {
                    expect(getUsersCount(store.state)).toEventually(equal(2))
                    self.userManagerController.addNewUser(name: "Kamal Perera", age: 38, email: "kamal@99x.lk")
                    expect(getUsersCount(store.state)).toEventually(equal(3))
                    expect(self.userManagerController.users.count).toEventually(equal(3))
                }
                it("Remove users") {
                    expect(getUsersCount(store.state)).toEventually(equal(2))
                    self.userManagerController.removeUser(email: "dinuka@99x.lk")
                    expect(getUsersCount(store.state)).toEventually(equal(1))
                    expect(self.userManagerController.users.count).toEventually(equal(1))
                }
                it("Adding existing users will throw an error") {
                    expect(getUsersCount(store.state)).toEventually(equal(2))
                    expect(self.userManagerController.error == nil).to(equal(true))
                    self.userManagerController.addNewUser(name: "Suren Rodrigo", age: 38, email: "surenr@99x.lk")
                    // First make sure error is not null(nil)
                    expect(self.userManagerController.error == nil).toEventually(equal(false))
                    
                    // Now assert that we have got the right error code
                    expect(self.userManagerController.error!.code).toEventually(equal(500))
                    
                }
            }
        }
    }
}
