//
//  AppDelegate.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        configJg(launchOptions: launchOptions)
        
        application.applicationIconBadgeNumber = 0;
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }

    // 配置极光
    private func configJg(launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        let entity = JPUSHRegisterEntity()
        entity.types = Int(JPAuthorizationOptions.alert.rawValue)|Int(JPAuthorizationOptions.badge.rawValue)|Int(JPAuthorizationOptions.sound.rawValue)|Int(JPAuthorizationOptions.providesAppNotificationSettings.rawValue)
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        JPUSHService.setup(withOption: launchOptions, appKey: "8142d27abeec4682ba00ecc0", channel: "App Store", apsForProduction: false)
        JPUSHService.resetBadge() // 清空JPUSH服务端储存的badge值为0
    }

}

extension AppDelegate: JPUSHRegisterDelegate {
    // 判断授权关系，没有用到
    func jpushNotificationAuthorization(_ status: JPAuthorizationStatus, withInfo info: [AnyHashable : Any]!) {
        print("receive notification authorization status:\(status.rawValue), info:\(String(describing: info))");
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo;
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        
        // 控制应用在前台时是否显示通知
//        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
        JPUSHService.resetBadge() // 当前台无需显示通知时，每次接受通知后重置计数
        completionHandler(0)
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo;
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler();  // 系统要求执行这个方法
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification!) {
        if ((notification != nil) && notification.request.trigger is UNPushNotificationTrigger) {
          //从通知界面直接进入应用
        }else{
          //从通知设置界面进入应用
        }
    }
}

