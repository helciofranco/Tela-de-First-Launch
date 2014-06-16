//
//  AppDelegate.swift
//  Tela de Tutorial
//
//  Created by Hélcio Franco on 09/06/14.
//  Copyright (c) 2014 Hélcio Franco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // Nome dos Fundos - Coloque aqui o nome das imagens que você importou para o fundo
        let fundosArray: String[] = ["bg1.png", "bg2.png", "bg3.png", "bg4.png"]
        
        // Informações das páginas
        let paginasArray: (String, String, String)[] = [
            ("icon1.png", "Dinheiro", "Aqui você explica sobre essa função do seu aplicativo e algumas coisas a mais.\n Seja legal."),
            ("icon2.png", "Mapas", "Aqui você explica sobre essa função do seu aplicativo e algumas coisas a mais.\n Seja legal."),
            ("icon3.png", "Tesouro", "Aqui você explica sobre essa função do seu aplicativo e algumas coisas a mais.\n Seja legal."),
            ("icon4.png", "Mundo", "Aqui você explica sobre essa função do seu aplicativo e algumas coisas a mais.\n Seja legal.")
        ]
        
        // Define minha tela de tutorial como a Root View Controller da aplicação
        let telaTutorial: TutorialViewController = TutorialViewController(fundos: fundosArray, paginas: paginasArray)
        self.window!.rootViewController = telaTutorial

        /*
        -- detectar se a aplicação já foi utilizada alguma vez utilizando o NSUserDefaults booleano. :)
        */
        
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

