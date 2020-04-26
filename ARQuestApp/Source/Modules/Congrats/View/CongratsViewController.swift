//
//  Created by Andrey Vasilev on 26/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

final class CongratsViewController: BaseViewController {

    @IBOutlet weak var fw0ImageView: UIImageView!
    @IBOutlet weak var fw1ImageView: UIImageView!
    @IBOutlet weak var fw2ImageView: UIImageView!

    var presenter: ICongratsPresenter!

    init(presenter: ICongratsPresenter) {
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fw0ImageView.startAnimating()
        fw1ImageView.startAnimating()
        fw2ImageView.startAnimating()
    }
}

private extension CongratsViewController {

    func configure() {

        for item in [(fw0ImageView, 18), (fw1ImageView, 8), (fw2ImageView, 10)].enumerated() {
            var images = [UIImage?]()
            for i in 1...item.element.1 {
                images.append(UIImage(named: "fireworks-\(item.offset)-\(i) (перетянутый)"))
            }
            let imegeView = item.element.0
            imegeView?.animationImages = images.compactMap({ $0 })
            imegeView?.animationDuration = presenter.duration
            imegeView?.animationRepeatCount = presenter.repeatCount
        }
    }
}

extension CongratsViewController: ICongratsView {

}
