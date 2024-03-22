
import AVFoundation
import AVFAudio
import CallKit
import Flutter
import linphonesw
import CommonCrypto
import CryptoKit
import Foundation

class ProviderDelegate: NSObject, CXCallObserverDelegate {
    private let controller = CXCallController()
    private let provider: CXProvider
    private let callkitChannel: FlutterMethodChannel!
    private var answeredUuids: [String: Bool] = [:]
    private let theCallObserver = CXCallObserver()
    private var needsReport: String = "";
    private let speakerTurnedOn = false;
    var mCore: Core?;
    
    var username : String = "user"
    var passwd : String = "pwd"
    var domain : String = "sip.example.org"
    var loggedIn: Bool = false
    var transportType : String = "TCP"
    var uuidCalls: [String: Call] = [:];
    
    var callMsg : String = ""
    var isCallRunning : Bool = false
    var isVideoEnabled : Bool = false
    var canChangeCamera : Bool = false
    var remoteAddress : String = "sip:calldest@sip.linphone.org"
    var isCallIncoming : Bool = false
    var isMicrophoneEnabled : Bool = false
    var isSpeakerEnabled : Bool = false
    var wasAudioInterrupted : Bool = false
    var unpausePauseState : Int = 0
    var unpausePauseUuid : String = ""

    var coreVersion: String = Core.getVersion
    
    var mAccount: Account?
    var mCoreDelegate : CoreDelegate!
    var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    var isBluetoothOn: Bool = false
    var regState: RegistrationState = RegistrationState.None
    @objc func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
                return
        }
