//
//  Created by Andrey Vasilev on 26/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import Foundation

final class CongratsPresenter {

    let interactor: ICongratsInteractor
    let router: ICongratsRouter

    let duration: TimeInterval = 1
    let repeatCount = 3

    init(interactor: ICongratsInteractor, router: ICongratsRouter) {
        self.interactor = interactor
        self.router = router
    }

    func viewDidAppear() {
        let delay = duration * TimeInterval(repeatCount)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
            self.router.dismiss(animated: false)
        }
    }
}

extension CongratsPresenter: ICongratsPresenter {

}
