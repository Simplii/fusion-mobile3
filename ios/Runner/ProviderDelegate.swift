
import AVFoundation
import CallKit

class ProviderDelegate: NSObject {
    private let controller = CXCallController()
    private let provider: CXProvider
    private let callkitChannel: FlutterMethodChannel!

    public init(channel: FlutterMethodChannel) {
        provider = CXProvider(configuration: ProviderDelegate.providerConfiguration)
        callkitChannel = channel
        super.init()
        
        callkitChannel.setMethodCallHandler({ [self]
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            print("callkit method hanlder", call.method)
            
            if (call.method == "reportOutgoingCall") {
                print("report outgoing call callkit")
                let args = call.arguments as! [Any]
                let phoneNumber = args[1] as! String
                let uuid = args[0] as! String
                let name = args[2] as! String
                let handle = CXHandle(type: CXHandle.HandleType.phoneNumber, value: phoneNumber)

                let startCallAction = CXStartCallAction(call: UUID(uuidString: uuid)!,
                                                        handle: handle)
                startCallAction.contactIdentifier = name
                 
                let transaction = CXTransaction(action: startCallAction)
                self.requestTransaction(transaction)
            }
            else if (call.method == "endCall") {
                print("end call callkit")
                let args = call.arguments as! [Any]
                let uuid = args[0] as! String

                let endCallAction = CXEndCallAction(call: UUID(uuidString: uuid)!)
                let transaction = CXTransaction(action: endCallAction)
                self.requestTransaction(transaction)

            }
        })
        print("providerpush set delegate callkit")
        provider.setDelegate(self, queue: nil)
    }
  
    private func requestTransaction(_ transaction: CXTransaction) {
        controller.request(transaction) { error in
            if let error = error {
                print("Error requesting transaction: \(error)")
            } else {
                print("Requested transaction successfully")
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
        update.remoteHandle = CXHandle(type: .phoneNumber, value: handle)
        update.hasVideo = hasVideo
    
        provider.reportNewIncomingCall(with: uuid, update: update) { error in
            if error == nil {
                print("call reported no error provider callkit")
            } else {
                print("provider call reported and error callkit")
                print(error!)
            }
            completion?(error)
        }
        callkitChannel.invokeMethod("startCall", arguments: [uuid.uuidString, handle, callerName])
    }
}

extension ProviderDelegate: CXProviderDelegate {
    func provider(_ provider: CXProvider, perform action: CXSetMutedCallAction) {
    print("callkit mute pressed")
        callkitChannel.invokeMethod("muteButtonPressed", arguments: [action.callUUID.uuidString, action.isMuted])
    }
    
    func provider(_ provider: CXProvider, perform action: CXPlayDTMFCallAction) {
    print("callkit dtmf pressed")
        callkitChannel.invokeMethod("dtmfPressed", arguments: [action.callUUID.uuidString, action.digits])
    }
    
  func providerDidReset(_ provider: CXProvider) {
    print("provider didreset callkit");
  }
  
  func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
    print("answercall actoin provider callkit");
    callkitChannel.invokeMethod("answerButtonPressed", arguments: [action.callUUID.uuidString]);
    // answer the call here
  }
  
  func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
//    callkitChannel.invokeMethod("activatedSession", arguments: [.uuid]);

    print("didactivate here provider")
  }
  
  func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
    print("didend here provider")
    print("provider", action)
    print("provider", action.isComplete)
    print("provider", action.observationInfo)
    if (action.isComplete) {
        callkitChannel.invokeMethod("endButtonPressed", arguments: [action.callUUID.uuidString])
    }
    // end call
  }
  
  func provider(_ provider: CXProvider, perform action: CXSetHeldCallAction) {
    callkitChannel.invokeMethod("holdButtonPressed", arguments: [action.callUUID.uuidString, action.isOnHold])
    print("sethold provider")
    // set hold here
  }
  
  func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
    print("start call action here")
    callkitChannel.invokeMethod("startCall", arguments: [action.callUUID.uuidString, action.handle.value, action.contactIdentifier])
    //  start call action here
  }
}
