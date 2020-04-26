//
//  Created by Andrey Vasilev on 22/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

final class SetupAssembly {

    private let modulesFactory: IModulesFactory

    init(modulesFactory: IModulesFactory) {
        self.modulesFactory = modulesFactory
    }

    func build() -> ViperModule<SetupViewController, ISetupRouter> {
        let router = SetupRouter()
        let interactor = SetupInteractor()
        let presenter = SetupPresenter(interactor: interactor, router: router)
        let viewController = getViewController(presenter: presenter)

        router.viewController = viewController

        return ViperModule(viewController: viewController, router: router)
    }

    private func getViewController(presenter: ISetupPresenter) -> SetupViewController {
        let viewController: SetupViewController
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetupViewController") as? SetupViewController {
            viewController = controller
            viewController.output = presenter
            viewController.presenter = presenter
        } else {
            viewController = SetupViewController(presenter: presenter)
        }
        return viewController
    }
}
