//
//  Created by Andrey Vasilev on 22/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import Foundation

final class SetupPresenter {

    let interactor: ISetupInteractor
    let router: ISetupRouter

    init(interactor: ISetupInteractor, router: ISetupRouter) {
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {

    }
}

extension SetupPresenter: ISetupPresenter {

}
