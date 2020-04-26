//
//  Created by Andrey Vasilev on 01/05/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

final class GiftScannerAssembly {

    private let modulesFactory: IModulesFactory

    init(modulesFactory: IModulesFactory) {
        self.modulesFactory = modulesFactory
    }

    func build() -> ViperModule<ImageDetectionViewController, IGiftScannerRouter> {
        let router = GiftScannerRouter()
        let interactor = GiftScannerInteractor()
        let presenter = GiftScannerPresenter(interactor: interactor, router: router)
        let viewController = getViewController(presenter: presenter)

        router.viewController = viewController

        return ViperModule(viewController: viewController, router: router)
    }

    private func getViewController(presenter: IGiftScannerPresenter) -> ImageDetectionViewController {
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
