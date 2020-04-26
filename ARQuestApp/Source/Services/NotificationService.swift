//
//  NotificationService.swift
//  ARQuestApp
//
//  Created by Andrey Vasilev on 22.04.2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationService: NSObject {

    static let shared = NotificationService()

    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    private let notificationDateKey = "notificationDateKey"

    var isDateValid: Bool? {
        guard let date = notificationDate else { return nil }
        return Date().timeIntervalSince(date) >= 0
    }

    var notificationDate: Date? {
//        return Date(timeIntervalSinceNow: -1000)
//        didAddNotification(on: nil)
        return UserDefaults.standard.object(forKey: notificationDateKey) as? Date
    }

    func previewNotification(title: String, body: String) {
        addNotification(title: title, body: body, date: Date(timeIntervalSinceNow: 1))
    }

    func addNotification(title: String, body: String, date: Date) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [unowned self] (granted, error) in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alert.wav"))
                content.badge = 1
                let timeInterval = date.timeIntervalSince(Date()) + 1
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
                let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                self.didAddNotification(on: date)
            }
        }
    }

    private func didAddNotification(on date: Date?) {
        UserDefaults.standard.set(date, forKey: notificationDateKey)
        UserDefaults.standard.synchronize()
    }
}

extension NotificationService: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