print("audiointerruption")
        print(type.rawValue);
        switch type {
        case .began :
            wasAudioInterrupted = true
            break
        case .ended:
            break
        }
        return;
        // Switch over the interruption type.
        switch type {

        case .began:
            print("began audiosession interruption")
            callkitChannel.invokeMethod("setAudioSessionActive", arguments: [false])
            setAudioAndSpeakerPhone(speakerOn: speakerTurnedOn)
            break
            // An interruption began. Update the UI as necessary.

        case .ended:
            print("ended audiosession interruption")
           let session = AVAudioSession.sharedInstance()
            print("try to set audio active")
            do {
                print(session.category)
                print(session.mode)
               // try session.setActive(true)
                print("did set audiosessionactive")
                if (callkitChannel != nil) {
                    callkitChannel.invokeMethod("setAudioSessionActive", arguments: [true])
                }
            } catch let error as NSError {
                if (callkitChannel != nil) {
                }
                print("Unable to activate audiosession:  \(error.localizedDescription)")
            }
            guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
            let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
            print(optionsValue);print(options);
            if options.contains(.shouldResume) {
                // An interruption ended. Resume playback.
            } else {
                // An interruption ended. Don't resume playback.
            }

        default: ()
        }
    }
    
    
    public func setupLinphone() {
        LoggingService.Instance.logLevel = LogLevel.Debug
        let factory = Factory.Instance
        try! mCore = factory.createCore(configPath: "", factoryConfigPath: "", systemContext: nil)
        try! mCore?.start()
        sendDevices()
        mCore?.ipv6Enabled = false

        var mCoreDelegate = CoreDelegateStub( onCallStateChanged: { (core: Core, call: Call, state: Call.State, message: String) in
            // This function will be called each time a call state changes,
            // which includes new incoming/outgoing calls
            self.callMsg = message
            print("registrationcallstate");print(state)
            print(self.callMsg);
            print(call);
            print(call.callLog)
            print(call.remoteAddress)
            print(call.remoteParams);
            print(call.remoteContact);
            print(call.remoteUserAgent);
            print(call.remoteContact.description)
            print(call.remoteAddress!.displayName);
            var uuid: String? = self.findUuidByCall(call: call);
            if (state == .OutgoingInit) {
                // wait until .outgoingProgress to notify dart because the callid
                // doesn't seem to be available during .OutgoingInit
            } else if (state == .OutgoingProgress) {
                print("outgoing call info progress here")
                print(call.callLog!)
                print(call.callLog?.toStr())
                print(call.callLog!.callId)
                uuid = self.uuidFromString(str: call.callLog!.callId).uuidString;
                print(uuid);
                self.uuidCalls[uuid!] = call;
               self.callkitChannel.invokeMethod("lnOutgoingInit", arguments: [uuid, call.callLog?.callId, call.remoteAddressAsString])
                self.callkitChannel.invokeMethod("lnOutgoingProgress", arguments: [uuid])                // Right after outgoing init
            } else if (state == .OutgoingRinging) {
                print("outoging call info ringing here")
                print(call.callLog!)
                print(call.callLog?.toStr())
                print(call.callLog!.callId)
                self.callkitChannel.invokeMethod("lnOutgoingRinging", arguments: [uuid])                // This state will be reached upon reception of the 180 RINGING
            } else if (state == .Connected) {
                self.callkitChannel.invokeMethod("lnCallConnected", arguments: [uuid])                // When the 200 OK has been received
                var bluetoothRoutes: [AVAudioSession.Port] = [.bluetoothHFP, .carAudio, .bluetoothA2DP, .bluetoothLE]
                
                func bluetoothAudioDevice() -> AVAudioSessionPortDescription? {
                        return audioDevice(fromTypes: bluetoothRoutes)
                    }

                func audioDevice(fromTypes types: [AVAudioSession.Port]?) -> AVAudioSessionPortDescription? {
                        let routes = AVAudioSession.sharedInstance().availableInputs
                        for route in routes ?? [] {
                            if types?.contains(route.portType) ?? false {
                                return route
                            }
                        }
                        return nil
                    }
                var isBluetooth = bluetoothAudioDevice()
                if(isBluetooth != nil){
//                    self.toggleSpeaker(speakerOn: false, bluetoothOn: true)
                    self.callkitChannel.invokeMethod("lnCurrentRoute", arguments: [isBluetooth!.portName,isBluetooth!.portType])
                }
            } else if (state == .StreamsRunning) {
                print("outoging call info streamsrunning here")
                print(call.callLog!)
                print(call.callLog?.toStr())
                print(call.callLog!.callId)
                self.callkitChannel.invokeMethod("lnCallStreamsRunning", arguments: [uuid])                // This state indicates the call is active.
                // You may reach this state multiple times, for example after a pause/resume
                // or after the ICE negotiation completes
                // Wait for the call to be connected before allowing a call update
                self.isCallRunning = true
                // Only enable toggle camera button if there is more than 1 camera
                // We check if core.videoDevicesList.size > 2 because of the fake camera with static image created by our SDK (see below)e
                self.canChangeCamera = core.videoDevicesList.count > 2
            } else if (state == .Paused) {
                self.callkitChannel.invokeMethod("lnCallPaused", arguments: [uuid])                // When you put a call in pause, it will became Paused
                if (self.unpausePauseState == 2 && uuid == self.unpausePauseUuid) {
                    print("unpause2")
                    self.unpausePauseState = 0
                    self.unpausePauseUuid = ""
                    
                    let holdAction = CXSetHeldCallAction(call: UUID(uuidString: uuid!)!,
                                                         onHold: false)
                    let transaction = CXTransaction(action: holdAction)
                    self.requestTransaction(transaction)
                
                }
                
                self.canChangeCamera = false
            } else if (state == .PausedByRemote) {
                self.callkitChannel.invokeMethod("lnCallPausedByRemote", arguments: [uuid])                // When the remote end of the call pauses it, it will be PausedByRemote
            } else if (state == .Updating) {
                self.callkitChannel.invokeMethod("lnCallUpdating", arguments: [uuid])                // When we request a call update, for example when toggling video
            } else if (state == .UpdatedByRemote) {
                self.callkitChannel.invokeMethod("lnCallUpdatedByRemote", arguments: [uuid])                // When the remote requests a call update
            } else if (state == .Released) {
                self.ringingDidTimeout(uuid: uuid ?? "")
                self.callkitChannel.invokeMethod("lnCallReleased", arguments: [uuid])                // Call state will be released shortly after the End state
                self.isCallRunning = false
                self.canChangeCamera = false
                print("unpausetest")
                print(self.unpausePauseState)
                print(self.unpausePauseUuid)
                print(uuid)
                
                if (self.unpausePauseState == 1 && uuid == self.unpausePauseUuid) {
                    print("unpause1")
                    self.unpausePauseState = 2
                    
                    let holdAction = CXSetHeldCallAction(call: UUID(uuidString: uuid ?? "")!,
                                                         onHold: true)
                    let transaction = CXTransaction(action: holdAction)
                    self.requestTransaction(transaction)
                
                }
            } else if (state == .IncomingReceived) { // When a call is received
                do {
                    try uuid = self.uuidFromString(str: call.callLog!.callId).uuidString
                    
                    print(uuid)
                    self.uuidCalls[uuid!] = call;
                    print("invokingincoming")
                    self.callkitChannel.invokeMethod("lnIncomingReceived", arguments: [call.callLog?.callId, call.remoteContact, call.remoteAddressAsString, uuid, call.remoteAddress!.displayName])
                } catch {}
                self.isCallIncoming = true
                self.isCallRunning = false
                self.remoteAddress = call.remoteAddress!.asStringUriOnly()
            } else if (state == .Error) {
                self.callkitChannel.invokeMethod("lnCallError", arguments: [uuid])
            }
        },
//        onAudioDeviceChanged: { (core: Core, device: AudioDevice) in
//            print("THIS RAN onAudioDeviceChanged", device.deviceName)
////            self.callkitChannel.invokeMethod("lnAudioDeviceChanged", arguments: [device.id, device.deviceName, device.driverName, ""])
//        },
        onAudioDevicesListUpdated: { (core: Core) in
//            let devices = AVAudioSession.sharedInstance().availableInputs
            let btDevice = core.audioDevices.filter({$0.type == .Bluetooth || $0.type == .BluetoothA2DP})
            if(!btDevice.isEmpty){
                self.callkitChannel.invokeMethod("lnAudioDeviceListUpdated", arguments: [btDevice[0].id, btDevice[0].deviceName, btDevice[0].driverName])
            } else {
                self.callkitChannel.invokeMethod("lnAudioDeviceListUpdated", arguments: [])
            }
        }, onAccountRegistrationStateChanged: { (core: Core, account: Account, state: RegistrationState, message: String) in
            self.regState = state
            NSLog("New registration state is \(state) for user id \( String(describing: account.params?.identityAddress?.asString()))\n")
            
            if (state == .Ok) {
                print("registrationok");
                self.callkitChannel.invokeMethod("lnRegistrationOk", arguments: []);
                self.loggedIn = true
            } else if (state == .Cleared) {
                print("registrationcleared")
                self.callkitChannel.invokeMethod("lnRegistrationCleared", arguments: [])
                self.loggedIn = false
            }
        })
        sendDevices()
        mCore?.callkitEnabled = true
        mCore?.stunServer = "turn:services.fusioncom.co"
        mCore?.natPolicy?.turnEnabled = true
        mCore?.natPolicy?.stunServerUsername = "fuser"
        do {
            var turnAuth = try factory.createAuthInfo(
                username: "fuser", userid: "fuser", passwd: "fpassword",
                ha1: nil, realm: nil, domain: nil)
            mCore?.addAuthInfo(info: turnAuth)
        } catch {
            print("AUTHINFO for TURN not generated")
        }
        mCore?.echoLimiterEnabled = false
        mCore?.echoCancellationEnabled = false
        mCore?.natPolicy?.stunServer = "services.fusioncom.co"
        mCore?.addDelegate(delegate: mCoreDelegate)
        mCore?.remoteRingbackTone = Bundle.main.path(forResource: "outgoing", ofType: "wav") ?? ""
        mCore?.ring = Bundle.main.path(forResource: "inbound", ofType: "mp3") ?? ""
        coreVersion = Core.getVersion
        print("ringtone")
        print(mCore?.ring)
        print(mCore?.remoteRingbackTone)

        sendDevices()
    }
    
    public func registerPhone() {
        do {
            // Get the transport protocol to use.
            // TLS is strongly recommended
            // Only use UDP if you don't have the choice
            var transport : TransportType
            if (transportType == "TLS") { transport = TransportType.Tls }
            else if (transportType == "TCP") { transport = TransportType.Tcp }
            else  { transport = TransportType.Udp }
            
            // To configure a SIP account, we need an Account object and an AuthInfo object
            // The first one is how to connect to the proxy server, the second one stores the credentials
            
            // The auth info can be created from the Factory as it's only a data class
            // userID is set to null as it's the same as the username in our case
            // ha1 is set to null as we are using the clear text password. Upon first register, the hash will be computed automatically.
            // The realm will be determined automatically from the first register, as well as the algorithm
            let authInfo = try Factory.Instance.createAuthInfo(username: username, userid: "", passwd: passwd, ha1: "", realm: "", domain: domain)
            UserDefaults().set(domain, forKey: "domain")
            print("authinfo");
            print(authInfo);
            let accountParams = try mCore?.createAccountParams()
            print("accountparams");
            print(accountParams);

            let identity = try Factory.Instance.createAddress(addr: String("sip:" + username + "@" + domain))
            print(identity);
            print("identity");
            print(String("sip:"+username+"@"+domain))
            print(passwd);
            try! accountParams!.setIdentityaddress(newValue: identity)
            
            let address = try Factory.Instance.createAddress(addr: String("sip:services.fusioncom.co:5060"))
            
            try address.setTransport(newValue: transport)
            try accountParams!.setServeraddress(newValue: address)
            accountParams!.registerEnabled = true
            print("registering")
            let account = try mCore?.createAccount(params: accountParams!)
            
            mCore?.addAuthInfo(info: authInfo)
            try mCore?.addAccount(account: account!)
            mCore?.defaultAccount = account
            var defaultProxyConfig = mCore?.defaultProxyConfig
            if (defaultProxyConfig == nil) {
                defaultProxyConfig = try mCore?.createProxyConfig()
            }
            var proxyConfig = try createProxyConfig(proxyConfig: defaultProxyConfig!, aor: "sip:" + username + "@" + domain, authInfo: authInfo)
            try mCore?.addProxyConfig(config: proxyConfig)
            mCore?.defaultProxyConfig = proxyConfig
            sendDevices()
            getAppVersion()
        } catch {print("error registering");
            NSLog(error.localizedDescription) }
    }
    
    func createProxyConfig(proxyConfig: ProxyConfig, aor: String, authInfo: AuthInfo) throws -> ProxyConfig {
        let address = try mCore?.createAddress(address: aor)
        try proxyConfig.setIdentityaddress(newValue: address!)
        try proxyConfig.setServeraddr(newValue: "<sip:services.fusioncom.co:5060;transport=tcp>")
        try proxyConfig.setRoute(newValue: "<sip:services.fusioncom.co:5060;transport=tcp>")
        proxyConfig.realm = authInfo.realm
        proxyConfig.registerEnabled = true
        proxyConfig.avpfMode = .Disabled
        proxyConfig.publishEnabled = false
        proxyConfig.dialEscapePlus = false
        return proxyConfig
    }
    
    func unregister()
    {
        // Here we will disable the registration of our Account
        if let account = mCore?.defaultAccount {
            let params = account.params
            let clonedParams = params?.clone()
            clonedParams?.registerEnabled = false
            account.params = clonedParams
        }
    }
    
    func outgoingCall(address: String) {
        do {
            // As for everything we need to get the SIP URI of the remote and convert it to an Address
            let remoteAddress = try Factory.Instance.createAddress(addr: address)
            
            // We also need a CallParams object
            // Create call params expects a Call object for incoming calls, but for outgoing we must use null safely
            let params = try mCore?.createCallParams(call: nil)
            
            // We can now configure it
            // Here we ask for no encryption but we could ask for ZRTP/SRTP/DTLS
            params?.mediaEncryption = MediaEncryption.None
            // If we wanted to start the call with video directly
            //params.videoEnabled = true
            
            // Finally we start the call
            let _ = mCore?.inviteAddressWithParams(addr: remoteAddress, params: params!)
            // Call process can be followed in onCallStateChanged callback from core listener
        } catch {
            NSLog(error.localizedDescription)
        }
    }
    
    func findCallByUuid(uuid: String) -> Call? {
        return uuidCalls[uuid];
    }
    
    func findUuidByCall(call: Call) -> String? {
        for key in uuidCalls.keys {
            var compCall: Call = uuidCalls[key]!;
            if (call.callLog!.callId == compCall.callLog!.callId) {
                return key;
            }
        }
        return nil;
    }
    
    func terminateCall(uuid: String) {
        do {
            var call = uuidCalls[uuid];
            if (call == nil) {
                return;
            }
            else {
                try call!.terminate()
            }
        } catch { NSLog(error.localizedDescription) }
    }
    

    func acceptCall() {
        // IMPORTANT : Make sure you allowed the use of the microphone (see key "Privacy - Microphone usage description" in Info.plist) !
        do {
            // if we wanted, we could create a CallParams object
            // and answer using this object to make changes to the call configuration
            // (see OutgoingCall tutorial)
            try mCore?.currentCall?.accept()
        } catch { NSLog(error.localizedDescription) }
    }
    
    func muteMicrophone() {
        // The following toggles the microphone, disabling completely / enabling the sound capture
        // from the device microphone
        mCore!.micEnabled = mCore!.micEnabled
        isMicrophoneEnabled = !isMicrophoneEnabled
    }
    
    func toggleSpeaker(speakerOn: Bool, bluetoothOn: Bool) {
        // Get the currently used audio device
        // let currentAudioDevice = mCore?.currentCall?.outputAudioDevice
        // let speakerEnabled = currentAudioDevice?.type == AudioDeviceType.Speaker
        
        let session = AVAudioSession.sharedInstance()
        var outputDataSources: [AVAudioSessionPortDescription] = session.availableInputs!
        let currentRoute = session.currentRoute
        // let test = currentAudioDevice?.deviceName
        // We can get a list of all available audio devices using
        // Note that on tablets for example, there may be no Earpiece device
        for audioDevice in mCore!.audioDevices {
            // For IOS, the Speaker is an exception, Linphone cannot differentiate Input and Output.
            // This means that the default output device, the earpiece, is paired with the default phone microphone.
            // Setting the output audio device to the microphone will redirect the sound to the earpiece.
            if (!speakerOn && !bluetoothOn && audioDevice.type == AudioDeviceType.Microphone) {
                mCore!.currentCall?.outputAudioDevice = audioDevice
                
                //work around to switch current audio session
                let mic = outputDataSources.filter({$0.portType == .builtInMic})[0]
                do {
                    print("THIS RAN 3")
                    try session.setPreferredInput(mic)
                }catch{
                    print("failed to set user preferred input/output")
                }
                
                isSpeakerEnabled = false

            } else if (speakerOn && audioDevice.type == AudioDeviceType.Speaker) {
                mCore?.currentCall?.outputAudioDevice = audioDevice
                isSpeakerEnabled = true
            } else if (bluetoothOn && audioDevice.type == AudioDeviceType.Bluetooth) {
                mCore!.currentCall?.outputAudioDevice = audioDevice
            }
        }
    }

    func toggleBluetooth() {
        for audioDevice in mCore!.audioDevices {
             if (audioDevice.type == AudioDeviceType.Bluetooth) {
                 mCore!.currentCall?.outputAudioDevice = audioDevice
                 isBluetoothOn = true
             }
        }
    }

    @objc func handleRouteChange(notification: Notification) {
        let currentRoute: [AVAudioSessionPortDescription] = AVAudioSession.sharedInstance().currentRoute.outputs
        if(!currentRoute.isEmpty){
            print("THIS RAN handleRouteChange", currentRoute)
            self.callkitChannel.invokeMethod("lnAudioDeviceChanged", arguments: [currentRoute[0].portType.rawValue, currentRoute[0].portName, ""])
        }
//        mCore?.audioRouteChanged()
    }
    
    func clearCache(){
        let cacheURL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileManager = FileManager.default
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory( at: cacheURL, includingPropertiesForKeys: nil, options: [])
            for file in directoryContents {
                do {
                    try fileManager.removeItem(at: file)
                }
                catch let error as NSError {
                    print("Ooops! Something went wrong: \(error)")
                }

            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    public func sendDevices() {
        print("sending devices from swift")
        var devices: [[String]] = []
        mCore?.audioDevices.forEach({ device in
            devices.append([device.deviceName, device.id, device.type == .Microphone ? "Microphone" : "Speaker"])
        })
        let jsonEncoder = JSONEncoder()
        do {
            let devicesString = try jsonEncoder.encode(devices)
            self.callkitChannel.invokeMethod("lnNewDevicesList",
                                             arguments: [String(data: devicesString, encoding: .utf8), mCore?.echoLimiterEnabled, mCore?.echoCancellationEnabled, "notused", mCore?.defaultInputAudioDevice!.id, mCore?.defaultOutputAudioDevice!.id])                // Right after outgoing init
        } catch let error as NSError {
            print("was an error sending newdeviceslist")
        }

    }
    
    public func getAppVersion(){
        if(appVersion != nil){
            self.callkitChannel.invokeMethod("setAppVersion", arguments: [appVersion!])
        }
    }
    
    public init(channel: FlutterMethodChannel) {
        provider = CXProvider(configuration: ProviderDelegate.providerConfiguration)

        callkitChannel = channel
        super.init()
        setupLinphone();
        theCallObserver.setDelegate(self, queue: nil)
        
        print("setup audiosesssion observer")
        
        let nc = NotificationCenter.default
         nc.addObserver(self,
                        selector: #selector(handleInterruption),
                        name: AVAudioSession.interruptionNotification,
                        object: AVAudioSession.sharedInstance())
        
          nc.addObserver(self,
                         selector: #selector(handleRouteChange),
                         name: AVAudioSession.routeChangeNotification,
                         object: nil)
        
        callkitChannel.setMethodCallHandler({ [self]
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            print("callkit method hanlder", call.method)
            if (call.method == "setSpeaker") {
                print("settingspeakercallkit");
                let args = call.arguments as! [Any]
                let speakerOn = args[0] as! Bool
                setAudioAndSpeakerPhone(speakerOn: speakerOn)
//                sendDevices()
            }
          //  return;
            else if (call.method == "reportOutgoingCall") {
                print("report outgoing call callkit")
                let args = call.arguments as! [Any]
                let phoneNumber = args[1] as! String
                let uuid = args[0] as! String
                let name = args[2] as! String
                let uuidObj = UUID(uuidString: uuid)!
                let handle = CXHandle(
                    type: .phoneNumber,
                    value: phoneNumber.applyPatternOnNumbers(
                        pattern: phoneNumber.count > 10
                            ? "+# (###) ###-####"
                            : "(###) ###-####",
                        replacementCharacter: "#"
                    )
                )

                let startCallAction = CXStartCallAction(call: uuidObj,
                                                        handle: handle)
                startCallAction.contactIdentifier = name
                
                let transaction = CXTransaction(action: startCallAction)
                controller.request(transaction) { error in
                    if let error = error {
                        print("Error requesting transaction (new outgoing): \(error)")
                    } else {
                        print("request transaction");
                        print("does need reportcall");
                        let update = CXCallUpdate()
                        update.hasVideo = false
                        update.supportsHolding = true
                        update.supportsDTMF = true
                        
                        self.provider.reportCall(with: transaction.uuid,
                                                 updated: update)
                        print("reportcall Requested transaction successfully")
                    }
                }
                self.requestTransaction(transaction)
            }
            else if (call.method == "lpAnswer") {
                let args = call.arguments as! [Any]
                let call = findCallByUuid(uuid: args[0] as! String);
                do {
                    try call!.accept();
                } catch let error as NSError {
                    print("error answering call");
                }
            }
            else if (call.method == "lpSendDtmf") {
                let args = call.arguments as! [Any]
                let call = findCallByUuid(uuid:args[0] as! String);
                do {
                    try call?.sendDtmfs(dtmfs: args[1] as! String);
                } catch {
                    print("error sending dtmf")
                }
            }
            else if (call.method == "lpSetHold") {
                let args = call.arguments as! [Any]
                let call = findCallByUuid(uuid:args[0] as! String);
                print("toholdhere")
                print(call!.state)
                do {
                    let toHold = args[1] as! Bool
                    if (toHold) {
                        if (call!.state != .Paused && call!.state != .PausedByRemote && call!.state != .OutgoingInit && call!.state != .OutgoingProgress && call!.state != .OutgoingRinging && call!.state != .IncomingReceived && call!.state != .Error) {
                            try call!.pause();
                        }
                    } else {
                        if (call!.state == .Paused || call!.state == .PausedByRemote || call!.state == .Pausing) {
                            if (wasAudioInterrupted) {
                                print("unpause0 set to 1")
                                wasAudioInterrupted = false
                                unpausePauseState = 0
                                unpausePauseUuid = args[0] as! String
                                print(unpausePauseUuid)
                            }
                            try call!.resume();
                        } else if (call!.state == .Resuming){
                            let uuid = args[0] as! String

                            self.callkitChannel.invokeMethod("lnCallConnected", arguments: [uuid])                // Call state will be released shortly after the End state

                        }
                    }
                } catch let error as NSError {
                    print("error holding/unholding call");
                    print(error);
                    

                }
                self.sendDevices()
            }
            else if (call.method == "lpSetEchoLimiterEnabled") {
                let args = call.arguments as! [Any]
                mCore?.echoLimiterEnabled = args[0] as! Bool
                self.sendDevices()
            }
            else if (call.method == "lpSetDefaultInput") {
                let args = call.arguments as! [Any]
                let deviceId = args[0] as! String
                mCore?.extendedAudioDevices.forEach({ device in
                    if (device.id == deviceId) {
                        mCore?.defaultInputAudioDevice = device
                        mCore?.calls.forEach { call in
                            call.inputAudioDevice = device
                        }
                    }
                })
            }
            else if (call.method == "lpSetDefaultOutput") {
                let args = call.arguments as! [Any]
                let deviceId = args[0] as! String
                mCore?.extendedAudioDevices.forEach({ device in
                    if (device.id == deviceId) {
                        mCore?.defaultOutputAudioDevice = device
                        mCore?.calls.forEach { call in
                            call.outputAudioDevice = device
                        }
                    }
                })
            }
            else if (call.method == "lpSetEchoCancellationEnabled") {
                let args = call.arguments as! [Any]
                mCore?.echoCancellationEnabled = args[0] as! Bool
            }
            else if (call.method == "lpCalibrateEcho") {
                do {
                        try mCore?.startEchoCancellerCalibration()
                }catch let error as NSError {
                    print("error holding/unholding call");
                    print(error);
                    
                
                }
            }
            else if (call.method == "lpTestEcho") {
                do {
                 try   mCore?.startEchoTester(rate: 10)
                }catch let error as NSError {
                    print("error holding/unholding call");
                    print(error);
                    
                
                }
            }
            else if (call.method == "lpStopTestEcho") {
                do {
                  try  mCore?.stopEchoTester()
                }catch let error as NSError {
                    print("error holding/unholding call");
                    print(error);
                    
                
                }
                self.sendDevices()
            }
            else if (call.method == "lpSetEchoLimiterEnabled") {
                let args = call.arguments as! [Any]
                mCore?.echoLimiterEnabled = args[0] as! Bool
                self.sendDevices()
            }
            else if (call.method == "lpSetDefaultInput") {
                let args = call.arguments as! [Any]
                let deviceId = args[0] as! String
                mCore?.extendedAudioDevices.forEach({ device in
                    if (device.id == deviceId) {
                        mCore?.defaultInputAudioDevice = device
                        mCore?.calls.forEach { call in
                            call.inputAudioDevice = device
                        }
                    }
                })
            }
            else if (call.method == "lpSetDefaultOutput") {
                let args = call.arguments as! [Any]
                let deviceId = args[0] as! String
                mCore?.extendedAudioDevices.forEach({ device in
                    if (device.id == deviceId) {
                        mCore?.defaultOutputAudioDevice = device
                        mCore?.calls.forEach { call in
                            call.outputAudioDevice = device
                        }
                    }
                })
            }
            else if (call.method == "lpSetSpeaker") {
                let args = call.arguments as! [Any]
                do {
                    let speakerOn = args[0] as! Bool
                    toggleSpeaker(speakerOn: speakerOn,bluetoothOn: isBluetoothOn)
                } catch let error as NSError {
                    print("error holding/unholding call");
                    print(error);
                }
//                sendDevices()
            }
            else if (call.method == "lpSetBluetooth") {
                do {
                    toggleBluetooth();
                } catch let error as NSError {
                    print("error holding/unholding call");
                    print(error);
                }
//                sendDevices()

            }
            else if (call.method == "lpSetBluetooth") {
                do {
                    toggleBluetooth();
                } catch let error as NSError {
                    print("error holding/unholding call");
                    print(error);
                }
//                sendDevices()
            }
            else if (call.method == "lpMuteCall") {
                let args = call.arguments as! [Any]
                let call = findCallByUuid(uuid: args[0] as! String);
                if (call != nil) {
                    call!.microphoneMuted = true
                } else {
                    print("attempt to mute call but could not find call");
                    print(args[0]);
                }
            }
            else if (call.method == "lpUnmuteCall") {
                let args = call.arguments as! [Any]
                let call = findCallByUuid(uuid: args[0] as! String);
                if (call != nil) {
                    call!.microphoneMuted = false
                } else {
                    print("attempt to mute call but could not find call");
                    print(args[0]);
                }
            }
            else if (call.method == "lpRefer") {
                let args = call.arguments as! [Any]
                let call = findCallByUuid(uuid: args[0] as! String);
                if (call != nil) {
                    let destination = args[1] as! String;
                    do {
                        try call?.transfer(referTo: destination)
                    } catch let error as NSError {
                        print("error referring call");print(args);
                    }
                } else {
                    print("attempt to refer call but could not find call");
                    print(args[0]);
                    print(args[1]);
                }
            }
            else if (call.method == "lpStartCall") {
                let args = call.arguments as! [Any]
                var address = args[0] as! String

                outgoingCall(address: address)
            }
            else if (call.method == "lpEndCall") {
                let args = call.arguments as! [Any]
                var uuid = args[0] as! String
                terminateCall(uuid: uuid)
            }
            else if (call.method == "lpAssistedTransfer") {
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String
                let uuid1 = args[1] as! String
                
                let lpCallToTransfer = findCallByUuid(uuid:uuid)
                let activeCall = findCallByUuid(uuid:uuid1)
                
                if(lpCallToTransfer != nil && activeCall != nil){
                    do {
                        try lpCallToTransfer?.transferToAnother(dest: activeCall!)
                    } catch let error as NSError {
                        print("error assisted transfer call");print();
                    }
                    
                }
            }
            else if (call.method == "lpRegister") {
                let args = call.arguments as! [Any]

                username = args[0] as! String
                passwd = args[1] as! String
                domain = args[2] as! String
                self.registerPhone()
            }
            else if (call.method == "lpUnregister") {
                unregister()
            }
            
            else if (call.method == "endCall") {
                print("end call callkit")
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String

                let endCallAction = CXEndCallAction(call: UUID(uuidString: uuid)!)
                let transaction = CXTransaction(action: endCallAction)
                self.requestTransaction(transaction)

            } else if (call.method == "attemptAudioSessionActiveRingtone") {
                return;
//                let session = AVAudioSession.sharedInstance()
//                                    print("try to set audio active")
//                                    do {
//                                        try session.setCategory(.playback, mode: .voiceChat, options: .mixWithOthers)
//                                        try session.overrideOutputAudioPort(.speaker)
//                                        try session.setActive(true)
//
//                                        print(session.category)
//                                        print(session.mode)
//                                        print("did set audiosessionactive")
//                                        let url = URL(fileURLWithPath: "outgoing.wav")
//                                        let player = try? AVAudioPlayer(contentsOf: url)
//                                        player?.numberOfLoops = -1
//                                        player?.setVolume(1.0,  fadeDuration: 0)
//                                        player?.play()
//                                        print("played audiosession ringtone")
//                                    } catch let error as NSError {
//                                        print("Unable to activate audiosession:  \(error.localizedDescription)")
//                                    }
            }
            else if (call.method == "attemptAudioSessionActive") {
                return;
//                let session = AVAudioSession.sharedInstance()
//                print("try to set audio active")
//                do {
//                    print(session.category)
//                    print(session.mode)
//                    try session.setCategory(.playAndRecord)
//                    try session.setMode(.voiceChat)
//                    try session.setActive(true)
//                    setAudioAndSpeakerPhone(speakerOn: speakerTurnedOn)
//                    print("did set audiosessionactive")
//                } catch let error as NSError {
//                    print("Unable to activate audiosession:  \(error.localizedDescription)")
//                }
//
//                  var userInfo: Dictionary<AnyHashable, Any> = [:]
//                  userInfo[AVAudioSessionInterruptionTypeKey] = AVAudioSession.InterruptionType.ended.rawValue
//                  NotificationCenter.default.post(name: AVAudioSession.interruptionNotification,
//                                                  object: self, userInfo: userInfo)
//                  print("just sent it")
            } else if (call.method == "attemptAudioSessionInActive") {
                return;
                let session = AVAudioSession.sharedInstance()
                print("try to set audio inactive")
                do {
                    print(session.category)
                    print(session.mode)
                    try session.setActive(false)
                    print("did set audiosessionactive")
                } catch let error as NSError {
                    print("Unable to inactivate audiosession:  \(error.localizedDescription)")
                }
            }
            else if (call.method == "reportConnectedOutgoingCall") {
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String
                provider.reportOutgoingCall(with: UUID(uuidString: uuid)!,
                                            connectedAt: Date())
                print("callkit connecting")
            }
            else if (call.method == "stopRinging") {
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String
                print("stopping ringing unanswered");
                self.provider.reportCall(with: UUID.init(uuidString: uuid)!,
                                         endedAt: Date(),
                                         reason: .unanswered)
            }
            else if (call.method == "reportConnectingOutgoingCall") {
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String
                provider.reportOutgoingCall(
                    with: UUID(uuidString: uuid)!,
                    startedConnectingAt: Date())
                print("callkit connectd outgoing")
              
                print("callkit connected outgoing set supportsholding")
            }
            else if (call.method == "setUnhold") {
                print("set unhold call callkit")
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String
                if(self.answeredUuids.keys.contains(uuid)){
                    let unHoldAction = CXSetHeldCallAction(call: UUID(uuidString: uuid)!,
                                                            onHold: false)
                    let transaction = CXTransaction(action: unHoldAction)
                    self.requestTransaction(transaction)
                }
            }
            else if (call.method == "setHold") {
                print("sethold call callkit")
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String
                if(self.answeredUuids.keys.contains(uuid)){
                    let holdAction = CXSetHeldCallAction(call: UUID(uuidString: uuid)!,
                                                           onHold: true)
                    let transaction = CXTransaction(action: holdAction)
                    self.requestTransaction(transaction)
                }
            }
            else if (call.method == "setSpeaker") {
                print("settingspeakercallkit");
                let args = call.arguments as! [Any]
                let speakerOn = args[0] as! Bool
                setAudioAndSpeakerPhone(speakerOn: speakerOn)
            }
            else if (call.method == "answerCall") {
                print("answer call callkit")
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String
                let answerAction = CXAnswerCallAction(call:  UUID(uuidString: uuid)!)
                let transaction = CXTransaction(action: answerAction)
                self.requestTransaction(transaction)
            }
            else if (call.method == "muteCall") {
                print("mute call callkit")
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String
                if(self.answeredUuids.keys.contains(uuid)){
                    let action = CXSetMutedCallAction(call:  UUID(uuidString: uuid)!, muted: true)
                    let transaction = CXTransaction(action: action)
                    self.requestTransaction(transaction)
                }
            }
            else if (call.method == "unMuteCall") {
                print("unmute call callkit")
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String
                if(self.answeredUuids.keys.contains(uuid)){
                    let action = CXSetMutedCallAction(call:  UUID(uuidString: uuid)!, muted: false)
                    let transaction = CXTransaction(action: action)
                    self.requestTransaction(transaction)
                }
            } else if(call.method == "clearCache") {
                clearCache()
            }
        })
        print("providerpush set delegate callkit")
        provider.setDelegate(self, queue: nil)
    }
  
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        print("MyDebugMessage call uuid \(call.hasConnected)")
        print(call.isOnHold)
        if call.hasConnected == true {
            print("marking answered", call.uuid.uuidString)
            answeredUuids[call.uuid.uuidString] = true
            print(answeredUuids)
        }
    }

    private func requestTransaction(_ transaction: CXTransaction) {
        controller.request(transaction) { error in
            if let error = error {
                print("Error requesting transaction: \(error)")
            } else {
                print("request transaction success");
                print(transaction);
            }
        }
    }

    
    static var providerConfiguration: CXProviderConfiguration = {
        let providerConfiguration = CXProviderConfiguration(localizedName: "Fusion")
    
        providerConfiguration.supportsVideo = false
        providerConfiguration.maximumCallsPerCallGroup = 10
        providerConfiguration.supportedHandleTypes = [.phoneNumber]
    
        return providerConfiguration
    }()
  
    func reportNewIncomingCall(
        uuid: UUID,
        handle: String,
        callerName: String,
        hasVideo: Bool = false,
        completion: ((Error?) -> Void)?
    ) {
        let update = CXCallUpdate()
        update.localizedCallerName = callerName
        print("thehandle", handle)
        update.remoteHandle = CXHandle(type: .phoneNumber, value: handle)
        update.hasVideo = hasVideo
        update.supportsHolding = true
        update.supportsDTMF = true
    
        provider.reportNewIncomingCall(with: uuid, update: update) { error in
            if error == nil {
                print("call reported no error provider callkit")
            } else {
                print("provider call reported and error callkit")
                print(error!)
            }
            completion?(error)
        
            self.callkitChannel.invokeMethod("startCall", arguments: [uuid.uuidString, handle, callerName])
            self.startRingingTimer(uuid: uuid.uuidString)
        }
    }
    
    private func startRingingTimer(uuid: String )
    {
        let vTimer = Timer(
            timeInterval: 40,
            repeats: false,
            block: { [weak self] _ in
                self?.ringingDidTimeout(uuid: uuid)
            })
        vTimer.tolerance = 0.5
        RunLoop.current.add(vTimer, forMode: .common)
    }

    private func ringingDidTimeout(uuid: String) {
        print("checking ring", uuid, answeredUuids)
        if (answeredUuids.keys.contains(uuid) && answeredUuids[uuid] != true) {
            print("removing unanswered")
            self.provider.reportCall(with: UUID.init(uuidString: uuid)!,
                                     endedAt: Date(),
                                     reason: .unanswered)
            answeredUuids.removeValue(forKey: uuid)
        }
    }
}

