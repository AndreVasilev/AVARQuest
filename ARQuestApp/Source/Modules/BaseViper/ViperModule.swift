//
//  Created by Andrey Vasilev on 10/01/2019.
//  Copyright © 2019 Andrey Vasilev. All rights reserved.
//

import UIKit

final class ViperModule<ViewController: UIViewController, Router> {
    let viewController: ViewController
    let router: Router

    init(viewController: ViewController, router: Router) {
        self.viewController = viewController
        self.router = router
    }
}
