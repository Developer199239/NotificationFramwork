//
//  MediumViewController.swift
//  UserNotificationFramwork
//
//  Created by Zeeshan Khan on 4/15/18.
//  Copyright © 2018 Murtuza. All rights reserved.
//

import UIKit
import UserNotifications

class MediumViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sendWithActtachmentAction(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Local Notification"
        content.subtitle = "Good morning"
        
        
        content.body = "This is notificaiton body"
        content.categoryIdentifier = "local"
        
         let url = Bundle.main.url(forResource: "img", withExtension: "jpg")
        
        let attachment = try! UNNotificationAttachment(identifier: "image", url: url!, options: [:])
        content.attachments = [attachment]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {(error) in
            print("error")
        })
        
    }
    
    @IBAction func removeAction(_ sender: Any) {
    }
    
}
