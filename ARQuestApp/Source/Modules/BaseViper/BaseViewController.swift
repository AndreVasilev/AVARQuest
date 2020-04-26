//
//  Created by Andrey Vasilev on 10/01/2019.
//  Copyright © 2019 Andrey Vasilev. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var output: ILifeCycleOutput!
    private(set) var tabBarShadowView: UIView?

    init(output: ILifeCycleOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, output: ILifeCycleOutput) {
        self.output = output
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit { print("💥 \(self)") }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        output.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        output.viewDidDisappear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }
}

private extension BaseViewController {

    func configure() {

    }
}
