//
//  Created by Andrey Vasilev on 26/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

final class CongratsAssembly {

    private let modulesFactory: IModulesFactory

    init(modulesFactory: IModulesFactory) {
        self.modulesFactory = modulesFactory
    }

    func build() -> ViperModule<CongratsViewController, ICongratsRouter> {
        let router = CongratsRouter()
        let interactor = CongratsInteractor()
        let presenter = CongratsPresenter(interactor: interactor, router: router)
        let viewController = getViewController(presenter: presenter)

        router.viewController = viewController

        return ViperModule(viewController: viewController, router: router)
    }

    private func getViewController(presenter: ICongratsPresenter) -> CongratsViewController {
        let viewController: CongratsViewController
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CongratsViewController") as? CongratsViewController {
            viewController = controller
            viewController.output = presenter
            viewController.presenter = presenter
        } else {
            viewController = CongratsViewController(presenter: presenter)
        }
        return viewController
    }
}
