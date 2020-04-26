//
//  Created by Andrey Vasilev on 26/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

final class MapViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var presenter: IMapPresenter!

    init(presenter: IMapPresenter) {
        self.presenter = presenter
        super.init(output: presenter)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension MapViewController {

    func configure() {
        view.backgroundColor = .black
        makeConstraints()
    }

    func makeConstraints() {

    }
}

extension MapViewController: IMapView {

}

extension MapViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.items.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.items[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapItemCell", for: indexPath)
        if let itemCell = cell as? MapItemCell {
            let item = presenter.items[indexPath.section][indexPath.row]
            itemCell.imageView.image = item.isHidden ? nil : UIImage(named: item.imageName)
        }
        return cell
    }
}

extension MapViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if presenter.isCompleted,
            let itemCell = cell as? MapItemCell {
            let isMarked = presenter.items[indexPath.section][indexPath.row].isMarked
            itemCell.setMarked(isMarked)
        }
    }
}

extension MapViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}
