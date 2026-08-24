import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let productsVC = ProductsViewControllerBuilder.build(
                   categoryId: "7f2fb644-4649-459c-8faf-3870577b65f6",
                   categoryName: "عصاير",
                   area: "الظاهر",
                   city: "القاهره"
               )

        let navController = UINavigationController(rootViewController: productsVC)
        window?.rootViewController = navController
        
        window?.makeKeyAndVisible()
    }
}
