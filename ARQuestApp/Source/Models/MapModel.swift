//
//  MapModel.swift
//  ARQuestApp
//
//  Created by Andrey Vasilev on 26.04.2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import Foundation

class MapModel {

    let arResourcesGroup: String
    let items: [[MapItem]]

    init(group: String, items: [[MapItem]]) {
        self.arResourcesGroup = group
        self.items = items
    }
}

extension MapModel {

    static var demo: MapModel {
        let items = [[MapItem(indexPath: IndexPath(item: 0, section: 0), image: "row-1-col-1", referenceImage: "iMac 21.5-inch", isMarked: true),
                      MapItem(indexPath: IndexPath(item: 1, section: 0), image: "row-1-col-2", referenceImage: "iMac 27-inch"),
                      MapItem(indexPath: IndexPath(item: 2, section: 0), image: "row-1-col-3", referenceImage: "iPad 9.7-inch"),
                      MapItem(indexPath: IndexPath(item: 3, section: 0), image: "row-1-col-4", referenceImage: "iPad Pro 10.5-inch"),
                      MapItem(indexPath: IndexPath(item: 4, section: 0), image: "row-2-col-1", referenceImage: "iPad Pro 12.9-inch"),
                      MapItem(indexPath: IndexPath(item: 5, section: 0), image: "row-2-col-2", referenceImage: "iPhone 4.7-inch"),
                      MapItem(indexPath: IndexPath(item: 6, section: 0), image: "row-2-col-3", referenceImage: "iPhone 5.5-inch"),
                      MapItem(indexPath: IndexPath(item: 7, section: 0), image: "row-2-col-4", referenceImage: "iPhone X"),
                      MapItem(indexPath: IndexPath(item: 8, section: 0), image: "row-3-col-1", referenceImage: "iPhone 4-inch"),
                      MapItem(indexPath: IndexPath(item: 9, section: 0), image: "row-3-col-2", referenceImage: "MacBook 12-inch"),
                      MapItem(indexPath: IndexPath(item: 10, section: 0), image: "row-3-col-3", referenceImage: "MacBook Pro 13-inch"),
                      MapItem(indexPath: IndexPath(item: 11, section: 0), image: "row-3-col-4", referenceImage: "MacBook Pro 15-inch")]]
        return MapModel(group: "AR Resources Demo", items: items)
    }

    static var template: MapModel {
        let items = [[MapItem]]()
        return MapModel(group: "AR Resources", items: items)
    }

    var isCompleted: Bool {
        for row in items {
            if row.contains(where: { $0.isHidden }) {
                return false
            }
        }
        return true
    }
}
