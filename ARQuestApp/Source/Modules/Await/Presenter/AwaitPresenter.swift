//
//  Created by Andrey Vasilev on 22/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import Foundation

final class AwaitPresenter {

    let interactor: IAwaitInteractor
    let router: IAwaitRouter

    init(interactor: IAwaitInteractor, router: IAwaitRouter) {
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {

    }
}

extension AwaitPresenter: IAwaitPresenter {

}
