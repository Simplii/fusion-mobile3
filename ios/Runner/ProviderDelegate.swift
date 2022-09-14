
import AVFoundation
import AVFAudio
import CallKit
import Sentry
import WebRTC

class ProviderDelegate: NSObject, CXCallObserverDelegate {
    private let controller = CXCallController()
    private let provider: CXProvider
    private let callkitChannel: FlutterMethodChannel!
    private var answeredUuids: [String: Bool] = [:]
    private let theCallObserver = CXCallObserver()
    private var needsReport: String = "";
    private let speakerTurnedOn = false;

    @objc func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
                return
        }

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
    
    public init(channel: FlutterMethodChannel) {
        provider = CXProvider(configuration: ProviderDelegate.providerConfiguration)

        callkitChannel = channel
        super.init()
        theCallObserver.setDelegate(self, queue: nil)
        
        print("setup audiosesssion observer")
        
        let nc = NotificationCenter.default
          nc.addObserver(self,
                         selector: #selector(handleInterruption),
                         name: AVAudioSession.interruptionNotification,
                         object: AVAudioSession.sharedInstance())

        callkitChannel.setMethodCallHandler({ [self]
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            print("callkit method hanlder", call.method)
            if (call.method == "setSpeaker") {
                print("settingspeakercallkit");
                let args = call.arguments as! [Any]
                let speakerOn = args[0] as! Bool
                setAudioAndSpeakerPhone(speakerOn: speakerOn)
            }
          //  return;
            if (call.method == "reportOutgoingCall") {
                print("report outgoing call callkit")
                let args = call.arguments as! [Any]
                let phoneNumber = args[1] as! String
                let uuid = args[0] as! String
                let name = args[2] as! String
                let uuidObj = UUID(uuidString: uuid)!
                let handle = CXHandle(type: CXHandle.HandleType.phoneNumber, value: phoneNumber)

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
            else if (call.method == "endCall") {
                print("end call callkit")
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String

                let endCallAction = CXEndCallAction(call: UUID(uuidString: uuid)!)
                let transaction = CXTransaction(action: endCallAction)
                self.requestTransaction(transaction)

            }else if (call.method == "attemptAudioSessionActiveRingtone") {
                let session = AVAudioSession.sharedInstance()
                                    print("try to set audio active")
                                    do {
                                        try session.setCategory(.playback, mode: .voiceChat, options: .mixWithOthers)
                                        try session.overrideOutputAudioPort(.speaker)
                                        try session.setActive(true) 
                
                                        print(session.category)
                                        print(session.mode)
                                        print("did set audiosessionactive")
                                        let url = URL(fileURLWithPath: "outgoing.wav")
                                        let player = try? AVAudioPlayer(contentsOf: url)
                                        player?.numberOfLoops = -1
                                        player?.setVolume(1.0,  fadeDuration: 0)
                                        player?.play()
                                        print("played audiosession ringtone")
                                    } catch let error as NSError {
                                        print("Unable to activate audiosession:  \(error.localizedDescription)")
                                    }
                                }
            else if (call.method == "attemptAudioSessionActive") {
                let session = AVAudioSession.sharedInstance()
                print("try to set audio active")
                do {
                    print(session.category)
                    print(session.mode)
                    try session.setCategory(.playAndRecord)
                    try session.setMode(.voiceChat)
                    try session.setActive(true)
                    setAudioAndSpeakerPhone(speakerOn: speakerTurnedOn)
                    print("did set audiosessionactive")
                } catch let error as NSError {
                    print("Unable to activate audiosession:  \(error.localizedDescription)")
                }
                
                  var userInfo: Dictionary<AnyHashable, Any> = [:]
                  userInfo[AVAudioSessionInterruptionTypeKey] = AVAudioSession.InterruptionType.ended.rawValue
                  NotificationCenter.default.post(name: AVAudioSession.interruptionNotification,
                                                  object: self, userInfo: userInfo)
                  print("just sent it")
            } else if (call.method == "attemptAudioSessionInActive") {
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
                let unHoldAction = CXSetHeldCallAction(call: UUID(uuidString: uuid)!,
                                                       onHold: false)
                let transaction = CXTransaction(action: unHoldAction)
                self.requestTransaction(transaction)
            }
            else if (call.method == "setHold") {
                print("sethold call callkit")
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String
                let holdAction = CXSetHeldCallAction(call: UUID(uuidString: uuid)!,
                                                       onHold: true)
                let transaction = CXTransaction(action: holdAction)
                self.requestTransaction(transaction)
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
                let action = CXSetMutedCallAction(call:  UUID(uuidString: uuid)!, muted: true)
                let transaction = CXTransaction(action: action)
                self.requestTransaction(transaction)
            }
            else if (call.method == "unMuteCall") {
                print("unmute call callkit")
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String
                let action = CXSetMutedCallAction(call:  UUID(uuidString: uuid)!, muted: false)
                let transaction = CXTransaction(action: action)
                self.requestTransaction(transaction)
            }
        })
        print("providerpush set delegate callkit")
        provider.setDelegate(self, queue: nil)
    }
  
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        print("call observer")
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
        update.remoteHandle = CXHandle(type: .generic, value:  handle)
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
        callkitChannel.invokeMethod("muteButtonPressed", arguments: [action.callUUID.uuidString, action.isMuted])
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXPlayDTMFCallAction) {
    print("callkit dtmf pressed")
        callkitChannel.invokeMethod("dtmfPressed", arguments: [action.callUUID.uuidString, action.digits])
        action.fulfill()
    }
    
  func providerDidReset(_ provider: CXProvider) {
    print("provider didreset callkit");
  }
  
  func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
    callkitChannel.invokeMethod("answerButtonPressed", arguments: [action.callUUID.uuidString]);
    action.fulfill();
    // answer the call here
  }
  
    func provider(_ provider: CXProvider, didDeactivate audioSession: AVAudioSession) {
        print("audiosession dideactivate");
        RTCAudioSession.sharedInstance().audioSessionDidDeactivate(audioSession);
        RTCAudioSession.sharedInstance().isAudioEnabled = false;
    }
    
    func _setAudioAndSpeakerphone(speakerOn: Bool) {
    var session = RTCAudioSession.sharedInstance();
        //session.beginConfiguration();
        session.lockForConfiguration();
        do {
        try session.setCategory(AVAudioSession.Category.playAndRecord.rawValue)
        try session.overrideOutputAudioPort(
            speakerOn
            ? AVAudioSession.PortOverride.speaker
            : AVAudioSession.PortOverride.none);
        try session.setActive(true);
        } catch let error {
            print("!!!!!therewasanerror!!!rtcsession setactivespaker");
            print(error);
        }
        session.unlockForConfiguration();
    }
    
    func setAudioAndSpeakerPhone(speakerOn: Bool) {
        _setAudioAndSpeakerphone(speakerOn: !speakerOn)
        _setAudioAndSpeakerphone(speakerOn: speakerOn)
    }
    
  func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
