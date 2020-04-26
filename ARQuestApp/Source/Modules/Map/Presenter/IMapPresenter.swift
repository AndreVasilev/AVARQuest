//
//  Created by Andrey Vasilev on 26/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import Foundation

protocol IMapPresenter: ILifeCycleOutput {

    var items: [[MapItem]] { get }
    var isCompleted: Bool { get }
    var itemsPerRow: Int { get }

    func didSelectItem(at indexPath: IndexPath)
}
