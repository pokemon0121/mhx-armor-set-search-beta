//
//  AppDelegate.swift
//  mhxdb-draft
//
//  Created by Gardevoir on 10/21/16.
//  Copyright © 2016 Yimu Gao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var dbFilePath: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if self.initializeDb() {
            NSLog("Successful db copy")
        }
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

    
    // MARK: - FMDB
    
    let DATABASE_RESOURCE_NAME = "mhx"
    let DATABASE_RESOURCE_TYPE = "sqlite"
    let DATABASE_FILE_NAME = "mhx.db"
    
    func initializeDb() -> Bool {
        let documentFolderPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let dbfile = "/" + DATABASE_FILE_NAME;
        
        self.dbFilePath = documentFolderPath + dbfile
        
        let filemanager = FileManager.default
        if (!filemanager.fileExists(atPath: dbFilePath! as String) ) {
            
            let backupDbPath = Bundle.main.path(forResource: DATABASE_RESOURCE_NAME, ofType: DATABASE_RESOURCE_TYPE)
            
            if (backupDbPath == nil) {
                return false
            } else {
                do {
                    try filemanager.copyItem(atPath: backupDbPath!, toPath:dbFilePath!)
                }
                catch let error as NSError {
                    print("Something went wrong: \(error)")
                }
            }
            
        }
        return true
    
    }

}

