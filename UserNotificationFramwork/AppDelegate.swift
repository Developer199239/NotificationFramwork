//
//  AppDelegate.swift
//  UserNotificationFramwork
//
//  Created by Zeeshan Khan on 4/15/18.
//  Copyright © 2018 Murtuza. All rights reserved.
//

//---- this is for location reminder ----
//https://github.com/zzheads/ProximityReminders

//----- this is for understanding----
//https://medium.com/@prianka.kariat/ios-10-notifications-with-attachments-and-much-more-169a7405ddaf

//----- this best for coding----
//https://code.tutsplus.com/tutorials/an-introduction-to-the-usernotifications-framework--cms-27250


import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //----- set delegate---
        UNUserNotificationCenter.current().delegate = self
        //---- custom action notifications----
        let replayAction = UNTextInputNotificationAction(identifier: "com.surroundapps.replay", title: "Replay", options: [], textInputButtonTitle: "Send", textInputPlaceholder: "Type your message")
        let deleteAction = UNNotificationAction(identifier: "com.surroundapps.delete", title: "Delete", options: [.authenticationRequired,.destructive])
        let category = UNNotificationCategory(identifier: "com.surroundapps.message", actions: [replayAction,deleteAction], intentIdentifiers: [], options: [])
        //--- authorization request --
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([category])
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        center.requestAuthorization(options: options, completionHandler: {
            (granted,error)in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                // add flag for notificaiton not authorization
                print("error")
            }
        })
        
        //----- this is for medium sample code ---
//        requestPermissionWithCompletionHandler(completion: nil)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //MARK: usernotification delegat
    //---- when app foreground first time come here
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("here")
        completionHandler([.alert, .sound])
    }
    
    //This method is called when the user interacts with a notification for your app in any way, including dismissing it or opening your app from it.
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let actionIndentifier = response.actionIdentifier
        switch actionIndentifier {
        case UNNotificationDismissActionIdentifier: // Notification was dismissed by user
            completionHandler()
        case UNNotificationDefaultActionIdentifier: // app was opened from notificaiton
            completionHandler()
        case "com.surroundapps.replay":
            if let textResponse = response as? UNTextInputNotificationResponse {
                let replay = textResponse.userText
                print(replay)
                completionHandler()
            }
        case "com.surroundapps.delete":
            completionHandler()
        default:
            completionHandler()
        }
    }
    
    
    private func requestPermissionWithCompletionHandler(completion:((Bool) ->(Void))?){
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted,error)in
            guard error == nil else {
                completion?(false)
                return
            }
            
            if granted {
                UNUserNotificationCenter.current().delegate = self
                self.setNotificationCategories()
                
            }
        })
    }
    
    private func setNotificationCategories(){
        let likeAction = UNNotificationAction(identifier: "like", title: "Like", options: [])
        let replayAction = UNNotificationAction(identifier: "replay", title: "Replay", options: [])
        let archiveAction = UNNotificationAction(identifier: "archive", title: "Archive", options: [])
        let ccomentAction = UNTextInputNotificationAction(identifier: "comment", title: "comment", options: [])
        
        
        let localCat = UNNotificationCategory(identifier: "category", actions: [likeAction], intentIdentifiers: [], options: [])
        let customCat = UNNotificationCategory(identifier: "recipe", actions: [likeAction,ccomentAction], intentIdentifiers: [], options: [])
        let emailCat = UNNotificationCategory(identifier: "email", actions: [replayAction,archiveAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([localCat,customCat,emailCat])
        
    }
    
}