//    https://stackoverflow.com/questions/47416493/callkit-can-reactivate-sound-after-swapping-call
      //https://bugs.chromium.org/p/webrtc/issues/detail?id=8126
    print("didactivate here provider audiosession callkit", audioSession)
print("webrtc workaround didactivate")
      RTCAudioSession.sharedInstance().audioSessionDidActivate(audioSession);
      RTCAudioSession.sharedInstance().isAudioEnabled = true;
      setAudioAndSpeakerPhone(speakerOn: false)
      var userInfo: Dictionary<AnyHashable, Any> = [:]
      userInfo[AVAudioSessionInterruptionTypeKey] = AVAudioSession.InterruptionType.ended.rawValue
      NotificationCenter.default.post(name: AVAudioSession.interruptionNotification,
                                      object: self, userInfo: userInfo)
      print("just sent it")
  }
  
  func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
    callkitChannel.invokeMethod("endButtonPressed", arguments: [action.callUUID.uuidString])
    action.fulfill()
    // end call
  }
  
  func provider(_ provider: CXProvider, perform action: CXSetHeldCallAction) {
    callkitChannel.invokeMethod("holdButtonPressed", arguments: [action.callUUID.uuidString, action.isOnHold])
      
      let session = AVAudioSession.sharedInstance()
      do {
          print("going to set active audio session")
          print(!action.isOnHold)
         /* try session.setCategory(.playAndRecord, mode: .voiceChat, options: [.interruptSpokenAudioAndMixWithOthers])
          try session.overrideOutputAudioPort(.speaker)
              print("settingitactive")*/
          if (!action.isOnHold) {
              try session.setActive(!action.isOnHold)
              var userInfo: Dictionary<AnyHashable, Any> = [:]
              userInfo[AVAudioSessionInterruptionTypeKey] = AVAudioSession.InterruptionType.ended.rawValue
              NotificationCenter.default.post(name: AVAudioSession.interruptionNotification,
                                              object: self, userInfo: userInfo)
              print("just sent it")
          }
          print("setaudiosession active")

      } catch (let error) {print("adioerror");print(error)
          //  callkitChannel.invokeMethod("setAudioSessionActive", arguments: [false])
      }
      action.fulfill()
  }
  
  func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
    print("start call action here callkit")
    callkitChannel.invokeMethod("startCall", arguments: [action.callUUID.uuidString, action.handle.value, action.contactIdentifier])
    action.fulfill()
  }
}
