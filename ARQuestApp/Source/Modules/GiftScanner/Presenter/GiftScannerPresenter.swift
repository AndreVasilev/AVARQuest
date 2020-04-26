//
//  Created by Andrey Vasilev on 01/05/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import Foundation

final class GiftScannerPresenter {

    let interactor: IGiftScannerInteractor
    let router: IGiftScannerRouter

    init(interactor: IGiftScannerInteractor, router: IGiftScannerRouter) {
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {

    }
}

extension GiftScannerPresenter: IGiftScannerPresenter {

    var resourceGroupName: String {
        return "AR Gift"
    }

    func didTrackImage(referenceName: String) -> String? {
        return "gift-tracked"
    }

    func presentMap() { /* do nothing */ }
}
