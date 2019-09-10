//
//  TestBase.swift
//  UdfBaseTests
//
//  Created by Suren Rodrigo on 9/3/19.
//  Copyright © 2019 Suren Rodrigo. All rights reserved.
//

import ReSwift
import UdfBase

@testable import Boilerplate_Udf_IOS

class TestBase: Base{
    var storeInstance: Store<UdfBaseState<TestState>> = store
    
    var actionIds: [String] = []
    
    func onStateUpdate(state: UdfBaseState<TestState>, action: BaseAction?) -> Bool {
       return false
    }
    
    func onError(action: BaseAction) {
     
    }
    
    func showLoadingAnimation() {
        
    }
    
    func hideLoadingAnimation() {
        
    }
   
}
