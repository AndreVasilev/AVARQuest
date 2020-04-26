//
//  Created by Andrey Vasilev on 10/01/2019.
//  Copyright © 2019 Andrey Vasilev. All rights reserved.
//

import Foundation

protocol ILifeCycleOutput: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewDidDisappear()
}

//default implementation
extension ILifeCycleOutput {
    func viewDidLoad() {
        //do nothing
    }

    func viewWillAppear() {
        //do nothing
    }

    func viewDidAppear() {
        //do nothing
    }

    func viewDidDisappear() {
        //do nothing
    }
}
