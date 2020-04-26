//
//  MapItem.swift
//  ARQuestApp
//
//  Created by Andrey Vasilev on 26.04.2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import Foundation

class MapItem {

    let indexPath: IndexPath
    let imageName: String
    let referenceImageName: String
    let isMarked: Bool
    var isHidden: Bool = true

    init(indexPath: IndexPath, image name: String, referenceImage referenceName: String, isMarked: Bool = false) {
        self.indexPath = indexPath
        self.imageName = name
        self.referenceImageName = referenceName
        self.isMarked = isMarked
    }
}
