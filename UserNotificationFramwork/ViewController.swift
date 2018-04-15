//
//  ViewController.swift
//  UserNotificationFramwork
//
//  Created by Zeeshan Khan on 4/15/18.
//  Copyright © 2018 Murtuza. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func postNotificationAction(_ sender: Any) {
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "com.surroundapps.message"
        content.title = "Notificaiton Title"
        content.subtitle = "Notification Subtitle"
        content.body = "Some notification body information to be displayed."
        content.badge = 1
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "LocaitonNotificaiton", content: content, trigger: timeTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            if error != nil {
                print("error")
            } else {
                print("success")
            }
        }
        )
        
    }
    
}

