//
//  Created by Andrey Vasilev on 26/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

final class MapAssembly {

    private let modulesFactory: IModulesFactory

    init(modulesFactory: IModulesFactory) {
        self.modulesFactory = modulesFactory
    }

    func build(model: MapModel) -> ViperModule<MapViewController, IMapRouter> {
        let router = MapRouter(giftScannerAssembly: modulesFactory.giftScannerAssembly)
        let interactor = MapInteractor()
        let presenter = MapPresenter(interactor: interactor, router: router, mapModel: model)
        let viewController = getViewController(presenter: presenter)

        router.viewController = viewController

        return ViperModule(viewController: viewController, router: router)
    }

    private func getViewController(presenter: IMapPresenter) -> MapViewController {
        let viewController: MapViewController
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            viewController = controller
            viewController.output = presenter
            viewController.presenter = presenter
        } else {
            viewController = MapViewController(presenter: presenter)
        }
        return viewController
    }
}
