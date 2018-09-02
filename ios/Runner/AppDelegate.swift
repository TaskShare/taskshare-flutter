import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {

    // TODO: Configurationによって参照するファイル名を切り替え
//    let path = Bundle.main.path(forResource: "GoogleService-Info2", ofType: "plist")!
//    FirebaseApp.configure(options: FirebaseOptions(contentsOfFile: path)!)
//    print("projectID: \(FirebaseApp.app()?.options.projectID ?? "")");

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
