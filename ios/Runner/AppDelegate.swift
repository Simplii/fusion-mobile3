import UIKit
   import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, PKPushRegistryDelegate{
    
    var callProvider: CXProvider;
    var callManager: CallManager

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let config = CXProviderConfiguration(localizedName: "VoIP Service")
    config.supportsVideo = true
    config.supportedHandleTypes = [.phoneNumber]
    config.maximumCallsPerCallGroup = 1

    // Create the provider and attach the custom delegate object
    // used by the app to respond to updates.
    callProvider = CXProvider(configuration: config)
    callProvider?.setDelegate(callManager, queue: nil)
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func pushRegistry(_ registry: PKPushRegistry,
                      didReceiveIncomingPushWith payload: PKPushPayload,
                      for type: PKPushType, completion: @escaping () -> Void) {
        print("didrecpush", payload)
        if let uuidString = payload.dictionaryPayload["uuid"] as? String,
            let identifier = payload.dictionaryPayload["caller_name"] as? String,
            let uuid = UUID(uuidString: uuidString)
        {
            let update = CXCallUpdate()
            update.callerIdentifier = identifier
            update.hasVideo = false
            update.supportsDTMF = true
            update.remoteHandle = payload.dictionaryPayload["caller_id"]

            provider.reportNewIncomingCall(with: uuid, update: update) { error in
            }
        }
    }
}