extension ProviderDelegate: CXProviderDelegate {
    func provider(_ provider: CXProvider, perform action: CXSetMutedCallAction) {
    print("callkit mute pressed")
        action.fulfill()
        callkitChannel.invokeMethod("muteButtonPressed", arguments: [action.callUUID.uuidString, action.isMuted])
    }
    
    func provider(_ provider: CXProvider, perform action: CXPlayDTMFCallAction) {
    print("callkit dtmf pressed")
        action.fulfill()
        callkitChannel.invokeMethod("dtmfPressed", arguments: [action.callUUID.uuidString, action.digits])
    }
    
  func providerDidReset(_ provider: CXProvider) {
    print("provider didreset callkit");
  }
    
    func configureAudioSession() {
        
        let session = AVAudioSession.sharedInstance()
        do {
            //try session.setPrefersNoInterruptionsFromSystemAlerts(true)
            try session.setCategory(.playAndRecord, options: [.allowBluetooth])
            try session.setMode(.voiceChat)
            try session.setActive(true)
            print(session.category)
            print(session.mode)
            print("AudioSession did activate")
        } catch let error as NSError {
            print("unable to activate AudioSession:  \(error.localizedDescription)")
        }
    }
    
  
  func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
      configureAudioSession()
      callkitChannel.invokeMethod("answerButtonPressed", arguments: [action.callUUID.uuidString]);
      action.fulfill();
  }
  
    func provider(_ provider: CXProvider, didDeactivate audioSession: AVAudioSession) {
        mCore?.activateAudioSession(actived: false)
        return
        print("audiosession dideactivate");
    }
    
    func _setAudioAndSpeakerphone(speakerOn: Bool) {
    }
    
    func setAudioAndSpeakerPhone(speakerOn: Bool) {
        return;
        _setAudioAndSpeakerphone(speakerOn: !speakerOn)
        _setAudioAndSpeakerphone(speakerOn: speakerOn)
    }
    
  func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
      mCore?.activateAudioSession(actived: true)
      return;
  }
  
  func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
      print("theendcallaction from callkit")
      action.fulfill()
      callkitChannel.invokeMethod("endButtonPressed", arguments: [action.callUUID.uuidString])
    // end call
  }
  
  func provider(_ provider: CXProvider, perform action: CXSetHeldCallAction) {
      if (!action.isOnHold) {
          print("holdbuttonpressed configure audio")
      }
      action.fulfill()
      callkitChannel.invokeMethod("holdButtonPressed", arguments: [action.callUUID.uuidString, action.isOnHold])

  }
  
  func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
      print("start call action here callkit")
      configureAudioSession();
      callkitChannel.invokeMethod("startCall", arguments: [action.callUUID.uuidString, action.handle.value, action.contactIdentifier])
      action.fulfill()
  }
    
    func uuidFromString(str: String) -> UUID {
        
      if (str.count == 0) {
          return UUID();
      }
      else {
          let str2 = str.md5()
          print("hashing for uuid")
          print(str)
          print(str2)
          var numbers: [String] = [];
          var strIndex = 0;
          
          for i in 0..<16 {
              if (strIndex > str.count) {
                  strIndex = 0;
              }

              numbers.append(String(
                format: "%02X",
                str2[str2.index(str2.startIndex, offsetBy: strIndex)].asciiValue!));
              strIndex += 1;
        }
          
          var s = "";
          s += numbers[0] + numbers[1] + numbers[2] + numbers[3] + "-"
          s += numbers[4] + numbers[5] + "-"
          s += numbers[6] + numbers[7] + "-"
          s += numbers[8] + numbers[9] + "-"
          s += numbers[10] + numbers[11] + numbers[12] + numbers[13] + numbers[14] + numbers[15]
          print("builtuuid");print(s);
          return UUID(uuidString: s)!;
      }
    }
}

extension String {
    func md5() -> String {
        let data = Data(utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))

        data.withUnsafeBytes { buffer in
            _ = CC_MD5(buffer.baseAddress, CC_LONG(buffer.count), &hash)
        }

        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}
