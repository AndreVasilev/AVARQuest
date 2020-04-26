//
//  MapItemCell.swift
//  ARQuestApp
//
//  Created by Andrey Vasilev on 26.04.2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

class MapItemCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var markImageView: UIImageView!
}

extension MapItemCell {

    func setMarked(_ isMarked: Bool) {
        markImageView.isHidden = !isMarked
        if isMarked {
            startAnimation()
        }
    }

    func startAnimation(_ transform: CGAffineTransform = .identity) {
        guard !markImageView.isHidden else { return }
        UIView.animate(withDuration: 2, animations: {
            self.markImageView.transform = transform
        }, completion: { _ in
            let t = transform == .identity ? CGAffineTransform(scaleX: 1.2, y: 1.2) : .identity
            self.startAnimation(t)
        })
    }
}
