
//
//  ApiServices.swift
//  UdfBaseTests
//
//  Created by Suren Rodrigo on 9/2/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//

import UdfBase
import PromiseKit

protocol TestAppDataService: DataService {
    func addUserApiService(name:String, age: Int, email: String) -> Promise<TestUser>
}

public struct TestRemoteDataService: TestAppDataService {
    func addUserApiService(name:String, age: Int, email: String) -> Promise<TestUser> {
        return Promise<TestUser> { seal in
            if(name != "" && age != 0 && email != "") {
                let usersList = getAllUsers(store.state) //should never do this in a real application
                if let existingUser =  usersList.first( where: {$0.email == email}) {
                    seal.reject(NSError(domain: "User with email " + existingUser.email + " already exists", code: 500))
                } else {
                    seal.fulfill(TestUser(name: name, age: age, email: email))
                }
            } else {
                seal.reject(NSError(domain: "Invalid User Details", code: 500))
            }
        }
    }
}
