//
//  Created by Andrey Vasilev on 22/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

final class ImageDetectionPresenter {

    let interactor: IImageDetectionInteractor
    let router: IImageDetectionRouter
    weak var viewController: IImageDetectionView?

    let mapModel: MapModel

    init(interactor: IImageDetectionInteractor, router: IImageDetectionRouter, mapModel: MapModel) {
        self.interactor = interactor
        self.router = router
        self.mapModel = mapModel
    }

    func viewDidLoad() {

    }
}

extension ImageDetectionPresenter: IImageDetectionPresenter {

    var resourceGroupName: String {
        return mapModel.arResourcesGroup
    }

    func didTrackImage(referenceName: String) -> String? {
        for row in mapModel.items {
            if let item = row.first(where: { $0.referenceImageName == referenceName }) {
                didTrackImage(item: item)
                return item.imageName
            }
        }
        return nil
    }

    func presentMap() {
        router.presentMap(mapModel)
    }
}

private extension ImageDetectionPresenter {

    func didTrackImage(item: MapItem) {
        item.isHidden = false
        router.presentCongrats()
        viewController?.mapButton.isHidden = false

        if mapModel.isCompleted {
            startAnimation()
        }
    }

    func startAnimation(_ transform: CGAffineTransform = .identity) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.12, initialSpringVelocity: 0.2, options: .allowUserInteraction, animations: {
            self.viewController?.mapButton.transform = transform
        }, completion: { _ in
            let t = transform == .identity ? CGAffineTransform(scaleX: 1.1, y: 1.1) : .identity
            self.startAnimation(t)
        })
    }
}
