//
//  AppDelegate.swift
//  ARQuestApp
//
//  Created by Andrey Vasilev on 22.04.2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureInitialController()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

private extension AppDelegate {

    func configureInitialController() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }

    var rootViewController: UIViewController {
        let controller: UIViewController
        let modulesFactory = ModulesFactory()
        if let isDateValid = NotificationService.shared.isDateValid {
            if isDateValid {
                controller = modulesFactory.imageDetectionAssembly.build().viewController
            } else {
                controller = modulesFactory.awaitAssembly.build().viewController
            }
        } else {
            controller = modulesFactory.setupAssembly.build().viewController
        }
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }
}
