//
//  Created by Andrey Vasilev on 22/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

final class ImageDetectionRouter: BaseRouter {

    let congratsAssembly: CongratsAssembly
    let mapAssembly: MapAssembly

    init(congratsAssembly: CongratsAssembly, mapAssembly: MapAssembly) {
        self.congratsAssembly = congratsAssembly
        self.mapAssembly = mapAssembly
    }
}

extension ImageDetectionRouter: IImageDetectionRouter {

    func presentCongrats() {
        let controller = congratsAssembly.build().viewController
        controller.modalPresentationStyle = .overCurrentContext
        viewController?.present(controller, animated: false, completion: nil)
    }

    func presentMap(_ model: MapModel) {
        let controller = mapAssembly.build(model: model).viewController
        if model.isCompleted {
            controller.modalPresentationStyle = .fullScreen
        }
        viewController?.present(controller, animated: true, completion: nil)
    }
}
