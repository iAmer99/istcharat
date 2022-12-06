import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    weak var screen : UIView? = nil
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let secureChannel = FlutterMethodChannel(name: "secureIOSChannel", binaryMessenger: controller.binaryMessenger)
      secureChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          guard call.method == "secureScreen" else{
              result(FlutterMethodNotImplemented)
              return
          }
          self.window.makeSecure()
          NotificationCenter.default.addObserver(self, selector: #selector(self.preventScreenRecording), name: UIScreen.capturedDidChangeNotification, object: nil)
      })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
       override func applicationWillResignActive(
        _ application: UIApplication
      ) {
        self.window.isHidden = true;
      }
      override func applicationDidBecomeActive(
        _ application: UIApplication
      ) {
        self.window.isHidden = false;
      }
    
    @objc func preventScreenRecording() {
        let isCaptured = UIScreen.main.isCaptured
        print("isCaptured: \(isCaptured)")
        if isCaptured {
            blurScreen()
        }
        else {
            removeBlurScreen()
        }
    }

    func blurScreen(style: UIBlurEffect.Style = UIBlurEffect.Style.regular) {
        screen = UIScreen.main.snapshotView(afterScreenUpdates: false)
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        screen?.addSubview(blurBackground)
        blurBackground.frame = (screen?.frame)!
        window?.addSubview(screen!)
    }

    func removeBlurScreen() {
        screen?.removeFromSuperview()
    }
}

extension UIWindow {
   func makeSecure() {
    let field = UITextField()
    field.isSecureTextEntry = true
    self.addSubview(field)
    field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.layer.superlayer?.addSublayer(field.layer)
    field.layer.sublayers?.first?.addSublayer(self.layer)
  }
}
