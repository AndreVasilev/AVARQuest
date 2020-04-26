//
//  Created by Andrey Vasilev on 22/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

final class AwaitAssembly {

    private let modulesFactory: IModulesFactory

    init(modulesFactory: IModulesFactory) {
        self.modulesFactory = modulesFactory
    }

    func build() -> ViperModule<AwaitViewController, IAwaitRouter> {
        let router = AwaitRouter()
        let interactor = AwaitInteractor()
        let presenter = AwaitPresenter(interactor: interactor, router: router)
        let viewController = getViewController(presenter: presenter)

        router.viewController = viewController

        return ViperModule(viewController: viewController, router: router)
    }

    private func getViewController(presenter: IAwaitPresenter) -> AwaitViewController {
        let viewController: AwaitViewController
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AwaitViewController") as? AwaitViewController {
            viewController = controller
            viewController.output = presenter
            viewController.presenter = presenter
        } else {
            viewController = AwaitViewController(presenter: presenter)
        }
        return viewController
    }
}
