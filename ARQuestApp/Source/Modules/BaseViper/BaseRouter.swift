//
//  Created by Andrey Vasilev on 10/01/2019.
//  Copyright © 2019 Andrey Vasilev. All rights reserved.
//

import UIKit

class BaseRouter: NSObject {
    weak var viewController: UIViewController?
}

extension BaseRouter: IBaseRouter {

    func dismiss(animated: Bool) {
        viewController?.dismiss(animated: animated)
    }

    func presentAlert(_ alert: UIAlertController) {
        viewController?.present(alert, animated: true, completion: nil)
    }

    func present(_ controller: UIViewController, animated: Bool) {
        viewController?.present(controller, animated: animated, completion: nil)
    }

    func pop() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
