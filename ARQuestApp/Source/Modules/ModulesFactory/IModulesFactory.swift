//
// Created by Andrey Vasilev on 29/05/2018.
// Copyright (c) 2018 Andrey Vasilev. All rights reserved.
//

import Foundation

protocol IModulesFactory: AnyObject {

    var setupAssembly: SetupAssembly { get }
    var awaitAssembly: AwaitAssembly { get }
    var imageDetectionAssembly: ImageDetectionAssembly { get }
    var congratsAssembly: CongratsAssembly { get }
    var mapAssembly: MapAssembly { get }
    var giftScannerAssembly: GiftScannerAssembly{ get }
}
