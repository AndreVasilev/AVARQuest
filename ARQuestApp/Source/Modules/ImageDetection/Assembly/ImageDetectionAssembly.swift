//
//  Created by Andrey Vasilev on 22/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

final class ImageDetectionAssembly {

    private let modulesFactory: IModulesFactory

    init(modulesFactory: IModulesFactory) {
        self.modulesFactory = modulesFactory
    }

    func build() -> ViperModule<ImageDetectionViewController, IImageDetectionRouter> {
        let router = ImageDetectionRouter(congratsAssembly: modulesFactory.congratsAssembly, mapAssembly: modulesFactory.mapAssembly)
        let interactor = ImageDetectionInteractor()
        let presenter = ImageDetectionPresenter(interactor: interactor, router: router, mapModel: MapModel.demo)
        let viewController = getViewController(presenter: presenter)

        presenter.viewController = viewController
        router.viewController = viewController

        return ViperModule(viewController: viewController, router: router)
    }

    private func getViewController(presenter: IImageDetectionPresenter) -> ImageDetectionViewController {
        let viewController: ImageDetectionViewController
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageDetectionViewController") as? ImageDetectionViewController {
            viewController = controller
            viewController.output = presenter
            viewController.presenter = presenter
        } else {
            viewController = ImageDetectionViewController(presenter: presenter)
        }
        return viewController
    }
}
