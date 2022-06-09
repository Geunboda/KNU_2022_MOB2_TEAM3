//
//  MakeAlarm.swift
//  SmartScheduler
//
//  Created by Bogeun Kim on 2022/06/09.
//

import UIKit
import UserNotifications

class MakeAlarm: UIViewController {
    let userNotificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        userNotificationCenter.delegate = self
        requestAuthorization()
    }
   
    func requestAuthorization() {
        let options = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        userNotificationCenter.requestAuthorization(options: options) { success, error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func sendNotification(title: String, body: String, dateComponents: DateComponents) {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = title
        notiContent.body = body
        notiContent.sound = UNNotificationSound(named: UNNotificationSoundName("alarm.caf"))

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "LocalNoti", content: notiContent, trigger: trigger)

        userNotificationCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}

extension MakeAlarm: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .badge, .sound, .banner])
        //        completionHandler([.alert, .badge, .sound])
    }
}
