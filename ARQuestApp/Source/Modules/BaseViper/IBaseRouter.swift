//
//  Created by Andrey Vasilev on 10/01/2019.
//  Copyright © 2019 Andrey Vasilev. All rights reserved.
//

import UIKit

protocol IBaseRouter: AnyObject {
    func dismiss(animated: Bool)
    func presentAlert(_ alert: UIAlertController)
    func present(_ controller: UIViewController, animated: Bool)
    func pop()
}
