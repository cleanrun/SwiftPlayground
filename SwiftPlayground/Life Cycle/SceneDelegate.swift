//
//  SceneDelegate.swift
//  SwiftPlayground
//
//  Created by Marchell on 13/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        //guard let _ = (scene as? UIWindowScene) else { return }
        let vc = TVAnimationVC()
        window?.rootViewController = vc
        //window?.makeKeyAndVisible()
        showPinAfterLaunch(with: window)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        showPinAfterForeground()
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    // MARK: - Custom Functions
    
    private func showPinAfterForeground() {
        let pinVC = PinVC()
        let currentVC = window?.currentViewController()
        pinVC.vcPresent = currentVC
        pinVC.modalPresentationStyle = .overCurrentContext
        pinVC.modalTransitionStyle = .crossDissolve
        currentVC?.present(pinVC, animated: false, completion: nil)
    }
    
    private func showPinAfterLaunch(with window: UIWindow?) {
        let vc = PinVC()
        vc.vcPresent = window?.rootViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        let launch = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()!
        launch.view.frame = vc.view.bounds
        launch.view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        window?.makeKeyAndVisible()
        window?.addSubview(launch.view)
        
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                window?.rootViewController?.present(vc, animated: true) {
                    UIView.animate(withDuration: 0.5, animations: {
                        launch.view.alpha = 0
                    }, completion: { _ in
                        launch.view.removeFromSuperview()
                    })
                }
            }
        }
    }

}

