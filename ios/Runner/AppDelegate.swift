import UIKit
import Intents
import CallKit
import Flutter
import PushKit
import AVFoundation
import linphonesw
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, PKPushRegistryDelegate{
    
    var providerDelegate: ProviderDelegate!
    var callkitChannel: FlutterMethodChannel!

    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        print("opened from url")
        print(url)
        return true
    }
    
    override func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    {
     print("startintent")
        print(userActivity.activityType)
        if (userActivity.activityType == "INStartAudioCallIntent" && userActivity.startCallHandle != nil) {
            print("startcallintent")
            print(userActivity.startCallHandle)
            var matchNonNumeric = "[^0-9]+"
            var address = "sip:" + userActivity.startCallHandle!.replacingOccurrences(of: matchNonNumeric, with: "", options: [.regularExpression ]) + "@" + providerDelegate.domain
            providerDelegate.outgoingCall(
                address: address)
        }
        
        return true
    }
    
    @available(iOS 13.0, *)
    func handle(startWorkout intent: INStartCallIntent,
                completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
        print("hadle instartcallintent")
        print(intent.contacts)
    }

    func handle(startWorkout intent: INStartAudioCallIntent,
                completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
        print("hadle instartcallaudiointent")
        print(intent.identifier)
        print(intent)
    }
    
    func application(
        _ application: UIApplication,
        handlerFor intent: INIntent) {
            print("startedfromintent")
            print(intent)
            print(intent.identifier)
            print(intent.classForCoder)
            print(intent.intentDescription)
    }
    
    override func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let mainQueue = DispatchQueue.main
        let voipRegistry: PKPushRegistry = PKPushRegistry(queue: mainQueue)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
        
        if (voipRegistry.pushToken(for: .voIP) != nil) {
            let deviceToken: String = voipRegistry.pushToken(for: .voIP)!.map { String(format: "%02x", $0 as CVarArg) }.joined();
            
            if (callkitChannel != nil) {
                callkitChannel.invokeMethod("setPushToken", arguments: [deviceToken]);
            }
        }
    }
    
    override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        print("providerpush app delegate starting")
        
        setupCallkitFlutterLink()
        providerDelegate = ProviderDelegate(channel: callkitChannel)
        
        FirebaseApp.configure() //add this before the code below

        GeneratedPluginRegistrant.register(with: self)
        let mainQueue = DispatchQueue.main
        let voipRegistry: PKPushRegistry = PKPushRegistry(queue: mainQueue)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
        
        if (voipRegistry.pushToken(for: .voIP) != nil) {
            let deviceToken: String = voipRegistry.pushToken(for: .voIP)!.map { String(format: "%02x", $0 as CVarArg) }.joined();
            
            if (callkitChannel != nil) {
                callkitChannel.invokeMethod("setPushToken", arguments: [deviceToken]);
            }
        }
        
        UNUserNotificationCenter.current()
                    .requestAuthorization(options: [.alert, .sound, .badge]) {
                        [weak self] granted, error in
                        guard let _ = self else {return}
                        guard granted else { return }
                        self?.getNotificationSettings() }
        
        
/*        do {
            Client()
          Client.shared = try Client(dsn: "https://6ac1552d08264600966c0ec85516dbd9@o68456.ingest.sentry.io/146230")
                try Client.shared?.startCrashHandler()
        } catch let error {
            print("\(error)")
        }*/
        
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        print("opened from scene")
        print(scene)
        print(connectionOptions)
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        print("did become active");
        let session = AVAudioSession.sharedInstance()
        do {
            // 1) Configure your audio session category, options, and mode
            // 2) Activate your audio session to enable your custom configuration
//            try session.setMode(.voiceChat)
  //          try session.setCategory(.playAndRecord)
            //try session.setPrefersNoInterruptionsFromSystemAlerts(true)
            print(session.category)
            print(session.mode)
            try session.setActive(true)
            print("did set audiosessionactive")
            if (callkitChannel != nil) {
                callkitChannel.invokeMethod("setAudioSessionActive", arguments: [true])
            }
        } catch let error as NSError {
            if (callkitChannel != nil) {
                callkitChannel.invokeMethod("setAudioSessionActive", arguments: [false])
            }
            print("Unable to activate audiosession:  \(error.localizedDescription)")
        }
    }
    
    func setupCallkitFlutterLink() {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        callkitChannel = FlutterMethodChannel(
            name: "net.fusioncomm.ios/callkit",
            binaryMessenger: controller.binaryMessenger)
    }

    
        
        func getNotificationSettings() {
            if #available(iOS 10.0, *) {
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    UNUserNotificationCenter.current().delegate = self
                    guard settings.authorizationStatus == .authorized else { return }
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            } else {
                let settings = UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(settings)
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    
    func pushRegistry(_ registry: PKPushRegistry,
            didUpdate pushCredentials: PKPushCredentials,
            for type: PKPushType) {
        print("didpudategreds providerpush")
        print(pushCredentials)
        let deviceToken: String = pushCredentials.token.map { String(format: "%02x", $0) }.joined();

        if (callkitChannel != nil) {
            callkitChannel.invokeMethod("setPushToken", arguments: [deviceToken]);
        }
    }
    
    func pushRegistry(_ registry: PKPushRegistry,
                      didInvalidatePushTokenFor type: PKPushType) {
        print("didinvalidate providerpush")
        print(type)
    }
    
    func pushRegistry(_ registry: PKPushRegistry,
                        didReceiveIncomingPushWith payload: PKPushPayload,
                        for type: PKPushType, completion: @escaping () -> Void) {
        print("didrecproviderpush callkit", payload, payload.dictionaryPayload)
    

        if let uuidString = payload.dictionaryPayload["uuid"] as? String,
          let identifier = payload.dictionaryPayload["caller_name"] as? String,
          let handle = payload.dictionaryPayload["caller_id"] as? String,
          let uuid = UUID(uuidString: uuidString) {
        
        providerDelegate.reportNewIncomingCall(
              uuid: uuid,
              handle: handle,
              callerName: identifier,
            hasVideo: false) { (e: Error?) in
            print("completion")

        };
            
      } else if let identifier = payload.dictionaryPayload["caller_name"] as? String,
                let handle = payload.dictionaryPayload["caller_id"] as? String{
        let uuid = UUID()
              providerDelegate.reportNewIncomingCall(
                    uuid: uuid,
                    handle: handle,
                    callerName: identifier,
                  hasVideo: false) { (e: Error?) in
                  print("completion2")
    
              };
                  
            }
    else {
        providerDelegate.reportNewIncomingCall(uuid: UUID(), handle: "Unknown", callerName: "Unknown") {(e: Error?) in print("completion3"); };
        }
    }
}


@available(iOS 10.0, *)
protocol SupportedStartCallIntent {
    var contacts: [INPerson]? { get }
}

@available(iOS 10.0, *)
extension INStartAudioCallIntent: SupportedStartCallIntent {}

@available(iOS 10.0, *)
extension NSUserActivity {

    var startCallHandle: String? {
        guard let startCallIntent = interaction?.intent as? SupportedStartCallIntent else {
            return nil
        }
        return startCallIntent.contacts?.first?.personHandle?.value
    }

}
