//
//  Created by Andrey Vasilev on 22/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

final class AwaitViewController: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!

    var presenter: IAwaitPresenter!

    init(presenter: IAwaitPresenter) {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.startAnimating()
    }
}

private extension AwaitViewController {

    func configure() {
        var images = [UIImage?]()
        for i in 0...54 {
            images.append(UIImage(named: "09b20a2135e74f85e14a34360a8cd6367FIpq0aHp3tdM8eT-\(i)"))
        }
        imageView.animationImages = images.compactMap({ $0 })
        imageView.animationDuration = 2

        makeConstraints()
    }

    func makeConstraints() {

    }
}

extension AwaitViewController: IAwaitView {

}
