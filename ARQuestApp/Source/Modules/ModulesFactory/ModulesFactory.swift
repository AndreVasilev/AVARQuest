//
// Created by Andrey Vasilev on 29/05/2018.
// Copyright (c) 2018 Andrey Vasilev. All rights reserved.
//

import Foundation

class ModulesFactory {

}

extension ModulesFactory: IModulesFactory {

    var setupAssembly: SetupAssembly {
        return SetupAssembly(modulesFactory: self)
    }

    var awaitAssembly: AwaitAssembly {
        return AwaitAssembly(modulesFactory: self)
    }

    var imageDetectionAssembly: ImageDetectionAssembly {
        return ImageDetectionAssembly(modulesFactory: self)
    }

    var congratsAssembly: CongratsAssembly {
        return CongratsAssembly(modulesFactory: self)
    }

    var mapAssembly: MapAssembly {
        return MapAssembly(modulesFactory: self)
    }

    var giftScannerAssembly: GiftScannerAssembly {
        return GiftScannerAssembly(modulesFactory: self)
    }
}
