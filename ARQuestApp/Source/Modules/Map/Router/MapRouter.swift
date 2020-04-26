//
//  Created by Andrey Vasilev on 26/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import Foundation

final class MapRouter: BaseRouter {

    let giftScannerAssembly: GiftScannerAssembly

    init(giftScannerAssembly: GiftScannerAssembly) {
        self.giftScannerAssembly = giftScannerAssembly
    }
}

extension MapRouter: IMapRouter {

    func presentGiftScanner() {
        let controller = giftScannerAssembly.build().viewController
        viewController?.present(controller, animated: true, completion: nil)
    }
}
