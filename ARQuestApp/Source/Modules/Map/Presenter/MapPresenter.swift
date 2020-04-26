//
//  Created by Andrey Vasilev on 26/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import Foundation

final class MapPresenter {

    let interactor: IMapInteractor
    let router: IMapRouter

    let itemsPerRow = 4
    let mapModel: MapModel
    lazy var isCompleted: Bool = {
        return mapModel.isCompleted
    }()

    init(interactor: IMapInteractor, router: IMapRouter, mapModel: MapModel) {
        self.interactor = interactor
        self.router = router
        self.mapModel = mapModel
    }
}

extension MapPresenter: IMapPresenter {

    var items: [[MapItem]] {
        return mapModel.items
    }

    func didSelectItem(at indexPath: IndexPath) {
        if isCompleted,
            items[indexPath.section][indexPath.row].isMarked {
            router.presentGiftScanner()
        }
    }
}
