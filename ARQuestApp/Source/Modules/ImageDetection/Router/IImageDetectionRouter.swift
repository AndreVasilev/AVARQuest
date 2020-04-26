//
//  Created by Andrey Vasilev on 22/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import Foundation

protocol IImageDetectionRouter: IBaseRouter {

    func presentCongrats()
    func presentMap(_ model: MapModel)
}
