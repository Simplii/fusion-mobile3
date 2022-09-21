
/*
LinphoneEnums.swift
Copyright (C) 2019 Belledonne Communications SARL

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/
import Foundation
import linphone
#if canImport(SwiftUI)
import SwiftUI
#endif

///Enum describing RTP AVPF activation modes. 
public enum AVPFMode:Int
{
	/// Use default value defined at upper level. 
	case Default = -1
	/// AVPF is disabled. 
	case Disabled = 0
	/// AVPF is enabled. 
	case Enabled = 1
}
///Enum describing algorithm checking, used by the `AccountCreator`. 
public enum AccountCreatorAlgoStatus:Int
{
	/// Algorithm ok. 
	case Ok = 0
	/// Algorithm not supported. 
	case NotSupported = 1
}
///Enum describing backend used in the `AccountCreator`. 
public enum AccountCreatorBackend:Int
{
	/// XMLRPC Backend. 
	case XMLRPC = 0
	/// FlexiAPI Backend. 
	case FlexiAPI = 1
}
///Enum describing Ip family. 
public enum AddressFamily:Int
{
	/// IpV4. 
	case Inet = 0
	/// IpV6. 
	case Inet6 = 1
	/// Unknown. 
	case Unspec = 2
}
///`AudioDeviceCapabilities` enum represents whether a device can record audio,
///play audio or both 
public struct AudioDeviceCapabilities:OptionSet
{
	public let rawValue: Int

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	public static let CapabilityRecord = AudioDeviceCapabilities(rawValue: 1<<0)
	/// Can record audio. 
	public static let CapabilityPlay = AudioDeviceCapabilities(rawValue: 1<<1)
	/// Can play audio. 
	public static let CapabilityAll = AudioDeviceCapabilities(rawValue: 3)
}
///`AudioDeviceType` enum represents the different types of an audio device. 
public enum AudioDeviceType:Int
{
	case Unknown = 0
	/// Unknown. 
	case Microphone = 1
	/// Microphone. 
	case Earpiece = 2
	/// Earpiece. 
	case Speaker = 3
	/// Speaker. 
	case Bluetooth = 4
	/// Bluetooth. 
	case BluetoothA2DP = 5
	/// Bluetooth A2DP. 
	case Telephony = 6
	/// Telephony. 
	case AuxLine = 7
	/// AuxLine. 
	case GenericUsb = 8
	/// GenericUsb. 
	case Headset = 9
	/// Headset. 
	case Headphones = 10
}
///Enum describing the authentication methods. 
public enum AuthMethod:Int
{
	/// Digest authentication requested. 
	case HttpDigest = 0
	/// Client certificate requested. 
	case Tls = 1
}
///`ChatRoomBackend` is used to indicate the backend implementation of a chat
///room. 
public struct ChatRoomBackend:OptionSet
{
	public let rawValue: Int

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	/// Basic (client-to-client) chat room. 
	public static let Basic = ChatRoomBackend(rawValue: 1<<0)
	/// Server-based chat room. 
	public static let FlexisipChat = ChatRoomBackend(rawValue: 1<<1)
}
///`ChatRoomCapabilities` is used to indicate the capabilities of a chat room. 
public struct ChatRoomCapabilities:OptionSet
{
	public let rawValue: Int

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	/// No capabilities. 
	public static let None = ChatRoomCapabilities([])
	/// No server. 
	public static let Basic = ChatRoomCapabilities(rawValue: 1<<0)
	/// Supports RTT. 
	public static let RealTimeText = ChatRoomCapabilities(rawValue: 1<<1)
	/// Use server (supports group chat) 
	public static let Conference = ChatRoomCapabilities(rawValue: 1<<2)
	/// Special proxy chat room flag. 
	public static let Proxy = ChatRoomCapabilities(rawValue: 1<<3)
	/// Chat room migratable from Basic to Conference. 
	public static let Migratable = ChatRoomCapabilities(rawValue: 1<<4)
	/// A communication between two participants (can be Basic or Conference) 
	public static let OneToOne = ChatRoomCapabilities(rawValue: 1<<5)
	/// Chat room is encrypted. 
	public static let Encrypted = ChatRoomCapabilities(rawValue: 1<<6)
	/// Chat room can enable ephemeral messages. 
	public static let Ephemeral = ChatRoomCapabilities(rawValue: 1<<7)
}
///`ChatRoomEncryptionBackend` is used to indicate the encryption engine used by a
///chat room. 
public struct ChatRoomEncryptionBackend:OptionSet
{
	public let rawValue: Int

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	/// No encryption. 
	public static let None = ChatRoomEncryptionBackend([])
	/// Lime x3dh encryption. 
	public static let Lime = ChatRoomEncryptionBackend(rawValue: 1<<0)
}
///`ChatRoomEphemeralMode` is used to the ephemeral message mode used by a chat
///room. 
public enum ChatRoomEphemeralMode:Int
{
	/// Each device manages its own ephemeral settings. 
	case DeviceManaged = 0
	/// Ephemeral settings are chatroom wide and only admins can change them. 
	case AdminManaged = 1
}
///TODO move to encryption engine object when available `ChatRoomSecurityLevel` is
///used to indicate the encryption security level of a chat room. 
public enum ChatRoomSecurityLevel:Int
{
	/// Security failure. 
	case Unsafe = 0
	/// No encryption. 
	case ClearText = 1
	/// Encrypted. 
	case Encrypted = 2
	/// Encrypted and verified. 
	case Safe = 3
}
///Describes conference invitations possible errors. 
public enum ConferenceInfoError:Int
{
	/// Could not create or retrieve chat room. 
	case ChatRoomError = 0
}
///Describes the state of the remote configuring process of the `Core` object,
///'Skipped' when the feature is disabled. 
public enum ConfiguringState:Int
{
	case Successful = 0
	case Failed = 1
	case Skipped = 2
}
///Consolidated presence information: 'online' means the user is open for
///communication, 'busy' means the user is open for communication but involved in
///an other activity, 'do not disturb' means the user is not open for
///communication, and 'offline' means that no presence information is available. 
public enum ConsolidatedPresence:Int
{
	case Online = 0
	case Busy = 1
	case DoNotDisturb = 2
	case Offline = 3
}
///Enum describing the result of the echo canceller calibration process. 
public enum EcCalibratorStatus:Int
{
	/// The echo canceller calibration process is on going. 
	case InProgress = 0
	/// The echo canceller calibration has been performed and produced an echo delay
	/// measure. 
	case Done = 1
	/// The echo canceller calibration process has failed. 
	case Failed = 2
	/// The echo canceller calibration has been performed and no echo has been
	/// detected. 
	case DoneNoEcho = 3
}
///`EventLogType` is used to indicate the type of an event. 
public enum EventLogType:Int
{
	/// No defined event. 
	case None = 0
	/// Conference (created) event. 
	case ConferenceCreated = 1
	/// Conference (terminated) event. 
	case ConferenceTerminated = 2
	/// Conference call (start) event. 
	case ConferenceCallStart = 3
	/// Conference call (end) event. 
	case ConferenceCallEnd = 4
	/// Conference chat message event. 
	case ConferenceChatMessage = 5
	/// Conference participant (added) event. 
	case ConferenceParticipantAdded = 6
	/// Conference participant (removed) event. 
	case ConferenceParticipantRemoved = 7
	/// Conference participant (set admin) event. 
	case ConferenceParticipantSetAdmin = 8
	/// Conference participant (unset admin) event. 
	case ConferenceParticipantUnsetAdmin = 9
	/// Conference participant device (added) event. 
	case ConferenceParticipantDeviceAdded = 10
	/// Conference participant device (removed) event. 
	case ConferenceParticipantDeviceRemoved = 11
	/// Conference participant device (media changed) event. 
	case ConferenceParticipantDeviceMediaChanged = 17
	/// Conference subject event. 
	case ConferenceSubjectChanged = 12
	/// Conference available media event. 
	case ConferenceAvailableMediaChanged = 18
	/// Conference encryption security event. 
	case ConferenceSecurityEvent = 13
	/// Conference ephemeral message (ephemeral message lifetime changed) event. 
	case ConferenceEphemeralMessageLifetimeChanged = 14
	/// Conference ephemeral message (ephemeral message enabled) event. 
	case ConferenceEphemeralMessageEnabled = 15
	/// Conference ephemeral message (ephemeral message disabled) event. 
	case ConferenceEphemeralMessageDisabled = 16
	/// Conference ephemeral message (ephemeral message settings managed by admin)
	/// event. 
	case ConferenceEphemeralMessageManagedByAdmin = 19
	/// Conference ephemeral message (ephemeral message settings managed by
	/// participants) event. 
	case ConferenceEphemeralMessageManagedByParticipants = 20
}
///Enum describing the capabilities of a `Friend`, populated through presence
///subscribe/notify process. 
public struct FriendCapability:OptionSet
{
	public let rawValue: Int

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	/// No capabilities populated. 
	public static let None = FriendCapability([])
	/// This friend can be invited in a Flexisip backend `ChatRoom`. 
	public static let GroupChat = FriendCapability(rawValue: 1<<0)
	/// This friend can be invited in a Flexisip backend end-to-end encrypted
	/// `ChatRoom`. 
	public static let LimeX3Dh = FriendCapability(rawValue: 1<<1)
	/// This friend is able to delete ephemeral messages once they have expired. 
	public static let EphemeralMessages = FriendCapability(rawValue: 1<<2)
}
///The types of FriendList. 
public enum FriendListType:Int
{
	case CardDAV = 0
	case VCard4 = 1
}
///Describes the global state of the `Core` object. 
public enum GlobalState:Int
{
	/// State in which we're in after Core.stop(). 
	case Off = 0
	/// Transient state for when we call Core.start() 
	case Startup = 1
	/// Indicates `Core` has been started and is up and running. 
	case On = 2
	/// Transient state for when we call Core.stop() 
	case Shutdown = 3
	/// Transient state between Startup and On if there is a remote provisionning URI
	/// configured. 
	case Configuring = 4
	/// `Core` state after being created by linphone_factory_create_core, generally
	/// followed by a call to Core.start() 
	case Ready = 5
}
///Enum describing ICE states. 
public enum IceState:Int
{
	/// ICE has not been activated for this call or stream. 
	case NotActivated = 0
	/// ICE processing has failed. 
	case Failed = 1
	/// ICE process is in progress. 
	case InProgress = 2
	/// ICE has established a direct connection to the remote host. 
	case HostConnection = 3
	/// ICE has established a connection to the remote host through one or several
	/// NATs. 
	case ReflexiveConnection = 4
	/// ICE has established a connection through a relay. 
	case RelayConnection = 5
}
///Enum describing how the authentification will be made. 
public enum LdapAuthMethod:Int
{
	/// Connection without passwords. 
	case Anonymous = 0
	/// Connection with username/password. 
	case Simple = 1
}
///Enum describing server certificates verification modes. 
public enum LdapCertVerificationMode:Int
{
	/// Use default value defined on core. 
	case Default = -1
	/// Verification is disabled. 
	case Disabled = 0
	/// Verification is enabled. 
	case Enabled = 1
}
///Enum describing errors in LDAP parameters. 
public enum LdapCheck:Int
{
	/// No error. 
	case Ok = 0
	/// Server field is empty. 
	case ServerEmpty = 1
	/// The server is not an url. 
	case ServerNotUrl = 2
	/// The server doesn't contain a scheme. 
	case ServerNoScheme = 4
	/// The server is not a LDAP scheme. 
	case ServerNotLdap = 8
	/// LDAP over SSL is non-standardized and deprecated: ldaps has been specified. 
	case ServerLdaps = 16
	/// Base Object has been specified. 
	case BaseObjectEmpty = 32
	/// Some required fields are missing. 
	case MissingFields = 64
}
///Enum Debug verbosity for OpenLdap. 
public enum LdapDebugLevel:Int
{
	/// Set OpenLdap verbosity to none. 
	case Off = 0
	/// Set OpenLdap verbosity to debug level. 
	case Verbose = 1
}
public enum LimeState:Int
{
	/// Lime is not used at all. 
	case Disabled = 0
	/// Lime is always used. 
	case Mandatory = 1
	/// Lime is used only if we already shared a secret with remote. 
	case Preferred = 2
}
///Whether or not to keep a file with the logs. 
public enum LogCollectionState:Int
{
	case Disabled = 0
	case Enabled = 1
	case EnabledWithoutPreviousLogHandler = 2
}
///Verbosity levels of log messages. 
public struct LogLevel:OptionSet
{
	public let rawValue: Int

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	/// Level for debug messages. 
	public static let Debug = LogLevel(rawValue: 1<<0)
	/// Level for traces. 
	public static let Trace = LogLevel(rawValue: 1<<1)
	/// Level for information messages. 
	public static let Message = LogLevel(rawValue: 1<<2)
	/// Level for warning messages. 
	public static let Warning = LogLevel(rawValue: 1<<3)
	/// Level for error messages. 
	public static let Error = LogLevel(rawValue: 1<<4)
	/// Level for fatal error messages. 
	public static let Fatal = LogLevel(rawValue: 1<<5)
}
///Enum describing how to merge `SearchResult` from `MagicSearch`. 
public enum MagicSearchAggregation:Int
{
	/// No aggregation is done, you can have multiple SearchResult with the same
	/// Friend. 
	case None = 0
	/// Aggregation is done by friend, you will have at most a SearchResult per Friend. 
	case Friend = 1
}
///Enum describing the search categories for Magic Search. 
public struct MagicSearchSource:OptionSet
{
	public let rawValue: Int

	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	/// no Source specified. 
	public static let None = MagicSearchSource([])
	/// Search in friends only. 
	public static let Friends = MagicSearchSource(rawValue: 1<<0)
	/// Search in Call Logs. 
	public static let CallLogs = MagicSearchSource(rawValue: 1<<1)
	/// Search in LDAP servers. 
	public static let LdapServers = MagicSearchSource(rawValue: 1<<2)
	/// Search in Chat rooms participants. 
	public static let ChatRooms = MagicSearchSource(rawValue: 1<<3)
	/// Search from request : it is usually an address built from the request. 
	public static let Request = MagicSearchSource(rawValue: 1<<4)
	/// Search in all sources. 
	public static let All = MagicSearchSource(rawValue: -1)
}
///Indicates for a given media the stream direction. 
public enum MediaDirection:Int
{
	case Invalid = -1
	case Inactive = 0
	/// No active media not supported yet. 
	case SendOnly = 1
	/// Send only mode. 
	case RecvOnly = 2
	/// recv only mode 
	case SendRecv = 3
}
///Enum describing type of media encryption types. 
public enum MediaEncryption:Int
{
	/// No media encryption is used. 
	case None = 0
	/// Use SRTP media encryption. 
	case SRTP = 1
	/// Use ZRTP media encryption. 
	case ZRTP = 2
	/// Use DTLS media encryption. 
	case DTLS = 3
}
///Media resource usage. 
public enum MediaResourceMode:Int
{
	/// Media resources are not shared. 
	case ExclusiveMediaResources = 0
	/// Media resources are shared. 
	case SharedMediaResources = 1
}
///Activities as defined in section 3.2 of RFC 4480. 
public enum PresenceActivityType:Int
{
	/// The person has a calendar appointment, without specifying exactly of what type. 
	case Appointment = 0
	/// The person is physically away from all interactive communication devices. 
	case Away = 1
	/// The person is eating the first meal of the day, usually eaten in the morning. 
	case Breakfast = 2
	/// The person is busy, without further details. 
	case Busy = 3
	/// The person is having his or her main meal of the day, eaten in the evening or
	/// at midday. 
	case Dinner = 4
	/// This is a scheduled national or local holiday. 
	case Holiday = 5
	/// The person is riding in a vehicle, such as a car, but not steering. 
	case InTransit = 6
	/// The person is looking for (paid) work. 
	case LookingForWork = 7
	/// The person is eating his or her midday meal. 
	case Lunch = 8
	/// The person is scheduled for a meal, without specifying whether it is breakfast,
	/// lunch, or dinner, or some other meal. 
	case Meal = 9
	/// The person is in an assembly or gathering of people, as for a business, social,
	/// or religious purpose. 
	case Meeting = 10
	/// The person is talking on the telephone. 
	case OnThePhone = 11
	/// The person is engaged in an activity with no defined representation. 
	case Other = 12
	/// A performance is a sub-class of an appointment and includes musical,
	/// theatrical, and cinematic performances as well as lectures. 
	case Performance = 13
	/// The person will not return for the foreseeable future, e.g., because it is no
	/// longer working for the company. 
	case PermanentAbsence = 14
	/// The person is occupying himself or herself in amusement, sport, or other
	/// recreation. 
	case Playing = 15
	/// The person is giving a presentation, lecture, or participating in a formal
	/// round-table discussion. 
	case Presentation = 16
	/// The person is visiting stores in search of goods or services. 
	case Shopping = 17
	/// The person is sleeping. 
	case Sleeping = 18
	/// The person is observing an event, such as a sports event. 
	case Spectator = 19
	/// The person is controlling a vehicle, watercraft, or plane. 
	case Steering = 20
	/// The person is on a business or personal trip, but not necessarily in-transit. 
	case Travel = 21
	/// The person is watching television. 
	case TV = 22
	/// The activity of the person is unknown. 
	case Unknown = 23
	/// A period of time devoted to pleasure, rest, or relaxation. 
	case Vacation = 24
	/// The person is engaged in, typically paid, labor, as part of a profession or
	/// job. 
	case Working = 25
	/// The person is participating in religious rites. 
	case Worship = 26
}
///Basic status as defined in section 4.1.4 of RFC 3863. 
public enum PresenceBasicStatus:Int
{
	/// This value means that the associated contact element, if any, is ready to
	/// accept communication. 
	case Open = 0
	/// This value means that the associated contact element, if any, is unable to
	/// accept communication. 
	case Closed = 1
}
///Defines privacy policy to apply as described by rfc3323. 
public enum Privacy:Int
{
	/// Privacy services must not perform any privacy function. 
	case None = 0
	/// Request that privacy services provide a user-level privacy function. 
	case User = 1
	/// Request that privacy services modify headers that cannot be set arbitrarily by
	/// the user (Contact/Via). 
	case Header = 2
	/// Request that privacy services provide privacy for session media. 
	case Session = 4
	/// rfc3325 The presence of this privacy type in a Privacy header field indicates
	/// that the user would like the Network Asserted Identity to be kept private with
	/// respect to SIP entities outside the Trust Domain with which the user
	/// authenticated. 
	case Id = 8
	/// Privacy service must perform the specified services or fail the request. 
	case Critical = 16
	/// Special keyword to use privacy as defined either globally or by proxy using
	/// ProxyConfig.setPrivacy() 
	case Default = 32768
}
///Enum for publish states. 
public enum PublishState:Int
{
	/// Initial state, do not use. 
	case None = 0
	/// An outgoing publish was created and submitted. 
	case Progress = 1
	/// Publish is accepted. 
	case Ok = 2
	/// Publish encoutered an error, Event.getReason() gives reason code. 
	case Error = 3
	/// Publish is about to expire, only sent if [sip]->refresh_generic_publish
	/// property is set to 0. 
	case Expiring = 4
	/// Event has been un published. 
	case Cleared = 5
}
///Enum describing various failure reasons or contextual information for some
///events. 
public enum Reason:Int
{
	/// No reason has been set by the core. 
	case None = 0
	/// No response received from remote. 
	case NoResponse = 1
	/// Authentication failed due to bad credentials or resource forbidden. 
	case Forbidden = 2
	/// The call has been declined. 
	case Declined = 3
	/// Destination of the call was not found. 
	case NotFound = 4
	/// The call was not answered in time (request timeout) 
	case NotAnswered = 5
	/// Phone line was busy. 
	case Busy = 6
	/// Unsupported content. 
	case UnsupportedContent = 7
	/// Bad event. 
	case BadEvent = 8
	/// Transport error: connection failures, disconnections etc... 
	case IOError = 9
	/// Do not disturb reason. 
	case DoNotDisturb = 10
	/// Operation is unauthorized because missing credential. 
	case Unauthorized = 11
	/// Operation is rejected due to incompatible or unsupported media parameters. 
	case NotAcceptable = 12
	/// Operation could not be executed by server or remote client because it didn't
	/// have any context for it. 
	case NoMatch = 13
	/// Resource moved permanently. 
	case MovedPermanently = 14
	/// Resource no longer exists. 
	case Gone = 15
	/// Temporarily unavailable. 
	case TemporarilyUnavailable = 16
	/// Address incomplete. 
	case AddressIncomplete = 17
	/// Not implemented. 
	case NotImplemented = 18
	/// Bad gateway. 
	case BadGateway = 19
	/// The received request contains a Session-Expires header field with a duration
	/// below the minimum timer. 
	case SessionIntervalTooSmall = 20
	/// Server timeout. 
	case ServerTimeout = 21
	/// Unknown reason. 
	case Unknown = 22
	/// The call has been transferred. 
	case Transferred = 23
}
///Enum representing the file format of a recording. 
public enum RecorderFileFormat:Int
{
	case Unknown = 0
	case Wav = 1
	case Mkv = 2
}
///Enum representing the state of a recording. 
public enum RecorderState:Int
{
	/// No file is opened for recording. 
	case Closed = 0
	/// The recorder is paused. 
	case Paused = 1
	/// The recorder is running. 
	case Running = 2
}
///Describes proxy registration states. 
public enum RegistrationState:Int
{
	/// Initial state for registrations. 
	case None = 0
	/// Registration is in progress. 
	case Progress = 1
	/// Registration is successful. 
	case Ok = 2
	/// Unregistration succeeded. 
	case Cleared = 3
	/// Registration failed. 
	case Failed = 4
}
///`SecurityEventType` is used to indicate the type of security event. 
public enum SecurityEventType:Int
{
	/// Event is not a security event. 
	case None = 0
	/// Chatroom security level downgraded event. 
	case SecurityLevelDowngraded = 1
	/// Participant has exceeded the maximum number of device event. 
	case ParticipantMaxDeviceCountExceeded = 2
	/// Peer device instant messaging encryption identity key has changed event. 
	case EncryptionIdentityKeyChanged = 3
	/// Man in the middle detected event. 
	case ManInTheMiddleDetected = 4
}
///Session Timers refresher. 
public enum SessionExpiresRefresher:Int
{
	case Unspecified = 0
	case UAS = 1
	case UAC = 2
}
///Enum describing the stream types. 
public enum StreamType:Int
{
	case Audio = 0
	case Video = 1
	case Text = 2
	case Unknown = 3
}
///Enum controlling behavior for incoming subscription request. 
public enum SubscribePolicy:Int
{
	/// Does not automatically accept an incoming subscription request. 
	case SPWait = 0
	/// Rejects incoming subscription request. 
	case SPDeny = 1
	/// Automatically accepts a subscription request. 
	case SPAccept = 2
}
///Enum for subscription direction (incoming or outgoing). 
public enum SubscriptionDir:Int
{
	/// Incoming subscription. 
	case Incoming = 0
	/// Outgoing subscription. 
	case Outgoing = 1
	/// Invalid subscription direction. 
	case InvalidDir = 2
}
///Enum for subscription states. 
public enum SubscriptionState:Int
{
	/// Initial state, should not be used. 
	case None = 0
	/// An outgoing subcription was sent. 
	case OutgoingProgress = 1
	/// An incoming subcription is received. 
	case IncomingReceived = 2
	/// Subscription is pending, waiting for user approval. 
	case Pending = 3
	/// Subscription is accepted. 
	case Active = 4
	/// Subscription is terminated normally. 
	case Terminated = 5
	/// Subscription was terminated by an error, indicated by Event.getReason() 
	case Error = 6
	/// Subscription is about to expire, only sent if [sip]->refresh_generic_subscribe
	/// property is set to 0. 
	case Expiring = 7
}
public enum SupportLevel:Int
{
	/// No support for the feature. 
	case NoSupport = 0
	/// Optional support for the feature. 
	case Optional = 1
	/// Mandatory support for the feature. 
	case Mandatory = 2
}
///Enum listing frequent telephony tones. 
public enum ToneID:Int
{
	/// Not a tone. 
	case Undefined = 0
	/// Busy tone. 
	case Busy = 1
	case CallWaiting = 2
	/// Call waiting tone. 
	case CallOnHold = 3
	/// Call on hold tone. 
	case CallLost = 4
	/// Tone played when call is abruptly disconnected (media lost) 
	case CallEnd = 5
}
///Enum describing transport type for LinphoneAddress. 
public enum TransportType:Int
{
	case Udp = 0
	case Tcp = 1
	case Tls = 2
	case Dtls = 3
}
///Enum describing uPnP states. 
public enum UpnpState:Int
{
	/// uPnP is not activate 
	case Idle = 0
	/// uPnP process is in progress 
	case Pending = 1
	/// Internal use: Only used by port binding. 
	case Adding = 2
	/// Internal use: Only used by port binding. 
	case Removing = 3
	/// uPnP is not available 
	case NotAvailable = 4
	/// uPnP is enabled 
	case Ok = 5
	/// uPnP processing has failed 
	case Ko = 6
	/// IGD router is blacklisted. 
	case Blacklisted = 7
}
///Enum describing the result of a version update check. 
public enum VersionUpdateCheckResult:Int
{
	case UpToDate = 0
	case NewVersionAvailable = 1
	case Error = 2
}
///Enum describing the types of argument for LinphoneXmlRpcRequest. 
public enum XmlRpcArgType:Int
{
	case None = 0
	case Int = 1
	case String = 2
	case StringStruct = 3
}
///Enum describing the status of a LinphoneXmlRpcRequest. 
public enum XmlRpcStatus:Int
{
	case Pending = 0
	case Ok = 1
	case Failed = 2
}
///Enum describing the ZRTP SAS validation status of a peer URI. 
public enum ZrtpPeerStatus:Int
{
	/// Peer URI unkown or never validated/invalidated the SAS. 
	case Unknown = 0
	/// Peer URI SAS rejected in database. 
	case Invalid = 1
	/// Peer URI SAS validated in database. 
	case Valid = 2
}


func charArrayToString(charPointer: UnsafePointer<CChar>?) -> String {
	return charPointer != nil ? String(cString: charPointer!) : ""
}

/// Class basic linphone class
public class LinphoneObject {
	var cPtr:OpaquePointer?

	/*!
     Initializes a new LinphoneObject with the provided cPointer.

     - Parameters:
        - cPointer: The OpaquePointer of c lib

     - Returns: new LinphoneObject
  */
	init(cPointer:OpaquePointer) {
		cPtr = cPointer
		belle_sip_object_ref(UnsafeMutableRawPointer(cPtr))
	}

	deinit {
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  nil, nil)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPtr))
	}
}

func StringArrayToBctbxList(list: [String]?) -> UnsafeMutablePointer<bctbx_list_t>? {
	var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
	for data in list ?? [] {
		let sData:NSString = data as NSString
		cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
	}
	return cList
}

func BctbxListToStringArray(list: UnsafeMutablePointer<bctbx_list_t>) -> [String]? {
	var sList = [String]()
	var cList = list
	while (cList.pointee.data != nil) {
		sList.append(String(cString: unsafeBitCast(cList.pointee.data, to: UnsafePointer<CChar>.self)))
		cList = UnsafeMutablePointer<bctbx_list_t>(cList.pointee.next)
	}
	return sList
}

func ObjectArrayToBctbxList<T:LinphoneObject>(list: [T]?) -> UnsafeMutablePointer<bctbx_list_t>? {
	var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
	for data in list ?? []{
		cList = bctbx_list_append(cList, UnsafeMutableRawPointer(data.cPtr))
	}
	return cList
}

#if canImport(SwiftUI) && (os(iOS) || os(tvOS)) && (arch(arm64) || arch(x86_64)) ///does not compile on armv7 nor macOS
@available(iOS 13.0, tvOS 13.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
/// Add this object in your SwiftUI while giving him the callback necessary to link its view to the Core (using Core.nativeVideoWindowId for example).
public struct LinphoneVideoViewHolder: UIViewRepresentable {
	private let _view = UIView()
	private let _setVideoWindowFn : (UIView) -> Void

	public init(setVideoWindowFn : @escaping (UIView) -> Void)
	{
		_setVideoWindowFn = setVideoWindowFn
	}

	public func makeUIView(context: Context) -> UIView {
		_setVideoWindowFn(_view)
		return _view
	}

	public func updateUIView(_ uiView: UIView, context: Context) {}
}
#endif

protocol LinphoneObjectDelegate {
	var cPtr: OpaquePointer {get set}
}

enum LinphoneError: Error {
	case exception(result: String)
}


public protocol AccountCreatorDelegate : AnyObject {
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object   
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// - Parameter response: The response has a string   
	func onCreateAccount(creator: AccountCreator, status: AccountCreator.Status, response: String)
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object   
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// - Parameter response: The response has a string   
	func onIsAccountExist(creator: AccountCreator, status: AccountCreator.Status, response: String)
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object   
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// - Parameter response: The response has a string   
	func onActivateAccount(creator: AccountCreator, status: AccountCreator.Status, response: String)
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object   
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// - Parameter response: The response has a string   
	func onSendToken(creator: AccountCreator, status: AccountCreator.Status, response: String)
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object   
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// - Parameter response: The response has a string   
	func onIsAccountActivated(creator: AccountCreator, status: AccountCreator.Status, response: String)
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object   
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// - Parameter response: The response has a string   
	func onLinkAccount(creator: AccountCreator, status: AccountCreator.Status, response: String)
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object   
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// - Parameter response: The response has a string   
	func onActivateAlias(creator: AccountCreator, status: AccountCreator.Status, response: String)
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object   
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// - Parameter response: The response has a string   
	func onIsAliasUsed(creator: AccountCreator, status: AccountCreator.Status, response: String)
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object   
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// - Parameter response: The response has a string   
	func onIsAccountLinked(creator: AccountCreator, status: AccountCreator.Status, response: String)
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object   
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// - Parameter response: The response has a string   
	func onRecoverAccount(creator: AccountCreator, status: AccountCreator.Status, response: String)
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object   
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// - Parameter response: The response has a string   
	func onUpdateAccount(creator: AccountCreator, status: AccountCreator.Status, response: String)
	///	Callback to notify a response of server. 
	/// - Parameter creator: LinphoneAccountCreator object   
	/// - Parameter status: The status of the LinphoneAccountCreator test existence
	/// operation that has just finished 
	/// - Parameter response: The response has a string   
	func onLoginLinphoneAccount(creator: AccountCreator, status: AccountCreator.Status, response: String)
}

public extension AccountCreatorDelegate {
	func onCreateAccount(creator: AccountCreator, status: AccountCreator.Status, response: String) {}
	func onIsAccountExist(creator: AccountCreator, status: AccountCreator.Status, response: String) {}
	func onActivateAccount(creator: AccountCreator, status: AccountCreator.Status, response: String) {}
	func onSendToken(creator: AccountCreator, status: AccountCreator.Status, response: String) {}
	func onIsAccountActivated(creator: AccountCreator, status: AccountCreator.Status, response: String) {}
	func onLinkAccount(creator: AccountCreator, status: AccountCreator.Status, response: String) {}
	func onActivateAlias(creator: AccountCreator, status: AccountCreator.Status, response: String) {}
	func onIsAliasUsed(creator: AccountCreator, status: AccountCreator.Status, response: String) {}
	func onIsAccountLinked(creator: AccountCreator, status: AccountCreator.Status, response: String) {}
	func onRecoverAccount(creator: AccountCreator, status: AccountCreator.Status, response: String) {}
	func onUpdateAccount(creator: AccountCreator, status: AccountCreator.Status, response: String) {}
	func onLoginLinphoneAccount(creator: AccountCreator, status: AccountCreator.Status, response: String) {}
}

public final class AccountCreatorDelegateStub : AccountCreatorDelegate
{
	var _onCreateAccount: ((AccountCreator, AccountCreator.Status, String) -> Void)?
	var _onIsAccountExist: ((AccountCreator, AccountCreator.Status, String) -> Void)?
	var _onActivateAccount: ((AccountCreator, AccountCreator.Status, String) -> Void)?
	var _onSendToken: ((AccountCreator, AccountCreator.Status, String) -> Void)?
	var _onIsAccountActivated: ((AccountCreator, AccountCreator.Status, String) -> Void)?
	var _onLinkAccount: ((AccountCreator, AccountCreator.Status, String) -> Void)?
	var _onActivateAlias: ((AccountCreator, AccountCreator.Status, String) -> Void)?
	var _onIsAliasUsed: ((AccountCreator, AccountCreator.Status, String) -> Void)?
	var _onIsAccountLinked: ((AccountCreator, AccountCreator.Status, String) -> Void)?
	var _onRecoverAccount: ((AccountCreator, AccountCreator.Status, String) -> Void)?
	var _onUpdateAccount: ((AccountCreator, AccountCreator.Status, String) -> Void)?
	var _onLoginLinphoneAccount: ((AccountCreator, AccountCreator.Status, String) -> Void)?

	public func onCreateAccount(creator: AccountCreator, status: AccountCreator.Status, response: String){_onCreateAccount.map{$0(creator, status, response)}}
	public func onIsAccountExist(creator: AccountCreator, status: AccountCreator.Status, response: String){_onIsAccountExist.map{$0(creator, status, response)}}
	public func onActivateAccount(creator: AccountCreator, status: AccountCreator.Status, response: String){_onActivateAccount.map{$0(creator, status, response)}}
	public func onSendToken(creator: AccountCreator, status: AccountCreator.Status, response: String){_onSendToken.map{$0(creator, status, response)}}
	public func onIsAccountActivated(creator: AccountCreator, status: AccountCreator.Status, response: String){_onIsAccountActivated.map{$0(creator, status, response)}}
	public func onLinkAccount(creator: AccountCreator, status: AccountCreator.Status, response: String){_onLinkAccount.map{$0(creator, status, response)}}
	public func onActivateAlias(creator: AccountCreator, status: AccountCreator.Status, response: String){_onActivateAlias.map{$0(creator, status, response)}}
	public func onIsAliasUsed(creator: AccountCreator, status: AccountCreator.Status, response: String){_onIsAliasUsed.map{$0(creator, status, response)}}
	public func onIsAccountLinked(creator: AccountCreator, status: AccountCreator.Status, response: String){_onIsAccountLinked.map{$0(creator, status, response)}}
	public func onRecoverAccount(creator: AccountCreator, status: AccountCreator.Status, response: String){_onRecoverAccount.map{$0(creator, status, response)}}
	public func onUpdateAccount(creator: AccountCreator, status: AccountCreator.Status, response: String){_onUpdateAccount.map{$0(creator, status, response)}}
	public func onLoginLinphoneAccount(creator: AccountCreator, status: AccountCreator.Status, response: String){_onLoginLinphoneAccount.map{$0(creator, status, response)}}

	public init (
		onCreateAccount: ((AccountCreator, AccountCreator.Status, String) -> Void)? = nil,
		onIsAccountExist: ((AccountCreator, AccountCreator.Status, String) -> Void)? = nil,
		onActivateAccount: ((AccountCreator, AccountCreator.Status, String) -> Void)? = nil,
		onSendToken: ((AccountCreator, AccountCreator.Status, String) -> Void)? = nil,
		onIsAccountActivated: ((AccountCreator, AccountCreator.Status, String) -> Void)? = nil,
		onLinkAccount: ((AccountCreator, AccountCreator.Status, String) -> Void)? = nil,
		onActivateAlias: ((AccountCreator, AccountCreator.Status, String) -> Void)? = nil,
		onIsAliasUsed: ((AccountCreator, AccountCreator.Status, String) -> Void)? = nil,
		onIsAccountLinked: ((AccountCreator, AccountCreator.Status, String) -> Void)? = nil,
		onRecoverAccount: ((AccountCreator, AccountCreator.Status, String) -> Void)? = nil,
		onUpdateAccount: ((AccountCreator, AccountCreator.Status, String) -> Void)? = nil,
		onLoginLinphoneAccount: ((AccountCreator, AccountCreator.Status, String) -> Void)? = nil
	) {
		self._onCreateAccount = onCreateAccount
		self._onIsAccountExist = onIsAccountExist
		self._onActivateAccount = onActivateAccount
		self._onSendToken = onSendToken
		self._onIsAccountActivated = onIsAccountActivated
		self._onLinkAccount = onLinkAccount
		self._onActivateAlias = onActivateAlias
		self._onIsAliasUsed = onIsAliasUsed
		self._onIsAccountLinked = onIsAccountLinked
		self._onRecoverAccount = onRecoverAccount
		self._onUpdateAccount = onUpdateAccount
		self._onLoginLinphoneAccount = onLoginLinphoneAccount
	}
}

class AccountCreatorDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: AccountCreatorDelegate?

	public init() {
		cPtr = linphone_factory_create_account_creator_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<AccountCreatorDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_account_creator_cbs_set_create_account(cPtr, { (creator, status, response) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentDelegate
				delegate?.onCreateAccount(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, response: charArrayToString(charPointer: response))
			}
		})

		linphone_account_creator_cbs_set_is_account_exist(cPtr, { (creator, status, response) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentDelegate
				delegate?.onIsAccountExist(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, response: charArrayToString(charPointer: response))
			}
		})

		linphone_account_creator_cbs_set_activate_account(cPtr, { (creator, status, response) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentDelegate
				delegate?.onActivateAccount(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, response: charArrayToString(charPointer: response))
			}
		})

		linphone_account_creator_cbs_set_send_token(cPtr, { (creator, status, response) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentDelegate
				delegate?.onSendToken(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, response: charArrayToString(charPointer: response))
			}
		})

		linphone_account_creator_cbs_set_is_account_activated(cPtr, { (creator, status, response) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentDelegate
				delegate?.onIsAccountActivated(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, response: charArrayToString(charPointer: response))
			}
		})

		linphone_account_creator_cbs_set_link_account(cPtr, { (creator, status, response) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentDelegate
				delegate?.onLinkAccount(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, response: charArrayToString(charPointer: response))
			}
		})

		linphone_account_creator_cbs_set_activate_alias(cPtr, { (creator, status, response) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentDelegate
				delegate?.onActivateAlias(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, response: charArrayToString(charPointer: response))
			}
		})

		linphone_account_creator_cbs_set_is_alias_used(cPtr, { (creator, status, response) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentDelegate
				delegate?.onIsAliasUsed(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, response: charArrayToString(charPointer: response))
			}
		})

		linphone_account_creator_cbs_set_is_account_linked(cPtr, { (creator, status, response) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentDelegate
				delegate?.onIsAccountLinked(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, response: charArrayToString(charPointer: response))
			}
		})

		linphone_account_creator_cbs_set_recover_account(cPtr, { (creator, status, response) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentDelegate
				delegate?.onRecoverAccount(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, response: charArrayToString(charPointer: response))
			}
		})

		linphone_account_creator_cbs_set_update_account(cPtr, { (creator, status, response) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentDelegate
				delegate?.onUpdateAccount(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, response: charArrayToString(charPointer: response))
			}
		})

		linphone_account_creator_cbs_set_login_linphone_account(cPtr, { (creator, status, response) -> Void in
			if (creator != nil) {
				let sObject = AccountCreator.getSwiftObject(cObject: creator!)
				let delegate = sObject.currentDelegate
				delegate?.onLoginLinphoneAccount(creator: sObject, status: AccountCreator.Status(rawValue: Int(status.rawValue))!, response: charArrayToString(charPointer: response))
			}
		})
	}


}

public protocol AccountDelegate : AnyObject {
	///	Callback for notifying when a registration state has changed for the account. 
	/// - Parameter account: LinphoneAccount object whose registration state changed.   
	/// - Parameter state: The current LinphoneRegistrationState. 
	/// - Parameter message: A non nil informational message about the state.   
	func onRegistrationStateChanged(account: Account, state: RegistrationState, message: String)
}

public extension AccountDelegate {
	func onRegistrationStateChanged(account: Account, state: RegistrationState, message: String) {}
}

public final class AccountDelegateStub : AccountDelegate
{
	var _onRegistrationStateChanged: ((Account, RegistrationState, String) -> Void)?

	public func onRegistrationStateChanged(account: Account, state: RegistrationState, message: String){_onRegistrationStateChanged.map{$0(account, state, message)}}

	public init (
		onRegistrationStateChanged: ((Account, RegistrationState, String) -> Void)? = nil
	) {
		self._onRegistrationStateChanged = onRegistrationStateChanged
	}
}

class AccountDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: AccountDelegate?

	public init() {
		cPtr = linphone_factory_create_account_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<AccountDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_account_cbs_set_registration_state_changed(cPtr, { (account, state, message) -> Void in
			if (account != nil) {
				let sObject = Account.getSwiftObject(cObject: account!)
				let delegate = sObject.currentDelegate
				delegate?.onRegistrationStateChanged(account: sObject, state: RegistrationState(rawValue: Int(state.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})
	}


}

public protocol CallDelegate : AnyObject {
	///	Callback for being notified of received DTMFs. 
	/// - Parameter call: LinphoneCall object that received the dtmf   
	/// - Parameter dtmf: The ascii code of the dtmf 
	func onDtmfReceived(call: Call, dtmf: Int)
	///	Call encryption changed callback. 
	/// - Parameter call: LinphoneCall object whose encryption is changed.   
	/// - Parameter on: Whether encryption is activated. 
	/// - Parameter authenticationToken: An authentication_token, currently set for
	/// ZRTP kind of encryption only.   
	func onEncryptionChanged(call: Call, on: Bool, authenticationToken: String)
	///	Callback for receiving info messages. 
	/// - Parameter call: LinphoneCall whose info message belongs to.   
	/// - Parameter message: LinphoneInfoMessage object.   
	func onInfoMessageReceived(call: Call, message: InfoMessage)
	///	Call state notification callback. 
	/// - Parameter call: LinphoneCall whose state is changed.   
	/// - Parameter state: The new LinphoneCallState of the call 
	/// - Parameter message: An informational message about the state.   
	func onStateChanged(call: Call, state: Call.State, message: String)
	///	Callback for receiving quality statistics for calls. 
	/// - Parameter call: LinphoneCall object whose statistics are notified   
	/// - Parameter stats: LinphoneCallStats object   
	func onStatsUpdated(call: Call, stats: CallStats)
	///	Callback for notifying progresses of transfers. 
	/// - Parameter call: LinphoneCall that was transfered   
	/// - Parameter state: The LinphoneCallState of the call to transfer target at the
	/// far end. 
	func onTransferStateChanged(call: Call, state: Call.State)
	///	Callback for notifying the processing SIP ACK messages. 
	/// - Parameter call: LinphoneCall for which an ACK is being received or sent   
	/// - Parameter ack: the ACK LinphoneHeaders   
	/// - Parameter isReceived: if true this ACK is an incoming one, otherwise it is an
	/// ACK about to be sent. 
	func onAckProcessing(call: Call, ack: Headers, isReceived: Bool)
	///	Callback for notifying a received TMMBR. 
	/// - Parameter call: LinphoneCall for which the TMMBR has changed   
	/// - Parameter streamIndex: the index of the current stream 
	/// - Parameter tmmbr: the value of the received TMMBR 
	func onTmmbrReceived(call: Call, streamIndex: Int, tmmbr: Int)
	///	Callback for notifying a snapshot taken. 
	/// - Parameter call: LinphoneCall for which the snapshot was taken   
	/// - Parameter filePath: the name of the saved file   
	func onSnapshotTaken(call: Call, filePath: String)
	///	Callback to notify a next video frame has been decoded. 
	/// - Parameter call: LinphoneCall for which the next video frame has been decoded 
	///  
	func onNextVideoFrameDecoded(call: Call)
	///	Callback to notify that the camera is not working and has been changed to "No
	///	Webcam". 
	/// A camera is detected as mis-functionning as soon as it outputs no frames at all
	/// during a period of 5 seconds. This check is only performed on desktop
	/// platforms, in the purpose of notifying camera failures, for example if when a
	/// usb cable gets disconnected.
	/// - Parameter call: LinphoneCall for which the next video frame has been decoded 
	///  
	/// - Parameter cameraName: the name of the non-working camera   
	func onCameraNotWorking(call: Call, cameraName: String)
	///	Callback to notify that the audio device has been changed. 
	/// - Parameter call: LinphoneCall for which the audio device has changed   
	/// - Parameter audioDevice: the new audio device used for this call   
	func onAudioDeviceChanged(call: Call, audioDevice: AudioDevice)
	///	Callback to notify that the call is being recorded by the remote. 
	/// - Parameter call: LinphoneCall for which the audio is recorded   
	/// - Parameter recording: true if the call is being recorded by the remote, false
	/// otherwise 
	func onRemoteRecording(call: Call, recording: Bool)
}

public extension CallDelegate {
	func onDtmfReceived(call: Call, dtmf: Int) {}
	func onEncryptionChanged(call: Call, on: Bool, authenticationToken: String) {}
	func onInfoMessageReceived(call: Call, message: InfoMessage) {}
	func onStateChanged(call: Call, state: Call.State, message: String) {}
	func onStatsUpdated(call: Call, stats: CallStats) {}
	func onTransferStateChanged(call: Call, state: Call.State) {}
	func onAckProcessing(call: Call, ack: Headers, isReceived: Bool) {}
	func onTmmbrReceived(call: Call, streamIndex: Int, tmmbr: Int) {}
	func onSnapshotTaken(call: Call, filePath: String) {}
	func onNextVideoFrameDecoded(call: Call) {}
	func onCameraNotWorking(call: Call, cameraName: String) {}
	func onAudioDeviceChanged(call: Call, audioDevice: AudioDevice) {}
	func onRemoteRecording(call: Call, recording: Bool) {}
}

public final class CallDelegateStub : CallDelegate
{
	var _onDtmfReceived: ((Call, Int) -> Void)?
	var _onEncryptionChanged: ((Call, Bool, String) -> Void)?
	var _onInfoMessageReceived: ((Call, InfoMessage) -> Void)?
	var _onStateChanged: ((Call, Call.State, String) -> Void)?
	var _onStatsUpdated: ((Call, CallStats) -> Void)?
	var _onTransferStateChanged: ((Call, Call.State) -> Void)?
	var _onAckProcessing: ((Call, Headers, Bool) -> Void)?
	var _onTmmbrReceived: ((Call, Int, Int) -> Void)?
	var _onSnapshotTaken: ((Call, String) -> Void)?
	var _onNextVideoFrameDecoded: ((Call) -> Void)?
	var _onCameraNotWorking: ((Call, String) -> Void)?
	var _onAudioDeviceChanged: ((Call, AudioDevice) -> Void)?
	var _onRemoteRecording: ((Call, Bool) -> Void)?

	public func onDtmfReceived(call: Call, dtmf: Int){_onDtmfReceived.map{$0(call, dtmf)}}
	public func onEncryptionChanged(call: Call, on: Bool, authenticationToken: String){_onEncryptionChanged.map{$0(call, on, authenticationToken)}}
	public func onInfoMessageReceived(call: Call, message: InfoMessage){_onInfoMessageReceived.map{$0(call, message)}}
	public func onStateChanged(call: Call, state: Call.State, message: String){_onStateChanged.map{$0(call, state, message)}}
	public func onStatsUpdated(call: Call, stats: CallStats){_onStatsUpdated.map{$0(call, stats)}}
	public func onTransferStateChanged(call: Call, state: Call.State){_onTransferStateChanged.map{$0(call, state)}}
	public func onAckProcessing(call: Call, ack: Headers, isReceived: Bool){_onAckProcessing.map{$0(call, ack, isReceived)}}
	public func onTmmbrReceived(call: Call, streamIndex: Int, tmmbr: Int){_onTmmbrReceived.map{$0(call, streamIndex, tmmbr)}}
	public func onSnapshotTaken(call: Call, filePath: String){_onSnapshotTaken.map{$0(call, filePath)}}
	public func onNextVideoFrameDecoded(call: Call){_onNextVideoFrameDecoded.map{$0(call)}}
	public func onCameraNotWorking(call: Call, cameraName: String){_onCameraNotWorking.map{$0(call, cameraName)}}
	public func onAudioDeviceChanged(call: Call, audioDevice: AudioDevice){_onAudioDeviceChanged.map{$0(call, audioDevice)}}
	public func onRemoteRecording(call: Call, recording: Bool){_onRemoteRecording.map{$0(call, recording)}}

	public init (
		onDtmfReceived: ((Call, Int) -> Void)? = nil,
		onEncryptionChanged: ((Call, Bool, String) -> Void)? = nil,
		onInfoMessageReceived: ((Call, InfoMessage) -> Void)? = nil,
		onStateChanged: ((Call, Call.State, String) -> Void)? = nil,
		onStatsUpdated: ((Call, CallStats) -> Void)? = nil,
		onTransferStateChanged: ((Call, Call.State) -> Void)? = nil,
		onAckProcessing: ((Call, Headers, Bool) -> Void)? = nil,
		onTmmbrReceived: ((Call, Int, Int) -> Void)? = nil,
		onSnapshotTaken: ((Call, String) -> Void)? = nil,
		onNextVideoFrameDecoded: ((Call) -> Void)? = nil,
		onCameraNotWorking: ((Call, String) -> Void)? = nil,
		onAudioDeviceChanged: ((Call, AudioDevice) -> Void)? = nil,
		onRemoteRecording: ((Call, Bool) -> Void)? = nil
	) {
		self._onDtmfReceived = onDtmfReceived
		self._onEncryptionChanged = onEncryptionChanged
		self._onInfoMessageReceived = onInfoMessageReceived
		self._onStateChanged = onStateChanged
		self._onStatsUpdated = onStatsUpdated
		self._onTransferStateChanged = onTransferStateChanged
		self._onAckProcessing = onAckProcessing
		self._onTmmbrReceived = onTmmbrReceived
		self._onSnapshotTaken = onSnapshotTaken
		self._onNextVideoFrameDecoded = onNextVideoFrameDecoded
		self._onCameraNotWorking = onCameraNotWorking
		self._onAudioDeviceChanged = onAudioDeviceChanged
		self._onRemoteRecording = onRemoteRecording
	}
}

class CallDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: CallDelegate?

	public init() {
		cPtr = linphone_factory_create_call_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<CallDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_call_cbs_set_dtmf_received(cPtr, { (call, dtmf) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onDtmfReceived(call: sObject, dtmf: Int(dtmf))
			}
		})

		linphone_call_cbs_set_encryption_changed(cPtr, { (call, on, authenticationToken) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onEncryptionChanged(call: sObject, on: on != 0, authenticationToken: charArrayToString(charPointer: authenticationToken))
			}
		})

		linphone_call_cbs_set_info_message_received(cPtr, { (call, message) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onInfoMessageReceived(call: sObject, message: InfoMessage.getSwiftObject(cObject: message!))
			}
		})

		linphone_call_cbs_set_state_changed(cPtr, { (call, state, message) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onStateChanged(call: sObject, state: Call.State(rawValue: Int(state.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})

		linphone_call_cbs_set_stats_updated(cPtr, { (call, stats) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onStatsUpdated(call: sObject, stats: CallStats.getSwiftObject(cObject: stats!))
			}
		})

		linphone_call_cbs_set_transfer_state_changed(cPtr, { (call, state) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onTransferStateChanged(call: sObject, state: Call.State(rawValue: Int(state.rawValue))!)
			}
		})

		linphone_call_cbs_set_ack_processing(cPtr, { (call, ack, isReceived) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onAckProcessing(call: sObject, ack: Headers.getSwiftObject(cObject: ack!), isReceived: isReceived != 0)
			}
		})

		linphone_call_cbs_set_tmmbr_received(cPtr, { (call, streamIndex, tmmbr) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onTmmbrReceived(call: sObject, streamIndex: Int(streamIndex), tmmbr: Int(tmmbr))
			}
		})

		linphone_call_cbs_set_snapshot_taken(cPtr, { (call, filePath) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onSnapshotTaken(call: sObject, filePath: charArrayToString(charPointer: filePath))
			}
		})

		linphone_call_cbs_set_next_video_frame_decoded(cPtr, { (call) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onNextVideoFrameDecoded(call: sObject)
			}
		})

		linphone_call_cbs_set_camera_not_working(cPtr, { (call, cameraName) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onCameraNotWorking(call: sObject, cameraName: charArrayToString(charPointer: cameraName))
			}
		})

		linphone_call_cbs_set_audio_device_changed(cPtr, { (call, audioDevice) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onAudioDeviceChanged(call: sObject, audioDevice: AudioDevice.getSwiftObject(cObject: audioDevice!))
			}
		})

		linphone_call_cbs_set_remote_recording(cPtr, { (call, recording) -> Void in
			if (call != nil) {
				let sObject = Call.getSwiftObject(cObject: call!)
				let delegate = sObject.currentDelegate
				delegate?.onRemoteRecording(call: sObject, recording: recording != 0)
			}
		})
	}


}

public protocol ChatMessageDelegate : AnyObject {
	///	Call back used to notify message delivery status. 
	/// - Parameter message: LinphoneChatMessage object   
	/// - Parameter state: LinphoneChatMessageState 
	func onMsgStateChanged(message: ChatMessage, state: ChatMessage.State)
	///	File transfer receive callback prototype. 
	/// This function is called by the core upon an incoming File transfer is started.
	/// This function may be call several time for the same file in case of large file. 
	/// - Parameter message: LinphoneChatMessage message from which the body is
	/// received.   
	/// - Parameter content: LinphoneContent incoming content information   
	/// - Parameter buffer: LinphoneBuffer holding the received data. Empty buffer
	/// means end of file.   
	func onFileTransferRecv(message: ChatMessage, content: Content, buffer: Buffer)
	///	File transfer send callback prototype. 
	/// This function is called by the core when an outgoing file transfer is started.
	/// This function is called until size is set to 0. 
	/// - Parameter message: LinphoneChatMessage message from which the body is
	/// received.   
	/// - Parameter content: LinphoneContent outgoing content   
	/// - Parameter offset: the offset in the file from where to get the data to be
	/// sent 
	/// - Parameter size: the number of bytes expected by the framework 
	/// - Returns: A LinphoneBuffer object holding the data written by the application.
	/// An empty buffer means end of file.   
	/// - Warning: The returned value isn't used, hence the deprecation! 
	/// - deprecated: 17/08/2020 Use LinphoneChatMessageCbsFileTransferSendChunkCb
	/// instead. 
	func onFileTransferSend(message: ChatMessage, content: Content, offset: Int, size: Int) -> Buffer?
	///	File transfer send callback prototype. 
	/// This function is called by the core when an outgoing file transfer is started.
	/// This function is called until size is set to 0. 
	/// - Parameter message: LinphoneChatMessage message from which the body is
	/// received.   
	/// - Parameter content: LinphoneContent outgoing content   
	/// - Parameter offset: the offset in the file from where to get the data to be
	/// sent 
	/// - Parameter size: the number of bytes expected by the framework 
	/// - Parameter buffer: A LinphoneBuffer to be filled. Leave it empty when end of
	/// file has been reached.   
	func onFileTransferSendChunk(message: ChatMessage, content: Content, offset: Int, size: Int, buffer: Buffer)
	///	File transfer progress indication callback prototype. 
	/// - Parameter message: LinphoneChatMessage message from which the body is
	/// received.   
	/// - Parameter content: LinphoneContent incoming content information   
	/// - Parameter offset: The number of bytes sent/received since the beginning of
	/// the transfer. 
	/// - Parameter total: The total number of bytes to be sent/received. 
	func onFileTransferProgressIndication(message: ChatMessage, content: Content, offset: Int, total: Int)
	///	Call back used to notify participant IMDN state. 
	/// - Parameter message: LinphoneChatMessage object   
	/// - Parameter state: LinphoneParticipantImdnState   
	func onParticipantImdnStateChanged(message: ChatMessage, state: ParticipantImdnState)
	///	Callback used to notify an ephemeral message that its lifespan before
	///	disappearing has started to decrease. 
	/// This callback is called when the ephemeral message is read by the receiver. 
	/// - Parameter message: LinphoneChatMessage object   
	func onEphemeralMessageTimerStarted(message: ChatMessage)
	///	Call back used to notify ephemeral message is deleted. 
	/// - Parameter message: LinphoneChatMessage object   
	func onEphemeralMessageDeleted(message: ChatMessage)
}

public extension ChatMessageDelegate {
	func onMsgStateChanged(message: ChatMessage, state: ChatMessage.State) {}
	func onFileTransferRecv(message: ChatMessage, content: Content, buffer: Buffer) {}
	func onFileTransferSend(message: ChatMessage, content: Content, offset: Int, size: Int) -> Buffer? {return nil}
	func onFileTransferSendChunk(message: ChatMessage, content: Content, offset: Int, size: Int, buffer: Buffer) {}
	func onFileTransferProgressIndication(message: ChatMessage, content: Content, offset: Int, total: Int) {}
	func onParticipantImdnStateChanged(message: ChatMessage, state: ParticipantImdnState) {}
	func onEphemeralMessageTimerStarted(message: ChatMessage) {}
	func onEphemeralMessageDeleted(message: ChatMessage) {}
}

public final class ChatMessageDelegateStub : ChatMessageDelegate
{
	var _onMsgStateChanged: ((ChatMessage, ChatMessage.State) -> Void)?
	var _onFileTransferRecv: ((ChatMessage, Content, Buffer) -> Void)?
	var _onFileTransferSend: ((ChatMessage, Content, Int, Int) -> Void)?
	var _onFileTransferSendChunk: ((ChatMessage, Content, Int, Int, Buffer) -> Void)?
	var _onFileTransferProgressIndication: ((ChatMessage, Content, Int, Int) -> Void)?
	var _onParticipantImdnStateChanged: ((ChatMessage, ParticipantImdnState) -> Void)?
	var _onEphemeralMessageTimerStarted: ((ChatMessage) -> Void)?
	var _onEphemeralMessageDeleted: ((ChatMessage) -> Void)?

	public func onMsgStateChanged(message: ChatMessage, state: ChatMessage.State){_onMsgStateChanged.map{$0(message, state)}}
	public func onFileTransferRecv(message: ChatMessage, content: Content, buffer: Buffer){_onFileTransferRecv.map{$0(message, content, buffer)}}
	public func onFileTransferSend(message: ChatMessage, content: Content, offset: Int, size: Int){_onFileTransferSend.map{$0(message, content, offset, size)}}
	public func onFileTransferSendChunk(message: ChatMessage, content: Content, offset: Int, size: Int, buffer: Buffer){_onFileTransferSendChunk.map{$0(message, content, offset, size, buffer)}}
	public func onFileTransferProgressIndication(message: ChatMessage, content: Content, offset: Int, total: Int){_onFileTransferProgressIndication.map{$0(message, content, offset, total)}}
	public func onParticipantImdnStateChanged(message: ChatMessage, state: ParticipantImdnState){_onParticipantImdnStateChanged.map{$0(message, state)}}
	public func onEphemeralMessageTimerStarted(message: ChatMessage){_onEphemeralMessageTimerStarted.map{$0(message)}}
	public func onEphemeralMessageDeleted(message: ChatMessage){_onEphemeralMessageDeleted.map{$0(message)}}

	public init (
		onMsgStateChanged: ((ChatMessage, ChatMessage.State) -> Void)? = nil,
		onFileTransferRecv: ((ChatMessage, Content, Buffer) -> Void)? = nil,
		onFileTransferSend: ((ChatMessage, Content, Int, Int) -> Void)? = nil,
		onFileTransferSendChunk: ((ChatMessage, Content, Int, Int, Buffer) -> Void)? = nil,
		onFileTransferProgressIndication: ((ChatMessage, Content, Int, Int) -> Void)? = nil,
		onParticipantImdnStateChanged: ((ChatMessage, ParticipantImdnState) -> Void)? = nil,
		onEphemeralMessageTimerStarted: ((ChatMessage) -> Void)? = nil,
		onEphemeralMessageDeleted: ((ChatMessage) -> Void)? = nil
	) {
		self._onMsgStateChanged = onMsgStateChanged
		self._onFileTransferRecv = onFileTransferRecv
		self._onFileTransferSend = onFileTransferSend
		self._onFileTransferSendChunk = onFileTransferSendChunk
		self._onFileTransferProgressIndication = onFileTransferProgressIndication
		self._onParticipantImdnStateChanged = onParticipantImdnStateChanged
		self._onEphemeralMessageTimerStarted = onEphemeralMessageTimerStarted
		self._onEphemeralMessageDeleted = onEphemeralMessageDeleted
	}
}

class ChatMessageDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: ChatMessageDelegate?

	public init() {
		cPtr = linphone_factory_create_chat_message_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<ChatMessageDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_chat_message_cbs_set_msg_state_changed(cPtr, { (message, state) -> Void in
			if (message != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: message!)
				let delegate = sObject.currentDelegate
				delegate?.onMsgStateChanged(message: sObject, state: ChatMessage.State(rawValue: Int(state.rawValue))!)
			}
		})

		linphone_chat_message_cbs_set_file_transfer_recv(cPtr, { (message, content, buffer) -> Void in
			if (message != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: message!)
				let delegate = sObject.currentDelegate
				delegate?.onFileTransferRecv(message: sObject, content: Content.getSwiftObject(cObject: content!), buffer: Buffer.getSwiftObject(cObject: buffer!))
			}
		})

		linphone_chat_message_cbs_set_file_transfer_send(cPtr, { (message, content, offset, size) -> OpaquePointer? in
			if (message != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: message!)
				let delegate = sObject.currentDelegate
				return delegate?.onFileTransferSend(message: sObject, content: Content.getSwiftObject(cObject: content!), offset: Int(offset), size: Int(size))?.cPtr
			} else {
				return nil
			}
		})

		linphone_chat_message_cbs_set_file_transfer_send_chunk(cPtr, { (message, content, offset, size, buffer) -> Void in
			if (message != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: message!)
				let delegate = sObject.currentDelegate
				delegate?.onFileTransferSendChunk(message: sObject, content: Content.getSwiftObject(cObject: content!), offset: Int(offset), size: Int(size), buffer: Buffer.getSwiftObject(cObject: buffer!))
			}
		})

		linphone_chat_message_cbs_set_file_transfer_progress_indication(cPtr, { (message, content, offset, total) -> Void in
			if (message != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: message!)
				let delegate = sObject.currentDelegate
				delegate?.onFileTransferProgressIndication(message: sObject, content: Content.getSwiftObject(cObject: content!), offset: Int(offset), total: Int(total))
			}
		})

		linphone_chat_message_cbs_set_participant_imdn_state_changed(cPtr, { (message, state) -> Void in
			if (message != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: message!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantImdnStateChanged(message: sObject, state: ParticipantImdnState.getSwiftObject(cObject: state!))
			}
		})

		linphone_chat_message_cbs_set_ephemeral_message_timer_started(cPtr, { (message) -> Void in
			if (message != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: message!)
				let delegate = sObject.currentDelegate
				delegate?.onEphemeralMessageTimerStarted(message: sObject)
			}
		})

		linphone_chat_message_cbs_set_ephemeral_message_deleted(cPtr, { (message) -> Void in
			if (message != nil) {
				let sObject = ChatMessage.getSwiftObject(cObject: message!)
				let delegate = sObject.currentDelegate
				delegate?.onEphemeralMessageDeleted(message: sObject)
			}
		})
	}


}

public protocol ChatRoomDelegate : AnyObject {
	///	Is composing notification callback prototype. 
	/// - Parameter chatRoom: LinphoneChatRoom involved in the conversation   
	/// - Parameter remoteAddress: The LinphoneAddress that has sent the is-composing
	/// notification   
	/// - Parameter isComposing: A boolean value telling whether the remote is
	/// composing or not 
	func onIsComposingReceived(chatRoom: ChatRoom, remoteAddress: Address, isComposing: Bool)
	///	Callback used to notify a chat room that a message has been received. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter message: The LinphoneChatMessage that has been received   
	func onMessageReceived(chatRoom: ChatRoom, message: ChatMessage)
	///	Callback used to notify a chat room that an event log has been created. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onNewEvent(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room that a chat message has been received. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onChatMessageReceived(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room that a chat message is being sent. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onChatMessageSending(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room that a chat message has been sent. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onChatMessageSent(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room that a participant has been added. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onParticipantAdded(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room that a participant has been removed. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onParticipantRemoved(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room that the admin status of a participant has
	///	been changed. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onParticipantAdminStatusChanged(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room state has changed. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter newState: The new LinphoneChatRoomState of the chat room 
	func onStateChanged(chatRoom: ChatRoom, newState: ChatRoom.State)
	///	Callback used to notify a security event in the chat room. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onSecurityEvent(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify that the subject of a chat room has changed. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onSubjectChanged(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room that a message has been received but we
	///	were unable to decrypt it. 
	/// - Parameter chatRoom: LinphoneChatRoom involved in this conversation   
	/// - Parameter message: The LinphoneChatMessage that has been received   
	func onUndecryptableMessageReceived(chatRoom: ChatRoom, message: ChatMessage)
	///	Callback used to notify a chat room that a participant has been added. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onParticipantDeviceAdded(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room that a participant has been removed. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onParticipantDeviceRemoved(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room has been joined. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onConferenceJoined(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room has been left. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onConferenceLeft(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room that an ephemeral related event has been
	///	generated. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onEphemeralEvent(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room that the lifespan of an ephemeral message
	///	before disappearing has started to decrease. 
	/// This callback is called when the ephemeral message is read by the receiver. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onEphemeralMessageTimerStarted(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used to notify a chat room that an ephemeral message has been deleted. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter eventLog: LinphoneEventLog The event to be notified   
	func onEphemeralMessageDeleted(chatRoom: ChatRoom, eventLog: EventLog)
	///	Callback used when a group chat room is created server-side to generate the
	///	address of the chat room. 
	/// The function linphone_chat_room_set_conference_address needs to be called by
	/// this callback. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	func onConferenceAddressGeneration(chatRoom: ChatRoom)
	///	Callback used when a group chat room server is subscribing to registration
	///	state of a participant. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter participantAddress: LinphoneAddress object   
	func onParticipantRegistrationSubscriptionRequested(chatRoom: ChatRoom, participantAddress: Address)
	///	Callback used when a group chat room server is unsubscribing to registration
	///	state of a participant. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter participantAddress: LinphoneAddress object   
	func onParticipantRegistrationUnsubscriptionRequested(chatRoom: ChatRoom, participantAddress: Address)
	///	Callback used to tell the core whether or not to store the incoming message in
	///	db or not using linphone_chat_message_set_to_be_stored. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter message: The LinphoneChatMessage that is being received   
	func onChatMessageShouldBeStored(chatRoom: ChatRoom, message: ChatMessage)
	///	Callback used to notify a participant state has changed in a message of this
	///	chat room. 
	/// - Parameter chatRoom: LinphoneChatRoom object   
	/// - Parameter message: The LinphoneChatMessage for which a participant has it's
	/// state changed   
	/// - Parameter state: The LinphoneParticipantImdnState   
	func onChatMessageParticipantImdnStateChanged(chatRoom: ChatRoom, message: ChatMessage, state: ParticipantImdnState)
}

public extension ChatRoomDelegate {
	func onIsComposingReceived(chatRoom: ChatRoom, remoteAddress: Address, isComposing: Bool) {}
	func onMessageReceived(chatRoom: ChatRoom, message: ChatMessage) {}
	func onNewEvent(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onChatMessageReceived(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onChatMessageSending(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onChatMessageSent(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onParticipantAdded(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onParticipantRemoved(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onParticipantAdminStatusChanged(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onStateChanged(chatRoom: ChatRoom, newState: ChatRoom.State) {}
	func onSecurityEvent(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onSubjectChanged(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onUndecryptableMessageReceived(chatRoom: ChatRoom, message: ChatMessage) {}
	func onParticipantDeviceAdded(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onParticipantDeviceRemoved(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onConferenceJoined(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onConferenceLeft(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onEphemeralEvent(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onEphemeralMessageTimerStarted(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onEphemeralMessageDeleted(chatRoom: ChatRoom, eventLog: EventLog) {}
	func onConferenceAddressGeneration(chatRoom: ChatRoom) {}
	func onParticipantRegistrationSubscriptionRequested(chatRoom: ChatRoom, participantAddress: Address) {}
	func onParticipantRegistrationUnsubscriptionRequested(chatRoom: ChatRoom, participantAddress: Address) {}
	func onChatMessageShouldBeStored(chatRoom: ChatRoom, message: ChatMessage) {}
	func onChatMessageParticipantImdnStateChanged(chatRoom: ChatRoom, message: ChatMessage, state: ParticipantImdnState) {}
}

public final class ChatRoomDelegateStub : ChatRoomDelegate
{
	var _onIsComposingReceived: ((ChatRoom, Address, Bool) -> Void)?
	var _onMessageReceived: ((ChatRoom, ChatMessage) -> Void)?
	var _onNewEvent: ((ChatRoom, EventLog) -> Void)?
	var _onChatMessageReceived: ((ChatRoom, EventLog) -> Void)?
	var _onChatMessageSending: ((ChatRoom, EventLog) -> Void)?
	var _onChatMessageSent: ((ChatRoom, EventLog) -> Void)?
	var _onParticipantAdded: ((ChatRoom, EventLog) -> Void)?
	var _onParticipantRemoved: ((ChatRoom, EventLog) -> Void)?
	var _onParticipantAdminStatusChanged: ((ChatRoom, EventLog) -> Void)?
	var _onStateChanged: ((ChatRoom, ChatRoom.State) -> Void)?
	var _onSecurityEvent: ((ChatRoom, EventLog) -> Void)?
	var _onSubjectChanged: ((ChatRoom, EventLog) -> Void)?
	var _onUndecryptableMessageReceived: ((ChatRoom, ChatMessage) -> Void)?
	var _onParticipantDeviceAdded: ((ChatRoom, EventLog) -> Void)?
	var _onParticipantDeviceRemoved: ((ChatRoom, EventLog) -> Void)?
	var _onConferenceJoined: ((ChatRoom, EventLog) -> Void)?
	var _onConferenceLeft: ((ChatRoom, EventLog) -> Void)?
	var _onEphemeralEvent: ((ChatRoom, EventLog) -> Void)?
	var _onEphemeralMessageTimerStarted: ((ChatRoom, EventLog) -> Void)?
	var _onEphemeralMessageDeleted: ((ChatRoom, EventLog) -> Void)?
	var _onConferenceAddressGeneration: ((ChatRoom) -> Void)?
	var _onParticipantRegistrationSubscriptionRequested: ((ChatRoom, Address) -> Void)?
	var _onParticipantRegistrationUnsubscriptionRequested: ((ChatRoom, Address) -> Void)?
	var _onChatMessageShouldBeStored: ((ChatRoom, ChatMessage) -> Void)?
	var _onChatMessageParticipantImdnStateChanged: ((ChatRoom, ChatMessage, ParticipantImdnState) -> Void)?

	public func onIsComposingReceived(chatRoom: ChatRoom, remoteAddress: Address, isComposing: Bool){_onIsComposingReceived.map{$0(chatRoom, remoteAddress, isComposing)}}
	public func onMessageReceived(chatRoom: ChatRoom, message: ChatMessage){_onMessageReceived.map{$0(chatRoom, message)}}
	public func onNewEvent(chatRoom: ChatRoom, eventLog: EventLog){_onNewEvent.map{$0(chatRoom, eventLog)}}
	public func onChatMessageReceived(chatRoom: ChatRoom, eventLog: EventLog){_onChatMessageReceived.map{$0(chatRoom, eventLog)}}
	public func onChatMessageSending(chatRoom: ChatRoom, eventLog: EventLog){_onChatMessageSending.map{$0(chatRoom, eventLog)}}
	public func onChatMessageSent(chatRoom: ChatRoom, eventLog: EventLog){_onChatMessageSent.map{$0(chatRoom, eventLog)}}
	public func onParticipantAdded(chatRoom: ChatRoom, eventLog: EventLog){_onParticipantAdded.map{$0(chatRoom, eventLog)}}
	public func onParticipantRemoved(chatRoom: ChatRoom, eventLog: EventLog){_onParticipantRemoved.map{$0(chatRoom, eventLog)}}
	public func onParticipantAdminStatusChanged(chatRoom: ChatRoom, eventLog: EventLog){_onParticipantAdminStatusChanged.map{$0(chatRoom, eventLog)}}
	public func onStateChanged(chatRoom: ChatRoom, newState: ChatRoom.State){_onStateChanged.map{$0(chatRoom, newState)}}
	public func onSecurityEvent(chatRoom: ChatRoom, eventLog: EventLog){_onSecurityEvent.map{$0(chatRoom, eventLog)}}
	public func onSubjectChanged(chatRoom: ChatRoom, eventLog: EventLog){_onSubjectChanged.map{$0(chatRoom, eventLog)}}
	public func onUndecryptableMessageReceived(chatRoom: ChatRoom, message: ChatMessage){_onUndecryptableMessageReceived.map{$0(chatRoom, message)}}
	public func onParticipantDeviceAdded(chatRoom: ChatRoom, eventLog: EventLog){_onParticipantDeviceAdded.map{$0(chatRoom, eventLog)}}
	public func onParticipantDeviceRemoved(chatRoom: ChatRoom, eventLog: EventLog){_onParticipantDeviceRemoved.map{$0(chatRoom, eventLog)}}
	public func onConferenceJoined(chatRoom: ChatRoom, eventLog: EventLog){_onConferenceJoined.map{$0(chatRoom, eventLog)}}
	public func onConferenceLeft(chatRoom: ChatRoom, eventLog: EventLog){_onConferenceLeft.map{$0(chatRoom, eventLog)}}
	public func onEphemeralEvent(chatRoom: ChatRoom, eventLog: EventLog){_onEphemeralEvent.map{$0(chatRoom, eventLog)}}
	public func onEphemeralMessageTimerStarted(chatRoom: ChatRoom, eventLog: EventLog){_onEphemeralMessageTimerStarted.map{$0(chatRoom, eventLog)}}
	public func onEphemeralMessageDeleted(chatRoom: ChatRoom, eventLog: EventLog){_onEphemeralMessageDeleted.map{$0(chatRoom, eventLog)}}
	public func onConferenceAddressGeneration(chatRoom: ChatRoom){_onConferenceAddressGeneration.map{$0(chatRoom)}}
	public func onParticipantRegistrationSubscriptionRequested(chatRoom: ChatRoom, participantAddress: Address){_onParticipantRegistrationSubscriptionRequested.map{$0(chatRoom, participantAddress)}}
	public func onParticipantRegistrationUnsubscriptionRequested(chatRoom: ChatRoom, participantAddress: Address){_onParticipantRegistrationUnsubscriptionRequested.map{$0(chatRoom, participantAddress)}}
	public func onChatMessageShouldBeStored(chatRoom: ChatRoom, message: ChatMessage){_onChatMessageShouldBeStored.map{$0(chatRoom, message)}}
	public func onChatMessageParticipantImdnStateChanged(chatRoom: ChatRoom, message: ChatMessage, state: ParticipantImdnState){_onChatMessageParticipantImdnStateChanged.map{$0(chatRoom, message, state)}}

	public init (
		onIsComposingReceived: ((ChatRoom, Address, Bool) -> Void)? = nil,
		onMessageReceived: ((ChatRoom, ChatMessage) -> Void)? = nil,
		onNewEvent: ((ChatRoom, EventLog) -> Void)? = nil,
		onChatMessageReceived: ((ChatRoom, EventLog) -> Void)? = nil,
		onChatMessageSending: ((ChatRoom, EventLog) -> Void)? = nil,
		onChatMessageSent: ((ChatRoom, EventLog) -> Void)? = nil,
		onParticipantAdded: ((ChatRoom, EventLog) -> Void)? = nil,
		onParticipantRemoved: ((ChatRoom, EventLog) -> Void)? = nil,
		onParticipantAdminStatusChanged: ((ChatRoom, EventLog) -> Void)? = nil,
		onStateChanged: ((ChatRoom, ChatRoom.State) -> Void)? = nil,
		onSecurityEvent: ((ChatRoom, EventLog) -> Void)? = nil,
		onSubjectChanged: ((ChatRoom, EventLog) -> Void)? = nil,
		onUndecryptableMessageReceived: ((ChatRoom, ChatMessage) -> Void)? = nil,
		onParticipantDeviceAdded: ((ChatRoom, EventLog) -> Void)? = nil,
		onParticipantDeviceRemoved: ((ChatRoom, EventLog) -> Void)? = nil,
		onConferenceJoined: ((ChatRoom, EventLog) -> Void)? = nil,
		onConferenceLeft: ((ChatRoom, EventLog) -> Void)? = nil,
		onEphemeralEvent: ((ChatRoom, EventLog) -> Void)? = nil,
		onEphemeralMessageTimerStarted: ((ChatRoom, EventLog) -> Void)? = nil,
		onEphemeralMessageDeleted: ((ChatRoom, EventLog) -> Void)? = nil,
		onConferenceAddressGeneration: ((ChatRoom) -> Void)? = nil,
		onParticipantRegistrationSubscriptionRequested: ((ChatRoom, Address) -> Void)? = nil,
		onParticipantRegistrationUnsubscriptionRequested: ((ChatRoom, Address) -> Void)? = nil,
		onChatMessageShouldBeStored: ((ChatRoom, ChatMessage) -> Void)? = nil,
		onChatMessageParticipantImdnStateChanged: ((ChatRoom, ChatMessage, ParticipantImdnState) -> Void)? = nil
	) {
		self._onIsComposingReceived = onIsComposingReceived
		self._onMessageReceived = onMessageReceived
		self._onNewEvent = onNewEvent
		self._onChatMessageReceived = onChatMessageReceived
		self._onChatMessageSending = onChatMessageSending
		self._onChatMessageSent = onChatMessageSent
		self._onParticipantAdded = onParticipantAdded
		self._onParticipantRemoved = onParticipantRemoved
		self._onParticipantAdminStatusChanged = onParticipantAdminStatusChanged
		self._onStateChanged = onStateChanged
		self._onSecurityEvent = onSecurityEvent
		self._onSubjectChanged = onSubjectChanged
		self._onUndecryptableMessageReceived = onUndecryptableMessageReceived
		self._onParticipantDeviceAdded = onParticipantDeviceAdded
		self._onParticipantDeviceRemoved = onParticipantDeviceRemoved
		self._onConferenceJoined = onConferenceJoined
		self._onConferenceLeft = onConferenceLeft
		self._onEphemeralEvent = onEphemeralEvent
		self._onEphemeralMessageTimerStarted = onEphemeralMessageTimerStarted
		self._onEphemeralMessageDeleted = onEphemeralMessageDeleted
		self._onConferenceAddressGeneration = onConferenceAddressGeneration
		self._onParticipantRegistrationSubscriptionRequested = onParticipantRegistrationSubscriptionRequested
		self._onParticipantRegistrationUnsubscriptionRequested = onParticipantRegistrationUnsubscriptionRequested
		self._onChatMessageShouldBeStored = onChatMessageShouldBeStored
		self._onChatMessageParticipantImdnStateChanged = onChatMessageParticipantImdnStateChanged
	}
}

class ChatRoomDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: ChatRoomDelegate?

	public init() {
		cPtr = linphone_factory_create_chat_room_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<ChatRoomDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_chat_room_cbs_set_is_composing_received(cPtr, { (chatRoom, remoteAddress, isComposing) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onIsComposingReceived(chatRoom: sObject, remoteAddress: Address.getSwiftObject(cObject: remoteAddress!), isComposing: isComposing != 0)
			}
		})

		linphone_chat_room_cbs_set_message_received(cPtr, { (chatRoom, message) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onMessageReceived(chatRoom: sObject, message: ChatMessage.getSwiftObject(cObject: message!))
			}
		})

		linphone_chat_room_cbs_set_new_event(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onNewEvent(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_chat_message_received(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onChatMessageReceived(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_chat_message_sending(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onChatMessageSending(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_chat_message_sent(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onChatMessageSent(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_participant_added(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantAdded(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_participant_removed(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantRemoved(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_participant_admin_status_changed(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantAdminStatusChanged(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_state_changed(cPtr, { (chatRoom, newState) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onStateChanged(chatRoom: sObject, newState: ChatRoom.State(rawValue: Int(newState.rawValue))!)
			}
		})

		linphone_chat_room_cbs_set_security_event(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onSecurityEvent(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_subject_changed(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onSubjectChanged(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_undecryptable_message_received(cPtr, { (chatRoom, message) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onUndecryptableMessageReceived(chatRoom: sObject, message: ChatMessage.getSwiftObject(cObject: message!))
			}
		})

		linphone_chat_room_cbs_set_participant_device_added(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantDeviceAdded(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_participant_device_removed(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantDeviceRemoved(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_conference_joined(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onConferenceJoined(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_conference_left(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onConferenceLeft(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_ephemeral_event(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onEphemeralEvent(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_ephemeral_message_timer_started(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onEphemeralMessageTimerStarted(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_ephemeral_message_deleted(cPtr, { (chatRoom, eventLog) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onEphemeralMessageDeleted(chatRoom: sObject, eventLog: EventLog.getSwiftObject(cObject: eventLog!))
			}
		})

		linphone_chat_room_cbs_set_conference_address_generation(cPtr, { (chatRoom) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onConferenceAddressGeneration(chatRoom: sObject)
			}
		})

		linphone_chat_room_cbs_set_participant_registration_subscription_requested(cPtr, { (chatRoom, participantAddress) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantRegistrationSubscriptionRequested(chatRoom: sObject, participantAddress: Address.getSwiftObject(cObject: participantAddress!))
			}
		})

		linphone_chat_room_cbs_set_participant_registration_unsubscription_requested(cPtr, { (chatRoom, participantAddress) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantRegistrationUnsubscriptionRequested(chatRoom: sObject, participantAddress: Address.getSwiftObject(cObject: participantAddress!))
			}
		})

		linphone_chat_room_cbs_set_chat_message_should_be_stored(cPtr, { (chatRoom, message) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onChatMessageShouldBeStored(chatRoom: sObject, message: ChatMessage.getSwiftObject(cObject: message!))
			}
		})

		linphone_chat_room_cbs_set_chat_message_participant_imdn_state_changed(cPtr, { (chatRoom, message, state) -> Void in
			if (chatRoom != nil) {
				let sObject = ChatRoom.getSwiftObject(cObject: chatRoom!)
				let delegate = sObject.currentDelegate
				delegate?.onChatMessageParticipantImdnStateChanged(chatRoom: sObject, message: ChatMessage.getSwiftObject(cObject: message!), state: ParticipantImdnState.getSwiftObject(cObject: state!))
			}
		})
	}


}

public protocol ConferenceDelegate : AnyObject {
	///	Callback used to notify a conference that a participant has been added. 
	/// - Parameter conference: LinphoneConference object   
	/// - Parameter participant: LinphoneParticipant that has been added to the
	/// conference   
	func onParticipantAdded(conference: Conference, participant: Participant)
	///	Callback used to notify a conference that a participant has been removed. 
	/// - Parameter conference: LinphoneConference object   
	/// - Parameter participant: LinphoneParticipant that has been removed to the
	/// conference   
	func onParticipantRemoved(conference: Conference, participant: Participant)
	///	Callback used to notify a conference that a participant has been added. 
	/// - Parameter conference: LinphoneConference object   
	/// - Parameter participantDevice: LinphoneParticipantDevice that has been added to
	/// the conference   
	func onParticipantDeviceAdded(conference: Conference, participantDevice: ParticipantDevice)
	///	Callback used to notify a conference that a participant has been removed. 
	/// - Parameter conference: LinphoneConference object   
	/// - Parameter participantDevice: LinphoneParticipantDevice that has been removed
	/// to the conference   
	func onParticipantDeviceRemoved(conference: Conference, participantDevice: ParticipantDevice)
	///	Callback used to notify a conference that the admin status of a participant has
	///	been changed. 
	/// - Parameter conference: LinphoneConference object   
	/// - Parameter participant: LinphoneParticipant whose admin status has changed   
	func onParticipantAdminStatusChanged(conference: Conference, participant: Participant)
	///	Callback used to notify a conference state has changed. 
	/// - Parameter conference: LinphoneConference object   
	/// - Parameter newState: The new state of the conference 
	func onStateChanged(conference: Conference, newState: Conference.State)
	///	Callback used to notify that the subject of a conference has changed. 
	/// - Parameter conference: LinphoneConference object   
	/// - Parameter subject: subject of the conference   
	func onSubjectChanged(conference: Conference, subject: String)
	///	Callback used to notify that the audio device of a conference has changed. 
	/// - Parameter conference: LinphoneConference object   
	/// - Parameter audioDevice: audio device of the conference   
	func onAudioDeviceChanged(conference: Conference, audioDevice: AudioDevice)
}

public extension ConferenceDelegate {
	func onParticipantAdded(conference: Conference, participant: Participant) {}
	func onParticipantRemoved(conference: Conference, participant: Participant) {}
	func onParticipantDeviceAdded(conference: Conference, participantDevice: ParticipantDevice) {}
	func onParticipantDeviceRemoved(conference: Conference, participantDevice: ParticipantDevice) {}
	func onParticipantAdminStatusChanged(conference: Conference, participant: Participant) {}
	func onStateChanged(conference: Conference, newState: Conference.State) {}
	func onSubjectChanged(conference: Conference, subject: String) {}
	func onAudioDeviceChanged(conference: Conference, audioDevice: AudioDevice) {}
}

public final class ConferenceDelegateStub : ConferenceDelegate
{
	var _onParticipantAdded: ((Conference, Participant) -> Void)?
	var _onParticipantRemoved: ((Conference, Participant) -> Void)?
	var _onParticipantDeviceAdded: ((Conference, ParticipantDevice) -> Void)?
	var _onParticipantDeviceRemoved: ((Conference, ParticipantDevice) -> Void)?
	var _onParticipantAdminStatusChanged: ((Conference, Participant) -> Void)?
	var _onStateChanged: ((Conference, Conference.State) -> Void)?
	var _onSubjectChanged: ((Conference, String) -> Void)?
	var _onAudioDeviceChanged: ((Conference, AudioDevice) -> Void)?

	public func onParticipantAdded(conference: Conference, participant: Participant){_onParticipantAdded.map{$0(conference, participant)}}
	public func onParticipantRemoved(conference: Conference, participant: Participant){_onParticipantRemoved.map{$0(conference, participant)}}
	public func onParticipantDeviceAdded(conference: Conference, participantDevice: ParticipantDevice){_onParticipantDeviceAdded.map{$0(conference, participantDevice)}}
	public func onParticipantDeviceRemoved(conference: Conference, participantDevice: ParticipantDevice){_onParticipantDeviceRemoved.map{$0(conference, participantDevice)}}
	public func onParticipantAdminStatusChanged(conference: Conference, participant: Participant){_onParticipantAdminStatusChanged.map{$0(conference, participant)}}
	public func onStateChanged(conference: Conference, newState: Conference.State){_onStateChanged.map{$0(conference, newState)}}
	public func onSubjectChanged(conference: Conference, subject: String){_onSubjectChanged.map{$0(conference, subject)}}
	public func onAudioDeviceChanged(conference: Conference, audioDevice: AudioDevice){_onAudioDeviceChanged.map{$0(conference, audioDevice)}}

	public init (
		onParticipantAdded: ((Conference, Participant) -> Void)? = nil,
		onParticipantRemoved: ((Conference, Participant) -> Void)? = nil,
		onParticipantDeviceAdded: ((Conference, ParticipantDevice) -> Void)? = nil,
		onParticipantDeviceRemoved: ((Conference, ParticipantDevice) -> Void)? = nil,
		onParticipantAdminStatusChanged: ((Conference, Participant) -> Void)? = nil,
		onStateChanged: ((Conference, Conference.State) -> Void)? = nil,
		onSubjectChanged: ((Conference, String) -> Void)? = nil,
		onAudioDeviceChanged: ((Conference, AudioDevice) -> Void)? = nil
	) {
		self._onParticipantAdded = onParticipantAdded
		self._onParticipantRemoved = onParticipantRemoved
		self._onParticipantDeviceAdded = onParticipantDeviceAdded
		self._onParticipantDeviceRemoved = onParticipantDeviceRemoved
		self._onParticipantAdminStatusChanged = onParticipantAdminStatusChanged
		self._onStateChanged = onStateChanged
		self._onSubjectChanged = onSubjectChanged
		self._onAudioDeviceChanged = onAudioDeviceChanged
	}
}

class ConferenceDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: ConferenceDelegate?

	public init() {
		cPtr = linphone_factory_create_conference_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<ConferenceDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_conference_cbs_set_participant_added(cPtr, { (conference, participant) -> Void in
			if (conference != nil) {
				let sObject = Conference.getSwiftObject(cObject: conference!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantAdded(conference: sObject, participant: Participant.getSwiftObject(cObject: participant!))
			}
		})

		linphone_conference_cbs_set_participant_removed(cPtr, { (conference, participant) -> Void in
			if (conference != nil) {
				let sObject = Conference.getSwiftObject(cObject: conference!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantRemoved(conference: sObject, participant: Participant.getSwiftObject(cObject: participant!))
			}
		})

		linphone_conference_cbs_set_participant_device_added(cPtr, { (conference, participantDevice) -> Void in
			if (conference != nil) {
				let sObject = Conference.getSwiftObject(cObject: conference!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantDeviceAdded(conference: sObject, participantDevice: ParticipantDevice.getSwiftObject(cObject: participantDevice!))
			}
		})

		linphone_conference_cbs_set_participant_device_removed(cPtr, { (conference, participantDevice) -> Void in
			if (conference != nil) {
				let sObject = Conference.getSwiftObject(cObject: conference!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantDeviceRemoved(conference: sObject, participantDevice: ParticipantDevice.getSwiftObject(cObject: participantDevice!))
			}
		})

		linphone_conference_cbs_set_participant_admin_status_changed(cPtr, { (conference, participant) -> Void in
			if (conference != nil) {
				let sObject = Conference.getSwiftObject(cObject: conference!)
				let delegate = sObject.currentDelegate
				delegate?.onParticipantAdminStatusChanged(conference: sObject, participant: Participant.getSwiftObject(cObject: participant!))
			}
		})

		linphone_conference_cbs_set_state_changed(cPtr, { (conference, newState) -> Void in
			if (conference != nil) {
				let sObject = Conference.getSwiftObject(cObject: conference!)
				let delegate = sObject.currentDelegate
				delegate?.onStateChanged(conference: sObject, newState: Conference.State(rawValue: Int(newState.rawValue))!)
			}
		})

		linphone_conference_cbs_set_subject_changed(cPtr, { (conference, subject) -> Void in
			if (conference != nil) {
				let sObject = Conference.getSwiftObject(cObject: conference!)
				let delegate = sObject.currentDelegate
				delegate?.onSubjectChanged(conference: sObject, subject: charArrayToString(charPointer: subject))
			}
		})

		linphone_conference_cbs_set_audio_device_changed(cPtr, { (conference, audioDevice) -> Void in
			if (conference != nil) {
				let sObject = Conference.getSwiftObject(cObject: conference!)
				let delegate = sObject.currentDelegate
				delegate?.onAudioDeviceChanged(conference: sObject, audioDevice: AudioDevice.getSwiftObject(cObject: audioDevice!))
			}
		})
	}


}

public protocol CoreDelegate : AnyObject {
	///	Global state notification callback. 
	/// - Parameter core: the LinphoneCore.   
	/// - Parameter state: the LinphoneGlobalState 
	/// - Parameter message: informational message.   
	func onGlobalStateChanged(core: Core, state: GlobalState, message: String)
	///	Registration state notification callback prototype. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter proxyConfig: the LinphoneProxyConfig which state has changed   
	/// - Parameter state: the current LinphoneRegistrationState 
	/// - Parameter message: a non nil informational message about the state   
	/// - deprecated: 06/04/2020 Use LinphoneCoreCbsAccountRegistrationStateChangedCb
	/// instead
	func onRegistrationStateChanged(core: Core, proxyConfig: ProxyConfig, state: RegistrationState, message: String)
	///	Call state notification callback. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter call: the LinphoneCall object whose state is changed.   
	/// - Parameter state: the new LinphoneCallState of the call 
	/// - Parameter message: a non nil informational message about the state.   
	func onCallStateChanged(core: Core, call: Call, state: Call.State, message: String)
	///	Report status change for a friend previously added to the LinphoneCore with
	///	linphone_core_add_friend(). 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter linphoneFriend: Updated LinphoneFriend   
	func onNotifyPresenceReceived(core: Core, linphoneFriend: Friend)
	///	Reports presence model change for a specific URI or phone number of a friend. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter linphoneFriend: LinphoneFriend object   
	/// - Parameter uriOrTel: The URI or phone number for which the presence model has
	/// changed   
	/// - Parameter presenceModel: The new LinphonePresenceModel   
	func onNotifyPresenceReceivedForUriOrTel(core: Core, linphoneFriend: Friend, uriOrTel: String, presenceModel: PresenceModel)
	///	Reports that a new subscription request has been received and wait for a
	///	decision. 
	/// - Note: A subscription request is notified by this function only if the
	/// LinphoneSubscribePolicy for the given LinphoneFriend has been set to
	/// LinphoneSPWait. See linphone_friend_set_inc_subscribe_policy. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter linphoneFriend: The LinphoneFriend aimed by the subscription.   
	/// - Parameter url: URI of the subscriber   
	func onNewSubscriptionRequested(core: Core, linphoneFriend: Friend, url: String)
	///	Callback for requesting authentication information to application or user. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter authInfo: a LinphoneAuthInfo pre-filled with username, realm and
	/// domain values as much as possible   
	/// - Parameter method: the type of authentication requested as LinphoneAuthMethod
	/// enum   Application shall reply to this callback using
	/// linphone_core_add_auth_info. 
	func onAuthenticationRequested(core: Core, authInfo: AuthInfo, method: AuthMethod)
	///	Callback to notify a new call-log entry has been added. 
	/// This is done typically when a call terminates. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter callLog: the new LinphoneCallLog entry added.   
	func onCallLogUpdated(core: Core, callLog: CallLog)
	///	Callback to notify the callid of a call has been updated. 
	/// This is done typically when a call retry. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter previousCallId: the previous callid.   
	/// - Parameter currentCallId: the new callid.   
	func onCallIdUpdated(core: Core, previousCallId: String, currentCallId: String)
	///	Chat message callback prototype. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter chatRoom: LinphoneChatRoom involved in this conversation. Can be
	/// created by the framework in case the From-URI is not present in any chat room. 
	///  
	/// - Parameter message: LinphoneChatMessage incoming message   
	func onMessageReceived(core: Core, chatRoom: ChatRoom, message: ChatMessage)
	///	Called after the #send method of the LinphoneChatMessage was called. 
	/// The message will be in state InProgress. In case of resend this callback won't
	/// be called. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter chatRoom: LinphoneChatRoom involved in this conversation. Can be be
	/// created by the framework in case the From-URI is not present in any chat room. 
	///  
	/// - Parameter message: LinphoneChatMessage outgoing message   
	func onMessageSent(core: Core, chatRoom: ChatRoom, message: ChatMessage)
	///	Chat room marked as read callback. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter chatRoom: LinphoneChatRoom that has been marked as read.   
	func onChatRoomRead(core: Core, chatRoom: ChatRoom)
	///	Chat message not decrypted callback prototype. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter chatRoom: LinphoneChatRoom involved in this conversation. Can be be
	/// created by the framework in case the from-URI is not present in any chat room. 
	///  
	/// - Parameter message: LinphoneChatMessage incoming message   
	func onMessageReceivedUnableDecrypt(core: Core, chatRoom: ChatRoom, message: ChatMessage)
	///	Is composing notification callback prototype. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter chatRoom: LinphoneChatRoom involved in the conversation.   
	func onIsComposingReceived(core: Core, chatRoom: ChatRoom)
	///	Callback for being notified of DTMFs received. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter call: the LinphoneCall that received the dtmf   
	/// - Parameter dtmf: the ascii code of the dtmf 
	func onDtmfReceived(core: Core, call: Call, dtmf: Int)
	///	Callback prototype for when a refer is received. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter referTo: the address of the refer   
	func onReferReceived(core: Core, referTo: String)
	///	Call encryption changed callback. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter call: the LinphoneCall on which encryption is changed.   
	/// - Parameter mediaEncryptionEnabled: whether encryption is activated. 
	/// - Parameter authenticationToken: an authentication_token, currently set for
	/// ZRTP kind of encryption only.   
	func onCallEncryptionChanged(core: Core, call: Call, mediaEncryptionEnabled: Bool, authenticationToken: String)
	///	Callback for notifying progresses of transfers. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter transfered: the LinphoneCall that was transfered   
	/// - Parameter callState: the LinphoneCallState of the call to transfer target at
	/// the far end. 
	func onTransferStateChanged(core: Core, transfered: Call, callState: Call.State)
	///	Callback prototype when using the buddy plugin. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter linphoneFriend: the LinphoneFriend that has been updated   
	func onBuddyInfoUpdated(core: Core, linphoneFriend: Friend)
	///	Callback for receiving quality statistics for calls. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter call: the call   
	/// - Parameter callStats: the call statistics.   
	func onCallStatsUpdated(core: Core, call: Call, callStats: CallStats)
	///	Callback prototype for receiving info messages. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter call: the call whose info message belongs to.   
	/// - Parameter message: the info message.   
	func onInfoReceived(core: Core, call: Call, message: InfoMessage)
	///	Callback prototype for notifying the application about changes of subscription
	///	states, including arrival of new subscriptions. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter linphoneEvent: the LinphoneEvent   
	/// - Parameter state: the new LinphoneSubscriptionState 
	func onSubscriptionStateChanged(core: Core, linphoneEvent: Event, state: SubscriptionState)
	///	Callback prototype for notifying the application about notification received
	///	from the network. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter linphoneEvent: the LinphoneEvent received   
	/// - Parameter notifiedEvent: The event as string   
	/// - Parameter body: the LinphoneContent of the event   
	func onNotifyReceived(core: Core, linphoneEvent: Event, notifiedEvent: String, body: Content)
	///	Callback prototype for notifying the application about subscription received
	///	from the network. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter linphoneEvent: the LinphoneEvent received   
	/// - Parameter subscribeEvent: The event as string   
	/// - Parameter body: the LinphoneContent of the event   
	func onSubscribeReceived(core: Core, linphoneEvent: Event, subscribeEvent: String, body: Content)
	///	Callback prototype for notifying the application about changes of publish
	///	states. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter linphoneEvent: the LinphoneEvent   
	/// - Parameter state: the new LinphonePublishState 
	func onPublishStateChanged(core: Core, linphoneEvent: Event, state: PublishState)
	///	Callback prototype for configuring status changes notification. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter status: the current LinphoneConfiguringState 
	/// - Parameter message: informational message.   
	func onConfiguringStatus(core: Core, status: ConfiguringState, message: String)
	///	Callback prototype for reporting network change either automatically detected
	///	or notified by linphone_core_set_network_reachable. 
	/// - Parameter core: the LinphoneCore   
	/// - Parameter reachable: true if network is reachable. 
	func onNetworkReachable(core: Core, reachable: Bool)
	///	Callback prototype for reporting log collection upload state change. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter state: The state of the log collection upload 
	/// - Parameter info: Additional information: error message in case of error state,
	/// URL of uploaded file in case of success.   
	func onLogCollectionUploadStateChanged(core: Core, state: Core.LogCollectionUploadState, info: String)
	///	Callback prototype for reporting log collection upload progress indication. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter offset: the number of bytes sent since the start of the upload 
	/// - Parameter total: the total number of bytes to upload 
	func onLogCollectionUploadProgressIndication(core: Core, offset: Int, total: Int)
	///	Callback prototype for reporting when a friend list has been added to the core
	///	friends list. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter friendList: LinphoneFriendList object   
	func onFriendListCreated(core: Core, friendList: FriendList)
	///	Callback prototype for reporting when a friend list has been removed from the
	///	core friends list. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter friendList: LinphoneFriendList object   
	func onFriendListRemoved(core: Core, friendList: FriendList)
	///	Callback notifying that a new LinphoneCall (either incoming or outgoing) has
	///	been created. 
	/// - Parameter core: LinphoneCore object that has created the call   
	/// - Parameter call: The newly created LinphoneCall object   
	func onCallCreated(core: Core, call: Call)
	///	Callback prototype for reporting the result of a version update check. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter result: The result of the version update check   
	/// - Parameter url: The url where to download the new version if the result is
	/// #LinphoneVersionUpdateCheckNewVersionAvailable   
	func onVersionUpdateCheckResultReceived(core: Core, result: VersionUpdateCheckResult, version: String, url: String)
	///	Callback prototype telling that a LinphoneConference state has changed. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter conference: The LinphoneConference object for which the state has
	/// changed   
	/// - Parameter state: the current LinphoneChatRoomState 
	func onConferenceStateChanged(core: Core, conference: Conference, state: Conference.State)
	///	Callback prototype telling that a LinphoneChatRoom state has changed. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter chatRoom: The LinphoneChatRoom object for which the state has
	/// changed   
	/// - Parameter state: the current LinphoneChatRoomState 
	func onChatRoomStateChanged(core: Core, chatRoom: ChatRoom, state: ChatRoom.State)
	///	Callback prototype telling that a LinphoneChatRoom subject has changed. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter chatRoom: The LinphoneChatRoom object for which the subject has
	/// changed   
	func onChatRoomSubjectChanged(core: Core, chatRoom: ChatRoom)
	///	Callback prototype telling that a LinphoneChatRoom ephemeral message has
	///	expired. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter chatRoom: The LinphoneChatRoom object for which a message has
	/// expired.   
	func onChatRoomEphemeralMessageDeleted(core: Core, chatRoom: ChatRoom)
	///	Callback prototype telling that an Instant Message Encryption Engine user
	///	registered on the server with or without success. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter status: the return status of the registration action. 
	/// - Parameter userId: the userId published on the encryption engine server   
	/// - Parameter info: information about failure   
	func onImeeUserRegistration(core: Core, status: Bool, userId: String, info: String)
	///	Callback prototype telling the result of decoded qrcode. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter result: The result of the decoded qrcode   
	func onQrcodeFound(core: Core, result: String)
	///	Callback prototype telling a call has started (incoming or outgoing) while
	///	there was no other call. 
	/// - Parameter core: LinphoneCore object   
	func onFirstCallStarted(core: Core)
	///	Callback prototype telling the last call has ended
	///	(#LinphoneCore.get_calls_nb() returns 0) 
	/// - Parameter core: LinphoneCore object   
	func onLastCallEnded(core: Core)
	///	Callback prototype telling that the audio device for at least one call has
	///	changed. 
	/// - Parameter core: LinphoneCore object   
	/// - Parameter audioDevice: the newly used LinphoneAudioDevice object   
	func onAudioDeviceChanged(core: Core, audioDevice: AudioDevice)
	///	Callback prototype telling the audio devices list has been updated. 
	/// Either a new device is available or a previously available device isn't
	/// anymore. You can call linphone_core_get_audio_devices to get the new list. 
	/// - Parameter core: LinphoneCore object   
	func onAudioDevicesListUpdated(core: Core)
	///	Function prototype used by #linphone_core_cbs_set_ec_calibrator_result(). 
	/// - Parameter core: The LinphoneCore.   
	/// - Parameter status: The LinphoneEcCalibratorStatus of the calibrator. 
	/// - Parameter delayMs: The measured delay if available. 
	func onEcCalibrationResult(core: Core, status: EcCalibratorStatus, delayMs: Int)
	///	Function prototype used by #linphone_core_cbs_set_ec_calibrator_audio_init(). 
	/// - Parameter core: The LinphoneCore.   
	func onEcCalibrationAudioInit(core: Core)
	///	Function prototype used by #linphone_core_cbs_set_ec_calibrator_audio_uninit(). 
	/// - Parameter core: The LinphoneCore.   
	func onEcCalibrationAudioUninit(core: Core)
	///	Callback notifying that a LinphoneAccount has its registration state changed. 
	/// - Parameter core: The LinphoneCore object.   
	/// - Parameter account: The LinphoneAccount object which has its registration
	/// changed.   
	/// - Parameter state: The new state for this account. 
	/// - Parameter message: a non nil informational message about the state   
	func onAccountRegistrationStateChanged(core: Core, account: Account, state: RegistrationState, message: String)
	///	Callback notifying that a conference invitation has been sent to all
	///	participants. 
	/// - Parameter core: The LinphoneCore object.   
	/// - Parameter conferenceInfo: The LinphoneConferenceInfo object that was sent.   
	func onConferenceInfoOnSent(core: Core, conferenceInfo: ConferenceInfo)
	///	Callback notifying that a conference invitation has been sent to
	///	LinphoneAddress. 
	/// - Parameter core: The LinphoneCore object.   
	/// - Parameter conferenceInfo: The LinphoneConferenceInfo object that was sent.   
	/// - Parameter participant: The LinphoneAddress object corresponding to the
	/// participant.   
	func onConferenceInfoOnParticipantSent(core: Core, conferenceInfo: ConferenceInfo, participant: Address)
	///	Callback notifying that a conference invitation could not be sent to
	///	LinphoneAddress. 
	/// - Parameter core: The LinphoneCore object.   
	/// - Parameter conferenceInfo: The LinphoneConferenceInfo object that was sent.   
	/// - Parameter participant: The LinphoneAddress object corresponding to the
	/// participant.   
	func onConferenceInfoOnParticipantError(core: Core, conferenceInfo: ConferenceInfo, participant: Address, error: ConferenceInfoError)
}

public extension CoreDelegate {
	func onGlobalStateChanged(core: Core, state: GlobalState, message: String) {}
	func onRegistrationStateChanged(core: Core, proxyConfig: ProxyConfig, state: RegistrationState, message: String) {}
	func onCallStateChanged(core: Core, call: Call, state: Call.State, message: String) {}
	func onNotifyPresenceReceived(core: Core, linphoneFriend: Friend) {}
	func onNotifyPresenceReceivedForUriOrTel(core: Core, linphoneFriend: Friend, uriOrTel: String, presenceModel: PresenceModel) {}
	func onNewSubscriptionRequested(core: Core, linphoneFriend: Friend, url: String) {}
	func onAuthenticationRequested(core: Core, authInfo: AuthInfo, method: AuthMethod) {}
	func onCallLogUpdated(core: Core, callLog: CallLog) {}
	func onCallIdUpdated(core: Core, previousCallId: String, currentCallId: String) {}
	func onMessageReceived(core: Core, chatRoom: ChatRoom, message: ChatMessage) {}
	func onMessageSent(core: Core, chatRoom: ChatRoom, message: ChatMessage) {}
	func onChatRoomRead(core: Core, chatRoom: ChatRoom) {}
	func onMessageReceivedUnableDecrypt(core: Core, chatRoom: ChatRoom, message: ChatMessage) {}
	func onIsComposingReceived(core: Core, chatRoom: ChatRoom) {}
	func onDtmfReceived(core: Core, call: Call, dtmf: Int) {}
	func onReferReceived(core: Core, referTo: String) {}
	func onCallEncryptionChanged(core: Core, call: Call, mediaEncryptionEnabled: Bool, authenticationToken: String) {}
	func onTransferStateChanged(core: Core, transfered: Call, callState: Call.State) {}
	func onBuddyInfoUpdated(core: Core, linphoneFriend: Friend) {}
	func onCallStatsUpdated(core: Core, call: Call, callStats: CallStats) {}
	func onInfoReceived(core: Core, call: Call, message: InfoMessage) {}
	func onSubscriptionStateChanged(core: Core, linphoneEvent: Event, state: SubscriptionState) {}
	func onNotifyReceived(core: Core, linphoneEvent: Event, notifiedEvent: String, body: Content) {}
	func onSubscribeReceived(core: Core, linphoneEvent: Event, subscribeEvent: String, body: Content) {}
	func onPublishStateChanged(core: Core, linphoneEvent: Event, state: PublishState) {}
	func onConfiguringStatus(core: Core, status: ConfiguringState, message: String) {}
	func onNetworkReachable(core: Core, reachable: Bool) {}
	func onLogCollectionUploadStateChanged(core: Core, state: Core.LogCollectionUploadState, info: String) {}
	func onLogCollectionUploadProgressIndication(core: Core, offset: Int, total: Int) {}
	func onFriendListCreated(core: Core, friendList: FriendList) {}
	func onFriendListRemoved(core: Core, friendList: FriendList) {}
	func onCallCreated(core: Core, call: Call) {}
	func onVersionUpdateCheckResultReceived(core: Core, result: VersionUpdateCheckResult, version: String, url: String) {}
	func onConferenceStateChanged(core: Core, conference: Conference, state: Conference.State) {}
	func onChatRoomStateChanged(core: Core, chatRoom: ChatRoom, state: ChatRoom.State) {}
	func onChatRoomSubjectChanged(core: Core, chatRoom: ChatRoom) {}
	func onChatRoomEphemeralMessageDeleted(core: Core, chatRoom: ChatRoom) {}
	func onImeeUserRegistration(core: Core, status: Bool, userId: String, info: String) {}
	func onQrcodeFound(core: Core, result: String) {}
	func onFirstCallStarted(core: Core) {}
	func onLastCallEnded(core: Core) {}
	func onAudioDeviceChanged(core: Core, audioDevice: AudioDevice) {}
	func onAudioDevicesListUpdated(core: Core) {}
	func onEcCalibrationResult(core: Core, status: EcCalibratorStatus, delayMs: Int) {}
	func onEcCalibrationAudioInit(core: Core) {}
	func onEcCalibrationAudioUninit(core: Core) {}
	func onAccountRegistrationStateChanged(core: Core, account: Account, state: RegistrationState, message: String) {}
	func onConferenceInfoOnSent(core: Core, conferenceInfo: ConferenceInfo) {}
	func onConferenceInfoOnParticipantSent(core: Core, conferenceInfo: ConferenceInfo, participant: Address) {}
	func onConferenceInfoOnParticipantError(core: Core, conferenceInfo: ConferenceInfo, participant: Address, error: ConferenceInfoError) {}
}

public final class CoreDelegateStub : CoreDelegate
{
	var _onGlobalStateChanged: ((Core, GlobalState, String) -> Void)?
	var _onRegistrationStateChanged: ((Core, ProxyConfig, RegistrationState, String) -> Void)?
	var _onCallStateChanged: ((Core, Call, Call.State, String) -> Void)?
	var _onNotifyPresenceReceived: ((Core, Friend) -> Void)?
	var _onNotifyPresenceReceivedForUriOrTel: ((Core, Friend, String, PresenceModel) -> Void)?
	var _onNewSubscriptionRequested: ((Core, Friend, String) -> Void)?
	var _onAuthenticationRequested: ((Core, AuthInfo, AuthMethod) -> Void)?
	var _onCallLogUpdated: ((Core, CallLog) -> Void)?
	var _onCallIdUpdated: ((Core, String, String) -> Void)?
	var _onMessageReceived: ((Core, ChatRoom, ChatMessage) -> Void)?
	var _onMessageSent: ((Core, ChatRoom, ChatMessage) -> Void)?
	var _onChatRoomRead: ((Core, ChatRoom) -> Void)?
	var _onMessageReceivedUnableDecrypt: ((Core, ChatRoom, ChatMessage) -> Void)?
	var _onIsComposingReceived: ((Core, ChatRoom) -> Void)?
	var _onDtmfReceived: ((Core, Call, Int) -> Void)?
	var _onReferReceived: ((Core, String) -> Void)?
	var _onCallEncryptionChanged: ((Core, Call, Bool, String) -> Void)?
	var _onTransferStateChanged: ((Core, Call, Call.State) -> Void)?
	var _onBuddyInfoUpdated: ((Core, Friend) -> Void)?
	var _onCallStatsUpdated: ((Core, Call, CallStats) -> Void)?
	var _onInfoReceived: ((Core, Call, InfoMessage) -> Void)?
	var _onSubscriptionStateChanged: ((Core, Event, SubscriptionState) -> Void)?
	var _onNotifyReceived: ((Core, Event, String, Content) -> Void)?
	var _onSubscribeReceived: ((Core, Event, String, Content) -> Void)?
	var _onPublishStateChanged: ((Core, Event, PublishState) -> Void)?
	var _onConfiguringStatus: ((Core, ConfiguringState, String) -> Void)?
	var _onNetworkReachable: ((Core, Bool) -> Void)?
	var _onLogCollectionUploadStateChanged: ((Core, Core.LogCollectionUploadState, String) -> Void)?
	var _onLogCollectionUploadProgressIndication: ((Core, Int, Int) -> Void)?
	var _onFriendListCreated: ((Core, FriendList) -> Void)?
	var _onFriendListRemoved: ((Core, FriendList) -> Void)?
	var _onCallCreated: ((Core, Call) -> Void)?
	var _onVersionUpdateCheckResultReceived: ((Core, VersionUpdateCheckResult, String, String) -> Void)?
	var _onConferenceStateChanged: ((Core, Conference, Conference.State) -> Void)?
	var _onChatRoomStateChanged: ((Core, ChatRoom, ChatRoom.State) -> Void)?
	var _onChatRoomSubjectChanged: ((Core, ChatRoom) -> Void)?
	var _onChatRoomEphemeralMessageDeleted: ((Core, ChatRoom) -> Void)?
	var _onImeeUserRegistration: ((Core, Bool, String, String) -> Void)?
	var _onQrcodeFound: ((Core, String) -> Void)?
	var _onFirstCallStarted: ((Core) -> Void)?
	var _onLastCallEnded: ((Core) -> Void)?
	var _onAudioDeviceChanged: ((Core, AudioDevice) -> Void)?
	var _onAudioDevicesListUpdated: ((Core) -> Void)?
	var _onEcCalibrationResult: ((Core, EcCalibratorStatus, Int) -> Void)?
	var _onEcCalibrationAudioInit: ((Core) -> Void)?
	var _onEcCalibrationAudioUninit: ((Core) -> Void)?
	var _onAccountRegistrationStateChanged: ((Core, Account, RegistrationState, String) -> Void)?
	var _onConferenceInfoOnSent: ((Core, ConferenceInfo) -> Void)?
	var _onConferenceInfoOnParticipantSent: ((Core, ConferenceInfo, Address) -> Void)?
	var _onConferenceInfoOnParticipantError: ((Core, ConferenceInfo, Address, ConferenceInfoError) -> Void)?

	public func onGlobalStateChanged(core: Core, state: GlobalState, message: String){_onGlobalStateChanged.map{$0(core, state, message)}}
	public func onRegistrationStateChanged(core: Core, proxyConfig: ProxyConfig, state: RegistrationState, message: String){_onRegistrationStateChanged.map{$0(core, proxyConfig, state, message)}}
	public func onCallStateChanged(core: Core, call: Call, state: Call.State, message: String){_onCallStateChanged.map{$0(core, call, state, message)}}
	public func onNotifyPresenceReceived(core: Core, linphoneFriend: Friend){_onNotifyPresenceReceived.map{$0(core, linphoneFriend)}}
	public func onNotifyPresenceReceivedForUriOrTel(core: Core, linphoneFriend: Friend, uriOrTel: String, presenceModel: PresenceModel){_onNotifyPresenceReceivedForUriOrTel.map{$0(core, linphoneFriend, uriOrTel, presenceModel)}}
	public func onNewSubscriptionRequested(core: Core, linphoneFriend: Friend, url: String){_onNewSubscriptionRequested.map{$0(core, linphoneFriend, url)}}
	public func onAuthenticationRequested(core: Core, authInfo: AuthInfo, method: AuthMethod){_onAuthenticationRequested.map{$0(core, authInfo, method)}}
	public func onCallLogUpdated(core: Core, callLog: CallLog){_onCallLogUpdated.map{$0(core, callLog)}}
	public func onCallIdUpdated(core: Core, previousCallId: String, currentCallId: String){_onCallIdUpdated.map{$0(core, previousCallId, currentCallId)}}
	public func onMessageReceived(core: Core, chatRoom: ChatRoom, message: ChatMessage){_onMessageReceived.map{$0(core, chatRoom, message)}}
	public func onMessageSent(core: Core, chatRoom: ChatRoom, message: ChatMessage){_onMessageSent.map{$0(core, chatRoom, message)}}
	public func onChatRoomRead(core: Core, chatRoom: ChatRoom){_onChatRoomRead.map{$0(core, chatRoom)}}
	public func onMessageReceivedUnableDecrypt(core: Core, chatRoom: ChatRoom, message: ChatMessage){_onMessageReceivedUnableDecrypt.map{$0(core, chatRoom, message)}}
	public func onIsComposingReceived(core: Core, chatRoom: ChatRoom){_onIsComposingReceived.map{$0(core, chatRoom)}}
	public func onDtmfReceived(core: Core, call: Call, dtmf: Int){_onDtmfReceived.map{$0(core, call, dtmf)}}
	public func onReferReceived(core: Core, referTo: String){_onReferReceived.map{$0(core, referTo)}}
	public func onCallEncryptionChanged(core: Core, call: Call, mediaEncryptionEnabled: Bool, authenticationToken: String){_onCallEncryptionChanged.map{$0(core, call, mediaEncryptionEnabled, authenticationToken)}}
	public func onTransferStateChanged(core: Core, transfered: Call, callState: Call.State){_onTransferStateChanged.map{$0(core, transfered, callState)}}
	public func onBuddyInfoUpdated(core: Core, linphoneFriend: Friend){_onBuddyInfoUpdated.map{$0(core, linphoneFriend)}}
	public func onCallStatsUpdated(core: Core, call: Call, callStats: CallStats){_onCallStatsUpdated.map{$0(core, call, callStats)}}
	public func onInfoReceived(core: Core, call: Call, message: InfoMessage){_onInfoReceived.map{$0(core, call, message)}}
	public func onSubscriptionStateChanged(core: Core, linphoneEvent: Event, state: SubscriptionState){_onSubscriptionStateChanged.map{$0(core, linphoneEvent, state)}}
	public func onNotifyReceived(core: Core, linphoneEvent: Event, notifiedEvent: String, body: Content){_onNotifyReceived.map{$0(core, linphoneEvent, notifiedEvent, body)}}
	public func onSubscribeReceived(core: Core, linphoneEvent: Event, subscribeEvent: String, body: Content){_onSubscribeReceived.map{$0(core, linphoneEvent, subscribeEvent, body)}}
	public func onPublishStateChanged(core: Core, linphoneEvent: Event, state: PublishState){_onPublishStateChanged.map{$0(core, linphoneEvent, state)}}
	public func onConfiguringStatus(core: Core, status: ConfiguringState, message: String){_onConfiguringStatus.map{$0(core, status, message)}}
	public func onNetworkReachable(core: Core, reachable: Bool){_onNetworkReachable.map{$0(core, reachable)}}
	public func onLogCollectionUploadStateChanged(core: Core, state: Core.LogCollectionUploadState, info: String){_onLogCollectionUploadStateChanged.map{$0(core, state, info)}}
	public func onLogCollectionUploadProgressIndication(core: Core, offset: Int, total: Int){_onLogCollectionUploadProgressIndication.map{$0(core, offset, total)}}
	public func onFriendListCreated(core: Core, friendList: FriendList){_onFriendListCreated.map{$0(core, friendList)}}
	public func onFriendListRemoved(core: Core, friendList: FriendList){_onFriendListRemoved.map{$0(core, friendList)}}
	public func onCallCreated(core: Core, call: Call){_onCallCreated.map{$0(core, call)}}
	public func onVersionUpdateCheckResultReceived(core: Core, result: VersionUpdateCheckResult, version: String, url: String){_onVersionUpdateCheckResultReceived.map{$0(core, result, version, url)}}
	public func onConferenceStateChanged(core: Core, conference: Conference, state: Conference.State){_onConferenceStateChanged.map{$0(core, conference, state)}}
	public func onChatRoomStateChanged(core: Core, chatRoom: ChatRoom, state: ChatRoom.State){_onChatRoomStateChanged.map{$0(core, chatRoom, state)}}
	public func onChatRoomSubjectChanged(core: Core, chatRoom: ChatRoom){_onChatRoomSubjectChanged.map{$0(core, chatRoom)}}
	public func onChatRoomEphemeralMessageDeleted(core: Core, chatRoom: ChatRoom){_onChatRoomEphemeralMessageDeleted.map{$0(core, chatRoom)}}
	public func onImeeUserRegistration(core: Core, status: Bool, userId: String, info: String){_onImeeUserRegistration.map{$0(core, status, userId, info)}}
	public func onQrcodeFound(core: Core, result: String){_onQrcodeFound.map{$0(core, result)}}
	public func onFirstCallStarted(core: Core){_onFirstCallStarted.map{$0(core)}}
	public func onLastCallEnded(core: Core){_onLastCallEnded.map{$0(core)}}
	public func onAudioDeviceChanged(core: Core, audioDevice: AudioDevice){_onAudioDeviceChanged.map{$0(core, audioDevice)}}
	public func onAudioDevicesListUpdated(core: Core){_onAudioDevicesListUpdated.map{$0(core)}}
	public func onEcCalibrationResult(core: Core, status: EcCalibratorStatus, delayMs: Int){_onEcCalibrationResult.map{$0(core, status, delayMs)}}
	public func onEcCalibrationAudioInit(core: Core){_onEcCalibrationAudioInit.map{$0(core)}}
	public func onEcCalibrationAudioUninit(core: Core){_onEcCalibrationAudioUninit.map{$0(core)}}
	public func onAccountRegistrationStateChanged(core: Core, account: Account, state: RegistrationState, message: String){_onAccountRegistrationStateChanged.map{$0(core, account, state, message)}}
	public func onConferenceInfoOnSent(core: Core, conferenceInfo: ConferenceInfo){_onConferenceInfoOnSent.map{$0(core, conferenceInfo)}}
	public func onConferenceInfoOnParticipantSent(core: Core, conferenceInfo: ConferenceInfo, participant: Address){_onConferenceInfoOnParticipantSent.map{$0(core, conferenceInfo, participant)}}
	public func onConferenceInfoOnParticipantError(core: Core, conferenceInfo: ConferenceInfo, participant: Address, error: ConferenceInfoError){_onConferenceInfoOnParticipantError.map{$0(core, conferenceInfo, participant, error)}}

	public init (
		onGlobalStateChanged: ((Core, GlobalState, String) -> Void)? = nil,
		onRegistrationStateChanged: ((Core, ProxyConfig, RegistrationState, String) -> Void)? = nil,
		onCallStateChanged: ((Core, Call, Call.State, String) -> Void)? = nil,
		onNotifyPresenceReceived: ((Core, Friend) -> Void)? = nil,
		onNotifyPresenceReceivedForUriOrTel: ((Core, Friend, String, PresenceModel) -> Void)? = nil,
		onNewSubscriptionRequested: ((Core, Friend, String) -> Void)? = nil,
		onAuthenticationRequested: ((Core, AuthInfo, AuthMethod) -> Void)? = nil,
		onCallLogUpdated: ((Core, CallLog) -> Void)? = nil,
		onCallIdUpdated: ((Core, String, String) -> Void)? = nil,
		onMessageReceived: ((Core, ChatRoom, ChatMessage) -> Void)? = nil,
		onMessageSent: ((Core, ChatRoom, ChatMessage) -> Void)? = nil,
		onChatRoomRead: ((Core, ChatRoom) -> Void)? = nil,
		onMessageReceivedUnableDecrypt: ((Core, ChatRoom, ChatMessage) -> Void)? = nil,
		onIsComposingReceived: ((Core, ChatRoom) -> Void)? = nil,
		onDtmfReceived: ((Core, Call, Int) -> Void)? = nil,
		onReferReceived: ((Core, String) -> Void)? = nil,
		onCallEncryptionChanged: ((Core, Call, Bool, String) -> Void)? = nil,
		onTransferStateChanged: ((Core, Call, Call.State) -> Void)? = nil,
		onBuddyInfoUpdated: ((Core, Friend) -> Void)? = nil,
		onCallStatsUpdated: ((Core, Call, CallStats) -> Void)? = nil,
		onInfoReceived: ((Core, Call, InfoMessage) -> Void)? = nil,
		onSubscriptionStateChanged: ((Core, Event, SubscriptionState) -> Void)? = nil,
		onNotifyReceived: ((Core, Event, String, Content) -> Void)? = nil,
		onSubscribeReceived: ((Core, Event, String, Content) -> Void)? = nil,
		onPublishStateChanged: ((Core, Event, PublishState) -> Void)? = nil,
		onConfiguringStatus: ((Core, ConfiguringState, String) -> Void)? = nil,
		onNetworkReachable: ((Core, Bool) -> Void)? = nil,
		onLogCollectionUploadStateChanged: ((Core, Core.LogCollectionUploadState, String) -> Void)? = nil,
		onLogCollectionUploadProgressIndication: ((Core, Int, Int) -> Void)? = nil,
		onFriendListCreated: ((Core, FriendList) -> Void)? = nil,
		onFriendListRemoved: ((Core, FriendList) -> Void)? = nil,
		onCallCreated: ((Core, Call) -> Void)? = nil,
		onVersionUpdateCheckResultReceived: ((Core, VersionUpdateCheckResult, String, String) -> Void)? = nil,
		onConferenceStateChanged: ((Core, Conference, Conference.State) -> Void)? = nil,
		onChatRoomStateChanged: ((Core, ChatRoom, ChatRoom.State) -> Void)? = nil,
		onChatRoomSubjectChanged: ((Core, ChatRoom) -> Void)? = nil,
		onChatRoomEphemeralMessageDeleted: ((Core, ChatRoom) -> Void)? = nil,
		onImeeUserRegistration: ((Core, Bool, String, String) -> Void)? = nil,
		onQrcodeFound: ((Core, String) -> Void)? = nil,
		onFirstCallStarted: ((Core) -> Void)? = nil,
		onLastCallEnded: ((Core) -> Void)? = nil,
		onAudioDeviceChanged: ((Core, AudioDevice) -> Void)? = nil,
		onAudioDevicesListUpdated: ((Core) -> Void)? = nil,
		onEcCalibrationResult: ((Core, EcCalibratorStatus, Int) -> Void)? = nil,
		onEcCalibrationAudioInit: ((Core) -> Void)? = nil,
		onEcCalibrationAudioUninit: ((Core) -> Void)? = nil,
		onAccountRegistrationStateChanged: ((Core, Account, RegistrationState, String) -> Void)? = nil,
		onConferenceInfoOnSent: ((Core, ConferenceInfo) -> Void)? = nil,
		onConferenceInfoOnParticipantSent: ((Core, ConferenceInfo, Address) -> Void)? = nil,
		onConferenceInfoOnParticipantError: ((Core, ConferenceInfo, Address, ConferenceInfoError) -> Void)? = nil
	) {
		self._onGlobalStateChanged = onGlobalStateChanged
		self._onRegistrationStateChanged = onRegistrationStateChanged
		self._onCallStateChanged = onCallStateChanged
		self._onNotifyPresenceReceived = onNotifyPresenceReceived
		self._onNotifyPresenceReceivedForUriOrTel = onNotifyPresenceReceivedForUriOrTel
		self._onNewSubscriptionRequested = onNewSubscriptionRequested
		self._onAuthenticationRequested = onAuthenticationRequested
		self._onCallLogUpdated = onCallLogUpdated
		self._onCallIdUpdated = onCallIdUpdated
		self._onMessageReceived = onMessageReceived
		self._onMessageSent = onMessageSent
		self._onChatRoomRead = onChatRoomRead
		self._onMessageReceivedUnableDecrypt = onMessageReceivedUnableDecrypt
		self._onIsComposingReceived = onIsComposingReceived
		self._onDtmfReceived = onDtmfReceived
		self._onReferReceived = onReferReceived
		self._onCallEncryptionChanged = onCallEncryptionChanged
		self._onTransferStateChanged = onTransferStateChanged
		self._onBuddyInfoUpdated = onBuddyInfoUpdated
		self._onCallStatsUpdated = onCallStatsUpdated
		self._onInfoReceived = onInfoReceived
		self._onSubscriptionStateChanged = onSubscriptionStateChanged
		self._onNotifyReceived = onNotifyReceived
		self._onSubscribeReceived = onSubscribeReceived
		self._onPublishStateChanged = onPublishStateChanged
		self._onConfiguringStatus = onConfiguringStatus
		self._onNetworkReachable = onNetworkReachable
		self._onLogCollectionUploadStateChanged = onLogCollectionUploadStateChanged
		self._onLogCollectionUploadProgressIndication = onLogCollectionUploadProgressIndication
		self._onFriendListCreated = onFriendListCreated
		self._onFriendListRemoved = onFriendListRemoved
		self._onCallCreated = onCallCreated
		self._onVersionUpdateCheckResultReceived = onVersionUpdateCheckResultReceived
		self._onConferenceStateChanged = onConferenceStateChanged
		self._onChatRoomStateChanged = onChatRoomStateChanged
		self._onChatRoomSubjectChanged = onChatRoomSubjectChanged
		self._onChatRoomEphemeralMessageDeleted = onChatRoomEphemeralMessageDeleted
		self._onImeeUserRegistration = onImeeUserRegistration
		self._onQrcodeFound = onQrcodeFound
		self._onFirstCallStarted = onFirstCallStarted
		self._onLastCallEnded = onLastCallEnded
		self._onAudioDeviceChanged = onAudioDeviceChanged
		self._onAudioDevicesListUpdated = onAudioDevicesListUpdated
		self._onEcCalibrationResult = onEcCalibrationResult
		self._onEcCalibrationAudioInit = onEcCalibrationAudioInit
		self._onEcCalibrationAudioUninit = onEcCalibrationAudioUninit
		self._onAccountRegistrationStateChanged = onAccountRegistrationStateChanged
		self._onConferenceInfoOnSent = onConferenceInfoOnSent
		self._onConferenceInfoOnParticipantSent = onConferenceInfoOnParticipantSent
		self._onConferenceInfoOnParticipantError = onConferenceInfoOnParticipantError
	}
}

class CoreDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: CoreDelegate?

	public init() {
		cPtr = linphone_factory_create_core_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<CoreDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_core_cbs_set_global_state_changed(cPtr, { (core, state, message) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onGlobalStateChanged(core: sObject, state: GlobalState(rawValue: Int(state.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})

		linphone_core_cbs_set_registration_state_changed(cPtr, { (core, proxyConfig, state, message) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onRegistrationStateChanged(core: sObject, proxyConfig: ProxyConfig.getSwiftObject(cObject: proxyConfig!), state: RegistrationState(rawValue: Int(state.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})

		linphone_core_cbs_set_call_state_changed(cPtr, { (core, call, state, message) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onCallStateChanged(core: sObject, call: Call.getSwiftObject(cObject: call!), state: Call.State(rawValue: Int(state.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})

		linphone_core_cbs_set_notify_presence_received(cPtr, { (core, linphoneFriend) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onNotifyPresenceReceived(core: sObject, linphoneFriend: Friend.getSwiftObject(cObject: linphoneFriend!))
			}
		})

		linphone_core_cbs_set_notify_presence_received_for_uri_or_tel(cPtr, { (core, linphoneFriend, uriOrTel, presenceModel) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onNotifyPresenceReceivedForUriOrTel(core: sObject, linphoneFriend: Friend.getSwiftObject(cObject: linphoneFriend!), uriOrTel: charArrayToString(charPointer: uriOrTel), presenceModel: PresenceModel.getSwiftObject(cObject: presenceModel!))
			}
		})

		linphone_core_cbs_set_new_subscription_requested(cPtr, { (core, linphoneFriend, url) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onNewSubscriptionRequested(core: sObject, linphoneFriend: Friend.getSwiftObject(cObject: linphoneFriend!), url: charArrayToString(charPointer: url))
			}
		})

		linphone_core_cbs_set_authentication_requested(cPtr, { (core, authInfo, method) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onAuthenticationRequested(core: sObject, authInfo: AuthInfo.getSwiftObject(cObject: authInfo!), method: AuthMethod(rawValue: Int(method.rawValue))!)
			}
		})

		linphone_core_cbs_set_call_log_updated(cPtr, { (core, callLog) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onCallLogUpdated(core: sObject, callLog: CallLog.getSwiftObject(cObject: callLog!))
			}
		})

		linphone_core_cbs_set_call_id_updated(cPtr, { (core, previousCallId, currentCallId) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onCallIdUpdated(core: sObject, previousCallId: charArrayToString(charPointer: previousCallId), currentCallId: charArrayToString(charPointer: currentCallId))
			}
		})

		linphone_core_cbs_set_message_received(cPtr, { (core, chatRoom, message) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onMessageReceived(core: sObject, chatRoom: ChatRoom.getSwiftObject(cObject: chatRoom!), message: ChatMessage.getSwiftObject(cObject: message!))
			}
		})

		linphone_core_cbs_set_message_sent(cPtr, { (core, chatRoom, message) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onMessageSent(core: sObject, chatRoom: ChatRoom.getSwiftObject(cObject: chatRoom!), message: ChatMessage.getSwiftObject(cObject: message!))
			}
		})

		linphone_core_cbs_set_chat_room_read(cPtr, { (core, chatRoom) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onChatRoomRead(core: sObject, chatRoom: ChatRoom.getSwiftObject(cObject: chatRoom!))
			}
		})

		linphone_core_cbs_set_message_received_unable_decrypt(cPtr, { (core, chatRoom, message) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onMessageReceivedUnableDecrypt(core: sObject, chatRoom: ChatRoom.getSwiftObject(cObject: chatRoom!), message: ChatMessage.getSwiftObject(cObject: message!))
			}
		})

		linphone_core_cbs_set_is_composing_received(cPtr, { (core, chatRoom) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onIsComposingReceived(core: sObject, chatRoom: ChatRoom.getSwiftObject(cObject: chatRoom!))
			}
		})

		linphone_core_cbs_set_dtmf_received(cPtr, { (core, call, dtmf) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onDtmfReceived(core: sObject, call: Call.getSwiftObject(cObject: call!), dtmf: Int(dtmf))
			}
		})

		linphone_core_cbs_set_refer_received(cPtr, { (core, referTo) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onReferReceived(core: sObject, referTo: charArrayToString(charPointer: referTo))
			}
		})

		linphone_core_cbs_set_call_encryption_changed(cPtr, { (core, call, mediaEncryptionEnabled, authenticationToken) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onCallEncryptionChanged(core: sObject, call: Call.getSwiftObject(cObject: call!), mediaEncryptionEnabled: mediaEncryptionEnabled != 0, authenticationToken: charArrayToString(charPointer: authenticationToken))
			}
		})

		linphone_core_cbs_set_transfer_state_changed(cPtr, { (core, transfered, callState) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onTransferStateChanged(core: sObject, transfered: Call.getSwiftObject(cObject: transfered!), callState: Call.State(rawValue: Int(callState.rawValue))!)
			}
		})

		linphone_core_cbs_set_buddy_info_updated(cPtr, { (core, linphoneFriend) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onBuddyInfoUpdated(core: sObject, linphoneFriend: Friend.getSwiftObject(cObject: linphoneFriend!))
			}
		})

		linphone_core_cbs_set_call_stats_updated(cPtr, { (core, call, callStats) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onCallStatsUpdated(core: sObject, call: Call.getSwiftObject(cObject: call!), callStats: CallStats.getSwiftObject(cObject: callStats!))
			}
		})

		linphone_core_cbs_set_info_received(cPtr, { (core, call, message) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onInfoReceived(core: sObject, call: Call.getSwiftObject(cObject: call!), message: InfoMessage.getSwiftObject(cObject: message!))
			}
		})

		linphone_core_cbs_set_subscription_state_changed(cPtr, { (core, linphoneEvent, state) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onSubscriptionStateChanged(core: sObject, linphoneEvent: Event.getSwiftObject(cObject: linphoneEvent!), state: SubscriptionState(rawValue: Int(state.rawValue))!)
			}
		})

		linphone_core_cbs_set_notify_received(cPtr, { (core, linphoneEvent, notifiedEvent, body) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onNotifyReceived(core: sObject, linphoneEvent: Event.getSwiftObject(cObject: linphoneEvent!), notifiedEvent: charArrayToString(charPointer: notifiedEvent), body: Content.getSwiftObject(cObject: body!))
			}
		})

		linphone_core_cbs_set_subscribe_received(cPtr, { (core, linphoneEvent, subscribeEvent, body) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onSubscribeReceived(core: sObject, linphoneEvent: Event.getSwiftObject(cObject: linphoneEvent!), subscribeEvent: charArrayToString(charPointer: subscribeEvent), body: Content.getSwiftObject(cObject: body!))
			}
		})

		linphone_core_cbs_set_publish_state_changed(cPtr, { (core, linphoneEvent, state) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onPublishStateChanged(core: sObject, linphoneEvent: Event.getSwiftObject(cObject: linphoneEvent!), state: PublishState(rawValue: Int(state.rawValue))!)
			}
		})

		linphone_core_cbs_set_configuring_status(cPtr, { (core, status, message) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onConfiguringStatus(core: sObject, status: ConfiguringState(rawValue: Int(status.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})

		linphone_core_cbs_set_network_reachable(cPtr, { (core, reachable) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onNetworkReachable(core: sObject, reachable: reachable != 0)
			}
		})

		linphone_core_cbs_set_log_collection_upload_state_changed(cPtr, { (core, state, info) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onLogCollectionUploadStateChanged(core: sObject, state: Core.LogCollectionUploadState(rawValue: Int(state.rawValue))!, info: charArrayToString(charPointer: info))
			}
		})

		linphone_core_cbs_set_log_collection_upload_progress_indication(cPtr, { (core, offset, total) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onLogCollectionUploadProgressIndication(core: sObject, offset: Int(offset), total: Int(total))
			}
		})

		linphone_core_cbs_set_friend_list_created(cPtr, { (core, friendList) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onFriendListCreated(core: sObject, friendList: FriendList.getSwiftObject(cObject: friendList!))
			}
		})

		linphone_core_cbs_set_friend_list_removed(cPtr, { (core, friendList) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onFriendListRemoved(core: sObject, friendList: FriendList.getSwiftObject(cObject: friendList!))
			}
		})

		linphone_core_cbs_set_call_created(cPtr, { (core, call) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onCallCreated(core: sObject, call: Call.getSwiftObject(cObject: call!))
			}
		})

		linphone_core_cbs_set_version_update_check_result_received(cPtr, { (core, result, version, url) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onVersionUpdateCheckResultReceived(core: sObject, result: VersionUpdateCheckResult(rawValue: Int(result.rawValue))!, version: charArrayToString(charPointer: version), url: charArrayToString(charPointer: url))
			}
		})

		linphone_core_cbs_set_conference_state_changed(cPtr, { (core, conference, state) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onConferenceStateChanged(core: sObject, conference: Conference.getSwiftObject(cObject: conference!), state: Conference.State(rawValue: Int(state.rawValue))!)
			}
		})

		linphone_core_cbs_set_chat_room_state_changed(cPtr, { (core, chatRoom, state) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onChatRoomStateChanged(core: sObject, chatRoom: ChatRoom.getSwiftObject(cObject: chatRoom!), state: ChatRoom.State(rawValue: Int(state.rawValue))!)
			}
		})

		linphone_core_cbs_set_chat_room_subject_changed(cPtr, { (core, chatRoom) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onChatRoomSubjectChanged(core: sObject, chatRoom: ChatRoom.getSwiftObject(cObject: chatRoom!))
			}
		})

		linphone_core_cbs_set_chat_room_ephemeral_message_deleted(cPtr, { (core, chatRoom) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onChatRoomEphemeralMessageDeleted(core: sObject, chatRoom: ChatRoom.getSwiftObject(cObject: chatRoom!))
			}
		})

		linphone_core_cbs_set_imee_user_registration(cPtr, { (core, status, userId, info) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onImeeUserRegistration(core: sObject, status: status != 0, userId: charArrayToString(charPointer: userId), info: charArrayToString(charPointer: info))
			}
		})

		linphone_core_cbs_set_qrcode_found(cPtr, { (core, result) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onQrcodeFound(core: sObject, result: charArrayToString(charPointer: result))
			}
		})

		linphone_core_cbs_set_first_call_started(cPtr, { (core) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onFirstCallStarted(core: sObject)
			}
		})

		linphone_core_cbs_set_last_call_ended(cPtr, { (core) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onLastCallEnded(core: sObject)
			}
		})

		linphone_core_cbs_set_audio_device_changed(cPtr, { (core, audioDevice) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onAudioDeviceChanged(core: sObject, audioDevice: AudioDevice.getSwiftObject(cObject: audioDevice!))
			}
		})

		linphone_core_cbs_set_audio_devices_list_updated(cPtr, { (core) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onAudioDevicesListUpdated(core: sObject)
			}
		})

		linphone_core_cbs_set_ec_calibration_result(cPtr, { (core, status, delayMs) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onEcCalibrationResult(core: sObject, status: EcCalibratorStatus(rawValue: Int(status.rawValue))!, delayMs: Int(delayMs))
			}
		})

		linphone_core_cbs_set_ec_calibration_audio_init(cPtr, { (core) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onEcCalibrationAudioInit(core: sObject)
			}
		})

		linphone_core_cbs_set_ec_calibration_audio_uninit(cPtr, { (core) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onEcCalibrationAudioUninit(core: sObject)
			}
		})

		linphone_core_cbs_set_account_registration_state_changed(cPtr, { (core, account, state, message) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onAccountRegistrationStateChanged(core: sObject, account: Account.getSwiftObject(cObject: account!), state: RegistrationState(rawValue: Int(state.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})

		linphone_core_cbs_set_conference_info_on_sent(cPtr, { (core, conferenceInfo) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onConferenceInfoOnSent(core: sObject, conferenceInfo: ConferenceInfo.getSwiftObject(cObject: conferenceInfo!))
			}
		})

		linphone_core_cbs_set_conference_info_on_participant_sent(cPtr, { (core, conferenceInfo, participant) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onConferenceInfoOnParticipantSent(core: sObject, conferenceInfo: ConferenceInfo.getSwiftObject(cObject: conferenceInfo!), participant: Address.getSwiftObject(cObject: participant!))
			}
		})

		linphone_core_cbs_set_conference_info_on_participant_error(cPtr, { (core, conferenceInfo, participant, error) -> Void in
			if (core != nil) {
				let sObject = Core.getSwiftObject(cObject: core!)
				let delegate = sObject.currentDelegate
				delegate?.onConferenceInfoOnParticipantError(core: sObject, conferenceInfo: ConferenceInfo.getSwiftObject(cObject: conferenceInfo!), participant: Address.getSwiftObject(cObject: participant!), error: ConferenceInfoError(rawValue: Int(error.rawValue))!)
			}
		})
	}


}

public protocol EventDelegate : AnyObject {
	///	Callback used to notify the response to a sent NOTIFY. 
	/// - Parameter linphoneEvent: The LinphoneEvent object that has sent the NOTIFY
	/// and for which we received a response   
	func onNotifyResponse(linphoneEvent: Event)
}

public extension EventDelegate {
	func onNotifyResponse(linphoneEvent: Event) {}
}

public final class EventDelegateStub : EventDelegate
{
	var _onNotifyResponse: ((Event) -> Void)?

	public func onNotifyResponse(linphoneEvent: Event){_onNotifyResponse.map{$0(linphoneEvent)}}

	public init (
		onNotifyResponse: ((Event) -> Void)? = nil
	) {
		self._onNotifyResponse = onNotifyResponse
	}
}

class EventDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: EventDelegate?

	public init() {
		cPtr = linphone_factory_create_event_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<EventDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_event_cbs_set_notify_response(cPtr, { (linphoneEvent) -> Void in
			if (linphoneEvent != nil) {
				let sObject = Event.getSwiftObject(cObject: linphoneEvent!)
				let delegate = sObject.currentDelegate
				delegate?.onNotifyResponse(linphoneEvent: sObject)
			}
		})
	}


}

public protocol FriendListDelegate : AnyObject {
	///	Callback used to notify a new contact has been created on the CardDAV server
	///	and downloaded locally. 
	/// - Parameter friendList: The LinphoneFriendList object the new contact is added
	/// to   
	/// - Parameter linphoneFriend: The LinphoneFriend object that has been created   
	func onContactCreated(friendList: FriendList, linphoneFriend: Friend)
	///	Callback used to notify a contact has been deleted on the CardDAV server. 
	/// - Parameter friendList: The LinphoneFriendList object a contact has been
	/// removed from   
	/// - Parameter linphoneFriend: The LinphoneFriend object that has been deleted   
	func onContactDeleted(friendList: FriendList, linphoneFriend: Friend)
	///	Callback used to notify a contact has been updated on the CardDAV server. 
	/// - Parameter friendList: The LinphoneFriendList object in which a contact has
	/// been updated   
	/// - Parameter newFriend: The new LinphoneFriend object corresponding to the
	/// updated contact   
	/// - Parameter oldFriend: The old LinphoneFriend object before update   
	func onContactUpdated(friendList: FriendList, newFriend: Friend, oldFriend: Friend)
	///	Callback used to notify the status of the synchronization has changed. 
	/// - Parameter friendList: The LinphoneFriendList object for which the status has
	/// changed   
	/// - Parameter status: The new LinphoneFriendListSyncStatus 
	/// - Parameter message: An additional information on the status update   
	func onSyncStatusChanged(friendList: FriendList, status: FriendList.SyncStatus, message: String)
	///	Callback used to notify a list with all friends that have received presence
	///	information. 
	/// - Parameter friendList: The LinphoneFriendList object for which the status has
	/// changed   
	/// - Parameter friends: A  of the relevant friends   
	func onPresenceReceived(friendList: FriendList, friends: [Friend])
}

public extension FriendListDelegate {
	func onContactCreated(friendList: FriendList, linphoneFriend: Friend) {}
	func onContactDeleted(friendList: FriendList, linphoneFriend: Friend) {}
	func onContactUpdated(friendList: FriendList, newFriend: Friend, oldFriend: Friend) {}
	func onSyncStatusChanged(friendList: FriendList, status: FriendList.SyncStatus, message: String) {}
	func onPresenceReceived(friendList: FriendList, friends: [Friend]) {}
}

public final class FriendListDelegateStub : FriendListDelegate
{
	var _onContactCreated: ((FriendList, Friend) -> Void)?
	var _onContactDeleted: ((FriendList, Friend) -> Void)?
	var _onContactUpdated: ((FriendList, Friend, Friend) -> Void)?
	var _onSyncStatusChanged: ((FriendList, FriendList.SyncStatus, String) -> Void)?
	var _onPresenceReceived: ((FriendList, [Friend]) -> Void)?

	public func onContactCreated(friendList: FriendList, linphoneFriend: Friend){_onContactCreated.map{$0(friendList, linphoneFriend)}}
	public func onContactDeleted(friendList: FriendList, linphoneFriend: Friend){_onContactDeleted.map{$0(friendList, linphoneFriend)}}
	public func onContactUpdated(friendList: FriendList, newFriend: Friend, oldFriend: Friend){_onContactUpdated.map{$0(friendList, newFriend, oldFriend)}}
	public func onSyncStatusChanged(friendList: FriendList, status: FriendList.SyncStatus, message: String){_onSyncStatusChanged.map{$0(friendList, status, message)}}
	public func onPresenceReceived(friendList: FriendList, friends: [Friend]){_onPresenceReceived.map{$0(friendList, friends)}}

	public init (
		onContactCreated: ((FriendList, Friend) -> Void)? = nil,
		onContactDeleted: ((FriendList, Friend) -> Void)? = nil,
		onContactUpdated: ((FriendList, Friend, Friend) -> Void)? = nil,
		onSyncStatusChanged: ((FriendList, FriendList.SyncStatus, String) -> Void)? = nil,
		onPresenceReceived: ((FriendList, [Friend]) -> Void)? = nil
	) {
		self._onContactCreated = onContactCreated
		self._onContactDeleted = onContactDeleted
		self._onContactUpdated = onContactUpdated
		self._onSyncStatusChanged = onSyncStatusChanged
		self._onPresenceReceived = onPresenceReceived
	}
}

class FriendListDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: FriendListDelegate?

	public init() {
		cPtr = linphone_factory_create_friend_list_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<FriendListDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_friend_list_cbs_set_contact_created(cPtr, { (friendList, linphoneFriend) -> Void in
			if (friendList != nil) {
				let sObject = FriendList.getSwiftObject(cObject: friendList!)
				let delegate = sObject.currentDelegate
				delegate?.onContactCreated(friendList: sObject, linphoneFriend: Friend.getSwiftObject(cObject: linphoneFriend!))
			}
		})

		linphone_friend_list_cbs_set_contact_deleted(cPtr, { (friendList, linphoneFriend) -> Void in
			if (friendList != nil) {
				let sObject = FriendList.getSwiftObject(cObject: friendList!)
				let delegate = sObject.currentDelegate
				delegate?.onContactDeleted(friendList: sObject, linphoneFriend: Friend.getSwiftObject(cObject: linphoneFriend!))
			}
		})

		linphone_friend_list_cbs_set_contact_updated(cPtr, { (friendList, newFriend, oldFriend) -> Void in
			if (friendList != nil) {
				let sObject = FriendList.getSwiftObject(cObject: friendList!)
				let delegate = sObject.currentDelegate
				delegate?.onContactUpdated(friendList: sObject, newFriend: Friend.getSwiftObject(cObject: newFriend!), oldFriend: Friend.getSwiftObject(cObject: oldFriend!))
			}
		})

		linphone_friend_list_cbs_set_sync_status_changed(cPtr, { (friendList, status, message) -> Void in
			if (friendList != nil) {
				let sObject = FriendList.getSwiftObject(cObject: friendList!)
				let delegate = sObject.currentDelegate
				delegate?.onSyncStatusChanged(friendList: sObject, status: FriendList.SyncStatus(rawValue: Int(status.rawValue))!, message: charArrayToString(charPointer: message))
			}
		})

		linphone_friend_list_cbs_set_presence_received(cPtr, { (friendList, friends) -> Void in
			if (friendList != nil) {
				let sObject = FriendList.getSwiftObject(cObject: friendList!)
				let delegate = sObject.currentDelegate
				var friendssList = [Friend]()
				let friendscList = friends
				var listTemp = friendscList
				while (listTemp != nil) {
					let data = unsafeBitCast(listTemp!.pointee.data, to: OpaquePointer.self)
					friendssList.append(Friend.getSwiftObject(cObject: data))
					listTemp = UnsafePointer<bctbx_list_t>(listTemp!.pointee.next)
				}
				delegate?.onPresenceReceived(friendList: sObject, friends: friendssList)
			}
		})
	}


}

public protocol LoggingServiceDelegate : AnyObject {
	///	Type of callbacks called each time liblinphone write a log message. 
	/// - Parameter logService: A pointer on the logging service singleton.   
	/// - Parameter domain: A string describing which sub-library of liblinphone the
	/// message is coming from.   
	/// - Parameter level: Verbosity LinphoneLogLevel of the message. 
	/// - Parameter message: Content of the message.   
	func onLogMessageWritten(logService: LoggingService, domain: String, level: LogLevel, message: String)
}

public extension LoggingServiceDelegate {
	func onLogMessageWritten(logService: LoggingService, domain: String, level: LogLevel, message: String) {}
}

public final class LoggingServiceDelegateStub : LoggingServiceDelegate
{
	var _onLogMessageWritten: ((LoggingService, String, LogLevel, String) -> Void)?

	public func onLogMessageWritten(logService: LoggingService, domain: String, level: LogLevel, message: String){_onLogMessageWritten.map{$0(logService, domain, level, message)}}

	public init (
		onLogMessageWritten: ((LoggingService, String, LogLevel, String) -> Void)? = nil
	) {
		self._onLogMessageWritten = onLogMessageWritten
	}
}

class LoggingServiceDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: LoggingServiceDelegate?

	public init() {
		cPtr = linphone_factory_create_logging_service_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<LoggingServiceDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_logging_service_cbs_set_log_message_written(cPtr, { (logService, domain, level, message) -> Void in
			if (logService != nil) {
				let sObject = LoggingService.getSwiftObject(cObject: logService!)
				let delegate = sObject.currentDelegate
				delegate?.onLogMessageWritten(logService: sObject, domain: charArrayToString(charPointer: domain), level: LogLevel(rawValue: Int(level.rawValue)), message: charArrayToString(charPointer: message))
			}
		})
	}


}

public protocol MagicSearchDelegate : AnyObject {
	///	Callback used to notify when results are received. 
	/// - Parameter magicSearch: LinphoneMagicSearch object   
	func onSearchResultsReceived(magicSearch: MagicSearch)
	///	Callback used to notify when LDAP have more results available. 
	/// - Parameter magicSearch: LinphoneMagicSearch object   
	/// - Parameter ldap: LinphoneLdap object   
	func onLdapHaveMoreResults(magicSearch: MagicSearch, ldap: Ldap)
}

public extension MagicSearchDelegate {
	func onSearchResultsReceived(magicSearch: MagicSearch) {}
	func onLdapHaveMoreResults(magicSearch: MagicSearch, ldap: Ldap) {}
}

public final class MagicSearchDelegateStub : MagicSearchDelegate
{
	var _onSearchResultsReceived: ((MagicSearch) -> Void)?
	var _onLdapHaveMoreResults: ((MagicSearch, Ldap) -> Void)?

	public func onSearchResultsReceived(magicSearch: MagicSearch){_onSearchResultsReceived.map{$0(magicSearch)}}
	public func onLdapHaveMoreResults(magicSearch: MagicSearch, ldap: Ldap){_onLdapHaveMoreResults.map{$0(magicSearch, ldap)}}

	public init (
		onSearchResultsReceived: ((MagicSearch) -> Void)? = nil,
		onLdapHaveMoreResults: ((MagicSearch, Ldap) -> Void)? = nil
	) {
		self._onSearchResultsReceived = onSearchResultsReceived
		self._onLdapHaveMoreResults = onLdapHaveMoreResults
	}
}

class MagicSearchDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: MagicSearchDelegate?

	public init() {
		cPtr = linphone_factory_create_magic_search_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<MagicSearchDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_magic_search_cbs_set_search_results_received(cPtr, { (magicSearch) -> Void in
			if (magicSearch != nil) {
				let sObject = MagicSearch.getSwiftObject(cObject: magicSearch!)
				let delegate = sObject.currentDelegate
				delegate?.onSearchResultsReceived(magicSearch: sObject)
			}
		})

		linphone_magic_search_cbs_set_ldap_have_more_results(cPtr, { (magicSearch, ldap) -> Void in
			if (magicSearch != nil) {
				let sObject = MagicSearch.getSwiftObject(cObject: magicSearch!)
				let delegate = sObject.currentDelegate
				delegate?.onLdapHaveMoreResults(magicSearch: sObject, ldap: Ldap.getSwiftObject(cObject: ldap!))
			}
		})
	}


}

public protocol ParticipantDeviceDelegate : AnyObject {
	///	Callback used to notify that is this participant device speaking has changed. 
	/// - Parameter participantDevice: LinphoneParticipantDevice object   
	/// - Parameter isSpeaking: is this participant device speaking 
	func onIsSpeakingChanged(participantDevice: ParticipantDevice, isSpeaking: Bool)
}

public extension ParticipantDeviceDelegate {
	func onIsSpeakingChanged(participantDevice: ParticipantDevice, isSpeaking: Bool) {}
}

public final class ParticipantDeviceDelegateStub : ParticipantDeviceDelegate
{
	var _onIsSpeakingChanged: ((ParticipantDevice, Bool) -> Void)?

	public func onIsSpeakingChanged(participantDevice: ParticipantDevice, isSpeaking: Bool){_onIsSpeakingChanged.map{$0(participantDevice, isSpeaking)}}

	public init (
		onIsSpeakingChanged: ((ParticipantDevice, Bool) -> Void)? = nil
	) {
		self._onIsSpeakingChanged = onIsSpeakingChanged
	}
}

class ParticipantDeviceDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: ParticipantDeviceDelegate?

	public init() {
		cPtr = linphone_factory_create_participant_device_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<ParticipantDeviceDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_participant_device_cbs_set_is_speaking_changed(cPtr, { (participantDevice, isSpeaking) -> Void in
			if (participantDevice != nil) {
				let sObject = ParticipantDevice.getSwiftObject(cObject: participantDevice!)
				let delegate = sObject.currentDelegate
				delegate?.onIsSpeakingChanged(participantDevice: sObject, isSpeaking: isSpeaking != 0)
			}
		})
	}


}

public protocol PlayerDelegate : AnyObject {
	///	Callback for notifying end of play (file). 
	/// - Parameter player: The LinphonePlayer object   
	func onEofReached(player: Player)
}

public extension PlayerDelegate {
	func onEofReached(player: Player) {}
}

public final class PlayerDelegateStub : PlayerDelegate
{
	var _onEofReached: ((Player) -> Void)?

	public func onEofReached(player: Player){_onEofReached.map{$0(player)}}

	public init (
		onEofReached: ((Player) -> Void)? = nil
	) {
		self._onEofReached = onEofReached
	}
}

class PlayerDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: PlayerDelegate?

	public init() {
		cPtr = linphone_factory_create_player_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<PlayerDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_player_cbs_set_eof_reached(cPtr, { (player) -> Void in
			if (player != nil) {
				let sObject = Player.getSwiftObject(cObject: player!)
				let delegate = sObject.currentDelegate
				delegate?.onEofReached(player: sObject)
			}
		})
	}


}

public protocol XmlRpcRequestDelegate : AnyObject {
	///	Callback used to notify the response to an XML-RPC request. 
	/// - Parameter request: LinphoneXmlRpcRequest object   
	func onResponse(request: XmlRpcRequest)
}

public extension XmlRpcRequestDelegate {
	func onResponse(request: XmlRpcRequest) {}
}

public final class XmlRpcRequestDelegateStub : XmlRpcRequestDelegate
{
	var _onResponse: ((XmlRpcRequest) -> Void)?

	public func onResponse(request: XmlRpcRequest){_onResponse.map{$0(request)}}

	public init (
		onResponse: ((XmlRpcRequest) -> Void)? = nil
	) {
		self._onResponse = onResponse
	}
}

class XmlRpcRequestDelegateManager
{
	var cPtr: OpaquePointer
	public var delegate: XmlRpcRequestDelegate?

	public init() {
		cPtr = linphone_factory_create_xml_rpc_request_cbs(linphone_factory_get())
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque()), {
			data in
			if (data != nil) {
				Unmanaged<XmlRpcRequestDelegateManager>.fromOpaque(data!).release()
			}
		})

		linphone_xml_rpc_request_cbs_set_response(cPtr, { (request) -> Void in
			if (request != nil) {
				let sObject = XmlRpcRequest.getSwiftObject(cObject: request!)
				let delegate = sObject.currentDelegate
				delegate?.onResponse(request: sObject)
			}
		})
	}


}


/// Object that represents a Linphone Account. 
/// This object replaces the deprecated `ProxyConfig`. Use a `AccountParams` object
/// to configure it. 
public class Account : LinphoneObject
{
	var delegateManagers : [AccountDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> Account {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Account>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Account(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Object that represents a Linphone Account. 
	/// This object replaces the deprecated `ProxyConfig`. Use a `AccountParams` object
	/// to configure it. 
	public func addDelegate(delegate: AccountDelegate)
	{
		let manager = AccountDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_account_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// Object that represents a Linphone Account. 
	/// This object replaces the deprecated `ProxyConfig`. Use a `AccountParams` object
	/// to configure it. 
	public func removeDelegate(delegate: AccountDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_account_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Create a new `Account` with a Proxy config backpointer. 
	/// This is only intended to be used while keeping a backward compatibility with
	/// proxy config. 
	/// - Parameter lc: The `Core` object.   
	/// - Parameter params: The `AccountParams` object.   
	/// - Parameter config: The `ProxyConfig` object.   
	/// - Returns: The newly created `Account` object.   
	static public func newWithConfig(lc:Core?, params:AccountParams, config:ProxyConfig?) -> Account?
	{
		let cPointer = linphone_account_new_with_config(lc?.cPtr, params.cPtr, config?.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Account.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Indicates whether AVPF/SAVPF is being used for calls using this account. 
	/// - Returns: true if AVPF/SAVPF is enabled, false otherwise. 
	public var avpfEnabled: Bool
	{
			return linphone_account_avpf_enabled(cPtr) != 0
	}

	/// Return the contact address of the account. 
	/// - Returns: a `Address` correspond to the contact address of the account.   
	public var contactAddress: Address?
	{
			let cPointer = linphone_account_get_contact_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the `Core` object to which is associated the `Account`. 
	/// - Returns: The `Core` object to which is associated the `Account`.   
	public var core: Core?
	{
			let cPointer = linphone_account_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Core.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the current LinphoneAccountCbs. 
	/// This is meant only to be called from a callback to be able to get the user_data
	/// associated with the LinphoneAccountCbs that is calling the callback. 
	/// - Returns: The LinphoneAccountCbs that has called the last callback.   
	public var currentDelegate: AccountDelegate?
	{
			let cObject = linphone_account_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<AccountDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Get the dependency of a `Account`. 
	/// - Returns: The account this one is dependent upon, or nil if not marked
	/// dependent.   
	public var dependency: Account?
	{
		get
		{
			let cPointer = linphone_account_get_dependency(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Account.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_account_set_dependency(cPtr, newValue?.cPtr)
		}
	}

	/// Get the reason why registration failed when the account state is
	/// LinphoneRegistrationFailed. 
	/// - Returns: The `Reason` why registration failed for this account. 
	public var error: Reason
	{
			return Reason(rawValue: Int(linphone_account_get_error(cPtr).rawValue))!
	}

	/// Get detailed information why registration failed when the account state is
	/// LinphoneRegistrationFailed. 
	/// - Returns: The `ErrorInfo` explaining why registration failed for this account.
	///   
	public var errorInfo: ErrorInfo?
	{
			let cPointer = linphone_account_get_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ErrorInfo.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Indicates whether AVPF/SAVPF is being used for calls using this account. 
	/// - Returns: true if AVPF/SAVPF is enabled, false otherwise. 
	/// - deprecated: 16/12/2021 Use avpfEnabled() instead. 
	@available(*, deprecated)
	public var isAvpfEnabled: Bool
	{
			return linphone_account_is_avpf_enabled(cPtr) != 0
	}

	/// Get the `AccountParams` as read-only object. 
	/// To make changes, clone the returned object using AccountParams.clone() method,
	/// make your changes on it and apply them using with setParams(). 
	/// - Returns: The `AccountParams` attached to this account.   
	public var params: AccountParams?
	{
		get
		{
			let cPointer = linphone_account_get_params(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = AccountParams.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_account_set_params(cPtr, newValue?.cPtr)
		}
	}

	/// Get the registration state of the given account. 
	/// - Returns: The `RegistrationState` of the account. 
	public var state: RegistrationState
	{
			return RegistrationState(rawValue: Int(linphone_account_get_state(cPtr).rawValue))!
	}

	/// Get the transport from either service route, route or addr. 
	/// - Returns: The transport as a string (I.E udp, tcp, tls, dtls). 
	/// - deprecated: 01/03/2021 Use Linphone_account_params_get_transport() instead. 
	@available(*, deprecated)
	public var transport: TransportType
	{
			return TransportType(rawValue: Int(linphone_account_get_transport(cPtr).rawValue))!
	}

	/// Return the unread chat message count for a given account. 
	/// - Returns: The unread chat message count. 
	public var unreadChatMessageCount: Int
	{
			return Int(linphone_account_get_unread_chat_message_count(cPtr))
	}

	/// Retrieve the user pointer associated with the account. 
	/// - Returns: The user data.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_account_get_user_data(cPtr)
		}
		set
		{
			linphone_account_set_user_data(cPtr, newValue)
		}
	}

	/// Instantiate a new account with values from source. 
	/// - Returns: The newly created `Account` object.   
	public func clone() -> Account?
	{
		let cPointer = linphone_account_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Account.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Find authentication info matching account, if any, similarly to
	/// linphone_core_find_auth_info. 
	/// - Returns: a `AuthInfo` matching account criteria if possible, nil if nothing
	/// can be found.   
	public func findAuthInfo() -> AuthInfo?
	{
		let cPointer = linphone_account_find_auth_info(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = AuthInfo.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Obtain the value of a header sent by the server in last answer to REGISTER. 
	/// - Parameter headerName: The header name for which to fetch corresponding value.
	///   
	/// - Returns: The value of the queried header.   
	public func getCustomHeader(headerName:String) -> String
	{
		let cstr = linphone_account_get_custom_header(cPtr, headerName)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Detect if the given input is a phone number or not. 
	/// - Parameter username: The string to parse.   
	/// - Returns: true if input is a phone number, false otherwise. 
	public func isPhoneNumber(username:String) -> Bool
	{
		return linphone_account_is_phone_number(cPtr, username) != 0
	}

	/// Normalize a human readable phone number into a basic string. 
	/// 888-444-222 becomes 888444222 or +33888444222 depending on the `Account`
	/// object. This function will always generate a normalized username if input is a
	/// phone number. 
	/// - Parameter username: The string to parse.   
	/// - Returns: nil if input is an invalid phone number, normalized phone number
	/// from username input otherwise.   
	public func normalizePhoneNumber(username:String) -> String
	{
		let cstr = linphone_account_normalize_phone_number(cPtr, username)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Normalize a human readable sip uri into a fully qualified LinphoneAddress. 
	/// A sip address should look like DisplayName <sip:username@domain:port> .
	/// Basically this function performs the following tasks
	/// The result is a syntactically correct SIP address. 
	/// - Parameter username: The string to parse.   
	/// - Returns: nil if invalid input, normalized sip address otherwise.   
	public func normalizeSipUri(username:String) -> Address?
	{
		let cPointer = linphone_account_normalize_sip_uri(cPtr, username)
		if (cPointer == nil) {
			return nil
		}
		let result = Address.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Prevent an account from refreshing its registration. 
	/// This is useful to let registrations to expire naturally (or) when the
	/// application wants to keep control on when refreshes are sent. However,
	/// linphone_core_set_network_reachable(lc,true) will always request the accounts
	/// to refresh their registrations. The refreshing operations can be resumed with
	/// refreshRegister(). 
	public func pauseRegister() 
	{
		linphone_account_pause_register(cPtr)
	}

	/// Refresh a proxy registration. 
	/// This is useful if for example you resuming from suspend, thus IP address may
	/// have changed. 
	public func refreshRegister() 
	{
		linphone_account_refresh_register(cPtr)
	}

	/// Set the value of a custom header sent to the server in REGISTERs request. 
	/// - Parameter headerName: The header name.   
	/// - Parameter headerValue: The header value.   
	public func setCustomHeader(headerName:String, headerValue:String?) 
	{
		linphone_account_set_custom_header(cPtr, headerName, headerValue)
	}
}

/// The object used to configure an account on a server via XML-RPC, see
/// https://wiki.linphone.org/xwiki/wiki/public/view/Lib/Features/Override%20account%20creator%20request/.
public class AccountCreator : LinphoneObject
{
	var delegateManagers : [AccountCreatorDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> AccountCreator {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<AccountCreator>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = AccountCreator(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///Enum describing the status of server request, used by the `AccountCreator`. 
	public enum Status:Int
	{
		/// Request status. 
		case RequestOk = 0
		/// Request failed. 
		case RequestFailed = 1
		/// Request failed due to missing argument(s) 
		case MissingArguments = 2
		/// Request failed due to missing callback(s) 
		case MissingCallbacks = 3
		/// Account status. 
		case AccountCreated = 4
		/// Account not created. 
		case AccountNotCreated = 5
		/// Account exist. 
		case AccountExist = 6
		/// Account exist with alias. 
		case AccountExistWithAlias = 7
		/// Account not exist. 
		case AccountNotExist = 8
		/// Account was created with Alias. 
		case AliasIsAccount = 9
		/// Alias exist. 
		case AliasExist = 10
		/// Alias not exist. 
		case AliasNotExist = 11
		/// Account activated. 
		case AccountActivated = 12
		/// Account already activated. 
		case AccountAlreadyActivated = 13
		/// Account not activated. 
		case AccountNotActivated = 14
		/// Account linked. 
		case AccountLinked = 15
		/// Account not linked. 
		case AccountNotLinked = 16
		/// Server. 
		case ServerError = 17
		/// Error cannot send SMS. 
		case PhoneNumberInvalid = 18
		/// Error key doesn't match. 
		case WrongActivationCode = 19
		/// Error too many SMS sent. 
		case PhoneNumberOverused = 20
		/// Error algo isn't MD5 or SHA-256. 
		case AlgoNotSupported = 21
		/// Generic error. 
		case UnexpectedError = 22
	}

	///Enum describing transport checking, used by the `AccountCreator`. 
	public enum TransportStatus:Int
	{
		/// Transport ok. 
		case Ok = 0
		/// Transport invalid. 
		case Unsupported = 1
	}

	///Enum describing domain checking, used by the `AccountCreator`. 
	public enum DomainStatus:Int
	{
		/// Domain ok. 
		case Ok = 0
		/// Domain invalid. 
		case Invalid = 1
	}

	///Enum describing activation code checking, used by the `AccountCreator`. 
	public enum ActivationCodeStatus:Int
	{
		/// Activation code ok. 
		case Ok = 0
		/// Activation code too short. 
		case TooShort = 1
		/// Activation code too long. 
		case TooLong = 2
		/// Contain invalid characters. 
		case InvalidCharacters = 3
	}

	///Enum describing language checking, used by the `AccountCreator`. 
	public enum LanguageStatus:Int
	{
		/// Language ok. 
		case Ok = 0
	}

	///Enum describing password checking, used by the `AccountCreator`. 
	public enum PasswordStatus:Int
	{
		/// Password ok. 
		case Ok = 0
		/// Password too short. 
		case TooShort = 1
		/// Password too long. 
		case TooLong = 2
		/// Contain invalid characters. 
		case InvalidCharacters = 3
		/// Missing specific characters. 
		case MissingCharacters = 4
	}

	///Enum describing email checking, used by the `AccountCreator`. 
	public enum EmailStatus:Int
	{
		/// Email ok. 
		case Ok = 0
		/// Email malformed. 
		case Malformed = 1
		/// Contain invalid characters. 
		case InvalidCharacters = 2
	}

	///Enum describing username checking, used by the `AccountCreator`. 
	public enum UsernameStatus:Int
	{
		/// Username ok. 
		case Ok = 0
		/// Username too short. 
		case TooShort = 1
		/// Username too long. 
		case TooLong = 2
		/// Contain invalid characters. 
		case InvalidCharacters = 3
		/// Invalid username. 
		case Invalid = 4
	}

	///Enum describing phone number checking, used by the `AccountCreator`. 
	public enum PhoneNumberStatus:Int
	{
		/// Phone number ok. 
		case Ok = 1
		/// Phone number too short. 
		case TooShort = 2
		/// Phone number too long. 
		case TooLong = 4
		/// Country code invalid. 
		case InvalidCountryCode = 8
		/// Phone number invalid. 
		case Invalid = 16
	}

	/// The object used to configure an account on a server via XML-RPC, see
	/// https://wiki.linphone.org/xwiki/wiki/public/view/Lib/Features/Override%20account%20creator%20request/.
	public func addDelegate(delegate: AccountCreatorDelegate)
	{
		let manager = AccountCreatorDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_account_creator_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// The object used to configure an account on a server via XML-RPC, see
	/// https://wiki.linphone.org/xwiki/wiki/public/view/Lib/Features/Override%20account%20creator%20request/.
	public func removeDelegate(delegate: AccountCreatorDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_account_creator_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Create a `AccountCreator` and set Linphone Request callbacks. 
	/// - Parameter core: The `Core` used for the XML-RPC communication   
	/// - Returns: The new `AccountCreator` object.   
	static public func create(core:Core) throws -> AccountCreator
	{
		let cPointer = linphone_account_creator_create(core.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null AccountCreator value")
		}
		let result = AccountCreator.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Get the activation code. 
	/// - Returns: The activation code of the `AccountCreator`.   
	public var activationCode: String
	{
		get
		{
			let cPointer = linphone_account_creator_get_activation_code(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_creator_set_activation_code(cPtr, newValue)
		}
	}

	/// Get the algorithm configured in the account creator. 
	/// - Returns: The algorithm of the `AccountCreator`.   
	public var algorithm: String
	{
		get
		{
			let cPointer = linphone_account_creator_get_algorithm(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_creator_set_algorithm(cPtr, newValue)
		}
	}

	/// Set the set_as_default property. 
	/// - Parameter setAsDefault: true for the created proxy config to be set as
	/// default in `Core`, false otherwise 
	/// - Returns: `RequestOk` if everything is OK, or a specific error otherwise. 
	public var asDefault: Bool?
	{
		willSet
		{
			linphone_account_creator_set_as_default(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the current LinphoneAccountCreatorCbs object associated with a
	/// LinphoneAccountCreator. 
	/// - Returns: The current LinphoneAccountCreatorCbs object associated with the
	/// LinphoneAccountCreator.   
	public var currentDelegate: AccountCreatorDelegate?
	{
			let cObject = linphone_account_creator_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<AccountCreatorDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Get the display name. 
	/// - Returns: The display name of the `AccountCreator`.   
	public var displayName: String
	{
		get
		{
			let cPointer = linphone_account_creator_get_display_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_creator_set_display_name(cPtr, newValue)
		}
	}

	/// Get the domain. 
	/// - Returns: The domain of the `AccountCreator`.   
	public var domain: String
	{
		get
		{
			let cPointer = linphone_account_creator_get_domain(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_creator_set_domain(cPtr, newValue)
		}
	}

	/// Get the email. 
	/// - Returns: The email of the `AccountCreator`.   
	public var email: String
	{
		get
		{
			let cPointer = linphone_account_creator_get_email(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_creator_set_email(cPtr, newValue)
		}
	}

	/// Get the ha1. 
	/// - Returns: The ha1 of the `AccountCreator`.   
	public var ha1: String
	{
		get
		{
			let cPointer = linphone_account_creator_get_ha1(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_creator_set_ha1(cPtr, newValue)
		}
	}

	/// Get the language use in email of SMS. 
	/// - Returns: The language of the `AccountCreator`.   
	public var language: String
	{
		get
		{
			let cPointer = linphone_account_creator_get_language(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_creator_set_language(cPtr, newValue)
		}
	}

	/// Get the password. 
	/// - Returns: The password of the `AccountCreator`.   
	public var password: String
	{
		get
		{
			let cPointer = linphone_account_creator_get_password(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_creator_set_password(cPtr, newValue)
		}
	}

	/// Get the international prefix. 
	/// - Returns: The international prefix (or phone country code) of the
	/// `AccountCreator`.   
	public var phoneCountryCode: String
	{
			let cPointer = linphone_account_creator_get_phone_country_code(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the RFC 3966 normalized phone number. 
	/// - Returns: The phone number of the `AccountCreator`.   
	public var phoneNumber: String
	{
			let cPointer = linphone_account_creator_get_phone_number(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Set the pn_param. 
	/// - Parameter pnParam: The pn_param to set   
	public var pnParam: String = ""
	{
		willSet
		{
			linphone_account_creator_set_pn_param(cPtr, newValue)
		}
	}

	/// Set the pn_prid. 
	/// - Parameter pnPrid: The pn_prid to set   
	public var pnPrid: String = ""
	{
		willSet
		{
			linphone_account_creator_set_pn_prid(cPtr, newValue)
		}
	}

	/// Set the pn_provider. 
	/// - Parameter pnProvider: The pn_provider to set   
	public var pnProvider: String = ""
	{
		willSet
		{
			linphone_account_creator_set_pn_provider(cPtr, newValue)
		}
	}

	/// Assign a proxy config pointer to the LinphoneAccountCreator. 
	/// - Parameter cfg: The LinphoneProxyConfig to associate with the
	/// LinphoneAccountCreator.   
	public var proxyConfig: ProxyConfig?
	{
		willSet
		{
			linphone_account_creator_set_proxy_config(cPtr, newValue?.cPtr)
		}
	}

	/// Get the set_as_default property. 
	/// - Returns: true if account will be set as default, false otherwise. 
	public var setAsDefault: Bool
	{
			return linphone_account_creator_get_set_as_default(cPtr) != 0
	}

	/// Set the token. 
	/// - Parameter token: The pn_prid to set   
	public var token: String = ""
	{
		willSet
		{
			linphone_account_creator_set_token(cPtr, newValue)
		}
	}

	/// Get Transport. 
	/// - Returns: The `TransportType` of the creator. 
	public var transport: TransportType
	{
		get
		{
			return TransportType(rawValue: Int(linphone_account_creator_get_transport(cPtr).rawValue))!
		}
		set
		{
			linphone_account_creator_set_transport(cPtr, LinphoneTransportType(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Retrieve the user pointer associated with the LinphoneAccountCreator. 
	/// - Returns: The user pointer associated with the LinphoneAccountCreator.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_account_creator_get_user_data(cPtr)
		}
		set
		{
			linphone_account_creator_set_user_data(cPtr, newValue)
		}
	}

	/// Get the username. 
	/// - Returns: The username of the `AccountCreator`.   
	public var username: String
	{
		get
		{
			let cPointer = linphone_account_creator_get_username(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_creator_set_username(cPtr, newValue)
		}
	}

	/// Send a request to activate an account on server. 
	/// - Returns: `RequestOk` if the request has been sent, `RequestFailed` otherwise 
	public func activateAccount() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_activate_account(cPtr).rawValue))!
	}

	/// Send a request to activate an alias. 
	/// - Returns: `RequestOk` if the request has been sent, `RequestFailed` otherwise 
	public func activateAlias() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_activate_alias(cPtr).rawValue))!
	}

	/// Send a request to create an account on server. 
	/// - Returns: `RequestOk` if the request has been sent, `RequestFailed` otherwise 
	public func createAccount() throws -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_create_account(cPtr).rawValue))!
	}

	/// Create and configure a proxy config and a authentication info for an account
	/// creator. 
	/// - Returns: A `ProxyConfig` object if successful, nil otherwise.   
	public func createProxyConfig() throws -> ProxyConfig
	{
		let cPointer = linphone_account_creator_create_proxy_config(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ProxyConfig value")
		}
		let result = ProxyConfig.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Send a request to know if an account is activated on server. 
	/// - Returns: `RequestOk` if the request has been sent, `RequestFailed` otherwise 
	public func isAccountActivated() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_is_account_activated(cPtr).rawValue))!
	}

	/// Send a request to know the existence of account on server. 
	/// - Returns: `RequestOk` if the request has been sent, `RequestFailed` otherwise 
	public func isAccountExist() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_is_account_exist(cPtr).rawValue))!
	}

	/// Send a request to know if an account is linked. 
	/// - Returns: `RequestOk` if the request has been sent, `RequestFailed` otherwise 
	public func isAccountLinked() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_is_account_linked(cPtr).rawValue))!
	}

	/// Send a request to know if an alias is used. 
	/// - Returns: `RequestOk` if the request has been sent, `RequestFailed` otherwise 
	public func isAliasUsed() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_is_alias_used(cPtr).rawValue))!
	}

	/// Send a request to link an account to an alias. 
	/// - Returns: `RequestOk` if the request has been sent, `RequestFailed` otherwise 
	public func linkAccount() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_link_account(cPtr).rawValue))!
	}

	/// Send a request to get the password & algorithm of an account using the
	/// confirmation key. 
	/// - Returns: `RequestOk` if everything is OK, or a specific error otherwise. 
	public func loginLinphoneAccount() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_login_linphone_account(cPtr).rawValue))!
	}

	/// Send a request to recover an account. 
	/// - Returns: `RequestOk` if the request has been sent, `RequestFailed` otherwise 
	public func recoverAccount() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_recover_account(cPtr).rawValue))!
	}

	/// Reset the account creator entries like username, password, phone number... 
	public func reset() 
	{
		linphone_account_creator_reset(cPtr)
	}

	/// Set the phone number normalized. 
	/// - Parameter phoneNumber: The phone number to set   
	/// - Parameter countryCode: Country code to associate phone number with   
	/// - Returns: `Ok` if everything is OK, or specific(s) error(s) otherwise. 
	public func setPhoneNumber(phoneNumber:String?, countryCode:String?) -> UInt
	{
		return UInt(linphone_account_creator_set_phone_number(cPtr, phoneNumber, countryCode))
	}

	/// Send a request to update an account. 
	/// - Returns: `RequestOk` if the request has been sent, `RequestFailed` otherwise 
	public func updateAccount() -> AccountCreator.Status
	{
		return AccountCreator.Status(rawValue: Int(linphone_account_creator_update_account(cPtr).rawValue))!
	}
}

/// Object that is used to set the different parameters of a `Account`. 
public class AccountParams : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> AccountParams {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<AccountParams>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = AccountParams(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Create a new `AccountParams` object from a configuration. 
	/// - Parameter lc: The `Core` object.   
	/// - Parameter index: The index of the configuration. 
	/// - Returns: The newly created `AccountParams` object.   
	static public func newWithConfig(lc:Core, index:Int) -> AccountParams?
	{
		let cPointer = linphone_account_params_new_with_config(lc.cPtr, CInt(index))
		if (cPointer == nil) {
			return nil
		}
		let result = AccountParams.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Get enablement status of RTCP feedback (also known as AVPF profile). 
	/// - Returns: the enablement mode, which can be `Default` (use LinphoneCore's
	/// mode), `Enabled` (avpf is enabled), or `Disabled` (disabled). 
	public var avpfMode: AVPFMode
	{
		get
		{
			return AVPFMode(rawValue: Int(linphone_account_params_get_avpf_mode(cPtr).rawValue))!
		}
		set
		{
			linphone_account_params_set_avpf_mode(cPtr, LinphoneAVPFMode(rawValue: CInt(newValue.rawValue)))
		}
	}

	/// Get the interval between regular RTCP reports when using AVPF/SAVPF. 
	/// - Returns: The interval in seconds. 
	public var avpfRrInterval: UInt8
	{
		get
		{
			return linphone_account_params_get_avpf_rr_interval(cPtr)
		}
		set
		{
			linphone_account_params_set_avpf_rr_interval(cPtr, newValue)
		}
	}

	/// Get the conference factory uri. 
	/// - Returns: The uri of the conference factory.   
	public var conferenceFactoryUri: String
	{
		get
		{
			let cPointer = linphone_account_params_get_conference_factory_uri(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_params_set_conference_factory_uri(cPtr, newValue)
		}
	}

	/// Returns the contact parameters. 
	/// - Returns: The previously set contact parameters.   
	public var contactParameters: String
	{
		get
		{
			let cPointer = linphone_account_params_get_contact_parameters(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_params_set_contact_parameters(cPtr, newValue)
		}
	}

	/// Return the contact URI parameters. 
	/// - Returns: The previously set contact URI parameters.   
	public var contactUriParameters: String
	{
		get
		{
			let cPointer = linphone_account_params_get_contact_uri_parameters(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_params_set_contact_uri_parameters(cPtr, newValue)
		}
	}

	/// Indicates whether chat messages sent by this account in a `Basic` chat room
	/// will be using CPIM format or not. 
	/// By default SIP SIMPLE format is used for "basic" chat rooms, CPIM is only used
	/// for `FlexisipChat` chat rooms. - See also:
	/// https://wiki.linphone.org/xwiki/wiki/public/view/Lib/Features/Instant%20Messaging/Reply%20to%20a%20specific%20message/ 
	/// - Returns: true if chat messages will be sent out in CPIM format, false if chat
	/// messages will be sent out as SIP SIMPLE. 
	public var cpimInBasicChatRoomEnabled: Bool
	{
		get
		{
			return linphone_account_params_cpim_in_basic_chat_room_enabled(cPtr) != 0
		}
		set
		{
			linphone_account_params_enable_cpim_in_basic_chat_room(cPtr, newValue==true ? 1:0)
		}
	}

	/// Return whether or not the + should be replaced by 00. 
	/// - Returns: Whether liblinphone should replace "+" by "00" in dialed numbers
	/// (passed to Core.invite()). 
	public var dialEscapePlusEnabled: Bool
	{
		get
		{
			return linphone_account_params_dial_escape_plus_enabled(cPtr) != 0
		}
		set
		{
			linphone_account_params_enable_dial_escape_plus(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the domain name of the given account params. 
	/// - Returns: The domain name of the account params.   
	public var domain: String
	{
			let cPointer = linphone_account_params_get_domain(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the account params expires. 
	/// - Returns: The duration of registration. 
	public var expires: Int
	{
		get
		{
			return Int(linphone_account_params_get_expires(cPtr))
		}
		set
		{
			linphone_account_params_set_expires(cPtr, CInt(newValue))
		}
	}

	/// Get the identity of the account params. 
	/// - Returns: The SIP identity that belongs to this account params.   
	/// - deprecated: 01/03/2021 Use getIdentityAddress() instead. 
	@available(*, deprecated)
	public var identity: String
	{
			let cPointer = linphone_account_params_get_identity(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the identity address of the account params. 
	/// - Returns: The SIP identity that belongs to this account params.   
	public var identityAddress: Address?
	{
			let cPointer = linphone_account_params_get_identity_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	public func setIdentityaddress(newValue: Address) throws
	{
		let exception_result = linphone_account_params_set_identity_address(cPtr, newValue.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the idkey property of a `AccountParams`. 
	/// - Returns: The idkey string, or nil.   
	public var idkey: String
	{
		get
		{
			let cPointer = linphone_account_params_get_idkey(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_params_set_idkey(cPtr, newValue)
		}
	}

	/// Get the prefix set for this account params. 
	/// - Returns: The international prefix.   
	public var internationalPrefix: String
	{
		get
		{
			let cPointer = linphone_account_params_get_international_prefix(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_params_set_international_prefix(cPtr, newValue)
		}
	}

	/// Gets whether push notifications are available or not (Android & iOS only). 
	/// - Returns: true if push notifications are available, false otherwise 
	public var isPushNotificationAvailable: Bool
	{
			return linphone_account_params_is_push_notification_available(cPtr) != 0
	}

	/// Get The policy that is used to pass through NATs/firewalls when using this
	/// account params. 
	/// If it is set to nil, the default NAT policy from the core will be used instead. 
	/// - Returns: The `NatPolicy` object in use.   
	/// - See also: Core.getNatPolicy() 
	public var natPolicy: NatPolicy?
	{
		get
		{
			let cPointer = linphone_account_params_get_nat_policy(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = NatPolicy.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_account_params_set_nat_policy(cPtr, newValue?.cPtr)
		}
	}

	/// Tell if the proxy is used as the only route. 
	/// - Returns: enable true if enabled, false otherwise. 
	public var outboundProxyEnabled: Bool
	{
		get
		{
			return linphone_account_params_outbound_proxy_enabled(cPtr) != 0
		}
		set
		{
			linphone_account_params_enable_outbound_proxy(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get default privacy policy for all calls routed through this proxy. 
	/// - Returns: Privacy mode as LinphonePrivacyMask 
	public var privacy: UInt
	{
		get
		{
			return UInt(linphone_account_params_get_privacy(cPtr))
		}
		set
		{
			linphone_account_params_set_privacy(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Tell if the PUBLISH is enabled. 
	/// - Returns: true if PUBLISH request is enabled for this proxy. 
	public var publishEnabled: Bool
	{
		get
		{
			return linphone_account_params_publish_enabled(cPtr) != 0
		}
		set
		{
			linphone_account_params_enable_publish(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the publish expiration time in second. 
	/// Default value is the registration expiration value. 
	/// - Returns: The expire time in seconds. 
	public var publishExpires: Int
	{
		get
		{
			return Int(linphone_account_params_get_publish_expires(cPtr))
		}
		set
		{
			linphone_account_params_set_publish_expires(cPtr, CInt(newValue))
		}
	}

	/// Indicates whether to add to the contact parameters the push notification
	/// information. 
	/// For IOS, it indicates for VOIP push notification. 
	/// - Returns: true if push notification informations should be added, false
	/// otherwise. 
	public var pushNotificationAllowed: Bool
	{
		get
		{
			return linphone_account_params_get_push_notification_allowed(cPtr) != 0
		}
		set
		{
			linphone_account_params_set_push_notification_allowed(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns the push notification configuration. 
	/// - Returns: The `PushNotificationConfig` object.   
	public var pushNotificationConfig: PushNotificationConfig?
	{
		get
		{
			let cPointer = linphone_account_params_get_push_notification_config(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = PushNotificationConfig.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_account_params_set_push_notification_config(cPtr, newValue?.cPtr)
		}
	}

	/// Get the route of the collector end-point when using quality reporting. 
	/// This SIP address should be used on server-side to process packets directly
	/// before discarding packets. Collector address should be a non existing account
	/// and will not receive any messages. If nil, reports will be send to the proxy
	/// domain. 
	/// - Returns: The SIP address of the collector end-point.   
	public var qualityReportingCollector: String
	{
		get
		{
			let cPointer = linphone_account_params_get_quality_reporting_collector(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_params_set_quality_reporting_collector(cPtr, newValue)
		}
	}

	/// Indicates whether quality statistics during call should be stored and sent to a
	/// collector according to RFC 6035. 
	/// - Returns: true if quality repotring is enabled, false otherwise. 
	public var qualityReportingEnabled: Bool
	{
		get
		{
			return linphone_account_params_quality_reporting_enabled(cPtr) != 0
		}
		set
		{
			linphone_account_params_enable_quality_reporting(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the interval between interval reports when using quality reporting. 
	/// - Returns: The interval in seconds, 0 means interval reports are disabled. 
	public var qualityReportingInterval: Int
	{
		get
		{
			return Int(linphone_account_params_get_quality_reporting_interval(cPtr))
		}
		set
		{
			linphone_account_params_set_quality_reporting_interval(cPtr, CInt(newValue))
		}
	}

	/// Get the realm of the given account params. 
	/// - Returns: The realm of the account params.   
	public var realm: String
	{
		get
		{
			let cPointer = linphone_account_params_get_realm(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_params_set_realm(cPtr, newValue)
		}
	}

	/// Get the persistent reference key associated to the account params. 
	/// The reference key can be for example an id to an external database. It is
	/// stored in the config file, thus can survive to process exits/restarts.
	/// - Returns: The reference key string that has been associated to the account
	/// params, or nil if none has been associated.   
	public var refKey: String
	{
		get
		{
			let cPointer = linphone_account_params_get_ref_key(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_account_params_set_ref_key(cPtr, newValue)
		}
	}

	/// Returns whether the account params is enabled or not. 
	/// - Returns: true if registration to the proxy is enabled. 
	public var registerEnabled: Bool
	{
		get
		{
			return linphone_account_params_register_enabled(cPtr) != 0
		}
		set
		{
			linphone_account_params_enable_register(cPtr, newValue==true ? 1:0)
		}
	}

	/// Indicates whether to add to the contact parameters the push notification
	/// information. 
	/// - Returns: true if remote push notification informations should be added, false
	/// otherwise. 
	public var remotePushNotificationAllowed: Bool
	{
		get
		{
			return linphone_account_params_get_remote_push_notification_allowed(cPtr) != 0
		}
		set
		{
			linphone_account_params_set_remote_push_notification_allowed(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the list of the routes set for this account params. 
	/// - Warning: If linphone_account_params_is_outbound_proxy_enabled is true then it
	/// will only return the proxy address. 
	/// - Returns: The list of routes.    
	public var routesAddresses: [Address]
	{
			var swiftList = [Address]()
			let cList = linphone_account_params_get_routes_addresses(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Address.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	public func setRoutesaddresses(newValue: [Address]) throws
	{
		var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
		for data in newValue {
			cList = bctbx_list_append(cList, UnsafeMutableRawPointer(data.cPtr))
		}
		let exception_result = linphone_account_params_set_routes_addresses(cPtr, cList)
		bctbx_list_free(cList)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the account params proxy address. 
	/// - Returns: The proxy's SIP address.   
	/// - deprecated: 01/03/2021 Use getServerAddress() instead. 
	@available(*, deprecated)
	public var serverAddr: String
	{
			let cPointer = linphone_account_params_get_server_addr(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setServeraddr(newValue: String) throws
	{
		let exception_result = linphone_account_params_set_server_addr(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the account params proxy address. 
	/// - Returns: The proxy's SIP `Address`.   
	public var serverAddress: Address?
	{
			let cPointer = linphone_account_params_get_server_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	public func setServeraddress(newValue: Address) throws
	{
		let exception_result = linphone_account_params_set_server_address(cPtr, newValue.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns the transport type of the server address. 
	/// - Returns: The `TransportType` of the server address. 
	public var transport: TransportType
	{
		get
		{
			return TransportType(rawValue: Int(linphone_account_params_get_transport(cPtr).rawValue))!
		}
		set
		{
			linphone_account_params_set_transport(cPtr, LinphoneTransportType(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Return whether or not the international prefix will automaticaly be used for
	/// calls and chats. 
	/// - Returns: Whether we should use international prefix automatically for calls. 
	public var useInternationalPrefixForCallsAndChats: Bool
	{
		get
		{
			return linphone_account_params_get_use_international_prefix_for_calls_and_chats(cPtr) != 0
		}
		set
		{
			linphone_account_params_set_use_international_prefix_for_calls_and_chats(cPtr, newValue==true ? 1:0)
		}
	}

	/// Retrieve the user pointer associated with the account params. 
	/// - Returns: The user data.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_account_params_get_user_data(cPtr)
		}
		set
		{
			linphone_account_params_set_user_data(cPtr, newValue)
		}
	}

	/// Instantiate a new account params with values from source. 
	/// - Returns: The newly created `AccountParams` object.   
	public func clone() -> AccountParams?
	{
		let cPointer = linphone_account_params_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = AccountParams.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}
}

/// Object that represents a parsed SIP address. 
/// A SIP address is made of display name, username, domain name, port, and various
/// uri headers (such as tags). It looks like 'Alice <sip:alice@example.net>'.
/// You can create an address using Factory.createAddress() or Core.interpretUrl()
/// and both will return a nil object if it doesn't match the grammar defined by
/// the standard.
/// This object is used in almost every other major objects to identity people
/// (including yourself) & servers.
/// The `Address` has methods to extract and manipulate all parts of the address. 
public class Address : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Address {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Address>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Address(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Returns the display name. 
	/// - Returns: the display name if any, nil otherwise.   
	public var displayName: String
	{
			let cPointer = linphone_address_get_display_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setDisplayname(newValue: String) throws
	{
		let exception_result = linphone_address_set_display_name(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns the domain name. 
	/// - Returns: the domain name if any, nil otherwise.   
	public var domain: String
	{
			let cPointer = linphone_address_get_domain(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setDomain(newValue: String) throws
	{
		let exception_result = linphone_address_set_domain(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// returns whether the address is a routable SIP address or not 
	/// - Returns: true if it is a routable SIP address, false otherwise 
	public var isSip: Bool
	{
			return linphone_address_is_sip(cPtr) != 0
	}

	/// Get the value of the method parameter. 
	/// - Returns: the value of the parameter or nil.   
	public var methodParam: String
	{
		get
		{
			let cPointer = linphone_address_get_method_param(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_address_set_method_param(cPtr, newValue)
		}
	}

	/// Get the password encoded in the address. 
	/// It is used for basic authentication (not recommended). 
	/// - Returns: the password if any, nil otherwise.   
	public var password: String
	{
		get
		{
			let cPointer = linphone_address_get_password(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_address_set_password(cPtr, newValue)
		}
	}

	/// Get port number as an integer value, 0 if not present. 
	/// - Returns: the port set in the address or 0 if not present. 
	public var port: Int
	{
			return Int(linphone_address_get_port(cPtr))
	}

	public func setPort(newValue: Int) throws
	{
		let exception_result = linphone_address_set_port(cPtr, CInt(newValue))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns the address scheme, normally "sip". 
	/// - Returns: the scheme if any, nil otherwise.   
	public var scheme: String
	{
			let cPointer = linphone_address_get_scheme(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns whether the address refers to a secure location (sips) or not. 
	/// - Returns: true if address refers to a secure location, false otherwise 
	public var secure: Bool
	{
		get
		{
			return linphone_address_get_secure(cPtr) != 0
		}
		set
		{
			linphone_address_set_secure(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the transport. 
	/// - Returns: a `TransportType`, default value if not set is UDP. 
	public var transport: TransportType
	{
			return TransportType(rawValue: Int(linphone_address_get_transport(cPtr).rawValue))!
	}

	public func setTransport(newValue: TransportType) throws
	{
		let exception_result = linphone_address_set_transport(cPtr, LinphoneTransportType(rawValue: CUnsignedInt(newValue.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Set the value of the parameters of the URI of the address. 
	/// - Parameter params: The parameters string 
	public var uriParams: String = ""
	{
		willSet
		{
			linphone_address_set_uri_params(cPtr, newValue)
		}
	}

	/// Returns the username. 
	/// - Returns: the username name if any, nil otherwise.   
	public var username: String
	{
			let cPointer = linphone_address_get_username(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setUsername(newValue: String) throws
	{
		let exception_result = linphone_address_set_username(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns the address as a string. 
	/// The returned char * must be freed by the application. Use ms_free(). 
	/// - Returns: a string representation of the address.     
	public func asString() -> String
	{
		let cstr = linphone_address_as_string(cPtr)
		let result = charArrayToString(charPointer: cstr)
		if (cstr != nil) {
			bctbx_free(cstr)
		}
		return result
	}

	/// Returns the SIP uri only as a string, that is display name is removed. 
	/// The returned char * must be freed by the application. Use ms_free(). 
	/// - Returns: a string representation of the address.     
	public func asStringUriOnly() -> String
	{
		let cstr = linphone_address_as_string_uri_only(cPtr)
		let result = charArrayToString(charPointer: cstr)
		if (cstr != nil) {
			bctbx_free(cstr)
		}
		return result
	}

	/// Removes address's tags and uri headers so that it is displayable to the user. 
	public func clean() 
	{
		linphone_address_clean(cPtr)
	}

	/// Clones a `Address` object. 
	/// - Returns: a new `Address` object.   
	public func clone() -> Address?
	{
		let cPointer = linphone_address_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Address.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Compare two `Address` taking the tags and headers into account. 
	/// - Parameter address2: `Address` object.   
	/// - Returns: Boolean value telling if the `Address` objects are equal. 
	/// - See also: weakEqual() 
	public func equal(address2:Address) -> Bool
	{
		return linphone_address_equal(cPtr, address2.cPtr) != 0
	}

	/// Get the header encoded in the address. 
	/// - Parameter headerName: the header name.   
	/// - Returns: the header value or nil if it doesn't exists.   
	public func getHeader(headerName:String) -> String
	{
		let cstr = linphone_address_get_header(cPtr, headerName)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Get the value of a parameter of the address. 
	/// - Parameter paramName: The name of the parameter.   
	/// - Returns: The value of the parameter or nil if it doesn't exists.   
	public func getParam(paramName:String) -> String
	{
		let cstr = linphone_address_get_param(cPtr, paramName)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Get the value of a parameter of the URI of the address. 
	/// - Parameter uriParamName: The name of the parameter.   
	/// - Returns: The value of the parameter or nil if it doesn't exists.   
	public func getUriParam(uriParamName:String) -> String
	{
		let cstr = linphone_address_get_uri_param(cPtr, uriParamName)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Tell whether a parameter is present in the address. 
	/// - Parameter paramName: The name of the parameter.   
	/// - Returns: A boolean value telling whether the parameter is present in the
	/// address 
	public func hasParam(paramName:String) -> Bool
	{
		return linphone_address_has_param(cPtr, paramName) != 0
	}

	/// Tell whether a parameter is present in the URI of the address. 
	/// - Parameter uriParamName: The name of the parameter.   
	/// - Returns: A boolean value telling whether the parameter is present in the URI
	/// of the address 
	public func hasUriParam(uriParamName:String) -> Bool
	{
		return linphone_address_has_uri_param(cPtr, uriParamName) != 0
	}

	/// Removes the value of a parameter of the URI of the address. 
	/// - Parameter uriParamName: The name of the parameter.   
	public func removeUriParam(uriParamName:String) 
	{
		linphone_address_remove_uri_param(cPtr, uriParamName)
	}

	/// Set a header into the address. 
	/// Headers appear in the URI with '?', such as
	/// <sip:test@linphone.org?SomeHeader=SomeValue>. 
	/// - Parameter headerName: the header name.   
	/// - Parameter headerValue: the header value.   
	public func setHeader(headerName:String, headerValue:String?) 
	{
		linphone_address_set_header(cPtr, headerName, headerValue)
	}

	/// Set the value of a parameter of the address. 
	/// - Parameter paramName: The name of the parameter.   
	/// - Parameter paramValue: The new value of the parameter.   
	public func setParam(paramName:String, paramValue:String?) 
	{
		linphone_address_set_param(cPtr, paramName, paramValue)
	}

	/// Set the value of a parameter of the URI of the address. 
	/// - Parameter uriParamName: The name of the parameter.   
	/// - Parameter uriParamValue: The new value of the parameter.   
	public func setUriParam(uriParamName:String, uriParamValue:String?) 
	{
		linphone_address_set_uri_param(cPtr, uriParamName, uriParamValue)
	}

	/// Compare two `Address` ignoring tags and headers, basically just domain,
	/// username, and port. 
	/// - Parameter address2: `Address` object.   
	/// - Returns: Boolean value telling if the `Address` objects are equal. 
	/// - See also: equal() 
	public func weakEqual(address2:Address) -> Bool
	{
		return linphone_address_weak_equal(cPtr, address2.cPtr) != 0
	}
}

/// Object holding audio device information. 
/// It contains the name of the device, it's type if available (Earpiece, Speaker,
/// Bluetooth, etc..) and capabilities (input, output or both) the name of the
/// driver that created it (filter in mediastreamer).
/// You can use the `AudioDevice` objects to configure default input/output devices
/// or do it dynamically during a call.
/// To get the list of available devices, use Core.getAudioDevices(). This list
/// will be limited to one device of each type. Use Core.getExtendedAudioDevices()
/// for a complete list. 
public class AudioDevice : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> AudioDevice {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<AudioDevice>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = AudioDevice(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Returns the capabilities of the device. 
	/// - Returns: the `AudioDeviceCapabilities` of the audio device (RECORD, PLAY or
	/// both) as a bit mask 
	public var capabilities: AudioDeviceCapabilities
	{
			return AudioDeviceCapabilities(rawValue: Int(linphone_audio_device_get_capabilities(cPtr).rawValue))
	}

	/// Returns the name of the audio device. 
	/// - Returns: the name of the audio device.   
	public var deviceName: String
	{
			let cPointer = linphone_audio_device_get_device_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns the driver name used by the device. 
	/// - Returns: the name of the driver used by this audio device.   
	public var driverName: String
	{
			let cPointer = linphone_audio_device_get_driver_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns the id of the audio device. 
	/// - Returns: the id of the audio device.   
	public var id: String
	{
			let cPointer = linphone_audio_device_get_id(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns the type of the device. 
	/// - Returns: the `AudioDeviceType` of the audio device (microphone, speaker,
	/// earpiece, bluetooth, etc...) 
	public var type: AudioDeviceType
	{
			return AudioDeviceType(rawValue: Int(linphone_audio_device_get_type(cPtr).rawValue))!
	}

	/// Returns whether or not the audio device has the given capability. 
	/// - Parameter capability: the `AudioDeviceCapabilities` to check 
	/// - Returns: true if the audio device has the capability, false otherwise 
	public func hasCapability(capability:AudioDeviceCapabilities) -> Bool
	{
		return linphone_audio_device_has_capability(cPtr, LinphoneAudioDeviceCapabilities(rawValue: CUnsignedInt(capability.rawValue))) != 0
	}
}

/// Object holding authentication information. 
/// In most case, authentication information consists of a username and password.
/// If realm isn't set, it will be deduced automatically from the first
/// authentication challenge as for the hash algorithm. Sometimes, a userid is
/// required by the proxy and then domain can be useful to discriminate different
/// credentials. You can also use this object if you need to use a client
/// certificate.
/// Once created and filled, a `AuthInfo` must be added to the `Core` in order to
/// become known and used automatically when needed. Use Core.addAuthInfo() for
/// that purpose.
/// The `Core` object can take the initiative to request authentication information
/// when needed to the application through the authentication_requested() callback
/// of it's LinphoneCoreCbs.
/// The application can respond to this information request later using
/// Core.addAuthInfo(). This will unblock all pending authentication transactions
/// and retry them with authentication headers. 
public class AuthInfo : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> AuthInfo {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<AuthInfo>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = AuthInfo(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the algorithm. 
	/// - Returns: The algorithm.   
	public var algorithm: String
	{
		get
		{
			let cPointer = linphone_auth_info_get_algorithm(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_auth_info_set_algorithm(cPtr, newValue)
		}
	}

	/// Gets all available algorithms. 
	/// - Returns: A list of available algorithms.    
	public var availableAlgorithms: [String]
	{
		get
		{
			var swiftList = [String]()
			let cList = linphone_auth_info_get_available_algorithms(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp!.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
		}
		set
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				let sData:NSString = data as NSString
				cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
			}
			linphone_auth_info_set_available_algorithms(cPtr, cList)
		}
	}

	/// Gets the domain. 
	/// - Returns: The domain.   
	public var domain: String
	{
		get
		{
			let cPointer = linphone_auth_info_get_domain(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_auth_info_set_domain(cPtr, newValue)
		}
	}

	/// Gets the ha1. 
	/// - Returns: The ha1.   
	public var ha1: String
	{
		get
		{
			let cPointer = linphone_auth_info_get_ha1(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_auth_info_set_ha1(cPtr, newValue)
		}
	}

	/// Gets the password. 
	/// - Returns: The password.   
	public var password: String
	{
		get
		{
			let cPointer = linphone_auth_info_get_password(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_auth_info_set_password(cPtr, newValue)
		}
	}

	/// Gets the realm. 
	/// - Returns: The realm.   
	public var realm: String
	{
		get
		{
			let cPointer = linphone_auth_info_get_realm(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_auth_info_set_realm(cPtr, newValue)
		}
	}

	/// Gets the TLS certificate. 
	/// - Returns: The TLS certificate.   
	public var tlsCert: String
	{
		get
		{
			let cPointer = linphone_auth_info_get_tls_cert(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_auth_info_set_tls_cert(cPtr, newValue)
		}
	}

	/// Gets the TLS certificate path. 
	/// - Returns: The TLS certificate path.   
	public var tlsCertPath: String
	{
		get
		{
			let cPointer = linphone_auth_info_get_tls_cert_path(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_auth_info_set_tls_cert_path(cPtr, newValue)
		}
	}

	/// Gets the TLS key. 
	/// - Returns: The TLS key.   
	public var tlsKey: String
	{
		get
		{
			let cPointer = linphone_auth_info_get_tls_key(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_auth_info_set_tls_key(cPtr, newValue)
		}
	}

	/// Gets the TLS key path. 
	/// - Returns: The TLS key path.   
	public var tlsKeyPath: String
	{
		get
		{
			let cPointer = linphone_auth_info_get_tls_key_path(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_auth_info_set_tls_key_path(cPtr, newValue)
		}
	}

	/// Gets the user id. 
	/// - Returns: The user id.   
	public var userid: String
	{
		get
		{
			let cPointer = linphone_auth_info_get_userid(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_auth_info_set_userid(cPtr, newValue)
		}
	}

	/// Gets the username. 
	/// - Returns: The username.   
	public var username: String
	{
		get
		{
			let cPointer = linphone_auth_info_get_username(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_auth_info_set_username(cPtr, newValue)
		}
	}

	/// Add an unique algorithm in the the available algorithms list : Algorithms that
	/// already exist will not be added. 
	/// - Parameter algorithm: The algorithm to add.   
	public func addAvailableAlgorithm(algorithm:String?) 
	{
		linphone_auth_info_add_available_algorithm(cPtr, algorithm)
	}

	/// Remove all algorithms from the available algorithms list. 
	public func clearAvailableAlgorithms() 
	{
		linphone_auth_info_clear_available_algorithms(cPtr)
	}

	/// Instantiates a new auth info with values from source. 
	/// - Returns: The newly created `AuthInfo` object.   
	public func clone() -> AuthInfo?
	{
		let cPointer = linphone_auth_info_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = AuthInfo.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Check if Authinfos are the same without taking account algorithms. 
	/// - Parameter authInfo2: The second `AuthInfo` object.   
	/// - Returns: true if all fields (Username, UserId, Realm, Domain) are the same. 
	public func isEqualButAlgorithms(authInfo2:AuthInfo?) -> Bool
	{
		return linphone_auth_info_is_equal_but_algorithms(cPtr, authInfo2?.cPtr) != 0
	}
}

/// The object representing a data buffer. 
public class Buffer : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Buffer {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Buffer>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Buffer(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Create a new `Buffer` object from existing data. 
	/// - Parameter data: The initial data to store in the LinphoneBuffer.   
	/// - Parameter size: The size of the initial data to stroe in the LinphoneBuffer. 
	/// - Returns: A new `Buffer` object.   
	static public func newFromData(data:UnsafePointer<UInt8>, size:Int) -> Buffer?
	{
		let cPointer = linphone_buffer_new_from_data(data, size)
		if (cPointer == nil) {
			return nil
		}
		let result = Buffer.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a new `Buffer` object from a string. 
	/// - Parameter data: The initial string content of the LinphoneBuffer.   
	/// - Returns: A new `Buffer` object.   
	static public func newFromString(data:String) -> Buffer?
	{
		let cPointer = linphone_buffer_new_from_string(data)
		if (cPointer == nil) {
			return nil
		}
		let result = Buffer.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Get the content of the data buffer. 
	/// - Returns: The content of the data buffer.   
	public var content: UnsafePointer<UInt8>
	{
			return linphone_buffer_get_content(cPtr)
	}

	/// Tell whether the `Buffer` is empty. 
	/// - Returns: A boolean value telling whether the `Buffer` is empty or not. 
	public var isEmpty: Bool
	{
			return linphone_buffer_is_empty(cPtr) != 0
	}

	/// Get the size of the content of the data buffer. 
	/// - Returns: The size of the content of the data buffer. 
	public var size: Int
	{
		get
		{
			return Int(linphone_buffer_get_size(cPtr))
		}
		set
		{
			linphone_buffer_set_size(cPtr, (newValue))
		}
	}

	/// Get the string content of the data buffer. 
	/// - Returns: The string content of the data buffer.   
	public var stringContent: String
	{
		get
		{
			let cPointer = linphone_buffer_get_string_content(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_buffer_set_string_content(cPtr, newValue)
		}
	}

	/// Retrieve the user pointer associated with the buffer. 
	/// - Returns: The user pointer associated with the buffer.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_buffer_get_user_data(cPtr)
		}
		set
		{
			linphone_buffer_set_user_data(cPtr, newValue)
		}
	}

	/// Set the content of the data buffer. 
	/// - Parameter content: The content of the data buffer.   
	/// - Parameter size: The size of the content of the data buffer. 
	public func setContent(content:UnsafePointer<UInt8>, size:Int) 
	{
		linphone_buffer_set_content(cPtr, content, size)
	}
}

/// This object represents a call issued or received by the `Core`. 
/// Linphone only allows at most one active call at any given time and it will be
/// in `StreamsRunning`. However, if the core is locally hosting a `Conference`,
/// you may have some or all the calls in the conference in `StreamsRunning` as
/// well as an additional active call outside of the conference in `StreamsRunning`
/// if the local participant of the `Conference` is not part of it.
/// You can get the `State` of the call using getState(), it's current `CallParams`
/// with getCurrentParams() and the latest statistics by calling getAudioStats() or
/// getVideoStats(). 
public class Call : LinphoneObject
{
	var delegateManagers : [CallDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> Call {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Call>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Call(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///Enum representing the status of a call. 
	public enum Status:Int
	{
		/// The call was sucessful. 
		case Success = 0
		/// The call was aborted (caller hanged up) 
		case Aborted = 1
		/// The call was missed (incoming call timed out without being answered or hanged
		/// up) 
		case Missed = 2
		/// The call was declined, either locally or by remote end. 
		case Declined = 3
		/// The call was aborted before being advertised to the application - for protocol
		/// reasons. 
		case EarlyAborted = 4
		/// The call was answered on another device. 
		case AcceptedElsewhere = 5
		/// The call was declined on another device. 
		case DeclinedElsewhere = 6
	}

	///Enum representing the direction of a call. 
	public enum Dir:Int
	{
		/// outgoing calls 
		case Outgoing = 0
		/// incoming calls 
		case Incoming = 1
	}

	///`State` enum represents the different states a call can reach into. 
	public enum State:Int
	{
		/// Initial state. 
		case Idle = 0
		/// Incoming call received. 
		case IncomingReceived = 1
		/// PushIncoming call received. 
		case PushIncomingReceived = 2
		/// Outgoing call initialized. 
		case OutgoingInit = 3
		/// Outgoing call in progress. 
		case OutgoingProgress = 4
		/// Outgoing call ringing. 
		case OutgoingRinging = 5
		/// Outgoing call early media. 
		case OutgoingEarlyMedia = 6
		/// Connected. 
		case Connected = 7
		/// Streams running. 
		case StreamsRunning = 8
		/// Pausing. 
		case Pausing = 9
		/// Paused. 
		case Paused = 10
		/// Resuming. 
		case Resuming = 11
		/// Referred. 
		case Referred = 12
		/// Error. 
		case Error = 13
		/// Call end. 
		case End = 14
		/// Paused by remote. 
		case PausedByRemote = 15
		/// The call's parameters are updated for example when video is asked by remote. 
		case UpdatedByRemote = 16
		/// We are proposing early media to an incoming call. 
		case IncomingEarlyMedia = 17
		/// We have initiated a call update. 
		case Updating = 18
		/// The call object is now released. 
		case Released = 19
		/// The call is updated by remote while not yet answered (SIP UPDATE in early
		/// dialog received) 
		case EarlyUpdatedByRemote = 20
		/// We are updating the call while not yet answered (SIP UPDATE in early dialog
		/// sent) 
		case EarlyUpdating = 21
	}

	/// This object represents a call issued or received by the `Core`. 
	/// Linphone only allows at most one active call at any given time and it will be
	/// in `StreamsRunning`. However, if the core is locally hosting a `Conference`,
	/// you may have some or all the calls in the conference in `StreamsRunning` as
	/// well as an additional active call outside of the conference in `StreamsRunning`
	/// if the local participant of the `Conference` is not part of it.
	/// You can get the `State` of the call using getState(), it's current `CallParams`
	/// with getCurrentParams() and the latest statistics by calling getAudioStats() or
	/// getVideoStats(). 
	public func addDelegate(delegate: CallDelegate)
	{
		let manager = CallDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_call_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// This object represents a call issued or received by the `Core`. 
	/// Linphone only allows at most one active call at any given time and it will be
	/// in `StreamsRunning`. However, if the core is locally hosting a `Conference`,
	/// you may have some or all the calls in the conference in `StreamsRunning` as
	/// well as an additional active call outside of the conference in `StreamsRunning`
	/// if the local participant of the `Conference` is not part of it.
	/// You can get the `State` of the call using getState(), it's current `CallParams`
	/// with getCurrentParams() and the latest statistics by calling getAudioStats() or
	/// getVideoStats(). 
	public func removeDelegate(delegate: CallDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_call_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Returns a copy of the call statistics for the audio stream. 
	/// - Returns: a `CallStats` object for the audio stream or nil if it isn't
	/// available.   
	public var audioStats: CallStats?
	{
			let cPointer = linphone_call_get_audio_stats(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = CallStats.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the ZRTP authentication token to verify. 
	/// - Returns: the authentication token to verify or nil if ZRTP isn't enabled.   
	public var authenticationToken: String
	{
			let cPointer = linphone_call_get_authentication_token(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns whether ZRTP authentication token is verified. 
	/// If not, it must be verified by users as described in ZRTP procedure. Once done,
	/// the application must inform of the results with
	/// setAuthenticationTokenVerified(). 
	/// - Returns: true if authentication token is verifed, false otherwise. 
	public var authenticationTokenVerified: Bool
	{
		get
		{
			return linphone_call_get_authentication_token_verified(cPtr) != 0
		}
		set
		{
			linphone_call_set_authentication_token_verified(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns call quality averaged over all the duration of the call. 
	/// See getCurrentQuality() for more details about quality measurement. 
	/// - Returns: the call average quality since tbe beginning of the call. 
	public var averageQuality: Float
	{
			return linphone_call_get_average_quality(cPtr)
	}

	/// Gets the call log associated to this call. 
	/// - Returns: The `CallLog` associated with the specified `Call`.   
	public var callLog: CallLog?
	{
			let cPointer = linphone_call_get_call_log(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = CallLog.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns if camera pictures are allowed to be sent to the remote party. 
	/// - Returns: true if local video stream is being sent, false otherwise. 
	public var cameraEnabled: Bool
	{
		get
		{
			return linphone_call_camera_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_enable_camera(cPtr, newValue==true ? 1:0)
		}
	}

	/// Create a new chat room for real time messaging from a call if not already
	/// existing, else return existing one. 
	/// No reference is given to the caller: the chat room will be deleted when the
	/// call is ended. 
	/// - Returns: `ChatRoom` where real time messaging can take place or nil if chat
	/// room couldn't be created.   
	public var chatRoom: ChatRoom?
	{
			let cPointer = linphone_call_get_chat_room(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ChatRoom.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Return the associated conference object. 
	/// - Returns: A pointer on `Conference` or nil if the call is not part of any
	/// conference.   
	public var conference: Conference?
	{
			let cPointer = linphone_call_get_conference(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Conference.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the core that has created the specified call. 
	/// - Returns: The `Core` object that has created the specified call.   
	public var core: Core?
	{
			let cPointer = linphone_call_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Core.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the current LinphoneCallCbs. 
	/// This is meant only to be called from a callback to be able to get the user_data
	/// associated with the LinphoneCallCbs that is calling the callback. 
	/// - Returns: The LinphoneCallCbs that has called the last callback   
	public var currentDelegate: CallDelegate?
	{
			let cObject = linphone_call_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<CallDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Returns current parameters associated to the call. 
	/// - Returns: the current `CallParams` of this call.   
	public var currentParams: CallParams?
	{
			let cPointer = linphone_call_get_current_params(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = CallParams.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Obtain real-time quality rating of the call. 
	/// Based on local RTP statistics and RTCP feedback, a quality rating is computed
	/// and updated during all the duration of the call. This function returns its
	/// value at the time of the function call. It is expected that the rating is
	/// updated at least every 5 seconds or so. The rating is a floating point number
	/// comprised between 0 and 5.
	/// 4-5 = good quality  3-4 = average quality  2-3 = poor quality  1-2 = very poor
	/// quality  0-1 = can't be worse, mostly unusable 
	/// - Returns: The function returns -1 if no quality measurement is available, for
	/// example if no active audio stream exist. Otherwise it returns the quality
	/// rating. 
	public var currentQuality: Float
	{
			return linphone_call_get_current_quality(cPtr)
	}

	/// Returns direction of the call (incoming or outgoing). 
	/// - Returns: the `Dir` 
	public var dir: Call.Dir
	{
			return Call.Dir(rawValue: Int(linphone_call_get_dir(cPtr).rawValue))!
	}

	/// Returns the diversion address associated to this call. 
	/// - Returns: the diversion address as `Address` or nil.   
	public var diversionAddress: Address?
	{
			let cPointer = linphone_call_get_diversion_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns call's duration in seconds. 
	/// - Returns: the call's duration in seconds. 
	public var duration: Int
	{
			return Int(linphone_call_get_duration(cPtr))
	}

	/// Returns if echo cancellation is enabled. 
	/// - Returns: true if echo cancellation is enabled, false otherwise. 
	public var echoCancellationEnabled: Bool
	{
		get
		{
			return linphone_call_echo_cancellation_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_enable_echo_cancellation(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns if echo limiter is enabled. 
	/// - Returns: true if echo limiter is enabled, false otherwise. 
	public var echoLimiterEnabled: Bool
	{
		get
		{
			return linphone_call_echo_limiter_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_enable_echo_limiter(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns full details about call errors or termination reasons. 
	/// - Returns: `ErrorInfo` object holding the reason error.   
	public var errorInfo: ErrorInfo?
	{
			let cPointer = linphone_call_get_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ErrorInfo.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the current input device for this call. 
	/// - Returns: the `AudioDevice` used by this call as input or nil if there is
	/// currently no soundcard configured (depending on the state of the call)   
	public var inputAudioDevice: AudioDevice?
	{
		get
		{
			let cPointer = linphone_call_get_input_audio_device(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = AudioDevice.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_call_set_input_audio_device(cPtr, newValue?.cPtr)
		}
	}

	/// Returns whether or not the call is currently being recorded. 
	/// - Returns: true if recording is in progress, false otherwise 
	/// - deprecated: 15/09/2021 Use CallParams.isRecording() instead. 
	@available(*, deprecated)
	public var isRecording: Bool
	{
			return linphone_call_is_recording(cPtr) != 0
	}

	/// Get microphone muted state. 
	/// Note that the microphone may be disabled globally if false was given to
	/// Core.enableMic(). 
	/// - Returns: The microphone muted state. 
	public var microphoneMuted: Bool
	{
		get
		{
			return linphone_call_get_microphone_muted(cPtr) != 0
		}
		set
		{
			linphone_call_set_microphone_muted(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get microphone volume gain. 
	/// If the sound backend supports it, the returned gain is equal to the gain set
	/// with the system mixer. 
	/// - Returns: double Percentage of the max supported volume gain. Valid values are
	/// in [ 0.0 : 1.0 ]. In case of failure, a negative value is returned 
	public var microphoneVolumeGain: Float
	{
		get
		{
			return linphone_call_get_microphone_volume_gain(cPtr)
		}
		set
		{
			linphone_call_set_microphone_volume_gain(cPtr, newValue)
		}
	}

	/// Get the native window handle of the video window, casted as an unsigned long. 
	/// - Returns: the native video window id (type may vary depending on platform).   
	public var nativeVideoWindowId: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_call_get_native_video_window_id(cPtr)
		}
		set
		{
			linphone_call_set_native_video_window_id(cPtr, newValue)
		}
	}

	/// Gets the current output device for this call. 
	/// - Returns: the `AudioDevice` used by this call as output or nil if there is
	/// currently no soundcard configured (depending on the state of the call)   
	public var outputAudioDevice: AudioDevice?
	{
		get
		{
			let cPointer = linphone_call_get_output_audio_device(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = AudioDevice.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_call_set_output_audio_device(cPtr, newValue?.cPtr)
		}
	}

	/// Returns local parameters associated with the call. 
	/// This is typically the parameters passed at call initiation to
	/// Core.inviteAddressWithParams() or acceptWithParams(), or some default
	/// parameters if no `CallParams` was explicitely passed during call initiation. 
	/// - Returns: the call's local parameters.   
	public var params: CallParams?
	{
		get
		{
			let cPointer = linphone_call_get_params(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = CallParams.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_call_set_params(cPtr, newValue?.cPtr)
		}
	}

	/// Get the mesured playback volume level (received from remote) in dbm0. 
	/// - Returns: float Volume level in percentage. 
	public var playVolume: Float
	{
			return linphone_call_get_play_volume(cPtr)
	}

	/// Gets a player associated with the call to play a local file and stream it to
	/// the remote peer. 
	/// - Returns: A `Player` object   
	public var player: Player?
	{
			let cPointer = linphone_call_get_player(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Player.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the reason for a call termination (either error or normal termination) 
	/// - Returns: the `Reason` of the call termination. 
	public var reason: Reason
	{
			return Reason(rawValue: Int(linphone_call_get_reason(cPtr).rawValue))!
	}

	/// Get the mesured record volume level (sent to remote) in dbm0. 
	/// - Returns: float Volume level in percentage. 
	public var recordVolume: Float
	{
			return linphone_call_get_record_volume(cPtr)
	}

	/// Gets the refer-to uri (if the call was transfered). 
	/// - Returns: The refer-to uri of the call (if it was transfered).   
	public var referTo: String
	{
			let cPointer = linphone_call_get_refer_to(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns the remote address associated to this call. 
	/// - Returns: The `Address` of the remote end of the call.   
	public var remoteAddress: Address?
	{
			let cPointer = linphone_call_get_remote_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the remote address associated to this call as a string. 
	/// The result string must be freed by user using ms_free(). 
	/// - Returns: the remote address as a string.     
	/// - deprecated: 06/07/2020 use getRemoteAddress() instead. 
	@available(*, deprecated)
	public var remoteAddressAsString: String
	{
			let cPointer = linphone_call_get_remote_address_as_string(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			if (cPointer != nil) {
				bctbx_free(cPointer)
			}
			return result
	}

	/// Returns the far end's sip contact as a string, if available. 
	/// - Returns: the remote contact or nil.   
	public var remoteContact: String
	{
			let cPointer = linphone_call_get_remote_contact(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns call parameters proposed by remote. 
	/// This is useful when receiving an incoming call, to know whether the remote
	/// party supports video, encryption or whatever.
	/// - Returns: the `CallParams` suggested by the remote or nil.   
	public var remoteParams: CallParams?
	{
			let cPointer = linphone_call_get_remote_params(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = CallParams.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the far end's user agent description string, if available. 
	/// - Returns: the remote user agent or nil.   
	public var remoteUserAgent: String
	{
			let cPointer = linphone_call_get_remote_user_agent(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns the call object this call is replacing, if any. 
	/// Call replacement can occur during call transfers. By default, the core
	/// automatically terminates the replaced call and accept the new one. This
	/// function allows the application to know whether a new incoming call is a one
	/// that replaces another one. 
	/// - Returns: the `Call` object this call is replacing or nil.   
	public var replacedCall: Call?
	{
			let cPointer = linphone_call_get_replaced_call(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Call.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get speaker muted state. 
	/// - Returns: The speaker muted state. 
	public var speakerMuted: Bool
	{
		get
		{
			return linphone_call_get_speaker_muted(cPtr) != 0
		}
		set
		{
			linphone_call_set_speaker_muted(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get speaker volume gain. 
	/// If the sound backend supports it, the returned gain is equal to the gain set
	/// with the system mixer. 
	/// - Returns: Percentage of the max supported volume gain. Valid values are in [
	/// 0.0 : 1.0 ]. In case of failure, a negative value is returned 
	public var speakerVolumeGain: Float
	{
		get
		{
			return linphone_call_get_speaker_volume_gain(cPtr)
		}
		set
		{
			linphone_call_set_speaker_volume_gain(cPtr, newValue)
		}
	}

	/// Retrieves the call's current state. 
	/// - Returns: the current `State` of this call. 
	public var state: Call.State
	{
			return Call.State(rawValue: Int(linphone_call_get_state(cPtr).rawValue))!
	}

	/// Returns the number of stream for the given call. 
	/// - Returns: the amount of streams for this call. 
	public var streamCount: Int
	{
			return Int(linphone_call_get_stream_count(cPtr))
	}

	/// Returns a copy of the call statistics for the text stream. 
	/// - Returns: a `CallStats` object for the text stream or nil if it isn't
	/// available.   
	public var textStats: CallStats?
	{
			let cPointer = linphone_call_get_text_stats(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = CallStats.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the to address with its headers associated to this call. 
	/// - Returns: the #LinphoneAdress matching the TO of the call.   
	public var toAddress: Address?
	{
			let cPointer = linphone_call_get_to_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the current transfer state, if a transfer has been initiated from this
	/// call. 
	/// - See also: linphone_core_transfer_call ,
	/// linphone_core_transfer_call_to_another 
	/// - Returns: the `State`. 
	public var transferState: Call.State
	{
			return Call.State(rawValue: Int(linphone_call_get_transfer_state(cPtr).rawValue))!
	}

	/// When this call has received a transfer request, returns the new call that was
	/// automatically created as a result of the transfer. 
	/// - Returns: the transfer `Call` created.   
	public var transferTargetCall: Call?
	{
			let cPointer = linphone_call_get_transfer_target_call(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Call.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the transferer if this call was started automatically as a result of an
	/// incoming transfer request. 
	/// The call in which the transfer request was received is returned in this case. 
	/// - Returns: The transferer `Call` if the specified call was started
	/// automatically as a result of an incoming transfer request, nil otherwise.   
	public var transfererCall: Call?
	{
			let cPointer = linphone_call_get_transferer_call(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Call.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Retrieve the user pointer associated with the call. 
	/// - Returns: The user pointer associated with the call.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_call_get_user_data(cPtr)
		}
		set
		{
			linphone_call_set_user_data(cPtr, newValue)
		}
	}

	/// Returns a copy of the call statistics for the video stream. 
	/// - Returns: a `CallStats` object for the video stream or nil if it isn't
	/// available.   
	public var videoStats: CallStats?
	{
			let cPointer = linphone_call_get_video_stats(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = CallStats.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Accept an incoming call. 
	/// Basically the application is notified of incoming calls within the
	/// call_state_changed callback of the LinphoneCoreVTable structure, where it will
	/// receive a `Incoming` event with the associated `Call` object. The application
	/// can later accept the call using this method. 
	/// - Returns: 0 on success, -1 on failure 
	public func accept() throws 
	{
		let exception_result = linphone_call_accept(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "accept returned value \(exception_result)")
		}
	}

	/// Accept an early media session for an incoming call. 
	/// This is identical as calling acceptEarlyMediaWithParams() with nil parameters. 
	/// - Returns: 0 if successful, -1 otherwise 
	/// - See also: acceptEarlyMediaWithParams() 
	public func acceptEarlyMedia() throws 
	{
		let exception_result = linphone_call_accept_early_media(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "acceptEarlyMedia returned value \(exception_result)")
		}
	}

	/// When receiving an incoming, accept to start a media session as early-media. 
	/// This means the call is not accepted but audio & video streams can be
	/// established if the remote party supports early media. However, unlike after
	/// call acceptance, mic and camera input are not sent during early-media, though
	/// received audio & video are played normally. The call can then later be fully
	/// accepted using accept() or acceptWithParams(). 
	/// - Parameter params: The call parameters to use (can be nil).   
	/// - Returns: 0 if successful, -1 otherwise 
	public func acceptEarlyMediaWithParams(params:CallParams?) throws 
	{
		let exception_result = linphone_call_accept_early_media_with_params(cPtr, params?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "acceptEarlyMediaWithParams returned value \(exception_result)")
		}
	}

	/// Accept call modifications initiated by other end. 
	/// This call may be performed in response to a #LinphoneCallUpdatedByRemote state
	/// notification. When such notification arrives, the application can decide to
	/// call deferUpdate() so that it can have the time to prompt the user.
	/// getRemoteParams() can be used to get information about the call parameters
	/// requested by the other party, such as whether a video stream is requested.
	/// When the user accepts or refuse the change, acceptUpdate() can be done to
	/// answer to the other party. If params is nil, then the same call parameters
	/// established before the update request will continue to be used (no change). If
	/// params is not nil, then the update will be accepted according to the parameters
	/// passed. Typical example is when a user accepts to start video, then params
	/// should indicate that video stream should be used (see
	/// CallParams.enableVideo()). 
	/// - Parameter params: A `CallParams` object describing the call parameters to
	/// accept.   
	/// - Returns: 0 if successful, -1 otherwise (actually when this function call is
	/// performed outside ot #LinphoneCallUpdatedByRemote state) 
	public func acceptUpdate(params:CallParams?) throws 
	{
		let exception_result = linphone_call_accept_update(cPtr, params?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "acceptUpdate returned value \(exception_result)")
		}
	}

	/// Accept an incoming call, with parameters. 
	/// Basically the application is notified of incoming calls within the
	/// call_state_changed callback of the LinphoneCoreVTable structure, where it will
	/// receive a `Incoming` event with the associated `Call` object. The application
	/// can later accept the call using this method. 
	/// - Parameter params: The specific parameters for this call, for example whether
	/// video is accepted or not. Use nil to use default parameters.   
	/// - Returns: 0 on success, -1 on failure 
	public func acceptWithParams(params:CallParams?) throws 
	{
		let exception_result = linphone_call_accept_with_params(cPtr, params?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "acceptWithParams returned value \(exception_result)")
		}
	}

	/// Tell whether a call has been asked to autoanswer. 
	/// - Returns: A boolean value telling whether the call has been asked to
	/// autoanswer 
	public func askedToAutoanswer() -> Bool
	{
		return linphone_call_asked_to_autoanswer(cPtr) != 0
	}

	/// Stop current DTMF sequence sending. 
	/// Please note that some DTMF could be already sent, depending on when this
	/// function call is delayed from sendDtmfs(). This function will be automatically
	/// called if call state change to anything but LinphoneCallStreamsRunning. 
	public func cancelDtmfs() 
	{
		linphone_call_cancel_dtmfs(cPtr)
	}

	/// Decline a pending incoming call, with a reason. 
	/// - Parameter reason: The reason for rejecting the call: `Declined` or `Busy` 
	/// - Returns: 0 on success, -1 on failure 
	public func decline(reason:Reason) throws 
	{
		let exception_result = linphone_call_decline(cPtr, LinphoneReason(rawValue: CUnsignedInt(reason.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "decline returned value \(exception_result)")
		}
	}

	/// Decline a pending incoming call, with a `ErrorInfo` object. 
	/// - Parameter ei: `ErrorInfo` containing more information on the call rejection. 
	///  
	/// - Returns: 0 on success, -1 on failure 
	public func declineWithErrorInfo(ei:ErrorInfo?) -> Int
	{
		return Int(linphone_call_decline_with_error_info(cPtr, ei?.cPtr))
	}

	/// When receiving a #LinphoneCallUpdatedByRemote state notification, prevent
	/// `Core` from performing an automatic answer. 
	/// When receiving a #LinphoneCallUpdatedByRemote state notification (ie an
	/// incoming reINVITE), the default behaviour of `Core` is defined by the
	/// "defer_update_default" option of the "sip" section of the config. If this
	/// option is 0 (the default) then the `Core` automatically answers the reINIVTE
	/// with call parameters unchanged. However when for example when the remote party
	/// updated the call to propose a video stream, it can be useful to prompt the user
	/// before answering. This can be achieved by calling
	/// linphone_core_defer_call_update during the call state notification, to
	/// deactivate the automatic answer that would just confirm the audio but reject
	/// the video. Then, when the user responds to dialog prompt, it becomes possible
	/// to call acceptUpdate() to answer the reINVITE, with eventually video enabled in
	/// the `CallParams` argument.
	/// The #LinphoneCallUpdatedByRemote notification can also arrive when receiving an
	/// INVITE without SDP. In such case, an unchanged offer is made in the 200Ok, and
	/// when the ACK containing the SDP answer is received,
	/// #LinphoneCallUpdatedByRemote is triggered to notify the application of possible
	/// changes in the media session. However in such case defering the update has no
	/// meaning since we just generating an offer.
	/// - Returns: 0 if successful, -1 if the deferUpdate() was done outside a valid
	/// #LinphoneCallUpdatedByRemote notification 
	public func deferUpdate() throws 
	{
		let exception_result = linphone_call_defer_update(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "deferUpdate returned value \(exception_result)")
		}
	}

	/// Returns a copy of the call statistics for a particular stream type. 
	/// - Parameter type: the `StreamType` 
	/// - Returns: a `CallStats` object for the given stream or nil if stream isn't
	/// available.   
	public func getStats(type:StreamType) -> CallStats?
	{
		let cPointer = linphone_call_get_stats(cPtr, LinphoneStreamType(rawValue: CUnsignedInt(type.rawValue)))
		if (cPointer == nil) {
			return nil
		}
		let result = CallStats.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Returns the value of the header name. 
	/// - Parameter headerName: the name of the header to check.   
	/// - Returns: the value of the header if exists.   
	/// - deprecated: 27/10/2020. Use CallParams.getCustomHeader() on getRemoteParams()
	/// instead. 
	@available(*, deprecated)
	public func getToHeader(headerName:String) -> String
	{
		let cstr = linphone_call_get_to_header(cPtr, headerName)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Returns if this calls has received a transfer that has not been executed yet. 
	/// Pending transfers are executed when this call is being paused or closed,
	/// locally or by remote endpoint. If the call is already paused while receiving
	/// the transfer request, the transfer immediately occurs. 
	/// - Returns: true if transfer is pending, false otherwise. 
	public func hasTransferPending() -> Bool
	{
		return linphone_call_has_transfer_pending(cPtr) != 0
	}

	/// Indicates whether an operation is in progress at the media side. 
	/// It can be a bad idea to initiate signaling operations (adding video, pausing
	/// the call, removing video, changing video parameters) while the media is busy in
	/// establishing the connection (typically ICE connectivity checks). It can result
	/// in failures generating loss of time in future operations in the call.
	/// Applications are invited to check this function after each call state change to
	/// decide whether certain operations are permitted or not. 
	/// - Returns: true if media is busy in establishing the connection, false
	/// otherwise. 
	public func mediaInProgress() -> Bool
	{
		return linphone_call_media_in_progress(cPtr) != 0
	}

	/// Starts the process of replying 180 Ringing. 
	/// This function is used in conjonction with Core.enableAutoSendRinging(). If the
	/// automatic sending of the 180 Ringing is disabled, this function needs to be
	/// called manually before the call timeouts.
	public func notifyRinging() 
	{
		linphone_call_notify_ringing(cPtr)
	}

	/// Calls generic OpenGL render for a given call. 
	public func oglRender() 
	{
		linphone_call_ogl_render(cPtr)
	}

	/// Pauses the call. 
	/// If a music file has been setup using Core.setPlayFile(), this file will be
	/// played to the remote user. The only way to resume a paused call is to call
	/// resume(). 
	/// - Returns: 0 on success, -1 on failure 
	/// - See also: resume() 
	public func pause() throws 
	{
		let exception_result = linphone_call_pause(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "pause returned value \(exception_result)")
		}
	}

	/// Redirect the specified call to the given redirect URI. 
	/// - Parameter redirectUri: The URI to redirect the call to   
	/// - Returns: 0 if successful, -1 on error. 
	/// - deprecated: 27/10/2020. Use redirectTo() instead. 
	@available(*, deprecated)
	public func redirect(redirectUri:String) throws 
	{
		let exception_result = linphone_call_redirect(cPtr, redirectUri)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "redirect returned value \(exception_result)")
		}
	}

	/// Redirect the specified call to the given redirect Address. 
	/// - Parameter redirectAddress: The `Address` to redirect the call to   
	/// - Returns: 0 if successful, -1 on error. 
	public func redirectTo(redirectAddress:Address) throws 
	{
		let exception_result = linphone_call_redirect_to(cPtr, redirectAddress.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "redirectTo returned value \(exception_result)")
		}
	}

	/// Request the callback passed to linphone_call_cbs_set_next_video_frame_decoded
	/// to be called the next time the video decoder properly decodes a video frame. 
	public func requestNotifyNextVideoFrameDecoded() 
	{
		linphone_call_request_notify_next_video_frame_decoded(cPtr)
	}

	/// Resumes a call. 
	/// The call needs to have been paused previously with pause(). 
	/// - Returns: 0 on success, -1 on failure 
	/// - See also: pause() 
	public func resume() throws 
	{
		let exception_result = linphone_call_resume(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "resume returned value \(exception_result)")
		}
	}

	/// Send the specified dtmf. 
	/// The dtmf is automatically played to the user. 
	/// - Parameter dtmf: The dtmf name specified as a char, such as '0', '#' etc... 
	/// - Returns: 0 if successful, -1 on error. 
	public func sendDtmf(dtmf:CChar) throws 
	{
		let exception_result = linphone_call_send_dtmf(cPtr, dtmf)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "sendDtmf returned value \(exception_result)")
		}
	}

	/// Send a list of dtmf. 
	/// The dtmfs are automatically sent to remote, separated by some needed
	/// customizable delay. Sending is canceled if the call state changes to something
	/// not LinphoneCallStreamsRunning. 
	/// - Parameter dtmfs: A dtmf sequence such as '123#123123'   
	/// - Returns: -2 if there is already a DTMF sequence, -1 if call is not ready, 0
	/// otherwise. 
	public func sendDtmfs(dtmfs:String) throws 
	{
		let exception_result = linphone_call_send_dtmfs(cPtr, dtmfs)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "sendDtmfs returned value \(exception_result)")
		}
	}

	/// Sends an info message through an established call. 
	/// - Parameter info: the `InfoMessage` to send   
	public func sendInfoMessage(info:InfoMessage) throws 
	{
		let exception_result = linphone_call_send_info_message(cPtr, info.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "sendInfoMessage returned value \(exception_result)")
		}
	}

	/// Request remote side to send us a Video Fast Update. 
	public func sendVfuRequest() 
	{
		linphone_call_send_vfu_request(cPtr)
	}

	/// Starts call recording. 
	/// Video record is only available if this function is called in state
	/// StreamRunning. The output file where audio is recorded must be previously
	/// specified with CallParams.setRecordFile(). 
	public func startRecording() 
	{
		linphone_call_start_recording(cPtr)
	}

	/// Stops call recording. 
	public func stopRecording() 
	{
		linphone_call_stop_recording(cPtr)
	}

	/// Take a photo of currently captured video and write it into a jpeg file. 
	/// Note that the snapshot is asynchronous, an application shall not assume that
	/// the file is created when the function returns. 
	/// - Parameter filePath: a path where to write the jpeg content.   
	/// - Returns: 0 if successfull, -1 otherwise (typically if jpeg format is not
	/// supported). 
	public func takePreviewSnapshot(filePath:String) throws 
	{
		let exception_result = linphone_call_take_preview_snapshot(cPtr, filePath)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "takePreviewSnapshot returned value \(exception_result)")
		}
	}

	/// Take a photo of currently received video and write it into a jpeg file. 
	/// Note that the snapshot is asynchronous, an application shall not assume that
	/// the file is created when the function returns. 
	/// - Parameter filePath: a path where to write the jpeg content.   
	/// - Returns: 0 if successfull, -1 otherwise (typically if jpeg format is not
	/// supported). 
	public func takeVideoSnapshot(filePath:String) throws 
	{
		let exception_result = linphone_call_take_video_snapshot(cPtr, filePath)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "takeVideoSnapshot returned value \(exception_result)")
		}
	}

	/// Terminates a call. 
	/// - Returns: 0 on success, -1 on failure 
	public func terminate() throws 
	{
		let exception_result = linphone_call_terminate(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "terminate returned value \(exception_result)")
		}
	}

	/// Terminates a call. 
	/// - Parameter ei: `ErrorInfo`   
	/// - Returns: 0 on success, -1 on failure 
	public func terminateWithErrorInfo(ei:ErrorInfo?) throws 
	{
		let exception_result = linphone_call_terminate_with_error_info(cPtr, ei?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "terminateWithErrorInfo returned value \(exception_result)")
		}
	}

	/// Performs a simple call transfer to the specified destination. 
	/// The remote endpoint is expected to issue a new call to the specified
	/// destination. The current call remains active and thus can be later paused or
	/// terminated. It is possible to follow the progress of the transfer provided that
	/// transferee sends notification about it. In this case, the
	/// transfer_state_changed callback of the LinphoneCoreVTable is invoked to notify
	/// of the state of the new call at the other party. The notified states are
	/// #LinphoneCallOutgoingInit , #LinphoneCallOutgoingProgress,
	/// #LinphoneCallOutgoingRinging and #LinphoneCallConnected. 
	/// - Parameter referTo: The destination the call is to be refered to.   
	/// - Returns: 0 on success, -1 on failure 
	/// - deprecated: 27/10/2020. Use transferTo() instead. 
	@available(*, deprecated)
	public func transfer(referTo:String) throws 
	{
		let exception_result = linphone_call_transfer(cPtr, referTo)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "transfer returned value \(exception_result)")
		}
	}

	/// Performs a simple call transfer to the specified destination. 
	/// The remote endpoint is expected to issue a new call to the specified
	/// destination. The current call remains active and thus can be later paused or
	/// terminated. It is possible to follow the progress of the transfer provided that
	/// transferee sends notification about it. In this case, the
	/// transfer_state_changed callback of the LinphoneCoreVTable is invoked to notify
	/// of the state of the new call at the other party. The notified states are
	/// #LinphoneCallOutgoingInit , #LinphoneCallOutgoingProgress,
	/// #LinphoneCallOutgoingRinging and #LinphoneCallConnected. 
	/// - Parameter referTo: The `Address` the call is to be refered to.   
	/// - Returns: 0 on success, -1 on failure 
	public func transferTo(referTo:Address) throws 
	{
		let exception_result = linphone_call_transfer_to(cPtr, referTo.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "transferTo returned value \(exception_result)")
		}
	}

	/// Transfers a call to destination of another running call. 
	/// This is used for "attended transfer" scenarios. The transfered call is supposed
	/// to be in paused state, so that it is able to accept the transfer immediately.
	/// The destination call is a call previously established to introduce the
	/// transfered person. This method will send a transfer request to the transfered
	/// person. The phone of the transfered is then expected to automatically call to
	/// the destination of the transfer. The receiver of the transfer will then
	/// automatically close the call with us (the 'dest' call). It is possible to
	/// follow the progress of the transfer provided that transferee sends notification
	/// about it. In this case, the transfer_state_changed callback of the
	/// LinphoneCoreVTable is invoked to notify of the state of the new call at the
	/// other party. The notified states are #LinphoneCallOutgoingInit ,
	/// #LinphoneCallOutgoingProgress, #LinphoneCallOutgoingRinging and
	/// #LinphoneCallConnected. 
	/// - Parameter dest: A running call whose remote person will receive the transfer 
	///  
	/// - Returns: 0 on success, -1 on failure 
	public func transferToAnother(dest:Call) throws 
	{
		let exception_result = linphone_call_transfer_to_another(cPtr, dest.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "transferToAnother returned value \(exception_result)")
		}
	}

	/// Updates a running call according to supplied call parameters or parameters
	/// changed in the LinphoneCore. 
	/// It triggers a SIP reINVITE in order to perform a new offer/answer of media
	/// capabilities. Changing the size of the transmitted video after calling
	/// linphone_core_set_preferred_video_size can be used by passing nil as params
	/// argument. In case no changes are requested through the `CallParams` argument,
	/// then this argument can be omitted and set to nil. WARNING: Updating a call in
	/// the #LinphoneCallPaused state will still result in a paused call even if the
	/// media directions set in the params are sendrecv. To resume a paused call, you
	/// need to call resume().
	/// - Parameter params: The new call parameters to use (may be nil).   
	/// - Returns: 0 if successful, -1 otherwise. 
	public func update(params:CallParams?) throws 
	{
		let exception_result = linphone_call_update(cPtr, params?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "update returned value \(exception_result)")
		}
	}

	/// Perform a zoom of the video displayed during a call. 
	/// The zoom ensures that all the screen is fullfilled with the video. 
	/// - Parameter zoomFactor: a floating point number describing the zoom factor. A
	/// value 1.0 corresponds to no zoom applied. 
	/// - Parameter cx: a floating point number pointing the horizontal center of the
	/// zoom to be applied. This value should be between 0.0 and 1.0. 
	/// - Parameter cy: a floating point number pointing the vertical center of the
	/// zoom to be applied. This value should be between 0.0 and 1.0. 
	public func zoom(zoomFactor:Float, cx:Float, cy:Float) 
	{
		linphone_call_zoom(cPtr, zoomFactor, cx, cy)
	}
}

/// Object used to keep track of all calls initiated, received or missed. 
/// It contains the call ID, date & time at which the call took place and it's
/// duration (0 if it wasn't answered). You can also know if video was enabled or
/// not or if it was a conference, as well as it's average quality.
/// If needed, you can also create a fake `CallLog` using Core.createCallLog(),
/// otherwise use Core.getCallLogs() or even Call.getCallLog() to get the log of an
/// ongoing call. 
public class CallLog : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> CallLog {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<CallLog>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = CallLog(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get the call ID used by the call. 
	/// - Returns: The call ID used by the call as a string.   
	public var callId: String
	{
			let cPointer = linphone_call_log_get_call_id(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the direction of the call. 
	/// - Returns: The `Call.Dir` of the call. 
	public var dir: Call.Dir
	{
			return Call.Dir(rawValue: Int(linphone_call_log_get_dir(cPtr).rawValue))!
	}

	/// Get the duration of the call since connected. 
	/// - Returns: The duration of the call in seconds. 
	public var duration: Int
	{
			return Int(linphone_call_log_get_duration(cPtr))
	}

	/// When the call was failed, return an object describing the failure. 
	/// - Returns: `ErrorInfo` about the error encountered by the call associated with
	/// this call log or nil.   
	public var errorInfo: ErrorInfo?
	{
			let cPointer = linphone_call_log_get_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ErrorInfo.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the origin address (ie from) of the call. 
	/// - Returns: The origin `Address` (ie from) of the call.   
	public var fromAddress: Address?
	{
			let cPointer = linphone_call_log_get_from_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the local address (that is from or to depending on call direction) 
	/// - Returns: The local `Address` of the call   
	public var localAddress: Address?
	{
			let cPointer = linphone_call_log_get_local_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the overall quality indication of the call. 
	/// - Returns: The overall quality indication of the call. 
	public var quality: Float
	{
			return linphone_call_log_get_quality(cPtr)
	}

	/// Get the persistent reference key associated to the call log. 
	/// The reference key can be for example an id to an external database. It is
	/// stored in the config file, thus can survive to process exits/restarts.
	/// - Returns: The reference key string that has been associated to the call log,
	/// or nil if none has been associated.   
	public var refKey: String
	{
		get
		{
			let cPointer = linphone_call_log_get_ref_key(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_call_log_set_ref_key(cPtr, newValue)
		}
	}

	/// Get the remote address (that is from or to depending on call direction). 
	/// - Returns: The remote `Address` of the call.   
	public var remoteAddress: Address?
	{
		get
		{
			let cPointer = linphone_call_log_get_remote_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_call_log_set_remote_address(cPtr, newValue?.cPtr)
		}
	}

	/// Get the start date of the call. 
	/// - Returns: The date of the beginning of the call. 
	public var startDate: time_t
	{
			return linphone_call_log_get_start_date(cPtr)
	}

	/// Get the status of the call. 
	/// - Returns: The `Call.Status` of the call. 
	public var status: Call.Status
	{
			return Call.Status(rawValue: Int(linphone_call_log_get_status(cPtr).rawValue))!
	}

	/// Get the destination address (ie to) of the call. 
	/// - Returns: The destination `Address` (ie to) of the call.   
	public var toAddress: Address?
	{
			let cPointer = linphone_call_log_get_to_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the user data associated with the call log. 
	/// - Returns: The user data associated with the call log.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_call_log_get_user_data(cPtr)
		}
		set
		{
			linphone_call_log_set_user_data(cPtr, newValue)
		}
	}

	/// Tell whether video was enabled at the end of the call or not. 
	/// - Returns: A boolean value telling whether video was enabled at the end of the
	/// call. 
	public var videoEnabled: Bool
	{
			return linphone_call_log_video_enabled(cPtr) != 0
	}

	/// Get a human readable string describing the call. 
	/// - Note: : the returned string must be freed by the application (use ms_free()). 
	/// - Returns: A human readable string describing the call.     
	public func toStr() -> String
	{
		let cstr = linphone_call_log_to_str(cPtr)
		let result = charArrayToString(charPointer: cstr)
		if (cstr != nil) {
			bctbx_free(cstr)
		}
		return result
	}

	/// Tells whether that call was a call to a conference server. 
	/// - Returns: true if the call was a call to a conference server, false otherwise. 
	public func wasConference() -> Bool
	{
		return linphone_call_log_was_conference(cPtr) != 0
	}
}

/// An object containing various parameters of a `Call`. 
/// You can specify your params while answering an incoming call using
/// Call.acceptWithParams() or while initiating an outgoing call with
/// Core.inviteAddressWithParams().
/// This object can be created using Core.createCallParams(), using nil for the
/// call pointer if you plan to use it for an outgoing call.
/// For each call, three `CallParams` are available: yours, your correspondent's
/// and the one that describe the current state of the call that is the result of
/// the negociation between the previous two. For example, you might enable a
/// certain feature in your call param but this feature can be denied in the
/// remote's configuration, hence the difference.
/// - See also: Call.getCurrentParams(), Call.getRemoteParams() and
/// Call.getParams(). 
public class CallParams : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> CallParams {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<CallParams>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = CallParams(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Refine bandwidth settings for this call by setting a bandwidth limit for audio
	/// streams. 
	/// As a consequence, codecs whose bitrates are not compatible with this limit
	/// won't be used. 
	/// - Parameter bandwidth: The audio bandwidth limit to set in kbit/s. 
	public var audioBandwidthLimit: Int = 0
	{
		willSet
		{
			linphone_call_params_set_audio_bandwidth_limit(cPtr, CInt(newValue))
		}
	}

	/// Get the audio stream direction. 
	/// - Returns: The audio stream `MediaDirection` associated with the call params. 
	public var audioDirection: MediaDirection
	{
		get
		{
			return MediaDirection(rawValue: Int(linphone_call_params_get_audio_direction(cPtr).rawValue))!
		}
		set
		{
			linphone_call_params_set_audio_direction(cPtr, LinphoneMediaDirection(rawValue: CInt(newValue.rawValue)))
		}
	}

	/// Tell whether audio is enabled or not. 
	/// - Returns: A boolean value telling whether audio is enabled or not. 
	public var audioEnabled: Bool
	{
		get
		{
			return linphone_call_params_audio_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_audio(cPtr, newValue==true ? 1:0)
		}
	}

	/// Use to get multicast state of audio stream. 
	/// - Returns: true if subsequent calls will propose multicast ip set by
	/// Core.setAudioMulticastAddr() 
	public var audioMulticastEnabled: Bool
	{
		get
		{
			return linphone_call_params_audio_multicast_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_audio_multicast(cPtr, newValue==true ? 1:0)
		}
	}

	/// Set the video stream direction. 
	/// - Parameter enable: wether or not AVPF should be enabled for this call 
	public var avpfEnabled: Bool?
	{
		willSet
		{
			linphone_call_params_enable_avpf(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check if the capability negotiation (RFC5939) reINVITE is enabled or not. 
	/// - Returns: true if capability negotiation reINVITE is enabled; false otherwise. 
	public var capabilityNegotiationReinviteEnabled: Bool
	{
		get
		{
			return linphone_call_params_capability_negotiation_reinvite_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_capability_negotiation_reinvite(cPtr, newValue==true ? 1:0)
		}
	}

	/// Indicates whether capability negotiations (RFC5939) is enabled. 
	/// - Returns: a boolean indicating the enablement of capability negotiations. 
	public var capabilityNegotiationsEnabled: Bool
	{
		get
		{
			return linphone_call_params_capability_negotiations_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_capability_negotiations(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets a list of `Content` set if exists. 
	/// - Returns: A list of `Content` set if exists, nil otherwise.      
	public var customContents: [Content]
	{
			var swiftList = [Content]()
			let cList = linphone_call_params_get_custom_contents(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Content.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Indicate whether sending of early media was enabled. 
	/// - Returns: A boolean value telling whether sending of early media was enabled. 
	public var earlyMediaSendingEnabled: Bool
	{
		get
		{
			return linphone_call_params_early_media_sending_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_early_media_sending(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check if the capability negotiation (RFC5939) reINVITE is enabled or not. 
	/// - Returns: true if capability negotiation reINVITE is enabled; false otherwise.
	/// - deprecated: 16/12/2021 Use capabilityNegotiationReinviteEnabled() instead. 
	@available(*, deprecated)
	public var isCapabilityNegotiationReinviteEnabled: Bool
	{
			return linphone_call_params_is_capability_negotiation_reinvite_enabled(cPtr) != 0
	}

	/// Indicates whether the call is being recorded. 
	/// - Returns: true if the call is being recorded, false otherwise. 
	public var isRecording: Bool
	{
			return linphone_call_params_is_recording(cPtr) != 0
	}

	/// Tell whether the call is part of the locally managed conference. 
	/// - Warning: If a conference server is used to manage conferences, that function
	/// does not return true even if the conference is running. If you want to test
	/// whether the conference is running, you should test whether Core.getConference()
	/// return a non-null pointer. 
	/// - Returns: A boolean value telling whether the call is part of the locally
	/// managed conference. 
	public var localConferenceMode: Bool
	{
			return linphone_call_params_get_local_conference_mode(cPtr) != 0
	}

	/// Tell whether the call has been configured in low bandwidth mode or not. 
	/// This mode can be automatically discovered thanks to a stun server when
	/// activate_edge_workarounds=1 in section [net] of configuration file. An
	/// application that would have reliable way to know network capacity may not use
	/// activate_edge_workarounds=1 but instead manually configure low bandwidth mode
	/// with enableLowBandwidth(). When enabled, this param may transform a call
	/// request with video in audio only mode. 
	/// - Returns: A boolean value telling whether the low bandwidth mode has been
	/// configured/detected. 
	public var lowBandwidthEnabled: Bool
	{
		get
		{
			return linphone_call_params_low_bandwidth_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_low_bandwidth(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the kind of media encryption selected for the call. 
	/// - Returns: The kind of `MediaEncryption` selected for the call. 
	public var mediaEncryption: MediaEncryption
	{
		get
		{
			return MediaEncryption(rawValue: Int(linphone_call_params_get_media_encryption(cPtr).rawValue))!
		}
		set
		{
			linphone_call_params_set_media_encryption(cPtr, LinphoneMediaEncryption(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get requested level of privacy for the call. 
	/// - Returns: The LinphonePrivacyMask used for the call. 
	public var privacy: UInt
	{
		get
		{
			return UInt(linphone_call_params_get_privacy(cPtr))
		}
		set
		{
			linphone_call_params_set_privacy(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Get the `ProxyConfig` that is used for the call. 
	/// - Returns: The selected `ProxyConfig` for the call, or nil if none has been
	/// selected.   
	public var proxyConfig: ProxyConfig?
	{
		get
		{
			let cPointer = linphone_call_params_get_proxy_config(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ProxyConfig.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_call_params_set_proxy_config(cPtr, newValue?.cPtr)
		}
	}

	/// Use to get real time text following rfc4103. 
	/// - Returns: returns true if call rtt is activated. 
	public var realtimeTextEnabled: Bool
	{
			return linphone_call_params_realtime_text_enabled(cPtr) != 0
	}

	public func setRealtimetextenabled(newValue: Bool) throws
	{
		let exception_result = linphone_call_params_enable_realtime_text(cPtr, newValue==true ? 1:0)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Use to get keep alive interval of real time text following rfc4103. 
	/// - Returns: returns keep alive interval of real time text. 
	public var realtimeTextKeepaliveInterval: UInt
	{
		get
		{
			return UInt(linphone_call_params_get_realtime_text_keepalive_interval(cPtr))
		}
		set
		{
			linphone_call_params_set_realtime_text_keepalive_interval(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Get the framerate of the video that is received. 
	/// - Returns: The actual received framerate in frames per seconds, 0 if not
	/// available. 
	public var receivedFramerate: Float
	{
			return linphone_call_params_get_received_framerate(cPtr)
	}

	/// Get the definition of the received video. 
	/// - Returns: The received `VideoDefinition` or nil.   
	public var receivedVideoDefinition: VideoDefinition?
	{
			let cPointer = linphone_call_params_get_received_video_definition(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = VideoDefinition.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the path for the audio recording of the call. 
	/// - Returns: The path to the audio recording of the call or nil.   
	public var recordFile: String
	{
		get
		{
			let cPointer = linphone_call_params_get_record_file(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_call_params_set_record_file(cPtr, newValue)
		}
	}

	/// Indicates whether RTP bundle mode (also known as Media Multiplexing) is
	/// enabled. 
	/// See https://tools.ietf.org/html/draft-ietf-mmusic-sdp-bundle-negotiation-54 for
	/// more information. 
	/// - Returns: a boolean indicating the enablement of rtp bundle mode. 
	public var rtpBundleEnabled: Bool
	{
		get
		{
			return linphone_call_params_rtp_bundle_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_rtp_bundle(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the RTP profile being used. 
	/// - Returns: The RTP profile.   
	public var rtpProfile: String
	{
			let cPointer = linphone_call_params_get_rtp_profile(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the framerate of the video that is sent. 
	/// - Returns: The actual sent framerate in frames per seconds, 0 if not available. 
	public var sentFramerate: Float
	{
			return linphone_call_params_get_sent_framerate(cPtr)
	}

	/// Get the definition of the sent video. 
	/// - Returns: The sent `VideoDefinition` or nil.   
	public var sentVideoDefinition: VideoDefinition?
	{
			let cPointer = linphone_call_params_get_sent_video_definition(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = VideoDefinition.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the session name of the media session (ie in SDP). 
	/// Subject from the SIP message can be retrieved using getCustomHeader() and is
	/// different. 
	/// - Returns: The session name of the media session or nil.   
	public var sessionName: String
	{
		get
		{
			let cPointer = linphone_call_params_get_session_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_call_params_set_session_name(cPtr, newValue)
		}
	}

	/// Enable merging of tcap lines with consecutive indexes if capability
	/// negotiations (RFC5939) is enabled. 
	/// - Parameter enabled: A boolean value telling whether to merge tcap lines 
	public var tcapLineMergingEnabled: Bool?
	{
		willSet
		{
			linphone_call_params_enable_tcap_line_merging(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the audio payload type that has been selected by a call. 
	/// - Returns: The selected `PayloadType`. nil is returned if no audio payload type
	/// has been selected by the call.   
	public var usedAudioPayloadType: PayloadType?
	{
			let cPointer = linphone_call_params_get_used_audio_payload_type(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = PayloadType.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the text payload type that has been selected by a call. 
	/// - Returns: The selected `PayloadType`. nil is returned if no text payload type
	/// has been selected by the call.   
	public var usedTextPayloadType: PayloadType?
	{
			let cPointer = linphone_call_params_get_used_text_payload_type(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = PayloadType.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the video payload type that has been selected by a call. 
	/// - Returns: The selected `PayloadType`. nil is returned if no video payload type
	/// has been selected by the call.   
	public var usedVideoPayloadType: PayloadType?
	{
			let cPointer = linphone_call_params_get_used_video_payload_type(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = PayloadType.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the user data associated with the call params. 
	/// - Returns: The user data associated with the call params.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_call_params_get_user_data(cPtr)
		}
		set
		{
			linphone_call_params_set_user_data(cPtr, newValue)
		}
	}

	/// Get the video stream direction. 
	/// - Returns: The video stream `MediaDirection` associated with the call params. 
	public var videoDirection: MediaDirection
	{
		get
		{
			return MediaDirection(rawValue: Int(linphone_call_params_get_video_direction(cPtr).rawValue))!
		}
		set
		{
			linphone_call_params_set_video_direction(cPtr, LinphoneMediaDirection(rawValue: CInt(newValue.rawValue)))
		}
	}

	/// Tell whether video is enabled or not. 
	/// - Returns: A boolean value telling whether video is enabled or not. 
	public var videoEnabled: Bool
	{
		get
		{
			return linphone_call_params_video_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_video(cPtr, newValue==true ? 1:0)
		}
	}

	/// Use to get multicast state of video stream. 
	/// - Returns: true if subsequent calls will propose multicast ip set by
	/// Core.setVideoMulticastAddr() 
	public var videoMulticastEnabled: Bool
	{
		get
		{
			return linphone_call_params_video_multicast_enabled(cPtr) != 0
		}
		set
		{
			linphone_call_params_enable_video_multicast(cPtr, newValue==true ? 1:0)
		}
	}

	/// Adds a `Content` to be added to the INVITE SDP. 
	/// - Parameter content: The `Content` to be added.   
	public func addCustomContent(content:Content) 
	{
		linphone_call_params_add_custom_content(cPtr, content.cPtr)
	}

	/// Add a custom SIP header in the INVITE for a call. 
	/// - Parameter headerName: The name of the header to add.   
	/// - Parameter headerValue: The content of the header to add.   
	public func addCustomHeader(headerName:String, headerValue:String?) 
	{
		linphone_call_params_add_custom_header(cPtr, headerName, headerValue)
	}

	/// Add a custom attribute related to all the streams in the SDP exchanged within
	/// SIP messages during a call. 
	/// - Parameter attributeName: The name of the attribute to add.   
	/// - Parameter attributeValue: The content value of the attribute to add.   
	public func addCustomSdpAttribute(attributeName:String, attributeValue:String?) 
	{
		linphone_call_params_add_custom_sdp_attribute(cPtr, attributeName, attributeValue)
	}

	/// Add a custom attribute related to a specific stream in the SDP exchanged within
	/// SIP messages during a call. 
	/// - Parameter type: The type of the stream to add a custom SDP attribute to. 
	/// - Parameter attributeName: The name of the attribute to add.   
	/// - Parameter attributeValue: The content value of the attribute to add.   
	public func addCustomSdpMediaAttribute(type:StreamType, attributeName:String, attributeValue:String?) 
	{
		linphone_call_params_add_custom_sdp_media_attribute(cPtr, LinphoneStreamType(rawValue: CUnsignedInt(type.rawValue)), attributeName, attributeValue)
	}

	/// Clear the custom SDP attributes related to all the streams in the SDP exchanged
	/// within SIP messages during a call. 
	public func clearCustomSdpAttributes() 
	{
		linphone_call_params_clear_custom_sdp_attributes(cPtr)
	}

	/// Clear the custom SDP attributes related to a specific stream in the SDP
	/// exchanged within SIP messages during a call. 
	/// - Parameter type: The type of the stream to clear the custom SDP attributes
	/// from. 
	public func clearCustomSdpMediaAttributes(type:StreamType) 
	{
		linphone_call_params_clear_custom_sdp_media_attributes(cPtr, LinphoneStreamType(rawValue: CUnsignedInt(type.rawValue)))
	}

	/// Copy an existing `CallParams` object to a new `CallParams` object. 
	/// - Returns: A copy of the `CallParams` object.   
	public func copy() -> CallParams?
	{
		let cPointer = linphone_call_params_copy(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = CallParams.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Get a custom SIP header. 
	/// - Parameter headerName: The name of the header to get.   
	/// - Returns: The content of the header or nil if not found.   
	public func getCustomHeader(headerName:String) -> String
	{
		let cstr = linphone_call_params_get_custom_header(cPtr, headerName)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Get a custom SDP attribute that is related to all the streams. 
	/// - Parameter attributeName: The name of the attribute to get.   
	/// - Returns: The content value of the attribute or nil if not found.   
	public func getCustomSdpAttribute(attributeName:String) -> String
	{
		let cstr = linphone_call_params_get_custom_sdp_attribute(cPtr, attributeName)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Get a custom SDP attribute that is related to a specific stream. 
	/// - Parameter type: The type of the stream to add a custom SDP attribute to. 
	/// - Parameter attributeName: The name of the attribute to get.   
	/// - Returns: The content value of the attribute or nil if not found.   
	public func getCustomSdpMediaAttribute(type:StreamType, attributeName:String) -> String
	{
		let cstr = linphone_call_params_get_custom_sdp_media_attribute(cPtr, LinphoneStreamType(rawValue: CUnsignedInt(type.rawValue)), attributeName)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Returns the encryption is supported. 
	/// - Parameter encryption: The `MediaEncryption` to check whether is supported 
	/// - Returns: a boolean indicating whether the encryption is supported 
	public func isMediaEncryptionSupported(encryption:MediaEncryption) -> Bool
	{
		return linphone_call_params_is_media_encryption_supported(cPtr, LinphoneMediaEncryption(rawValue: CUnsignedInt(encryption.rawValue))) != 0
	}

	/// Indicates whether tcap lines with consecutive indexes are going to be merged or
	/// not if capability negotiations (RFC5939) is enabled. 
	/// - Returns: a boolean indicating the enablement of tcap line merging 
	public func tcapLinesMerged() -> Bool
	{
		return linphone_call_params_tcap_lines_merged(cPtr) != 0
	}
}

/// This object carry various statistic informations regarding the quality of an
/// audio or video stream for a given `Call`. 
/// To receive these informations periodically and as soon as they are computed,
/// implement the call_stats_updated() callback inside a LinphoneCoreCbs.
/// At any time, the application can access latest computed statistics using
/// Call.getAudioStats() and Call.getVideoStats(). 
public class CallStats : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> CallStats {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<CallStats>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = CallStats(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get the bandwidth measurement of the received stream, expressed in kbit/s,
	/// including IP/UDP/RTP headers. 
	/// - Returns: The bandwidth measurement of the received stream in kbit/s. 
	public var downloadBandwidth: Float
	{
			return linphone_call_stats_get_download_bandwidth(cPtr)
	}

	/// Get the estimated bandwidth measurement of the received stream, expressed in
	/// kbit/s, including IP/UDP/RTP headers. 
	/// - Returns: The estimated bandwidth measurement of the received stream in
	/// kbit/s. 
	public var estimatedDownloadBandwidth: Float
	{
			return linphone_call_stats_get_estimated_download_bandwidth(cPtr)
	}

	/// Get the state of ICE processing. 
	/// - Returns: The `IceState` of ICE processing 
	public var iceState: IceState
	{
			return IceState(rawValue: Int(linphone_call_stats_get_ice_state(cPtr).rawValue))!
	}

	/// Get the IP address family of the remote peer. 
	/// - Returns: The IP address family `AddressFamily` of the remote peer. 
	public var ipFamilyOfRemote: AddressFamily
	{
			return AddressFamily(rawValue: Int(linphone_call_stats_get_ip_family_of_remote(cPtr).rawValue))!
	}

	/// Get the jitter buffer size in ms. 
	/// - Returns: The jitter buffer size in ms. 
	public var jitterBufferSizeMs: Float
	{
			return linphone_call_stats_get_jitter_buffer_size_ms(cPtr)
	}

	/// Gets the cumulative number of late packets. 
	/// - Returns: The cumulative number of late packets 
	public var latePacketsCumulativeNumber: UInt64
	{
			return linphone_call_stats_get_late_packets_cumulative_number(cPtr)
	}

	/// Gets the local late rate since last report. 
	/// - Returns: The local late rate 
	public var localLateRate: Float
	{
			return linphone_call_stats_get_local_late_rate(cPtr)
	}

	/// Get the local loss rate since last report. 
	/// - Returns: The local loss rate 
	public var localLossRate: Float
	{
			return linphone_call_stats_get_local_loss_rate(cPtr)
	}

	/// Gets the remote reported interarrival jitter. 
	/// - Returns: The interarrival jitter at last received receiver report 
	public var receiverInterarrivalJitter: Float
	{
			return linphone_call_stats_get_receiver_interarrival_jitter(cPtr)
	}

	/// Gets the remote reported loss rate since last report. 
	/// - Returns: The receiver loss rate 
	public var receiverLossRate: Float
	{
			return linphone_call_stats_get_receiver_loss_rate(cPtr)
	}

	/// Get the round trip delay in s. 
	/// - Returns: The round trip delay in s. 
	public var roundTripDelay: Float
	{
			return linphone_call_stats_get_round_trip_delay(cPtr)
	}

	/// Get the bandwidth measurement of the received RTCP, expressed in kbit/s,
	/// including IP/UDP/RTP headers. 
	/// - Returns: The bandwidth measurement of the received RTCP in kbit/s. 
	public var rtcpDownloadBandwidth: Float
	{
			return linphone_call_stats_get_rtcp_download_bandwidth(cPtr)
	}

	/// Get the bandwidth measurement of the sent RTCP, expressed in kbit/s, including
	/// IP/UDP/RTP headers. 
	/// - Returns: The bandwidth measurement of the sent RTCP in kbit/s. 
	public var rtcpUploadBandwidth: Float
	{
			return linphone_call_stats_get_rtcp_upload_bandwidth(cPtr)
	}

	/// Gets the local interarrival jitter. 
	/// - Returns: The interarrival jitter at last emitted sender report 
	public var senderInterarrivalJitter: Float
	{
			return linphone_call_stats_get_sender_interarrival_jitter(cPtr)
	}

	/// Get the local loss rate since last report. 
	/// - Returns: The sender loss rate 
	public var senderLossRate: Float
	{
			return linphone_call_stats_get_sender_loss_rate(cPtr)
	}

	/// Get the type of the stream the stats refer to. 
	/// - Returns: The `StreamType` the stats refer to 
	public var type: StreamType
	{
			return StreamType(rawValue: Int(linphone_call_stats_get_type(cPtr).rawValue))!
	}

	/// Get the bandwidth measurement of the sent stream, expressed in kbit/s,
	/// including IP/UDP/RTP headers. 
	/// - Returns: The bandwidth measurement of the sent stream in kbit/s. 
	public var uploadBandwidth: Float
	{
			return linphone_call_stats_get_upload_bandwidth(cPtr)
	}

	/// Get the state of uPnP processing. 
	/// - Returns: The `UpnpState` of uPnP processing. 
	public var upnpState: UpnpState
	{
			return UpnpState(rawValue: Int(linphone_call_stats_get_upnp_state(cPtr).rawValue))!
	}

	/// Gets the user data in the `CallStats` object. 
	/// - Returns: the user data.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_call_stats_get_user_data(cPtr)
		}
		set
		{
			linphone_call_stats_set_user_data(cPtr, newValue)
		}
	}
}

/// An chat message is the object that is sent or received through a `ChatRoom`. 
/// To create a `ChatMessage`, use ChatRoom.createEmptyMessage(), then either add
/// text using addUtf8TextContent() or a `Content` with file informations using
/// addFileContent(). A valid `Content` for file transfer must contain a type and
/// subtype, the name of the file and it's size. Finally call send() to send it.
/// To send files through a `ChatMessage`, you need to have configured a file
/// transfer server URL with Core.setFileTransferServer(). On the receiving side,
/// either use downloadContent() to download received files or enable auto-download
/// in the `Core` using Core.setMaxSizeForAutoDownloadIncomingFiles(), -1 disabling
/// the feature and 0 always downloading files no matter it's size.
/// Keep in mind a `ChatMessage` created by a `Basic` `ChatRoom` can only contain
/// one `Content`, either text or file. 
public class ChatMessage : LinphoneObject
{
	var delegateManagers : [ChatMessageDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> ChatMessage {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ChatMessage>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ChatMessage(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///`Direction` is used to indicate if a message is outgoing or incoming. 
	public enum Direction:Int
	{
		/// Incoming message. 
		case Incoming = 0
		/// Outgoing message. 
		case Outgoing = 1
	}

	///`State` is used to notify if messages have been successfully delivered or not. 
	public enum State:Int
	{
		/// Initial state. 
		case Idle = 0
		/// Delivery in progress. 
		case InProgress = 1
		/// Message successfully delivered and acknowledged by the server. 
		case Delivered = 2
		/// Message was not delivered. 
		case NotDelivered = 3
		/// Message was received and acknowledged but cannot get file from server. 
		case FileTransferError = 4
		/// File transfer has been completed successfully. 
		case FileTransferDone = 5
		/// Message successfully delivered an acknowledged by the remote user. 
		case DeliveredToUser = 6
		/// Message successfully displayed to the remote user. 
		case Displayed = 7
		case FileTransferInProgress = 8
	}

	/// An chat message is the object that is sent or received through a `ChatRoom`. 
	/// To create a `ChatMessage`, use ChatRoom.createEmptyMessage(), then either add
	/// text using addUtf8TextContent() or a `Content` with file informations using
	/// addFileContent(). A valid `Content` for file transfer must contain a type and
	/// subtype, the name of the file and it's size. Finally call send() to send it.
	/// To send files through a `ChatMessage`, you need to have configured a file
	/// transfer server URL with Core.setFileTransferServer(). On the receiving side,
	/// either use downloadContent() to download received files or enable auto-download
	/// in the `Core` using Core.setMaxSizeForAutoDownloadIncomingFiles(), -1 disabling
	/// the feature and 0 always downloading files no matter it's size.
	/// Keep in mind a `ChatMessage` created by a `Basic` `ChatRoom` can only contain
	/// one `Content`, either text or file. 
	public func addDelegate(delegate: ChatMessageDelegate)
	{
		let manager = ChatMessageDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_chat_message_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// An chat message is the object that is sent or received through a `ChatRoom`. 
	/// To create a `ChatMessage`, use ChatRoom.createEmptyMessage(), then either add
	/// text using addUtf8TextContent() or a `Content` with file informations using
	/// addFileContent(). A valid `Content` for file transfer must contain a type and
	/// subtype, the name of the file and it's size. Finally call send() to send it.
	/// To send files through a `ChatMessage`, you need to have configured a file
	/// transfer server URL with Core.setFileTransferServer(). On the receiving side,
	/// either use downloadContent() to download received files or enable auto-download
	/// in the `Core` using Core.setMaxSizeForAutoDownloadIncomingFiles(), -1 disabling
	/// the feature and 0 always downloading files no matter it's size.
	/// Keep in mind a `ChatMessage` created by a `Basic` `ChatRoom` can only contain
	/// one `Content`, either text or file. 
	public func removeDelegate(delegate: ChatMessageDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_chat_message_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Linphone message has an app-specific field that can store a text. 
	/// The application might want to use it for keeping data over restarts, like
	/// thumbnail image path. 
	/// - Returns: the application-specific data or nil if none has been stored.   
	public var appdata: String
	{
		get
		{
			let cPointer = linphone_chat_message_get_appdata(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_chat_message_set_appdata(cPtr, newValue)
		}
	}

	/// Gets the callId accociated with the message. 
	/// - Returns: the call Id   
	public var callId: String
	{
			let cPointer = linphone_chat_message_get_call_id(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns the chatroom this message belongs to. 
	/// - Returns: the `ChatRoom` in which this message has been sent or received.   
	public var chatRoom: ChatRoom?
	{
			let cPointer = linphone_chat_message_get_chat_room(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ChatRoom.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the content type of a chat message. 
	/// - Returns: The content type of the chat message   
	public var contentType: String
	{
		get
		{
			let cPointer = linphone_chat_message_get_content_type(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_chat_message_set_content_type(cPtr, newValue)
		}
	}

	/// Returns the list of contents in the message. 
	/// - Returns: The list of `Content`.    
	public var contents: [Content]
	{
			var swiftList = [Content]()
			let cList = linphone_chat_message_get_contents(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Content.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Returns back pointer to `Core` object. 
	/// - Returns: the `Core` object associated with this message.   
	public var core: Core?
	{
			let cPointer = linphone_chat_message_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Core.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the current LinphoneChatMessageCbs. 
	/// This is meant only to be called from a callback to be able to get the user_data
	/// associated with the LinphoneChatMessageCbs that is calling the callback. 
	/// - Returns: The LinphoneChatMessageCbs that has called the last callback.   
	public var currentDelegate: ChatMessageDelegate?
	{
			let cObject = linphone_chat_message_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<ChatMessageDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Returns the real time at which an ephemeral message expires and will be
	/// deleted. 
	/// - See also: isEphemeral() 
	/// - Returns: the time at which an ephemeral message expires. 0 means the message
	/// has not been read. 
	public var ephemeralExpireTime: time_t
	{
			return linphone_chat_message_get_ephemeral_expire_time(cPtr)
	}

	/// Returns lifetime of an ephemeral message. 
	/// The lifetime is the duration after which the ephemeral message will disappear
	/// once viewed. - See also: isEphemeral() 
	/// - Returns: the lifetime of an ephemeral message, by default 0 (disabled). 
	public var ephemeralLifetime: Int
	{
			return Int(linphone_chat_message_get_ephemeral_lifetime(cPtr))
	}

	/// Get full details about delivery error of a chat message. 
	/// - Returns: a `ErrorInfo` describing the details.   
	public var errorInfo: ErrorInfo?
	{
			let cPointer = linphone_chat_message_get_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ErrorInfo.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Linphone message can carry external body as defined by rfc2017. 
	/// - Returns: external body url or nil if not present.   
	public var externalBodyUrl: String
	{
		get
		{
			let cPointer = linphone_chat_message_get_external_body_url(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_chat_message_set_external_body_url(cPtr, newValue)
		}
	}

	/// Get the file_transfer_information (used by call backs to recover informations
	/// during a rcs file transfer) 
	/// - Returns: a pointer to the `Content` structure or nil if not present.   
	public var fileTransferInformation: Content?
	{
			let cPointer = linphone_chat_message_get_file_transfer_information(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Content.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the forward info if available as a string. 
	/// - Returns: the original sender of the message if it has been forwarded, nil
	/// otherwise.   
	public var forwardInfo: String
	{
			let cPointer = linphone_chat_message_get_forward_info(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get origin of the message. 
	/// - Returns: the `Address` of the sender.   
	public var fromAddress: Address?
	{
			let cPointer = linphone_chat_message_get_from_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns wether the chat message is an ephemeral message or not. 
	/// An ephemeral message will automatically disappear from the recipient's screen
	/// after the message has been viewed. 
	/// - Returns: true if it is an ephemeral message, false otherwise 
	public var isEphemeral: Bool
	{
			return linphone_chat_message_is_ephemeral(cPtr) != 0
	}

	/// Return whether or not a chat message is a file transfer. 
	/// - Returns: Whether or not the message is a file transfer 
	/// - deprecated: 06/07/2020 check if getContents() contains a `Content` for which
	/// Content.isFileTransfer() returns true. 
	@available(*, deprecated)
	public var isFileTransfer: Bool
	{
			return linphone_chat_message_is_file_transfer(cPtr) != 0
	}

	/// Gets whether or not a file is currently being downloaded or uploaded. 
	/// - Returns: true if download or upload is in progress, false otherwise 
	public var isFileTransferInProgress: Bool
	{
			return linphone_chat_message_is_file_transfer_in_progress(cPtr) != 0
	}

	/// Returns wether the chat message is a forward message or not. 
	/// - Returns: true if it is a forward message, false otherwise 
	public var isForward: Bool
	{
			return linphone_chat_message_is_forward(cPtr) != 0
	}

	/// Returns wehther the message has been sent or received. 
	/// - Returns: true if message has been sent, false if it has been received. 
	public var isOutgoing: Bool
	{
			return linphone_chat_message_is_outgoing(cPtr) != 0
	}

	/// Returns wether the message has been read or not. 
	/// - Returns: true if message has been marked as read, false otherwise. 
	public var isRead: Bool
	{
			return linphone_chat_message_is_read(cPtr) != 0
	}

	/// Returns wether the chat message is a reply message or not. 
	/// - Returns: true if it is a reply message, false otherwise 
	public var isReply: Bool
	{
			return linphone_chat_message_is_reply(cPtr) != 0
	}

	/// Get if the message was encrypted when transfered. 
	/// - Returns: true if the message was encrypted when transfered, false otherwise. 
	public var isSecured: Bool
	{
			return linphone_chat_message_is_secured(cPtr) != 0
	}

	/// Return whether or not a chat message is a text. 
	/// - Returns: Whether or not the message is a text 
	/// - deprecated: 06/07/2020 check if getContents() contains a `Content` with a
	/// PlainText content type. 
	@available(*, deprecated)
	public var isText: Bool
	{
			return linphone_chat_message_is_text(cPtr) != 0
	}

	/// Returns the local address the message was sent or received with. 
	/// - Returns: the `Address` of the local address used to send/receive this
	/// message.   
	public var localAddress: Address?
	{
			let cPointer = linphone_chat_message_get_local_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the message identifier. 
	/// It is used to identify a message so that it can be notified as delivered and/or
	/// displayed. 
	/// - Returns: The message identifier.   
	public var messageId: String
	{
			let cPointer = linphone_chat_message_get_message_id(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns the `ChatMessage` this message is a reply to. 
	/// - Returns: the original message `ChatMessage`.   
	public var replyMessage: ChatMessage?
	{
			let cPointer = linphone_chat_message_get_reply_message(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ChatMessage.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the ID of the message this is a reply to. 
	/// - Returns: the original message id.   
	public var replyMessageId: String
	{
			let cPointer = linphone_chat_message_get_reply_message_id(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns the ID of the message this is a reply to. 
	/// - Returns: the original message sender `Address`.   
	public var replyMessageSenderAddress: Address?
	{
			let cPointer = linphone_chat_message_get_reply_message_sender_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the state of the message. 
	/// - Returns: the current `State` of the message. 
	public var state: ChatMessage.State
	{
			return ChatMessage.State(rawValue: Int(linphone_chat_message_get_state(cPtr).rawValue))!
	}

	/// Gets the text content if available as a string. 
	/// - Returns: the `Content` buffer if available in System Locale, null otherwise. 
	///  
	/// - deprecated: 01/07/2020. Use getUtf8Text() instead. 
	@available(*, deprecated)
	public var textContent: String
	{
			let cPointer = linphone_chat_message_get_text_content(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the time the message was sent. 
	/// - Returns: the timestamp of when the message was sent. 
	public var time: time_t
	{
			return linphone_chat_message_get_time(cPtr)
	}

	/// Get destination of the message. 
	/// - Returns: the `Address` of the recipient.   
	public var toAddress: Address?
	{
			let cPointer = linphone_chat_message_get_to_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get if a chat message is to be stored. 
	/// - Returns: Whether or not the message is to be stored 
	public var toBeStored: Bool
	{
		get
		{
			return linphone_chat_message_get_to_be_stored(cPtr) != 0
		}
		set
		{
			linphone_chat_message_set_to_be_stored(cPtr, newValue==true ? 1:0)
		}
	}

	/// Retrieve the user pointer associated with the chat message. 
	/// - Returns: The user pointer associated with the chat message.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_chat_message_get_user_data(cPtr)
		}
		set
		{
			linphone_chat_message_set_user_data(cPtr, newValue)
		}
	}

	/// Get text part of this message. 
	/// Introduced in 01/07/2020 
	/// - Returns: The text in UTF8 or nil if no text.   
	public var utf8Text: String
	{
		get
		{
			let cPointer = linphone_chat_message_get_utf8_text(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_chat_message_set_utf8_text(cPtr, newValue)
		}
	}

	/// Adds a content to the ChatMessage. 
	/// - Parameter content: the `Content` object to add.   
	public func addContent(content:Content) 
	{
		linphone_chat_message_add_content(cPtr, content.cPtr)
	}

	/// Add custom headers to the message. 
	/// - Parameter headerName: name of the header   
	/// - Parameter headerValue: header value   
	public func addCustomHeader(headerName:String, headerValue:String?) 
	{
		linphone_chat_message_add_custom_header(cPtr, headerName, headerValue)
	}

	/// Adds a file content to the ChatMessage. 
	/// - Parameter content: the `Content` object to add.   
	public func addFileContent(content:Content) 
	{
		linphone_chat_message_add_file_content(cPtr, content.cPtr)
	}

	/// Creates a `Content` of type PlainText with the given text as body. 
	/// - Parameter text: The text in System Locale to add to the message.   
	/// - deprecated: 01/07/2020. Use addUtf8TextContent() instead. 
	@available(*, deprecated)
	public func addTextContent(text:String) 
	{
		linphone_chat_message_add_text_content(cPtr, text)
	}

	/// Creates a `Content` of type PlainText with the given text as body. 
	/// Introduced in 01/07/2020 
	/// - Parameter text: The text in UTF8 to add to the message.   
	public func addUtf8TextContent(text:String) 
	{
		linphone_chat_message_add_utf8_text_content(cPtr, text)
	}

	/// Cancel an ongoing file transfer attached to this message. 
	/// (upload or download) 
	public func cancelFileTransfer() 
	{
		linphone_chat_message_cancel_file_transfer(cPtr)
	}

	/// Start the download of the `Content` referenced in the `ChatMessage` from remote
	/// server. 
	/// - Parameter content: the `Content` object to download (must have the
	/// Content.isFileTransfer() method return true).   
	/// - Returns: false if there is an error, true otherwise. 
	public func downloadContent(content:Content) -> Bool
	{
		return linphone_chat_message_download_content(cPtr, content.cPtr) != 0
	}

	/// Retrieve a custom header value given its name. 
	/// - Parameter headerName: header name searched   
	/// - Returns: the custom header value or nil if not found.   
	public func getCustomHeader(headerName:String) -> String
	{
		let cstr = linphone_chat_message_get_custom_header(cPtr, headerName)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Gets the list of participants for which the imdn state has reached the
	/// specified state and the time at which they did. 
	/// - Parameter state: The LinphoneChatMessageState the imdn have reached (only use
	/// LinphoneChatMessageStateDelivered, LinphoneChatMessageStateDeliveredToUser,
	/// LinphoneChatMessageStateDisplayed and LinphoneChatMessageStateNotDelivered) 
	/// - Returns: The list of participants.      
	public func getParticipantsByImdnState(state:ChatMessage.State) -> [ParticipantImdnState]
	{
		var swiftList = [ParticipantImdnState]()
		let cList = linphone_chat_message_get_participants_by_imdn_state(cPtr, LinphoneChatMessageState(rawValue: CUnsignedInt(state.rawValue)))
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(ParticipantImdnState.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Returns wether the chat message has a text content or not. 
	/// - Returns: true if it has one, false otherwise. 
	/// - deprecated: 27/10/2020. Check if getContents() contains a `Content` for which
	/// it's content type is PlainText. 
	@available(*, deprecated)
	public func hasTextContent() -> Bool
	{
		return linphone_chat_message_has_text_content(cPtr) != 0
	}

	/// Fulfill a chat message char by char. 
	/// Message linked to a Real Time Text Call send char in realtime following RFC
	/// 4103/T.140 To commit a message, use linphone_chat_room_send_message 
	/// - Parameter character: T.140 char 
	/// - Returns: 0 if succeed. 
	public func putChar(character:UInt32) throws 
	{
		let exception_result = linphone_chat_message_put_char(cPtr, character)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "putChar returned value \(exception_result)")
		}
	}

	/// Removes a content from the ChatMessage. 
	/// - Parameter content: the `Content` object to remove.   
	public func removeContent(content:Content) 
	{
		linphone_chat_message_remove_content(cPtr, content.cPtr)
	}

	/// Removes a custom header from the message. 
	/// - Parameter headerName: name of the header to remove   
	public func removeCustomHeader(headerName:String) 
	{
		linphone_chat_message_remove_custom_header(cPtr, headerName)
	}

	/// Send a chat message. 
	public func send() 
	{
		linphone_chat_message_send(cPtr)
	}
}

/// A chat room is the place where `ChatMessage` are exchanged. 
/// To create (or find) a `ChatRoom`, you first need a `ChatRoomParams` object. A
/// chat room is uniquely identified by it's local and remote SIP addresses,
/// meaning you can only have one chat room between two accounts (unless the
/// backend is `FlexisipChat`). Then you can call Core.searchChatRoom() or
/// Core.createChatRoom().
/// Be careful as a `FlexisipChat` backend `ChatRoom` will be created
/// asynchronously, so make sure you add a LinphoneChatRoomCbs to the returned
/// object to be notified when it will be in state `Created`.
/// All chat rooms are loaded from database when the `Core` starts, and you can get
/// them using Core.getChatRooms(). This method doesn't return empty chat rooms nor
/// ones for which the local address doesn't match an existing `ProxyConfig`
/// identity, unless you specify otherwise in the [misc] section of your
/// configuration file by setting hide_empty_chat_rooms=0 and/or
/// hide_chat_rooms_from_removed_proxies=0. 
public class ChatRoom : LinphoneObject
{
	var delegateManagers : [ChatRoomDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> ChatRoom {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ChatRoom>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ChatRoom(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///`State` is used to indicate the current state of a chat room. 
	public enum State:Int
	{
		/// Initial state. 
		case None = 0
		/// Chat room is now instantiated on local. 
		case Instantiated = 1
		/// One creation request was sent to the server. 
		case CreationPending = 2
		/// Chat room was created on the server. 
		case Created = 3
		/// Chat room creation failed. 
		case CreationFailed = 4
		/// Wait for chat room termination. 
		case TerminationPending = 5
		/// Chat room exists on server but not in local. 
		case Terminated = 6
		/// The chat room termination failed. 
		case TerminationFailed = 7
		/// Chat room was deleted on the server. 
		case Deleted = 8
	}

	/// A chat room is the place where `ChatMessage` are exchanged. 
	/// To create (or find) a `ChatRoom`, you first need a `ChatRoomParams` object. A
	/// chat room is uniquely identified by it's local and remote SIP addresses,
	/// meaning you can only have one chat room between two accounts (unless the
	/// backend is `FlexisipChat`). Then you can call Core.searchChatRoom() or
	/// Core.createChatRoom().
	/// Be careful as a `FlexisipChat` backend `ChatRoom` will be created
	/// asynchronously, so make sure you add a LinphoneChatRoomCbs to the returned
	/// object to be notified when it will be in state `Created`.
	/// All chat rooms are loaded from database when the `Core` starts, and you can get
	/// them using Core.getChatRooms(). This method doesn't return empty chat rooms nor
	/// ones for which the local address doesn't match an existing `ProxyConfig`
	/// identity, unless you specify otherwise in the [misc] section of your
	/// configuration file by setting hide_empty_chat_rooms=0 and/or
	/// hide_chat_rooms_from_removed_proxies=0. 
	public func addDelegate(delegate: ChatRoomDelegate)
	{
		let manager = ChatRoomDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_chat_room_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// A chat room is the place where `ChatMessage` are exchanged. 
	/// To create (or find) a `ChatRoom`, you first need a `ChatRoomParams` object. A
	/// chat room is uniquely identified by it's local and remote SIP addresses,
	/// meaning you can only have one chat room between two accounts (unless the
	/// backend is `FlexisipChat`). Then you can call Core.searchChatRoom() or
	/// Core.createChatRoom().
	/// Be careful as a `FlexisipChat` backend `ChatRoom` will be created
	/// asynchronously, so make sure you add a LinphoneChatRoomCbs to the returned
	/// object to be notified when it will be in state `Created`.
	/// All chat rooms are loaded from database when the `Core` starts, and you can get
	/// them using Core.getChatRooms(). This method doesn't return empty chat rooms nor
	/// ones for which the local address doesn't match an existing `ProxyConfig`
	/// identity, unless you specify otherwise in the [misc] section of your
	/// configuration file by setting hide_empty_chat_rooms=0 and/or
	/// hide_chat_rooms_from_removed_proxies=0. 
	public func removeDelegate(delegate: ChatRoomDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_chat_room_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Converts a `State` enum to a string. 
	/// - Parameter state: a `State` to convert to string 
	/// - Returns: the string representation of the `State`   
	static public func stateToString(state:ChatRoom.State) -> String
	{
		let cstr = linphone_chat_room_state_to_string(LinphoneChatRoomState(rawValue: CUnsignedInt(state.rawValue)))
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Gets the current call associated to this chatroom if any To commit a message,
	/// use linphone_chat_room_send_message 
	/// - Returns: `Call` or nil.   
	public var call: Call?
	{
			let cPointer = linphone_chat_room_get_call(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Call.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the capabilities of a chat room. 
	/// - Returns: The capabilities of the chat room (as a
	/// LinphoneChatRoomCapabilitiesMask) 
	public var capabilities: UInt
	{
			return UInt(linphone_chat_room_get_capabilities(cPtr))
	}

	/// When realtime text is enabled CallParams.realtimeTextEnabled(),
	/// LinphoneCoreIsComposingReceivedCb is call everytime a char is received from
	/// peer. 
	/// At the end of remote typing a regular `ChatMessage` is received with committed
	/// data from LinphoneCoreMessageReceivedCb. 
	/// - Returns: RFC 4103/T.140 char 
	public var char: UInt32
	{
			return linphone_chat_room_get_char(cPtr)
	}

	/// Gets the list of participants that are currently composing. 
	/// - Returns: List of addresses that are in the is_composing state.  
	public var composingAddresses: [Address]
	{
			var swiftList = [Address]()
			let cList = linphone_chat_room_get_composing_addresses(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Address.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Get the conference address of the chat room. 
	/// - Returns: The conference address of the chat room or nil if this type of chat
	/// room is not conference based.   
	public var conferenceAddress: Address?
	{
		get
		{
			let cPointer = linphone_chat_room_get_conference_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_chat_room_set_conference_address(cPtr, newValue?.cPtr)
		}
	}

	/// Returns back pointer to `Core` object. 
	/// - Returns: the `Core` object this chat room is attached to.   
	public var core: Core?
	{
			let cPointer = linphone_chat_room_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Core.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Return the creation time for the chat room. 
	/// - Returns: the time at which the chat room was created 
	public var creationTime: time_t
	{
			return linphone_chat_room_get_creation_time(cPtr)
	}

	/// Gets the current LinphoneChatRoomCbs. 
	/// This is meant only to be called from a callback to be able to get the user_data
	/// associated with the LinphoneChatRoomCbs that is calling the callback. 
	/// - Returns: The LinphoneChatRoomCbs that has called the last callback   
	public var currentDelegate: ChatRoomDelegate?
	{
			let cObject = linphone_chat_room_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<ChatRoomDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Returns current parameters associated with the chat room. 
	/// This is typically the parameters passed at chat room chat_roomeation to
	/// linphone_core_chat_roomeate_chat_room() or some default parameters if no
	/// `ChatRoomParams` was explicitely passed during chat room chat_roomeation. 
	/// - Returns: the current `ChatRoomParams` parameters.   
	public var currentParams: ChatRoomParams?
	{
			let cPointer = linphone_chat_room_get_current_params(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ChatRoomParams.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns whether or not the ephemeral message feature is enabled in the chat
	/// room. 
	/// - Returns: true if ephemeral is enabled, false otherwise. 
	public var ephemeralEnabled: Bool
	{
		get
		{
			return linphone_chat_room_ephemeral_enabled(cPtr) != 0
		}
		set
		{
			linphone_chat_room_enable_ephemeral(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get lifetime (in seconds) for all new ephemeral messages in the chat room. 
	/// After the message is read, it will be deleted after "time" seconds. - See also:
	/// ephemeralEnabled() 
	/// - Returns: the ephemeral lifetime (in secoonds) 
	public var ephemeralLifetime: Int
	{
		get
		{
			return Int(linphone_chat_room_get_ephemeral_lifetime(cPtr))
		}
		set
		{
			linphone_chat_room_set_ephemeral_lifetime(cPtr, (newValue))
		}
	}

	/// Get the ephemeral mode of the chat room. 
	/// - See also: ephemeralEnabled() 
	/// - Returns: the ephemeral mode `ChatRoomEphemeralMode` 
	public var ephemeralMode: ChatRoomEphemeralMode
	{
		get
		{
			return ChatRoomEphemeralMode(rawValue: Int(linphone_chat_room_get_ephemeral_mode(cPtr).rawValue))!
		}
		set
		{
			linphone_chat_room_set_ephemeral_mode(cPtr, LinphoneChatRoomEphemeralMode(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Gets the number of events in a chat room. 
	/// - Returns: the number of events. 
	public var historyEventsSize: Int
	{
			return Int(linphone_chat_room_get_history_events_size(cPtr))
	}

	/// Gets the number of messages in a chat room. 
	/// - Returns: the number of messages. 
	public var historySize: Int
	{
			return Int(linphone_chat_room_get_history_size(cPtr))
	}

	/// Returns whether or not a `ChatRoom` has at least one `ChatMessage` or not. 
	/// - Returns: true if there are no `ChatMessage`, false otherwise. 
	public var isEmpty: Bool
	{
			return linphone_chat_room_is_empty(cPtr) != 0
	}

	/// Return whether or not a message can be sent using this chat room. 
	/// A chat room may be read only until it's created, or when it's a group you have
	/// left. 
	/// - Returns: true if a chat message can't be sent in it, false otherwise. 
	public var isReadOnly: Bool
	{
			return linphone_chat_room_is_read_only(cPtr) != 0
	}

	/// Tells whether the remote is currently composing a message. 
	/// - Returns: true if the remote is currently composing a message, false
	/// otherwise. 
	public var isRemoteComposing: Bool
	{
			return linphone_chat_room_is_remote_composing(cPtr) != 0
	}

	/// Gets the last chat message sent or received in this chat room. 
	/// - Returns: the latest `ChatMessage` or nil if no message.   
	public var lastMessageInHistory: ChatMessage?
	{
			let cPointer = linphone_chat_room_get_last_message_in_history(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ChatMessage.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Return the last updated time for the chat room. 
	/// - Returns: the last updated time 
	public var lastUpdateTime: time_t
	{
			return linphone_chat_room_get_last_update_time(cPtr)
	}

	/// Get the local address associated to this chat room. 
	/// - Returns: The local address.   
	public var localAddress: Address?
	{
			let cPointer = linphone_chat_room_get_local_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the participant representing myself in the chat room. 
	/// - Returns: The participant representing myself in the conference or nil if me
	/// is not set.   
	public var me: Participant?
	{
			let cPointer = linphone_chat_room_get_me(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Participant.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the number of participants in the chat room (that is without ourselves). 
	/// - Returns: The number of participants in the chat room 
	public var nbParticipants: Int
	{
			return Int(linphone_chat_room_get_nb_participants(cPtr))
	}

	/// Get the list of participants of a chat room. 
	/// - Returns: A  of the participants 
	public var participants: [Participant]
	{
			var swiftList = [Participant]()
			let cList = linphone_chat_room_get_participants(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Participant.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Get the peer address associated to this chat room. 
	/// - Returns: The peer address.   
	public var peerAddress: Address?
	{
			let cPointer = linphone_chat_room_get_peer_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the security level of a chat room. 
	/// - Returns: The current `ChatRoomSecurityLevel` of the chat room 
	public var securityLevel: ChatRoomSecurityLevel
	{
			return ChatRoomSecurityLevel(rawValue: Int(linphone_chat_room_get_security_level(cPtr).rawValue))!
	}

	/// Get the state of the chat room. 
	/// - Returns: The current `State` of the chat room 
	public var state: ChatRoom.State
	{
			return ChatRoom.State(rawValue: Int(linphone_chat_room_get_state(cPtr).rawValue))!
	}

	/// Get the subject of a chat room. 
	/// - Returns: The subject of the chat room.   
	public var subject: String
	{
		get
		{
			let cPointer = linphone_chat_room_get_subject(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_chat_room_set_subject(cPtr, newValue)
		}
	}

	/// Gets all unread messages for this chat room, sorted from oldest to most recent. 
	/// - Returns: A list of unread chat messages.    
	public var unreadHistory: [ChatMessage]
	{
			var swiftList = [ChatMessage]()
			let cList = linphone_chat_room_get_unread_history(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(ChatMessage.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Gets the number of unread messages in the chatroom. 
	/// - Returns: the number of unread messages. 
	public var unreadMessagesCount: Int
	{
			return Int(linphone_chat_room_get_unread_messages_count(cPtr))
	}

	/// Retrieve the user pointer associated with the chat room. 
	/// - Returns: The user pointer associated with the chat room.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_chat_room_get_user_data(cPtr)
		}
		set
		{
			linphone_chat_room_set_user_data(cPtr, newValue)
		}
	}

	/// Add a participant to a chat room. 
	/// This may fail if this type of chat room does not handle participants. Use
	/// canHandleParticipants() to know if this chat room handles participants. 
	/// - Parameter addr: The address of the participant to add to the chat room   
	public func addParticipant(addr:Address) 
	{
		linphone_chat_room_add_participant(cPtr, addr.cPtr)
	}

	/// Add several participants to a chat room at once. 
	/// This may fail if this type of chat room does not handle participants. Use
	/// canHandleParticipants() to know if this chat room handles participants. 
	/// - Parameter addresses: The participants to add.    
	/// - Returns: true if everything is OK, false otherwise 
	public func addParticipants(addresses:[Address]) -> Bool
	{
		return linphone_chat_room_add_participants(cPtr, ObjectArrayToBctbxList(list: addresses)) != 0
	}

	/// Allow cpim on a basic chat room   . 
	public func allowCpim() 
	{
		linphone_chat_room_allow_cpim(cPtr)
	}

	/// Allow multipart on a basic chat room   . 
	public func allowMultipart() 
	{
		linphone_chat_room_allow_multipart(cPtr)
	}

	/// Tells whether a chat room is able to handle participants. 
	/// - Returns: true if the chat room can handle participants, false otherwise 
	public func canHandleParticipants() -> Bool
	{
		return linphone_chat_room_can_handle_participants(cPtr) != 0
	}

	/// Notifies the destination of the chat message being composed that the user is
	/// typing a new message. 
	public func compose() 
	{
		linphone_chat_room_compose(cPtr)
	}

	/// Creates an empty message attached to the given chat room. 
	/// - Returns: a new `ChatMessage`   
	public func createEmptyMessage() throws -> ChatMessage
	{
		let cPointer = linphone_chat_room_create_empty_message(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatMessage value")
		}
		let result = ChatMessage.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates a message attached to the given chat room with a particular content. 
	/// Use linphone_chat_room_send_message to initiate the transfer 
	/// - Parameter initialContent: `Content` initial content.   
	/// - Returns: a new `ChatMessage`   
	public func createFileTransferMessage(initialContent:Content) throws -> ChatMessage
	{
		let cPointer = linphone_chat_room_create_file_transfer_message(cPtr, initialContent.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatMessage value")
		}
		let result = ChatMessage.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates a forward message attached to the given chat room with a particular
	/// message. 
	/// - Parameter message: `ChatMessage` message to be forwarded.   
	/// - Returns: a new `ChatMessage`   
	public func createForwardMessage(message:ChatMessage) throws -> ChatMessage
	{
		let cPointer = linphone_chat_room_create_forward_message(cPtr, message.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatMessage value")
		}
		let result = ChatMessage.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates a message attached to the given chat room with a plain text content
	/// filled with the given message. 
	/// - Parameter message: text message, nil if absent.   
	/// - Returns: a new `ChatMessage`   
	/// - deprecated: 01/07/2020. Use createMessageFromUtf8() instead. 
	@available(*, deprecated)
	public func createMessage(message:String?) throws -> ChatMessage
	{
		let cPointer = linphone_chat_room_create_message(cPtr, message)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatMessage value")
		}
		let result = ChatMessage.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates a message attached to the given chat room with a plain text content
	/// filled with the given message. 
	/// Introduced in 01/07/2020 
	/// - Parameter message: text message in UTF8, nil if absent.   
	/// - Returns: a new `ChatMessage`   
	public func createMessageFromUtf8(message:String?) throws -> ChatMessage
	{
		let cPointer = linphone_chat_room_create_message_from_utf8(cPtr, message)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatMessage value")
		}
		let result = ChatMessage.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates a reply message attached to the given chat room with a particular
	/// message. 
	/// - Parameter message: `ChatMessage` message to reply to.   
	/// - Returns: a new `ChatMessage`   
	public func createReplyMessage(message:ChatMessage) throws -> ChatMessage
	{
		let cPointer = linphone_chat_room_create_reply_message(cPtr, message.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatMessage value")
		}
		let result = ChatMessage.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates a chat message with a voice recording attached to the given chat room. 
	/// - Warning: If the recorder isn't in Closed state, it will return an empty
	/// message! 
	/// - Parameter recorder: the `Recorder` object used to record the voice message.   
	/// - Returns: a new `ChatMessage`   
	public func createVoiceRecordingMessage(recorder:Recorder) throws -> ChatMessage
	{
		let cPointer = linphone_chat_room_create_voice_recording_message(cPtr, recorder.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatMessage value")
		}
		let result = ChatMessage.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Delete all messages from the history. 
	public func deleteHistory() 
	{
		linphone_chat_room_delete_history(cPtr)
	}

	/// Delete a message from the chat room history. 
	/// - Parameter message: The `ChatMessage` object to remove.   
	public func deleteMessage(message:ChatMessage) 
	{
		linphone_chat_room_delete_message(cPtr, message.cPtr)
	}

	/// Uses linphone spec to check if all participants support ephemeral messages. 
	/// It doesn't prevent to send ephemeral messages in the room but those who don't
	/// support it won't delete messages after lifetime has expired. - See also:
	/// ephemeralEnabled() 
	/// - Returns: true if all participants in the chat room support ephemeral
	/// messages, false otherwise 
	public func ephemeralSupportedByAllParticipants() -> Bool
	{
		return linphone_chat_room_ephemeral_supported_by_all_participants(cPtr) != 0
	}

	/// Gets the chat message sent or received in this chat room that matches the
	/// message_id. 
	/// - Parameter messageId: The id of the message to find   
	/// - Returns: the `ChatMessage` if found or nil.   
	public func findMessage(messageId:String) -> ChatMessage?
	{
		let cPointer = linphone_chat_room_find_message(cPtr, messageId)
		if (cPointer == nil) {
			return nil
		}
		let result = ChatMessage.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Find a participant of a chat room from its address. 
	/// - Parameter address: The `Address` to search in the list of participants of the
	/// chat room   
	/// - Returns: The participant if found, nil otherwise.   
	public func findParticipant(address:Address) -> Participant?
	{
		let cPointer = linphone_chat_room_find_participant(cPtr, address.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Participant.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Gets nb_message most recent messages from chat_room chat room, sorted from
	/// oldest to most recent. 
	/// - Parameter nbMessage: Number of message to retrieve. 0 means everything. 
	/// - Returns: A list of chat messages.    
	public func getHistory(nbMessage:Int) -> [ChatMessage]
	{
		var swiftList = [ChatMessage]()
		let cList = linphone_chat_room_get_history(cPtr, CInt(nbMessage))
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(ChatMessage.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Gets nb_events most recent events from chat_room chat room, sorted from oldest
	/// to most recent. 
	/// - Parameter nbEvents: Number of events to retrieve. 0 means everything. 
	/// - Returns: The list of the most recent events.    
	public func getHistoryEvents(nbEvents:Int) -> [EventLog]
	{
		var swiftList = [EventLog]()
		let cList = linphone_chat_room_get_history_events(cPtr, CInt(nbEvents))
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(EventLog.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Gets nb_events most recent chat message events from chat_room chat room, sorted
	/// from oldest to most recent. 
	/// - Parameter nbEvents: Number of events to retrieve. 0 means everything. 
	/// - Returns: A list    
	public func getHistoryMessageEvents(nbEvents:Int) -> [EventLog]
	{
		var swiftList = [EventLog]()
		let cList = linphone_chat_room_get_history_message_events(cPtr, CInt(nbEvents))
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(EventLog.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Gets the partial list of messages in the given range, sorted from oldest to
	/// most recent. 
	/// - Parameter begin: The first message of the range to be retrieved. History most
	/// recent message has index 0. 
	/// - Parameter end: The last message of the range to be retrieved. History oldest
	/// message has index of history size - 1 (use getHistorySize() to retrieve history
	/// size) 
	/// - Returns: A list of chat messages.    
	public func getHistoryRange(begin:Int, end:Int) -> [ChatMessage]
	{
		var swiftList = [ChatMessage]()
		let cList = linphone_chat_room_get_history_range(cPtr, CInt(begin), CInt(end))
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(ChatMessage.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Gets the partial list of events in the given range, sorted from oldest to most
	/// recent. 
	/// - Parameter begin: The first event of the range to be retrieved. History most
	/// recent event has index 0. 
	/// - Parameter end: The last event of the range to be retrieved. History oldest
	/// event has index of history size - 1 
	/// - Returns: The list of the found events.    
	public func getHistoryRangeEvents(begin:Int, end:Int) -> [EventLog]
	{
		var swiftList = [EventLog]()
		let cList = linphone_chat_room_get_history_range_events(cPtr, CInt(begin), CInt(end))
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(EventLog.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Gets the partial list of chat message events in the given range, sorted from
	/// oldest to most recent. 
	/// - Parameter begin: The first event of the range to be retrieved. History most
	/// recent event has index 0. 
	/// - Parameter end: The last event of the range to be retrieved. History oldest
	/// event has index of history size - 1 
	/// - Returns: The list of chat message events.    
	public func getHistoryRangeMessageEvents(begin:Int, end:Int) -> [EventLog]
	{
		var swiftList = [EventLog]()
		let cList = linphone_chat_room_get_history_range_message_events(cPtr, CInt(begin), CInt(end))
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(EventLog.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Return whether or not the chat room has been left. 
	/// - Returns: true if the chat room has been left, false otherwise. 
	/// - deprecated: 16/03/2022 use isReadOnly() instead. 
	@available(*, deprecated)
	public func hasBeenLeft() -> Bool
	{
		return linphone_chat_room_has_been_left(cPtr) != 0
	}

	/// Check if a chat room has given capabilities. 
	/// - Parameter mask: a LinphoneChatRoomCapabilitiesMask mask 
	/// - Returns: true if the mask matches, false otherwise 
	public func hasCapability(mask:Int) -> Bool
	{
		return linphone_chat_room_has_capability(cPtr, CInt(mask)) != 0
	}

	/// Leave a chat room. 
	public func leave() 
	{
		linphone_chat_room_leave(cPtr)
	}

	/// Returns wether lime is available for given peer or not. 
	public func limeAvailable() -> Bool
	{
		return linphone_chat_room_lime_available(cPtr) != 0
	}

	/// Mark all messages of the conversation as read. 
	public func markAsRead() 
	{
		linphone_chat_room_mark_as_read(cPtr)
	}

	/// Notify the chatroom that a participant device has just registered. 
	/// This function is meaningful only for server implementation of chatroom, and
	/// shall not by used by client applications. 
	/// - Parameter participantDevice: list of the participant devices to be used by
	/// the group chat room   
	public func notifyParticipantDeviceRegistration(participantDevice:Address) 
	{
		linphone_chat_room_notify_participant_device_registration(cPtr, participantDevice.cPtr)
	}

	/// Used to receive a chat message when using async mechanism with IM
	/// enchat_roomyption engine. 
	/// - Parameter message: `ChatMessage` object   
	public func receiveChatMessage(message:ChatMessage) 
	{
		linphone_chat_room_receive_chat_message(cPtr, message.cPtr)
	}

	/// Remove a participant of a chat room. 
	/// - Parameter participant: The participant to remove from the chat room   
	public func removeParticipant(participant:Participant) 
	{
		linphone_chat_room_remove_participant(cPtr, participant.cPtr)
	}

	/// Remove several participants of a chat room at once. 
	/// - Parameter participants: The participants to remove.    
	public func removeParticipants(participants:[Participant]) 
	{
		linphone_chat_room_remove_participants(cPtr, ObjectArrayToBctbxList(list: participants))
	}

	/// Change the admin status of a participant of a chat room (you need to be an
	/// admin yourself to do this). 
	/// - Parameter participant: The Participant for which to change the admin status   
	/// - Parameter isAdmin: A boolean value telling whether the participant should now
	/// be an admin or not 
	public func setParticipantAdminStatus(participant:Participant, isAdmin:Bool) 
	{
		linphone_chat_room_set_participant_admin_status(cPtr, participant.cPtr, isAdmin==true ? 1:0)
	}

	/// Set the list of participant devices in the form of SIP URIs with GRUUs for a
	/// given participant. 
	/// This function is meaningful only for server implementation of chatroom, and
	/// shall not by used by client applications. 
	/// - Parameter participantAddress: The participant address   
	/// - Parameter deviceIdentities: List of the participant devices to be used by the
	/// group chat room    
	public func setParticipantDevices(participantAddress:Address, deviceIdentities:[ParticipantDeviceIdentity]) 
	{
		linphone_chat_room_set_participant_devices(cPtr, participantAddress.cPtr, ObjectArrayToBctbxList(list: deviceIdentities))
	}
}

/// Object defining parameters for a `ChatRoom`. 
/// Can be created with Core.createDefaultChatRoomParams(). You can use isValid()
/// to check if your configuration is valid or not.
/// If the `ChatRoom` backend is `Basic`, then no other parameter is required, but
/// `ChatMessage` sent and received won't benefit from all features a
/// `FlexisipChat` can offer like conversation with multiple participants and a
/// subject, end-to-end encryption, ephemeral messages, etc... but this type is the
/// only one that can interoperate with other SIP clients or with non-flexisip SIP
/// proxies. 
public class ChatRoomParams : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> ChatRoomParams {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ChatRoomParams>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ChatRoomParams(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get the backend implementation of the chat room associated with the given
	/// parameters. 
	/// - Returns: the `ChatRoomBackend` 
	public var backend: ChatRoomBackend
	{
		get
		{
			return ChatRoomBackend(rawValue: Int(linphone_chat_room_params_get_backend(cPtr).rawValue))
		}
		set
		{
			linphone_chat_room_params_set_backend(cPtr, LinphoneChatRoomBackend(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get the encryption implementation of the chat room associated with the given
	/// parameters. 
	/// - Returns: the `ChatRoomEncryptionBackend` 
	public var encryptionBackend: ChatRoomEncryptionBackend
	{
		get
		{
			return ChatRoomEncryptionBackend(rawValue: Int(linphone_chat_room_params_get_encryption_backend(cPtr).rawValue))
		}
		set
		{
			linphone_chat_room_params_set_encryption_backend(cPtr, LinphoneChatRoomEncryptionBackend(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get the encryption status of the chat room associated with the given
	/// parameters. 
	/// - Returns: true if encryption is enabled, false otherwise 
	public var encryptionEnabled: Bool
	{
		get
		{
			return linphone_chat_room_params_encryption_enabled(cPtr) != 0
		}
		set
		{
			linphone_chat_room_params_enable_encryption(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get lifetime (in seconds) for all new ephemeral messages in the chat room. 
	/// After the message is read, it will be deleted after "time" seconds. - See also:
	/// linphone_chat_room_params_ephemeral_enabled() 
	/// - Returns: the ephemeral lifetime (in seconds) 
	public var ephemeralLifetime: Int
	{
		get
		{
			return Int(linphone_chat_room_params_get_ephemeral_lifetime(cPtr))
		}
		set
		{
			linphone_chat_room_params_set_ephemeral_lifetime(cPtr, (newValue))
		}
	}

	/// Get the ephemeral message mode of the chat room associated with the given
	/// parameters. 
	/// - Returns: the ephemeral message mode `ChatRoomEphemeralMode` 
	public var ephemeralMode: ChatRoomEphemeralMode
	{
		get
		{
			return ChatRoomEphemeralMode(rawValue: Int(linphone_chat_room_params_get_ephemeral_mode(cPtr).rawValue))!
		}
		set
		{
			linphone_chat_room_params_set_ephemeral_mode(cPtr, LinphoneChatRoomEphemeralMode(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get the group chat status of the chat room associated with the given
	/// parameters. 
	/// - Returns: true if group chat is enabled, false if one-to-one 
	public var groupEnabled: Bool
	{
		get
		{
			return linphone_chat_room_params_group_enabled(cPtr) != 0
		}
		set
		{
			linphone_chat_room_params_enable_group(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns whether the given parameters are valid or not. 
	/// - Returns: true if the given parameters are valid, false otherwise 
	public var isValid: Bool
	{
			return linphone_chat_room_params_is_valid(cPtr) != 0
	}

	/// Get the real time text status of the chat room associated with the given
	/// parameters. 
	/// - Returns: true if real time text is enabled, false otherwise 
	public var rttEnabled: Bool
	{
		get
		{
			return linphone_chat_room_params_rtt_enabled(cPtr) != 0
		}
		set
		{
			linphone_chat_room_params_enable_rtt(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the subject of the chat room. 
	/// - Returns: The subject.   
	public var subject: String
	{
		get
		{
			let cPointer = linphone_chat_room_params_get_subject(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_chat_room_params_set_subject(cPtr, newValue)
		}
	}
}

/// A conference is the object that allow to make calls when there are 2 or more
/// participants. 
/// To create (or find) a `Conference`, you first need a `ConferenceParams` object.
/// Core.createConferenceWithParams() allows you to create a conference. A
/// conference is uniquely identified by a conference address, meaning you can have
/// more than one conference between two accounts. As of now, each `Core` can host
/// only 1 conference but it can be part of many conferences as a remote
/// participant. To find a conference among those a core is part of, you can call
/// Core.searchConference(). 
public class Conference : LinphoneObject
{
	var delegateManagers : [ConferenceDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> Conference {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Conference>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Conference(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///`State` is used to indicate the current state of a conference. 
	public enum State:Int
	{
		/// Initial state. 
		case None = 0
		/// Conference is now instantiated on local. 
		case Instantiated = 1
		/// One creation request was sent to the server. 
		case CreationPending = 2
		/// Conference was created on the server. 
		case Created = 3
		/// Conference creation failed. 
		case CreationFailed = 4
		/// Wait for conference termination. 
		case TerminationPending = 5
		/// Conference exists on server but not in local. 
		case Terminated = 6
		/// Conference termination failed. 
		case TerminationFailed = 7
		/// Conference was deleted on the server. 
		case Deleted = 8
	}

	/// A conference is the object that allow to make calls when there are 2 or more
	/// participants. 
	/// To create (or find) a `Conference`, you first need a `ConferenceParams` object.
	/// Core.createConferenceWithParams() allows you to create a conference. A
	/// conference is uniquely identified by a conference address, meaning you can have
	/// more than one conference between two accounts. As of now, each `Core` can host
	/// only 1 conference but it can be part of many conferences as a remote
	/// participant. To find a conference among those a core is part of, you can call
	/// Core.searchConference(). 
	public func addDelegate(delegate: ConferenceDelegate)
	{
		let manager = ConferenceDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_conference_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// A conference is the object that allow to make calls when there are 2 or more
	/// participants. 
	/// To create (or find) a `Conference`, you first need a `ConferenceParams` object.
	/// Core.createConferenceWithParams() allows you to create a conference. A
	/// conference is uniquely identified by a conference address, meaning you can have
	/// more than one conference between two accounts. As of now, each `Core` can host
	/// only 1 conference but it can be part of many conferences as a remote
	/// participant. To find a conference among those a core is part of, you can call
	/// Core.searchConference(). 
	public func removeDelegate(delegate: ConferenceDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_conference_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Get the conference address of the conference. 
	/// - Returns: The conference address of the conference.   
	public var conferenceAddress: Address?
	{
		get
		{
			let cPointer = linphone_conference_get_conference_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_conference_set_conference_address(cPtr, newValue?.cPtr)
		}
	}

	/// Returns core for a `Conference`. 
	/// - Returns: back pointer to `Core` object.   Returns back pointer to `Core`
	/// object. 
	public var core: Core?
	{
			let cPointer = linphone_conference_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Core.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the current LinphoneConferenceCbs. 
	/// This is meant only to be called from a callback to be able to get the user_data
	/// associated with the LinphoneConferenceCbs that is calling the callback. 
	/// - Returns: The LinphoneConferenceCbs that has called the last callback.   
	public var currentDelegate: ConferenceDelegate?
	{
			let cObject = linphone_conference_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<ConferenceDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Get current parameters of the conference. 
	/// - Returns: a `ConferenceParams` .   
	public var currentParams: ConferenceParams?
	{
			let cPointer = linphone_conference_get_current_params(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ConferenceParams.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the conference id as string. 
	/// - Returns: the conference id   
	/// - deprecated: 10/07/2020 Use getConferenceAddress() instead. 
	@available(*, deprecated)
	public var ID: String
	{
		get
		{
			let cPointer = linphone_conference_get_ID(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_conference_set_ID(cPtr, newValue)
		}
	}

	/// Gets the current input device for this conference. 
	/// - Returns: the `AudioDevice` used by this conference as input or nil if there
	/// is currently no soundcard configured (depending on the state of the conference)
	///   
	public var inputAudioDevice: AudioDevice?
	{
		get
		{
			let cPointer = linphone_conference_get_input_audio_device(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = AudioDevice.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_conference_set_input_audio_device(cPtr, newValue?.cPtr)
		}
	}

	/// For a local conference, it returns whether the local participant is enabled For
	/// a remote conference, it return whether the remote participant has left the
	/// conference without bein removed from it. 
	/// - Returns: true if the local participant is in a conference, false otherwise. 
	public var isIn: Bool
	{
			return linphone_conference_is_in(cPtr) != 0
	}

	/// Gets whether the conference is currently being recorded. 
	/// - Returns: true if conference is being recorded, false otherwise. 
	public var isRecording: Bool
	{
			return linphone_conference_is_recording(cPtr) != 0
	}

	/// For a local audio video conference, this function returns the participant
	/// hosting the conference For a remote audio video conference, this function
	/// returns the focus of the conference. 
	/// - Returns: a `Participant` .   
	public var me: Participant?
	{
			let cPointer = linphone_conference_get_me(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Participant.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the current output device for this conference. 
	/// - Returns: the `AudioDevice` used by this conference as output or nil if there
	/// is currently no soundcard configured (depending on the state of the conference)
	///   
	public var outputAudioDevice: AudioDevice?
	{
		get
		{
			let cPointer = linphone_conference_get_output_audio_device(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = AudioDevice.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_conference_set_output_audio_device(cPtr, newValue?.cPtr)
		}
	}

	/// Get number of participants without me. 
	/// - Returns: the number of participants excluding me in a `Conference` 
	public var participantCount: Int
	{
			return Int(linphone_conference_get_participant_count(cPtr))
	}

	/// Get list of all participants of one conference. 
	/// - Returns: The list of participants of the conference.      
	public var participantList: [Participant]
	{
			var swiftList = [Participant]()
			let cList = linphone_conference_get_participant_list(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Participant.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Get URIs of all participants of one conference The returned bctbx_list_t
	/// contains URIs of all participant. 
	/// That list must be freed after use and each URI must be unref with
	/// linphone_address_unref 
	/// - Returns: The list of the participants' address active in the conference.      
	/// - deprecated: 10/07/2020 Use getParticipantList() instead. 
	@available(*, deprecated)
	public var participants: [Address]
	{
			var swiftList = [Address]()
			let cList = linphone_conference_get_participants(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Address.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Get the conference subject. 
	/// - Returns: conference subject.   
	public var subject: String
	{
		get
		{
			let cPointer = linphone_conference_get_subject(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_conference_set_subject(cPtr, newValue)
		}
	}

	/// Retrieves the user pointer that was given to linphone_conference_new() 
	/// - Returns: The user data associated with the `Conference` object.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_conference_get_user_data(cPtr)
		}
		set
		{
			linphone_conference_set_user_data(cPtr, newValue)
		}
	}

	/// Join an existing call to the conference. 
	/// If the conference is in the state LinphoneConferenceStateCreationPending, then
	/// the conference will start on the input and output audio devices used for the
	/// currently active call, if any 
	/// - Parameter call: a `Call` that has to be added to the conference.   
	/// - Warning: This function guarantees that the local endpoint is added to the
	/// conference only if one of calls added is in state StreamsRunning. It is highly
	/// recommended to call linphone_confererence_enter() to guarantee that the local
	/// endpoint is added to the conference. 
	public func addParticipant(call:Call) throws 
	{
		let exception_result = linphone_conference_add_participant(cPtr, call.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addParticipant returned value \(exception_result)")
		}
	}

	/// Join a participant to the conference. 
	/// - Parameter uri: a `Address` that has to be added to the conference.   
	/// - Warning: This function guarantees that the local endpoint is added to the
	/// conference only if there is a call state StreamsRunning towards one of the
	/// addresses. It is highly recommended to call linphone_confererence_enter() to
	/// guarantee that the local endpoint is added to the conference. 
	public func addParticipant(uri:Address) throws 
	{
		let exception_result = linphone_conference_add_participant_2(cPtr, uri.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addParticipant returned value \(exception_result)")
		}
	}

	/// Add participants to the conference, by supplying a list of `Call`. 
	/// If the conference is in the state LinphoneConferenceStateCreationPending, then
	/// the conference will start on the input and output audio devices used for the
	/// currently active call, if any 
	/// - Parameter calls: A list of calls to add to the conference.    
	public func addParticipants(calls:[Call]) throws 
	{
		let exception_result = linphone_conference_add_participants(cPtr, ObjectArrayToBctbxList(list: calls))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addParticipants returned value \(exception_result)")
		}
	}

	/// For a local conference, the local participant joins the conference For a remote
	/// conference, the participant rejoins the conference after leaving it earlier on. 
	/// - Returns: 0 if succeeded. Negative number if failed 
	public func enter() -> Int
	{
		return Int(linphone_conference_enter(cPtr))
	}

	/// Find a participant from a conference. 
	/// - Parameter uri: SIP URI of the participant to search.   
	/// - Returns: a pointer to the participant found or nullptr.   
	public func findParticipant(uri:Address) -> Participant?
	{
		let cPointer = linphone_conference_find_participant(cPtr, uri.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Participant.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Retrieves the volume of a specific participant. 
	/// - Parameter device: The Participant   
	/// - Returns: The volume of the participant expressed in dbm0. 
	public func getParticipantDeviceVolume(device:ParticipantDevice) -> Int
	{
		return Int(linphone_conference_get_participant_device_volume(cPtr, device.cPtr))
	}

	/// Invite participants to the conference, by supplying a list of `Address` If the
	/// conference is in the state LinphoneConferenceStateCreationPending, then the
	/// conference will start on the input and output audio devices used for the
	/// currently active call, if any. 
	/// - Parameter addresses: A list of SIP addresses to invite.    
	/// - Parameter params: `CallParams` to use for inviting the participants.   
	public func inviteParticipants(addresses:[Address], params:CallParams?) throws 
	{
		let exception_result = linphone_conference_invite_participants(cPtr, ObjectArrayToBctbxList(list: addresses), params?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "inviteParticipants returned value \(exception_result)")
		}
	}

	/// For a local audio video conference, this function compares the address provided
	/// as argument with that of participant hosting the conference For a remote audio
	/// video conference, this function compares the address provided as argument with
	/// that of the focus of the conference. 
	/// - Parameter uri: A `Address` object   
	/// - Returns: true if the participant is me, false otherwise. 
	public func isMe(uri:Address) -> Bool
	{
		return linphone_conference_is_me(cPtr, uri.cPtr) != 0
	}

	/// For a local conference, the local participant leaves the conference For a
	/// remote conference, the participant leaves the conference after joining it
	/// earlier on. 
	/// - Returns: 0 if succeeded. Negative number if failed 
	public func leave() -> Int
	{
		return Int(linphone_conference_leave(cPtr))
	}

	/// Call generic OpenGL render for a given conference. 
	public func oglRender() 
	{
		linphone_conference_ogl_render(cPtr)
	}

	/// Call generic OpenGL render preview for a given conference. 
	public func previewOglRender() 
	{
		linphone_conference_preview_ogl_render(cPtr)
	}

	/// - Parameter uri: URI of the participant to remove   
	/// - Warning: The passed participant uri must be one of those returned by
	/// getParticipants() 
	/// - Returns: 0 if succeeded, -1 if failed 
	/// - deprecated: 10/07/2020 Use removeParticipant() instead. 
	@available(*, deprecated)
	public func removeParticipant(uri:Address) throws 
	{
		let exception_result = linphone_conference_remove_participant(cPtr, uri.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "removeParticipant returned value \(exception_result)")
		}
	}

	/// - Parameter participant: participant to remove   
	/// - Warning: The passed participant must be one of those returned by
	/// getParticipantList() 
	/// - Warning: This method may destroy the conference if the only remaining
	/// participant had an existing call to the local participant before the conference
	/// was created 
	/// - Returns: 0 if succeeded, -1 if failed 
	public func removeParticipant(participant:Participant) throws 
	{
		let exception_result = linphone_conference_remove_participant_2(cPtr, participant.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "removeParticipant returned value \(exception_result)")
		}
	}

	/// - Parameter call: call to remove   
	/// - Returns: 0 if succeeded, -1 if failed 
	/// - deprecated: 10/07/2020 Use removeParticipant() instead. 
	@available(*, deprecated)
	public func removeParticipant(call:Call) throws 
	{
		let exception_result = linphone_conference_remove_participant_3(cPtr, call.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "removeParticipant returned value \(exception_result)")
		}
	}

	/// Change the admin status of a participant of a conference (you need to be an
	/// admin yourself to do this). 
	/// - Parameter participant: The Participant for which to change the admin status   
	/// - Parameter isAdmin: A boolean value telling whether the participant should now
	/// be an admin or not 
	public func setParticipantAdminStatus(participant:Participant, isAdmin:Bool) 
	{
		linphone_conference_set_participant_admin_status(cPtr, participant.cPtr, isAdmin==true ? 1:0)
	}

	/// Starts recording the conference. 
	/// - Parameter path: Where to record the conference   
	/// - Returns: 0 if succeeded. Negative number in case of failure. 
	public func startRecording(path:String) -> Int
	{
		return Int(linphone_conference_start_recording(cPtr, path))
	}

	/// Stops the conference recording. 
	/// - Returns: 0 if succeeded. Negative number in case of failure. 
	public func stopRecording() -> Int
	{
		return Int(linphone_conference_stop_recording(cPtr))
	}

	/// Terminates conference. 
	/// - Returns: 0 if the termination is successful, -1 otherwise. 
	public func terminate() -> Int
	{
		return Int(linphone_conference_terminate(cPtr))
	}

	/// Update parameters of the conference. 
	/// This is typically used enable or disable the video stream in the conference. 
	/// - Parameter params: the new parameters to apply.   
	public func updateParams(params:ConferenceParams) -> Int
	{
		return Int(linphone_conference_update_params(cPtr, params.cPtr))
	}
}

/// Object defining all informations of a conference. 
public class ConferenceInfo : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> ConferenceInfo {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ConferenceInfo>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ConferenceInfo(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Retrieve the date and time of the conference. 
	/// - Returns: The date and time of the conference. 
	public var dateTime: time_t
	{
		get
		{
			return linphone_conference_info_get_date_time(cPtr)
		}
		set
		{
			linphone_conference_info_set_date_time(cPtr, newValue)
		}
	}

	/// Retrieve the description of the conference. 
	/// - Returns: The description of the conference.   
	public var description: String
	{
		get
		{
			let cPointer = linphone_conference_info_get_description(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_conference_info_set_description(cPtr, newValue)
		}
	}

	/// Retrieve the duration (in minutes) of the conference. 
	/// - Returns: The duration of the conference. 
	public var duration: Int
	{
		get
		{
			return Int(linphone_conference_info_get_duration(cPtr))
		}
		set
		{
			linphone_conference_info_set_duration(cPtr, CInt(newValue))
		}
	}

	/// Retrieve the conference as an Icalendar string. 
	/// - Returns: The conference as an Icalendar string. The returned char* must be
	/// freed by the caller.     
	public var icalendarString: String
	{
			let cPointer = linphone_conference_info_get_icalendar_string(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			if (cPointer != nil) {
				bctbx_free(cPointer)
			}
			return result
	}

	/// Retrieve the organizer of the conference. 
	/// - Returns: The `Address` of the conference's organizer.   
	public var organizer: Address?
	{
		get
		{
			let cPointer = linphone_conference_info_get_organizer(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_conference_info_set_organizer(cPtr, newValue?.cPtr)
		}
	}

	/// Retrieve the list of participants. 
	/// - Returns: The list of participants.    
	public var participants: [Address]
	{
		get
		{
			var swiftList = [Address]()
			let cList = linphone_conference_info_get_participants(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Address.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
		}
		set
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				cList = bctbx_list_append(cList, UnsafeMutableRawPointer(data.cPtr))
			}
			linphone_conference_info_set_participants(cPtr, cList)
		}
	}

	/// Retrieve the subject of the conference. 
	/// - Returns: The subject of the conference.   
	public var subject: String
	{
		get
		{
			let cPointer = linphone_conference_info_get_subject(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_conference_info_set_subject(cPtr, newValue)
		}
	}

	/// Retrieve the URI of the conference. 
	/// - Returns: The URI of the conference (`Address`).   
	public var uri: Address?
	{
		get
		{
			let cPointer = linphone_conference_info_get_uri(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_conference_info_set_uri(cPtr, newValue?.cPtr)
		}
	}

	/// Add a participant to the conference. 
	/// - Parameter participant: The participant (`Address`) to add.   
	public func addParticipant(participant:Address) 
	{
		linphone_conference_info_add_participant(cPtr, participant.cPtr)
	}
}

/// Object defining parameters for a `Conference`. 
/// Can be created by calling function Core.createConferenceParams(). 
public class ConferenceParams : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> ConferenceParams {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ConferenceParams>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ConferenceParams(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Check whether audio capabilities are enabled. 
	/// - Returns: true if the conference supports audio capabilities, false otherwise 
	public var audioEnabled: Bool
	{
		get
		{
			return linphone_conference_params_audio_enabled(cPtr) != 0
		}
		set
		{
			linphone_conference_params_enable_audio(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check whether chat capabilities are enabled. 
	/// - Returns: true if the conference supports chat capabilities, false otherwise 
	public var chatEnabled: Bool
	{
		get
		{
			return linphone_conference_params_chat_enabled(cPtr) != 0
		}
		set
		{
			linphone_conference_params_enable_chat(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check whether audio capabilities are enabled. 
	/// - Returns: true if the conference supports audio capabilities, false otherwise 
	/// - deprecated: 16/12/2021 Use audioEnabled() instead. 
	@available(*, deprecated)
	public var isAudioEnabled: Bool
	{
			return linphone_conference_params_is_audio_enabled(cPtr) != 0
	}

	/// Check whether chat capabilities are enabled. 
	/// - Returns: true if the conference supports chat capabilities, false otherwise 
	/// - deprecated: 16/12/2021 Use chatEnabled() instead. 
	@available(*, deprecated)
	public var isChatEnabled: Bool
	{
			return linphone_conference_params_is_chat_enabled(cPtr) != 0
	}

	/// Returns whether local participant has to enter the conference. 
	/// - Returns: true if local participant is by default part of the conference,
	/// false otherwise 
	/// - deprecated: 16/12/2021 Use localParticipantEnabled() instead. 
	@available(*, deprecated)
	public var isLocalParticipantEnabled: Bool
	{
			return linphone_conference_params_is_local_participant_enabled(cPtr) != 0
	}

	/// Returns whether conference can have only one participant. 
	/// - Returns: true if the conference can have only one participant, false
	/// otherwise 
	/// - deprecated: 16/12/2021 Use oneParticipantConferenceEnabled() instead. 
	@available(*, deprecated)
	public var isOneParticipantConferenceEnabled: Bool
	{
			return linphone_conference_params_is_one_participant_conference_enabled(cPtr) != 0
	}

	/// Check whether video capabilities are enabled. 
	/// - Returns: true if the conference supports video capabilities, false otherwise 
	/// - deprecated: 16/12/2021 Use videoEnabled() instead. 
	@available(*, deprecated)
	public var isVideoEnabled: Bool
	{
			return linphone_conference_params_is_video_enabled(cPtr) != 0
	}

	/// Returns whether local participant has to enter the conference. 
	/// - Returns: true if local participant is by default part of the conference,
	/// false otherwise 
	public var localParticipantEnabled: Bool
	{
		get
		{
			return linphone_conference_params_local_participant_enabled(cPtr) != 0
		}
		set
		{
			linphone_conference_params_enable_local_participant(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns whether conference can have only one participant. 
	/// - Returns: true if the conference can have only one participant, false
	/// otherwise 
	public var oneParticipantConferenceEnabled: Bool
	{
		get
		{
			return linphone_conference_params_one_participant_conference_enabled(cPtr) != 0
		}
		set
		{
			linphone_conference_params_enable_one_participant_conference(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check whether video capabilities are enabled. 
	/// - Returns: true if the conference supports video capabilities, false otherwise 
	public var videoEnabled: Bool
	{
		get
		{
			return linphone_conference_params_video_enabled(cPtr) != 0
		}
		set
		{
			linphone_conference_params_enable_video(cPtr, newValue==true ? 1:0)
		}
	}

	/// Clone a `ConferenceParams`. 
	/// - Returns: An allocated `ConferenceParams` with the same parameters than params
	///   
	public func clone() -> ConferenceParams?
	{
		let cPointer = linphone_conference_params_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = ConferenceParams.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}
}

/// This object is used to manipulate a configuration file. 
/// The format of the configuration file is a .ini like format:
/// Various types can be used: strings and lists of strings, integers, floats,
/// booleans (written as 0 or 1) and range of integers.
/// Usually a `Core` is initialized using two `Config`, one default (where
/// configuration changes through API calls will be saved) and one named 'factory'
/// which is read-only and overwrites any setting that may exists in the default
/// one.
/// It is also possible to use only one (either default or factory) or even none. 
public class Config : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Config {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Config>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Config(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Instantiates a `Config` object from a user config file name, group id and a
	/// factory config file. 
	/// The "group id" is the string that identify the "App group" capability of the
	/// iOS application. App group gives access to a shared file system where all the
	/// configuration files for shared core are stored. Both iOS application and iOS
	/// app extension that need shared core must activate the "App group" capability
	/// with the SAME "group id" in the project settings. The caller of this
	/// constructor owns a reference. linphone_config_unref must be called when this
	/// object is no longer needed.
	/// - Parameter appGroupId: used to compute the path of the config file in the file
	/// system shared by the shared Cores   
	/// - Parameter configFilename: the filename of the user config file to read to
	/// fill the instantiated `Config`   
	/// - Parameter factoryConfigFilename: the filename of the factory config file to
	/// read to fill the instantiated `Config`   
	/// - See also: linphone_config_new 
	/// - Returns: a `Config` object  
	/// The user config file is read first to fill the `Config` and then the factory
	/// config file is read. Therefore the configuration parameters defined in the user
	/// config file will be overwritten by the parameters defined in the factory config
	/// file. 
	static public func newForSharedCore(appGroupId:String, configFilename:String?, factoryConfigFilename:String?) -> Config?
	{
		let cPointer = linphone_config_new_for_shared_core(appGroupId, configFilename, factoryConfigFilename)
		if (cPointer == nil) {
			return nil
		}
		let result = Config.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Instantiates a `Config` object from a user provided buffer. 
	/// The caller of this constructor owns a reference. linphone_config_unref must be
	/// called when this object is no longer needed.
	/// - Parameter buffer: the buffer from which the `Config` will be retrieved. We
	/// expect the buffer to be null-terminated.   
	/// - See also: newWithFactory() 
	/// - See also: linphone_config_new 
	/// - Returns: a `Config` object   
	static public func newFromBuffer(buffer:String) -> Config?
	{
		let cPointer = linphone_config_new_from_buffer(buffer)
		if (cPointer == nil) {
			return nil
		}
		let result = Config.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Instantiates a `Config` object from a user config file and a factory config
	/// file. 
	/// The caller of this constructor owns a reference. linphone_config_unref must be
	/// called when this object is no longer needed.
	/// - Parameter configFilename: the filename of the user config file to read to
	/// fill the instantiated `Config`   
	/// - Parameter factoryConfigFilename: the filename of the factory config file to
	/// read to fill the instantiated `Config`   
	/// - See also: linphone_config_new 
	/// - Returns: a `Config` object  
	/// The user config file is read first to fill the `Config` and then the factory
	/// config file is read. Therefore the configuration parameters defined in the user
	/// config file will be overwritten by the parameters defined in the factory config
	/// file. 
	static public func newWithFactory(configFilename:String?, factoryConfigFilename:String?) -> Config?
	{
		let cPointer = linphone_config_new_with_factory(configFilename, factoryConfigFilename)
		if (cPointer == nil) {
			return nil
		}
		let result = Config.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Returns the list of sections' names in the LinphoneConfig. 
	/// - Returns: A list of strings.    
	public var sectionsNamesList: [String]
	{
			var swiftList = [String]()
			let cList = linphone_config_get_sections_names_list(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp!.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Removes entries for key,value in a section. 
	/// - Parameter section: the section for which to clean the key entry   
	/// - Parameter key: the key to clean   
	public func cleanEntry(section:String, key:String) 
	{
		linphone_config_clean_entry(cPtr, section, key)
	}

	/// Removes every pair of key,value in a section and remove the section. 
	/// - Parameter section: the section to clean   
	public func cleanSection(section:String) 
	{
		linphone_config_clean_section(cPtr, section)
	}

	/// Dumps the `Config` as INI into a buffer. 
	/// - Returns: The buffer that contains the config dump     
	public func dump() -> String
	{
		let cstr = linphone_config_dump(cPtr)
		let result = charArrayToString(charPointer: cstr)
		if (cstr != nil) {
			bctbx_free(cstr)
		}
		return result
	}

	/// Dumps the `Config` as XML into a buffer. 
	/// - Returns: The buffer that contains the XML dump     
	public func dumpAsXml() -> String
	{
		let cstr = linphone_config_dump_as_xml(cPtr)
		let result = charArrayToString(charPointer: cstr)
		if (cstr != nil) {
			bctbx_free(cstr)
		}
		return result
	}

	/// Retrieves a configuration item as a boolean, given its section, key, and
	/// default value. 
	/// The default boolean value is returned if the config item isn't found. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter defaultValue: The default value to return if not found 
	/// - Returns: the found value or default_value if not found. 
	public func getBool(section:String, key:String, defaultValue:Bool) -> Bool
	{
		return linphone_config_get_bool(cPtr, section, key, defaultValue==true ? 1:0) != 0
	}

	/// Retrieves a default configuration item as a float, given its section, key, and
	/// default value. 
	/// The default float value is returned if the config item isn't found. 
	/// - Parameter section: The section from which to retrieve the default value   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter defaultValue: The default value to return if not found 
	/// - Returns: the found default value or default_value if not found. 
	public func getDefaultFloat(section:String, key:String, defaultValue:Float) -> Float
	{
		return linphone_config_get_default_float(cPtr, section, key, defaultValue)
	}

	/// Retrieves a default configuration item as an integer, given its section, key,
	/// and default value. 
	/// The default integer value is returned if the config item isn't found. 
	/// - Parameter section: The section from which to retrieve the default value   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter defaultValue: The default value to return if not found 
	/// - Returns: the found default value or default_value if not found. 
	public func getDefaultInt(section:String, key:String, defaultValue:Int) -> Int
	{
		return Int(linphone_config_get_default_int(cPtr, section, key, CInt(defaultValue)))
	}

	/// Retrieves a default configuration item as a 64 bit integer, given its section,
	/// key, and default value. 
	/// The default integer value is returned if the config item isn't found. 
	/// - Parameter section: The section from which to retrieve the default value   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter defaultValue: The default value to return if not found 
	/// - Returns: the found default value or default_value if not found. 
	public func getDefaultInt64(section:String, key:String, defaultValue:Int64) -> Int64
	{
		return linphone_config_get_default_int64(cPtr, section, key, defaultValue)
	}

	/// Retrieves a default configuration item as a string, given its section, key, and
	/// default value. 
	/// The default value string is returned if the config item isn't found. 
	/// - Parameter section: The section from which to retrieve the default value   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter defaultValue: The default value to return if not found 
	/// - Returns: the found default value or default_value if not found. 
	public func getDefaultString(section:String, key:String, defaultValue:String) -> String
	{
		let cstr = linphone_config_get_default_string(cPtr, section, key, defaultValue)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Retrieves a configuration item as a float, given its section, key, and default
	/// value. 
	/// The default float value is returned if the config item isn't found. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter defaultValue: The default value to return if not found 
	/// - Returns: the found value or default_value if not found. 
	public func getFloat(section:String, key:String, defaultValue:Float) -> Float
	{
		return linphone_config_get_float(cPtr, section, key, defaultValue)
	}

	/// Retrieves a configuration item as an integer, given its section, key, and
	/// default value. 
	/// The default integer value is returned if the config item isn't found. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter defaultValue: The default value to return if not found 
	/// - Returns: the found value or default_value if not found. 
	public func getInt(section:String, key:String, defaultValue:Int) -> Int
	{
		return Int(linphone_config_get_int(cPtr, section, key, CInt(defaultValue)))
	}

	/// Retrieves a configuration item as a 64 bit integer, given its section, key, and
	/// default value. 
	/// The default integer value is returned if the config item isn't found. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter defaultValue: The default value to return if not found 
	/// - Returns: the found value or default_value if not found. 
	public func getInt64(section:String, key:String, defaultValue:Int64) -> Int64
	{
		return linphone_config_get_int64(cPtr, section, key, defaultValue)
	}

	/// Returns the list of keys' names for a section in the LinphoneConfig. 
	/// - Parameter section: The section name   
	/// - Returns: A list of strings.    
	public func getKeysNamesList(section:String) -> [String]
	{
		var swiftList = [String]()
		let cList = linphone_config_get_keys_names_list(cPtr, section)
		var listTemp = cList
		while (listTemp != nil) {
			swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp!.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Retrieves the overwrite flag for a config item. 
	/// - Parameter section: The section from which to retrieve the overwrite flag   
	/// - Parameter key: The name of the configuration item to retrieve the overwrite
	/// flag from.   
	/// - Returns: true if overwrite flag is set, false otherwise. 
	public func getOverwriteFlagForEntry(section:String, key:String) -> Bool
	{
		return linphone_config_get_overwrite_flag_for_entry(cPtr, section, key) != 0
	}

	/// Retrieves the overwrite flag for a config section. 
	/// - Parameter section: The section from which to retrieve the overwrite flag   
	/// - Returns: true if overwrite flag is set, false otherwise. 
	public func getOverwriteFlagForSection(section:String) -> Bool
	{
		return linphone_config_get_overwrite_flag_for_section(cPtr, section) != 0
	}

	/// Retrieves a configuration item as a range, given its section, key, and default
	/// min and max values. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter min: The min value found or default_min   
	/// - Parameter max: The max value found or default_max   
	/// - Parameter defaultMin: the default min value to return if not found 
	/// - Parameter defaultMax: the default max value to return if not found. 
	/// - Returns: true if the value is successfully parsed as a range, false
	/// otherwise. If false is returned, min and max are filled respectively with
	/// default_min and default_max values. 
	public func getRange(section:String, key:String, min:UnsafeMutablePointer<Int32>, max:UnsafeMutablePointer<Int32>, defaultMin:Int, defaultMax:Int) -> Bool
	{
		return linphone_config_get_range(cPtr, section, key, min, max, CInt(defaultMin), CInt(defaultMax)) != 0
	}

	/// Retrieves a section parameter item as a string, given its section and key. 
	/// The default value string is returned if the config item isn't found. 
	/// - Parameter section: The section from which to retrieve the default value   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter defaultValue: The default value to return if not found.   
	/// - Returns: the found default value or default_value if not found.   
	public func getSectionParamString(section:String, key:String, defaultValue:String?) -> String
	{
		let cstr = linphone_config_get_section_param_string(cPtr, section, key, defaultValue)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Retrieves the skip flag for a config item. 
	/// - Parameter section: The section from which to retrieve the skip flag   
	/// - Parameter key: The name of the configuration item to retrieve the skip flag
	/// from 
	/// - Returns: true if skip flag is set, false otherwise. 
	public func getSkipFlagForEntry(section:String, key:String) -> Bool
	{
		return linphone_config_get_skip_flag_for_entry(cPtr, section, key) != 0
	}

	/// Retrieves the skip flag for a config section. 
	/// - Parameter section: The section from which to retrieve the skip flag   
	/// - Returns: true if skip flag is set, false otherwise. 
	public func getSkipFlagForSection(section:String) -> Bool
	{
		return linphone_config_get_skip_flag_for_section(cPtr, section) != 0
	}

	/// Retrieves a configuration item as a string, given its section, key, and default
	/// value. 
	/// The default value string is returned if the config item isn't found. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter defaultString: The default value to return if not found.   
	/// - Returns: the found value or the default one if not found.   
	public func getString(section:String, key:String, defaultString:String?) -> String
	{
		let cstr = linphone_config_get_string(cPtr, section, key, defaultString)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Retrieves a configuration item as a list of strings, given its section, key,
	/// and default value. 
	/// The default value is returned if the config item is not found. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter defaultList: The list to return when the key doesn't exist.    
	/// - Returns: A list of strings.    
	public func getStringList(section:String, key:String, defaultList:[String]?) -> [String]
	{
		var swiftList = [String]()
		let cList = linphone_config_get_string_list(cPtr, section, key, StringArrayToBctbxList(list:defaultList))
		var listTemp = cList
		while (listTemp != nil) {
			swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp!.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Returns if a given section with a given key is present in the configuration. 
	/// - Parameter section: to check if the given entry exists   
	/// - Parameter key: to check if it exists   
	/// - Returns: 1 if it exists, 0 otherwise 
	public func hasEntry(section:String, key:String) -> Int
	{
		return Int(linphone_config_has_entry(cPtr, section, key))
	}

	/// Returns if a given section is present in the configuration. 
	/// - Parameter section: the section to check if exists   
	/// - Returns: 1 if it exists, 0 otherwise 
	public func hasSection(section:String) -> Int
	{
		return Int(linphone_config_has_section(cPtr, section))
	}

	/// Reads a xml config file and fill the `Config` with the read config dynamic
	/// values. 
	/// - Parameter filename: The filename of the config file to read to fill the
	/// `Config`   
	public func loadFromXmlFile(filename:String) -> String
	{
		let cstr = linphone_config_load_from_xml_file(cPtr, filename)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Reads a xml config string and fill the `Config` with the read config dynamic
	/// values. 
	/// - Parameter buffer: The string of the config file to fill the `Config`   
	/// - Returns: 0 in case of success 
	public func loadFromXmlString(buffer:String) throws 
	{
		let exception_result = linphone_config_load_from_xml_string(cPtr, buffer)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "loadFromXmlString returned value \(exception_result)")
		}
	}

	/// Reads a user config file and fill the `Config` with the read config values. 
	/// - Parameter filename: The filename of the config file to read to fill the
	/// `Config`   
	public func readFile(filename:String) throws 
	{
		let exception_result = linphone_config_read_file(cPtr, filename)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "readFile returned value \(exception_result)")
		}
	}

	/// Check if given file name exists relatively to the current location. 
	/// - Parameter filename: The file name to check if exists   
	/// - Returns: true if file exists relative to the to the current location 
	public func relativeFileExists(filename:String) -> Bool
	{
		return linphone_config_relative_file_exists(cPtr, filename) != 0
	}

	/// Reload the config from the file. 
	public func reload() 
	{
		linphone_config_reload(cPtr)
	}

	/// Sets a boolean config item. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter value: the value to set 
	public func setBool(section:String, key:String, value:Bool) 
	{
		linphone_config_set_bool(cPtr, section, key, value==true ? 1:0)
	}

	/// Sets a float config item. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter value: the value to set 
	public func setFloat(section:String, key:String, value:Float) 
	{
		linphone_config_set_float(cPtr, section, key, value)
	}

	/// Sets an integer config item. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter value: the value to set 
	public func setInt(section:String, key:String, value:Int) 
	{
		linphone_config_set_int(cPtr, section, key, CInt(value))
	}

	/// Sets a 64 bits integer config item. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter value: the value to set 
	public func setInt64(section:String, key:String, value:Int64) 
	{
		linphone_config_set_int64(cPtr, section, key, value)
	}

	/// Sets an integer config item, but store it as hexadecimal. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter value: the value to set 
	public func setIntHex(section:String, key:String, value:Int) 
	{
		linphone_config_set_int_hex(cPtr, section, key, CInt(value))
	}

	/// Sets the overwrite flag for a config item (used when dumping config as xml) 
	/// - Parameter section: The section from which to set the overwrite flag   
	/// - Parameter key: The name of the configuration item to set the overwrite flag
	/// from   
	/// - Parameter value: The overwrite flag value to set 
	public func setOverwriteFlagForEntry(section:String, key:String, value:Bool) 
	{
		linphone_config_set_overwrite_flag_for_entry(cPtr, section, key, value==true ? 1:0)
	}

	/// Sets the overwrite flag for a config section (used when dumping config as xml) 
	/// - Parameter section: The section from which to set the overwrite flag   
	/// - Parameter value: The overwrite flag value to set 
	public func setOverwriteFlagForSection(section:String, value:Bool) 
	{
		linphone_config_set_overwrite_flag_for_section(cPtr, section, value==true ? 1:0)
	}

	/// Sets a range config item. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter minValue: the min value to set 
	/// - Parameter maxValue: the max value to set 
	public func setRange(section:String, key:String, minValue:Int, maxValue:Int) 
	{
		linphone_config_set_range(cPtr, section, key, CInt(minValue), CInt(maxValue))
	}

	/// Sets the skip flag for a config item (used when dumping config as xml) 
	/// - Parameter section: The section from which to set the skip flag   
	/// - Parameter key: The name of the configuration item to set the skip flag from   
	/// - Parameter value: The skip flag value to set 
	public func setSkipFlagForEntry(section:String, key:String, value:Bool) 
	{
		linphone_config_set_skip_flag_for_entry(cPtr, section, key, value==true ? 1:0)
	}

	/// Sets the skip flag for a config section (used when dumping config as xml) 
	/// - Parameter section: The section from which to set the skip flag   
	/// - Parameter value: The skip flag value to set 
	public func setSkipFlagForSection(section:String, value:Bool) 
	{
		linphone_config_set_skip_flag_for_section(cPtr, section, value==true ? 1:0)
	}

	/// Sets a string config item. 
	/// - Parameter section: The section from which to retrieve a configuration item   
	/// - Parameter key: The name of the configuration item to retrieve   
	/// - Parameter value: The value to set   
	public func setString(section:String, key:String, value:String?) 
	{
		linphone_config_set_string(cPtr, section, key, value)
	}

	/// Sets a string list config item. 
	/// - Parameter section: The name of the section to put the configuration item into
	///   
	/// - Parameter key: The name of the configuration item to set   
	/// - Parameter value: The value to set.    
	public func setStringList(section:String, key:String, value:[String]?) 
	{
		linphone_config_set_string_list(cPtr, section, key, StringArrayToBctbxList(list:value))
	}

	/// Writes the config file to disk. 
	/// - Returns: 0 if successful, -1 otherwise 
	public func sync() throws 
	{
		let exception_result = linphone_config_sync(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "sync returned value \(exception_result)")
		}
	}

	/// Write a string in a file placed relatively with the Linphone configuration
	/// file. 
	/// - Parameter filename: Name of the file where to write data. The name is
	/// relative to the place of the config file   
	/// - Parameter data: String to write   
	public func writeRelativeFile(filename:String, data:String) 
	{
		linphone_config_write_relative_file(cPtr, filename, data)
	}
}

/// This object holds data that can be embedded in a signaling message. 
/// Use Core.createContent() to create it, and then you should set at least it's
/// type and subtype and fill the buffer with your data.
/// A `Content` can be multipart (contain other contents), have file information
/// (name, path, size), be encrypted, have custom headers, etc...
/// It is mainly used to send information through a `ChatMessage`. 
public class Content : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Content {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Content>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Content(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get the content data buffer, usually a string. 
	/// - Returns: The content data buffer.   
	public var buffer: UnsafePointer<UInt8>
	{
			return linphone_content_get_buffer(cPtr)
	}

	/// Get the encoding of the data buffer, for example "gzip". 
	/// - Returns: The encoding of the data buffer.   
	public var encoding: String
	{
		get
		{
			let cPointer = linphone_content_get_encoding(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_content_set_encoding(cPtr, newValue)
		}
	}

	/// Gets the file duration in seconds, if information is available. 
	public var fileDuration: Int
	{
			return Int(linphone_content_get_file_duration(cPtr))
	}

	/// Get the file transfer filepath set for this content (replace
	/// linphone_chat_message_get_file_transfer_filepath). 
	/// - Returns: The file path set for this content if it has been set, nil
	/// otherwise.   
	public var filePath: String
	{
		get
		{
			let cPointer = linphone_content_get_file_path(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_content_set_file_path(cPtr, newValue)
		}
	}

	/// Get the file size if content is either a FileContent or a FileTransferContent. 
	/// - Returns: The represented file size. 
	public var fileSize: Int
	{
			return Int(linphone_content_get_file_size(cPtr))
	}

	/// Tells whether or not this content contains a file. 
	/// - Returns: true if this content contains a file, false otherwise. 
	public var isFile: Bool
	{
			return linphone_content_is_file(cPtr) != 0
	}

	/// Tells whether or not this content contains an encrypted file. 
	/// - Returns: True is this content contains a file and this file is encrypted,
	/// false otherwise. 
	public var isFileEncrypted: Bool
	{
			return linphone_content_is_file_encrypted(cPtr) != 0
	}

	/// Tells whether or not this content is a file transfer. 
	/// - Returns: true if this content is a file transfer, false otherwise. 
	public var isFileTransfer: Bool
	{
			return linphone_content_is_file_transfer(cPtr) != 0
	}

	/// Tells whether or not this content contains an icalendar by checking it's
	/// content type. 
	/// - Returns: true if this content type is 'text/calendar;conference-event=yes',
	/// false otherwise. 
	public var isIcalendar: Bool
	{
			return linphone_content_is_icalendar(cPtr) != 0
	}

	/// Tell whether a content is a multipart content. 
	/// - Returns: A boolean value telling whether the content is multipart or not. 
	public var isMultipart: Bool
	{
			return linphone_content_is_multipart(cPtr) != 0
	}

	/// Tells whether or not this content contains text. 
	/// - Returns: true if this content contains plain text, false otherwise. 
	public var isText: Bool
	{
			return linphone_content_is_text(cPtr) != 0
	}

	/// Tells whether or not this content contains a voice recording by checking it's
	/// content type. 
	/// - Returns: true if this content type is 'audio/wav;voice-recording=yes', false
	/// otherwise. 
	public var isVoiceRecording: Bool
	{
			return linphone_content_is_voice_recording(cPtr) != 0
	}

	/// Get the key associated with a RCS file transfer message if encrypted. 
	/// - Returns: The key to encrypt/decrypt the file associated to this content.   
	public var key: String
	{
			let cPointer = linphone_content_get_key(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the size of key associated with a RCS file transfer message if encrypted. 
	/// - Returns: The key size in bytes 
	public var keySize: Int
	{
			return Int(linphone_content_get_key_size(cPtr))
	}

	/// Get the name associated with a RCS file transfer message. 
	/// It is used to store the original filename of the file to be downloaded from
	/// server. 
	/// - Returns: The name of the content.   
	public var name: String
	{
		get
		{
			let cPointer = linphone_content_get_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_content_set_name(cPtr, newValue)
		}
	}

	/// Get all the parts from a multipart content. 
	/// - Returns: A  object holding the part if found, nil otherwise.     
	public var parts: [Content]
	{
			var swiftList = [Content]()
			let cList = linphone_content_get_parts(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Content.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// If the content is an encrypted file, generate a temporary plain copy of the
	/// file and returns its paths The caller is responsible to then delete this
	/// temporary copy and the returned string. 
	/// - Returns: The file path set for this content if it has been set, nil
	/// otherwise.   
	public var plainFilePath: String
	{
			let cPointer = linphone_content_get_plain_file_path(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			if (cPointer != nil) {
				bctbx_free(cPointer)
			}
			return result
	}

	/// Get the content data buffer size, excluding null character despite null
	/// character is always set for convenience. 
	/// - Returns: The content data buffer size. 
	public var size: Int
	{
		get
		{
			return Int(linphone_content_get_size(cPtr))
		}
		set
		{
			linphone_content_set_size(cPtr, (newValue))
		}
	}

	/// Get the string content data buffer. 
	/// - Returns: The string content data buffer.   
	/// - deprecated: 2020-07-01. Use getUtf8Text() instead. 
	@available(*, deprecated)
	public var stringBuffer: String
	{
		get
		{
			let cPointer = linphone_content_get_string_buffer(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_content_set_string_buffer(cPtr, newValue)
		}
	}

	/// Get the mime subtype of the content data. 
	/// - Returns: The mime subtype of the content data, for example "html".   
	public var subtype: String
	{
		get
		{
			let cPointer = linphone_content_get_subtype(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_content_set_subtype(cPtr, newValue)
		}
	}

	/// Get the mime type of the content data. 
	/// - Returns: The mime type of the content data, for example "application".   
	public var type: String
	{
		get
		{
			let cPointer = linphone_content_get_type(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_content_set_type(cPtr, newValue)
		}
	}

	/// Retrieve the user pointer associated with the content. 
	/// - Returns: The user pointer associated with the content.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_content_get_user_data(cPtr)
		}
		set
		{
			linphone_content_set_user_data(cPtr, newValue)
		}
	}

	/// Get the string content data buffer. 
	/// Introduced in 01/07/2020 
	/// - Returns: The string content data buffer in UTF8.   
	public var utf8Text: String
	{
		get
		{
			let cPointer = linphone_content_get_utf8_text(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_content_set_utf8_text(cPtr, newValue)
		}
	}

	/// Adds a parameter to the ContentType header. 
	/// - Parameter name: the name of the parameter to add.   
	/// - Parameter value: the value of the parameter to add.   
	public func addContentTypeParameter(name:String, value:String?) 
	{
		linphone_content_add_content_type_parameter(cPtr, name, value)
	}

	/// Find a part from a multipart content looking for a part header with a specified
	/// value. 
	/// - Parameter headerName: The name of the header to look for.   
	/// - Parameter headerValue: The value of the header to look for.   
	/// - Returns: A `Content` object object the part if found, nil otherwise.   
	public func findPartByHeader(headerName:String, headerValue:String) -> Content?
	{
		let cPointer = linphone_content_find_part_by_header(cPtr, headerName, headerValue)
		if (cPointer == nil) {
			return nil
		}
		let result = Content.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Get a custom header value of a content. 
	/// - Parameter headerName: The name of the header to get the value from.   
	/// - Returns: The value of the header if found, nil otherwise.   
	public func getCustomHeader(headerName:String) -> String
	{
		let cstr = linphone_content_get_custom_header(cPtr, headerName)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Get a part from a multipart content according to its index. 
	/// - Parameter index: The index of the part to get. 
	/// - Returns: A `Content` object holding the part if found, nil otherwise.   
	public func getPart(index:Int) -> Content?
	{
		let cPointer = linphone_content_get_part(cPtr, CInt(index))
		if (cPointer == nil) {
			return nil
		}
		let result = Content.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Set the content data buffer, usually a string. 
	/// - Parameter buffer: The content data buffer.   
	/// - Parameter size: The size of the content data buffer. 
	public func setBuffer(buffer:UnsafePointer<UInt8>, size:Int) 
	{
		linphone_content_set_buffer(cPtr, buffer, size)
	}

	/// Set the key associated with a RCS file transfer message if encrypted. 
	/// - Parameter key: The key to be used to encrypt/decrypt file associated to this
	/// content.   
	/// - Parameter keyLength: The lengh of the key. 
	public func setKey(key:String, keyLength:Int) 
	{
		linphone_content_set_key(cPtr, key, keyLength)
	}
}

/// Main object to instanciate and on which to keep a reference. 
/// This object is the first object to instanciante, and will allow you to perform
/// all kind of tasks. To create it, use either Factory.createCore() or
/// Factory.createCoreWithConfig(), see `Config` for more information about factory
/// and default config. On some platforms like Android or iOS you will need to give
/// it the Context of your application.
/// Once the `Core` is in state `Ready`, use start(). It will then go to state `On`
/// and from that you can start using it for calls and chat messages. It is
/// recommended to add a LinphoneCoreCbs listener using linphone_core_add_listener
/// to it to monitor different events.
/// To be able to receive events from the network, you must schedule a call
/// iterate() often, like every 20ms. On Android & iOS isAutoIterateEnabled() is
/// enabled by default so you don't have to worry about that unless you disable it
/// using linphone_core_set_auto_iterate_enabled or by setting in the [misc]
/// section of your configuration auto_iterate=0. - Warning: Our API isn't
/// thread-safe but also isn't blocking, so it is strongly recommend to always call
/// our methods from the main thread.
/// Once you don't need it anymore, call stop() and release the reference on it so
/// it can gracefully shutdown. 
public class Core : LinphoneObject
{
	var delegateManagers : [CoreDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> Core {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Core>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Core(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}
	/// Get the UIView in which the video is be rendered. Use nativeVideoWindowId for direct pointer management.
	/// - Returns: The UIView in which the video will be rendered.
#if os(iOS) || os(tvOS)
	public var nativeVideoWindow: UIView?
	{
		get
		{
			return Unmanaged<UIView>.fromOpaque(linphone_core_get_native_video_window_id(cPtr)).takeUnretainedValue()
		}
		set
		{
			if let previousViewPtr = linphone_core_get_native_video_window_id(cPtr)
			{
				Unmanaged<UIView>.fromOpaque(previousViewPtr).release()
			}
			if let view = newValue {
				linphone_core_set_native_video_window_id(cPtr, UnsafeMutableRawPointer(Unmanaged.passRetained(view).toOpaque()))
			} else {
				linphone_core_set_native_video_window_id(cPtr, nil)
			}
		}
	}
#else
	public var nativeVideoWindow: UnsafeMutableRawPointer?

	{
		get
		{
			return linphone_core_get_native_video_window_id(cPtr)
		}
		set
		{
			linphone_core_set_native_video_window_id(cPtr, newValue)
		}
	}
#endif
	/// Get the UIView in which the camera preview is be rendered. Use nativePreviewWindowId for direct pointer management.
	/// - Returns: The UIView in which the camera preview will be rendered.
#if os(iOS) || os(tvOS)
	public var nativePreviewWindow: UIView?
	{
		get
		{
			return Unmanaged<UIView>.fromOpaque(linphone_core_get_native_preview_window_id(cPtr)).takeUnretainedValue()
		}
		set
		{
			if let previousViewPtr = linphone_core_get_native_preview_window_id(cPtr)
			{
				Unmanaged<UIView>.fromOpaque(previousViewPtr).release()
			}
			if let view = newValue {
				linphone_core_set_native_preview_window_id(cPtr, UnsafeMutableRawPointer(Unmanaged.passRetained(view).toOpaque()))
			} else {
				linphone_core_set_native_preview_window_id(cPtr, nil)
			}
		}
	}
#else
	public var nativePreviewWindow: UnsafeMutableRawPointer?

	{
		get
		{
			return linphone_core_get_native_preview_window_id(cPtr)
		}
		set
		{
			linphone_core_set_native_preview_window_id(cPtr, newValue)
		}
	}
#endif

	///Used to notify if log collection upload have been succesfully delivered or not. 
	public enum LogCollectionUploadState:Int
	{
		/// Delivery in progress. 
		case InProgress = 0
		/// Log collection upload successfully delivered and acknowledged by remote end
		/// point. 
		case Delivered = 1
		/// Log collection upload was not delivered. 
		case NotDelivered = 2
	}

	/// Main object to instanciate and on which to keep a reference. 
	/// This object is the first object to instanciante, and will allow you to perform
	/// all kind of tasks. To create it, use either Factory.createCore() or
	/// Factory.createCoreWithConfig(), see `Config` for more information about factory
	/// and default config. On some platforms like Android or iOS you will need to give
	/// it the Context of your application.
	/// Once the `Core` is in state `Ready`, use start(). It will then go to state `On`
	/// and from that you can start using it for calls and chat messages. It is
	/// recommended to add a LinphoneCoreCbs listener using linphone_core_add_listener
	/// to it to monitor different events.
	/// To be able to receive events from the network, you must schedule a call
	/// iterate() often, like every 20ms. On Android & iOS isAutoIterateEnabled() is
	/// enabled by default so you don't have to worry about that unless you disable it
	/// using linphone_core_set_auto_iterate_enabled or by setting in the [misc]
	/// section of your configuration auto_iterate=0. - Warning: Our API isn't
	/// thread-safe but also isn't blocking, so it is strongly recommend to always call
	/// our methods from the main thread.
	/// Once you don't need it anymore, call stop() and release the reference on it so
	/// it can gracefully shutdown. 
	public func addDelegate(delegate: CoreDelegate)
	{
		let manager = CoreDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_core_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// Main object to instanciate and on which to keep a reference. 
	/// This object is the first object to instanciante, and will allow you to perform
	/// all kind of tasks. To create it, use either Factory.createCore() or
	/// Factory.createCoreWithConfig(), see `Config` for more information about factory
	/// and default config. On some platforms like Android or iOS you will need to give
	/// it the Context of your application.
	/// Once the `Core` is in state `Ready`, use start(). It will then go to state `On`
	/// and from that you can start using it for calls and chat messages. It is
	/// recommended to add a LinphoneCoreCbs listener using linphone_core_add_listener
	/// to it to monitor different events.
	/// To be able to receive events from the network, you must schedule a call
	/// iterate() often, like every 20ms. On Android & iOS isAutoIterateEnabled() is
	/// enabled by default so you don't have to worry about that unless you disable it
	/// using linphone_core_set_auto_iterate_enabled or by setting in the [misc]
	/// section of your configuration auto_iterate=0. - Warning: Our API isn't
	/// thread-safe but also isn't blocking, so it is strongly recommend to always call
	/// our methods from the main thread.
	/// Once you don't need it anymore, call stop() and release the reference on it so
	/// it can gracefully shutdown. 
	public func removeDelegate(delegate: CoreDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_core_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Compress the log collection in a single file. 
	/// - Returns: The path of the compressed log collection file (to be freed calling
	/// ms_free()).     
	static public func compressLogCollection() -> String
	{
		let cstr = linphone_core_compress_log_collection()
		let result = charArrayToString(charPointer: cstr)
		if (cstr != nil) {
			bctbx_free(cstr)
		}
		return result
	}

	/// Enable the linphone core log collection to upload logs on a server. 
	/// - Parameter state: `LogCollectionState` value telling whether to enable log
	/// collection or not. 
	static public func enableLogCollection(state:LogCollectionState) 
	{
		linphone_core_enable_log_collection(LinphoneLogCollectionState(rawValue: CUnsignedInt(state.rawValue)))
	}

	/// Get the max file size in bytes of the files used for log collection. 
	/// - Returns: The max file size in bytes of the files used for log collection.   
	static public var getLogCollectionMaxFileSize: Int
	{
			return Int(linphone_core_get_log_collection_max_file_size())
	}

	/// Get the path where the log files will be written for log collection. 
	/// - Returns: The path where the log files will be written.   
	static public var getLogCollectionPath: String
	{
			let cPointer = linphone_core_get_log_collection_path()
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the prefix of the filenames that will be used for log collection. 
	/// - Returns: The prefix of the filenames used for log collection.   
	static public var getLogCollectionPrefix: String
	{
			let cPointer = linphone_core_get_log_collection_prefix()
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns liblinphone's version as a string. 
	/// - Returns: the current version of the `Core`   
	static public var getVersion: String
	{
			let cPointer = linphone_core_get_version()
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Tells whether the linphone core log collection is enabled. 
	/// - Returns: The `LogCollectionState` of the `Core` log collection. 
	static public func logCollectionEnabled() -> LogCollectionState
	{
		return LogCollectionState(rawValue: Int(linphone_core_log_collection_enabled().rawValue))!
	}

	/// Reset the log collection by removing the log files. 
	static public func resetLogCollection() 
	{
		linphone_core_reset_log_collection()
	}

	/// Enable logs serialization (output logs from either the thread that creates the
	/// linphone core or the thread that calls iterate()). 
	/// Must be called before creating the linphone core. 
	static public func serializeLogs() 
	{
		linphone_core_serialize_logs()
	}

	/// Set the max file size in bytes of the files used for log collection. 
	/// Warning: this function should only not be used to change size dynamically but
	/// instead only before calling enableLogCollection(). If you increase max size on
	/// runtime, logs chronological order COULD be broken. 
	/// - Parameter size: The max file size in bytes of the files used for log
	/// collection. 
	static public func setLogCollectionMaxFileSize(size:Int) 
	{
		linphone_core_set_log_collection_max_file_size(size)
	}

	/// Set the path of a directory where the log files will be written for log
	/// collection. 
	/// When log collection is enabled, the function will close the file with the
	/// current prefix in the old path and it will open the new file with current
	/// prefix in the new path. If you need to change the path and the file at the same
	/// time, then you should deactivate log collection with enableLogCollection()
	/// before doing modifications. 
	/// - Parameter path: The path where the log files will be written.   
	static public func setLogCollectionPath(path:String) 
	{
		linphone_core_set_log_collection_path(path)
	}

	/// Set the prefix of the filenames that will be used for log collection. 
	/// When log collection is enabled, the function will close the old file and it
	/// will open the new one in the current path. If you need to change the path and
	/// the file at the same time, then you should deactivate log collection with
	/// enableLogCollection() before doing modifications. 
	/// - Parameter prefix: The prefix to use for the filenames for log collection.   
	static public func setLogCollectionPrefix(prefix:String) 
	{
		linphone_core_set_log_collection_prefix(prefix)
	}

	/// True if tunnel support was compiled. 
	/// - Returns: true if library was built with tunnel, false otherwise 
	static public func tunnelAvailable() -> Bool
	{
		return linphone_core_tunnel_available() != 0
	}

	/// Return the availability of uPnP. 
	/// - Returns: true if uPnP is available otherwise return false. 
	static public func upnpAvailable() -> Bool
	{
		return linphone_core_upnp_available() != 0
	}

	/// Tells whether VCARD support is builtin. 
	/// - Returns: true if VCARD is supported, false otherwise. 
	static public func vcardSupported() -> Bool
	{
		return linphone_core_vcard_supported() != 0
	}

	/// Returns an unmodifiable list of entered accounts. 
	/// - Returns:     
	public var accountList: [Account]
	{
			var swiftList = [Account]()
			let cList = linphone_core_get_account_list(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Account.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Returns which adaptive rate algorithm is currently configured for future calls. 
	/// - See also: setAdaptiveRateAlgorithm() 
	/// - Returns: the adaptive rate algorithm. Currently two values are supported:
	/// 'advanced', which is the default value, or 'basic'.   
	public var adaptiveRateAlgorithm: String
	{
		get
		{
			let cPointer = linphone_core_get_adaptive_rate_algorithm(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_adaptive_rate_algorithm(cPtr, newValue)
		}
	}

	/// Returns whether adaptive rate control is enabled. 
	/// - See also: enableAdaptiveRateControl()
	/// - Returns: true if adaptive rate control is enabled, false otherwise 
	public var adaptiveRateControlEnabled: Bool
	{
		get
		{
			return linphone_core_adaptive_rate_control_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_adaptive_rate_control(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether the audio adaptive jitter compensation is enabled. 
	/// - Returns: true if the audio adaptive jitter compensation is enabled, false
	/// otherwise. 
	public var audioAdaptiveJittcompEnabled: Bool
	{
		get
		{
			return linphone_core_audio_adaptive_jittcomp_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_audio_adaptive_jittcomp(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns a list of audio devices, with only the first device for each type To
	/// have the list of all audio devices, use getExtendedAudioDevices() 
	/// - Returns:   A list with the first `AudioDevice` of each type     
	public var audioDevices: [AudioDevice]
	{
			var swiftList = [AudioDevice]()
			let cList = linphone_core_get_audio_devices(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(AudioDevice.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Get the DSCP field for outgoing audio streams. 
	/// The DSCP defines the quality of service in IP packets. 
	/// - Returns: The current DSCP value 
	public var audioDscp: Int
	{
		get
		{
			return Int(linphone_core_get_audio_dscp(cPtr))
		}
		set
		{
			linphone_core_set_audio_dscp(cPtr, CInt(newValue))
		}
	}

	/// Returns the nominal audio jitter buffer size in milliseconds. 
	/// - Returns: The nominal audio jitter buffer size in milliseconds 
	public var audioJittcomp: Int
	{
		get
		{
			return Int(linphone_core_get_audio_jittcomp(cPtr))
		}
		set
		{
			linphone_core_set_audio_jittcomp(cPtr, CInt(newValue))
		}
	}

	/// Use to get multicast address to be used for audio stream. 
	/// - Returns: an ipv4/6 multicast address or default value.   
	public var audioMulticastAddr: String
	{
			let cPointer = linphone_core_get_audio_multicast_addr(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setAudiomulticastaddr(newValue: String) throws
	{
		let exception_result = linphone_core_set_audio_multicast_addr(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Use to get multicast state of audio stream. 
	/// - Returns: true if subsequent calls will propose multicast ip set by
	/// setAudioMulticastAddr() 
	public var audioMulticastEnabled: Bool
	{
		get
		{
			return linphone_core_audio_multicast_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_audio_multicast(cPtr, newValue==true ? 1:0)
		}
	}

	/// Use to get multicast ttl to be used for audio stream. 
	/// - Returns: a time to leave value 
	public var audioMulticastTtl: Int
	{
			return Int(linphone_core_get_audio_multicast_ttl(cPtr))
	}

	public func setAudiomulticastttl(newValue: Int) throws
	{
		let exception_result = linphone_core_set_audio_multicast_ttl(cPtr, CInt(newValue))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Return the list of the available audio payload types. 
	/// - Returns: A freshly allocated list of the available payload types. The list
	/// must be destroyed with bctbx_list_free() after usage. The elements of the list
	/// haven't to be unref.    
	public var audioPayloadTypes: [PayloadType]
	{
		get
		{
			var swiftList = [PayloadType]()
			let cList = linphone_core_get_audio_payload_types(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(PayloadType.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
		}
		set
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				cList = bctbx_list_append(cList, UnsafeMutableRawPointer(data.cPtr))
			}
			linphone_core_set_audio_payload_types(cPtr, cList)
		}
	}

	/// Gets the UDP port used for audio streaming. 
	/// - Returns: The UDP port used for audio streaming 
	public var audioPort: Int
	{
		get
		{
			return Int(linphone_core_get_audio_port(cPtr))
		}
		set
		{
			linphone_core_set_audio_port(cPtr, CInt(newValue))
		}
	}

	/// Get the audio port range from which is randomly chosen the UDP port used for
	/// audio streaming. 
	/// - Returns: a `Range` object     
	public var audioPortsRange: Range?
	{
			let cPointer = linphone_core_get_audio_ports_range(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Range.getSwiftObject(cObject:cPointer!)
			belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
			return result
	}

	/// Returns an unmodifiable list of currently entered `AuthInfo`. 
	/// - Returns: A list of `AuthInfo`.    
	public var authInfoList: [AuthInfo]
	{
			var swiftList = [AuthInfo]()
			let cList = linphone_core_get_auth_info_list(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(AuthInfo.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Gets if the auto download for incoming icalendars is enabled or not. 
	/// - Returns: true if icalendars will be automatically downloaded, false
	/// otherwise. 
	public var autoDownloadIcalendarsEnabled: Bool
	{
		get
		{
			return linphone_core_auto_download_icalendars_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_auto_download_icalendars(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets if the auto download for incoming voice recordings is enabled or not. 
	/// - Returns: true if voice recordings will be automatically downloaded, false
	/// otherwise. 
	public var autoDownloadVoiceRecordingsEnabled: Bool
	{
		get
		{
			return linphone_core_auto_download_voice_recordings_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_auto_download_voice_recordings(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets whether auto iterate is enabled or not (Android & iOS only). 
	/// - Returns: true if iterate() is scheduled automatically, false otherwise 
	public var autoIterateEnabled: Bool
	{
		get
		{
			return linphone_core_auto_iterate_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_auto_iterate(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets if the automatic sending of 180 Ringing is enabled or not. 
	/// - Returns: true if the automatic sending of 180 Ringing is enabled, false
	/// otherwise. 
	public var autoSendRingingEnabled: Bool
	{
		get
		{
			return linphone_core_auto_send_ringing_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_auto_send_ringing(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns whether automatic http proxy is enabled. 
	/// - Returns: true if automatic http proxy is enabled or false. 
	public var automaticHttpProxyDetectionEnabled: Bool
	{
		get
		{
			return linphone_core_automatic_http_proxy_detection_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_automatic_http_proxy_detection(cPtr, newValue==true ? 1:0)
		}
	}

	/// Return AVPF enablement. 
	/// See setAvpfMode() . 
	/// - Returns: The current `AVPFMode` mode 
	public var avpfMode: AVPFMode
	{
		get
		{
			return AVPFMode(rawValue: Int(linphone_core_get_avpf_mode(cPtr).rawValue))!
		}
		set
		{
			linphone_core_set_avpf_mode(cPtr, LinphoneAVPFMode(rawValue: CInt(newValue.rawValue)))
		}
	}

	/// Return the avpf report interval in seconds. 
	/// - Returns: The current AVPF report interval in seconds 
	public var avpfRrInterval: Int
	{
		get
		{
			return Int(linphone_core_get_avpf_rr_interval(cPtr))
		}
		set
		{
			linphone_core_set_avpf_rr_interval(cPtr, CInt(newValue))
		}
	}

	/// Get the list of call logs (past calls). 
	/// - Returns: A list of `CallLog`.    
	public var callLogs: [CallLog]
	{
			var swiftList = [CallLog]()
			let cList = linphone_core_get_call_logs(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(CallLog.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Gets the database filename where call logs will be stored. 
	/// - Returns: filesystem path.   
	public var callLogsDatabasePath: String
	{
		get
		{
			let cPointer = linphone_core_get_call_logs_database_path(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_call_logs_database_path(cPtr, newValue)
		}
	}

	/// Special function to check if the callkit is enabled, False by default. 
	/// - Returns: true if callkit is enabled, false otherwise. 
	public var callkitEnabled: Bool
	{
		get
		{
			return linphone_core_callkit_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_callkit(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the current list of calls. 
	/// Note that this list is read-only and might be changed by the core after a
	/// function call to iterate(). Similarly the `Call` objects inside it might be
	/// destroyed without prior notice. To hold references to `Call` object into your
	/// program, you must use linphone_call_ref. 
	/// - Returns: A list of `Call`    
	public var calls: [Call]
	{
			var swiftList = [Call]()
			let cList = linphone_core_get_calls(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Call.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Get the number of Call. 
	/// - Returns: The current number of calls 
	public var callsNb: Int
	{
			return Int(linphone_core_get_calls_nb(cPtr))
	}

	/// Get the camera sensor rotation. 
	/// This is needed on some mobile platforms to get the number of degrees the camera
	/// sensor is rotated relative to the screen. 
	/// - Returns: The camera sensor rotation in degrees (0 to 360) or -1 if it could
	/// not be retrieved 
	public var cameraSensorRotation: Int
	{
			return Int(linphone_core_get_camera_sensor_rotation(cPtr))
	}

	/// Check if the capability negotiation (RFC5939) is supported or not. 
	/// - Returns: true if capability negotiation is supported; false otherwise. 
	public var capabilityNegociationEnabled: Bool
	{
		get
		{
			return linphone_core_capability_negociation_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_capability_negociation(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check if the capability negotiation (RFC5939) reINVITE is enabled or not. 
	/// - Returns: true if capability negotiation reINVITE is enabled; false otherwise. 
	public var capabilityNegotiationReinviteEnabled: Bool
	{
		get
		{
			return linphone_core_capability_negotiation_reinvite_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_capability_negotiation_reinvite(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the name of the currently assigned sound device for capture. 
	/// - Returns: The name of the currently assigned sound device for capture.   
	public var captureDevice: String
	{
			let cPointer = linphone_core_get_capture_device(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setCapturedevice(newValue: String) throws
	{
		let exception_result = linphone_core_set_capture_device(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns whether chat is enabled. 
	/// - Returns: true if chat is enabled, false otherwise 
	public var chatEnabled: Bool
	{
			return linphone_core_chat_enabled(cPtr) != 0
	}

	/// Returns a list of chat rooms. 
	/// - Returns: List of chat rooms.    
	public var chatRooms: [ChatRoom]
	{
			var swiftList = [ChatRoom]()
			let cList = linphone_core_get_chat_rooms(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(ChatRoom.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Get a pointer on the internal conference object. 
	/// - Returns: A pointer on `Conference` or nil if no conference are going on.   
	public var conference: Conference?
	{
			let cPointer = linphone_core_get_conference(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Conference.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the set input volume of the local participant. 
	/// - Returns: A value inside [0.0 ; 1.0] 
	public var conferenceLocalInputVolume: Float
	{
			return linphone_core_get_conference_local_input_volume(cPtr)
	}

	/// Tells whether the conference server feature is enabled. 
	/// - Returns: A boolean value telling whether the conference server feature is
	/// enabled or not 
	public var conferenceServerEnabled: Bool
	{
		get
		{
			return linphone_core_conference_server_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_conference_server(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the number of participants including me, if it in, in the running
	/// conference. 
	/// The local participant is included in the count only if it is in the conference. 
	/// - Returns: The number of participants including me, if it in. 
	/// - deprecated: 16/04/2021 Use Conference.getParticipantCount() instead. 
	@available(*, deprecated)
	public var conferenceSize: Int
	{
			return Int(linphone_core_get_conference_size(cPtr))
	}

	/// Returns the config object used to manage the storage (config) file. 
	/// - Returns: a `Config` object.   
	public var config: Config?
	{
			let cPointer = linphone_core_get_config(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Config.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get my consolidated presence. 
	/// - Returns: My `ConsolidatedPresence` presence 
	public var consolidatedPresence: ConsolidatedPresence
	{
		get
		{
			return ConsolidatedPresence(rawValue: Int(linphone_core_get_consolidated_presence(cPtr).rawValue))!
		}
		set
		{
			linphone_core_set_consolidated_presence(cPtr, LinphoneConsolidatedPresence(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Gets the current call. 
	/// - Returns: The current call or nil if no call is running.   
	public var currentCall: Call?
	{
			let cPointer = linphone_core_get_current_call(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Call.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the remote address of the current call. 
	/// - Returns: The remote address of the current call or nil if there is no current
	/// call.   
	public var currentCallRemoteAddress: Address?
	{
			let cPointer = linphone_core_get_current_call_remote_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the current LinphoneCoreCbs. 
	/// This is meant only to be called from a callback to be able to get the user_data
	/// associated with the LinphoneCoreCbs that is calling the callback. 
	/// - Returns: the LinphoneCoreCbs that has called the last callback   
	public var currentDelegate: CoreDelegate?
	{
			let cObject = linphone_core_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<CoreDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Get the effective video definition provided by the camera for the captured
	/// video. 
	/// When preview is disabled or not yet started this function returns a 0x0 video
	/// definition. 
	/// - Returns: The captured `VideoDefinition`.  
	/// - See also: setPreviewVideoDefinition() 
	public var currentPreviewVideoDefinition: VideoDefinition?
	{
			let cPointer = linphone_core_get_current_preview_video_definition(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = VideoDefinition.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the default account, that is the one used to determine the current
	/// identity. 
	/// - Returns: The default account.   
	public var defaultAccount: Account?
	{
		get
		{
			let cPointer = linphone_core_get_default_account(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Account.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_core_set_default_account(cPtr, newValue?.cPtr)
		}
	}

	/// Gets the default lifetime of ephemeral messages in seconds @core core the
	/// linphone core. 
	/// - Returns: lifetime of ephemeral messages in seconds 
	public var defaultEphemeralLifetime: Int
	{
		get
		{
			return Int(linphone_core_get_default_ephemeral_lifetime(cPtr))
		}
		set
		{
			linphone_core_set_default_ephemeral_lifetime(cPtr, (newValue))
		}
	}

	/// Retrieves the first list of `Friend` from the core. 
	/// - Returns: the first `FriendList` object or nil.   
	public var defaultFriendList: FriendList?
	{
			let cPointer = linphone_core_get_default_friend_list(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = FriendList.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the default input audio device. 
	/// - Returns: The default input audio device   
	public var defaultInputAudioDevice: AudioDevice?
	{
		get
		{
			let cPointer = linphone_core_get_default_input_audio_device(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = AudioDevice.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_core_set_default_input_audio_device(cPtr, newValue?.cPtr)
		}
	}

	/// Gets the default output audio device. 
	/// - Returns: The default output audio device   
	public var defaultOutputAudioDevice: AudioDevice?
	{
		get
		{
			let cPointer = linphone_core_get_default_output_audio_device(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = AudioDevice.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_core_set_default_output_audio_device(cPtr, newValue?.cPtr)
		}
	}

	/// Returns the default proxy configuration, that is the one used to determine the
	/// current identity. 
	/// - Returns: The default proxy configuration.   
	public var defaultProxyConfig: ProxyConfig?
	{
		get
		{
			let cPointer = linphone_core_get_default_proxy_config(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ProxyConfig.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_core_set_default_proxy_config(cPtr, newValue?.cPtr)
		}
	}

	/// Get the name of the default mediastreamer2 filter used for rendering video on
	/// the current platform. 
	/// This is for advanced users of the library, mainly to expose mediastreamer video
	/// filter name and status. 
	/// - Returns: The default video display filter.   
	public var defaultVideoDisplayFilter: String
	{
			let cPointer = linphone_core_get_default_video_display_filter(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Gets the delayed timeout See setDelayedTimeout() for details. 
	/// - Returns: The current delayed timeout in seconds 
	public var delayedTimeout: Int
	{
		get
		{
			return Int(linphone_core_get_delayed_timeout(cPtr))
		}
		set
		{
			linphone_core_set_delayed_timeout(cPtr, CInt(newValue))
		}
	}

	/// Gets the current device orientation. 
	/// - Returns: The current device orientation
	/// - See also: setDeviceRotation() 
	public var deviceRotation: Int
	{
		get
		{
			return Int(linphone_core_get_device_rotation(cPtr))
		}
		set
		{
			linphone_core_set_device_rotation(cPtr, CInt(newValue))
		}
	}

	/// Get the current digest authentication policy applicable for SIP and HTTP. 
	/// Get the current digest authentication policy applicable for SIP and HTTP. 
	/// - Returns: The current digest authentication policy.   
	public var digestAuthenticationPolicy: DigestAuthenticationPolicy?
	{
		get
		{
			let cPointer = linphone_core_get_digest_authentication_policy(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = DigestAuthenticationPolicy.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_core_set_digest_authentication_policy(cPtr, newValue?.cPtr)
		}
	}

	/// Get whether the microphone will be completely deactivated when muted. 
	/// Please refer to setDisableRecordOnMute().
	/// - Returns: True if you wish to entirely stop the audio recording when muting
	/// the microphone. 
	public var disableRecordOnMute: Bool
	{
		get
		{
			return linphone_core_get_disable_record_on_mute(cPtr) != 0
		}
		set
		{
			linphone_core_set_disable_record_on_mute(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether DNS search (use of local domain if the fully qualified name did
	/// return results) is enabled. 
	/// - Returns: true if DNS search is enabled, false if disabled. 
	public var dnsSearchEnabled: Bool
	{
		get
		{
			return linphone_core_dns_search_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_dns_search(cPtr, newValue==true ? 1:0)
		}
	}

	/// Forces liblinphone to use the supplied list of dns servers, instead of system's
	/// ones. 
	/// - Parameter servers: A list of strings containing the IP addresses of DNS
	/// servers to be used.  Setting to nil restores default behaviour, which is to use
	/// the DNS server list provided by the system. The list is copied internally.   
	public var dnsServers: [String] = []
	{
		willSet
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				let sData:NSString = data as NSString
				cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
			}
			linphone_core_set_dns_servers(cPtr, cList)
		}
	}

	/// Forces liblinphone to use the supplied list of dns servers, instead of system's
	/// ones and set dns_set_by_app at true or false according to value of servers
	/// list. 
	/// - Parameter servers: A list of strings containing the IP addresses of DNS
	/// servers to be used.  Setting to nil restores default behaviour, which is to use
	/// the DNS server list provided by the system. The list is copied internally.   
	public var dnsServersApp: [String] = []
	{
		willSet
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				let sData:NSString = data as NSString
				cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
			}
			linphone_core_set_dns_servers_app(cPtr, cList)
		}
	}

	/// Tells if the DNS was set by an application. 
	/// - Returns: true if DNS was set by app, false otherwise. 
	public var dnsSetByApp: Bool
	{
			return linphone_core_get_dns_set_by_app(cPtr) != 0
	}

	/// Tells whether DNS SRV resolution is enabled. 
	/// - Returns: true if DNS SRV resolution is enabled, false if disabled. 
	public var dnsSrvEnabled: Bool
	{
		get
		{
			return linphone_core_dns_srv_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_dns_srv(cPtr, newValue==true ? 1:0)
		}
	}

	/// Retrieve the maximum available download bandwidth. 
	/// This value was set by setDownloadBandwidth(). 
	/// - Returns: the download bandiwdth in kbits/s, 0 for infinite 
	public var downloadBandwidth: Int
	{
		get
		{
			return Int(linphone_core_get_download_bandwidth(cPtr))
		}
		set
		{
			linphone_core_set_download_bandwidth(cPtr, CInt(newValue))
		}
	}

	/// Get audio packetization time linphone expects to receive from peer. 
	/// A value of zero means that ptime is not specified. 
	/// - Returns: the download packetization time set 
	public var downloadPtime: Int
	{
		get
		{
			return Int(linphone_core_get_download_ptime(cPtr))
		}
		set
		{
			linphone_core_set_download_ptime(cPtr, CInt(newValue))
		}
	}

	/// Returns true if echo cancellation is enabled. 
	/// - Returns: A boolean value telling whether echo cancellation is enabled or
	/// disabled 
	public var echoCancellationEnabled: Bool
	{
		get
		{
			return linphone_core_echo_cancellation_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_echo_cancellation(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the name of the mediastreamer2 filter used for echo cancelling. 
	/// - Returns: The name of the mediastreamer2 filter used for echo cancelling.   
	public var echoCancellerFilterName: String
	{
		get
		{
			let cPointer = linphone_core_get_echo_canceller_filter_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_echo_canceller_filter_name(cPtr, newValue)
		}
	}

	/// Tells whether echo limiter is enabled. 
	/// - Returns: true if the echo limiter is enabled, false otherwise. 
	public var echoLimiterEnabled: Bool
	{
		get
		{
			return linphone_core_echo_limiter_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_echo_limiter(cPtr, newValue==true ? 1:0)
		}
	}

	/// Enable or disable the UPDATE method support. 
	/// - Parameter value: Enable or disable it 
	public var enableSipUpdate: Int = 0
	{
		willSet
		{
			linphone_core_set_enable_sip_update(cPtr, CInt(newValue))
		}
	}

	/// Sets expected available upload bandwidth This is IP bandwidth, in kbit/s. 
	/// This information is used by liblinphone together with remote side available
	/// bandwidth signaled in SDP messages to properly configure audio & video codec's
	/// output bitrate.
	/// - Parameter bandwidth: the bandwidth in kbits/s, 0 for infinite 
	public var expectedBandwidth: Int = 0
	{
		willSet
		{
			linphone_core_set_expected_bandwidth(cPtr, CInt(newValue))
		}
	}

	/// Returns the list of all audio devices. 
	/// - Returns:   A list of all `AudioDevice`     
	public var extendedAudioDevices: [AudioDevice]
	{
			var swiftList = [AudioDevice]()
			let cList = linphone_core_get_extended_audio_devices(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(AudioDevice.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Get the globaly set http file transfer server to be used for content type
	/// application/vnd.gsma.rcs-ft-http+xml. 
	/// Url may be like: "https://file.linphone.org/upload.php". 
	/// - Returns: URL of the file server.   
	public var fileTransferServer: String
	{
		get
		{
			let cPointer = linphone_core_get_file_transfer_server(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_file_transfer_server(cPtr, newValue)
		}
	}

	/// Indicates whether the ICE relay path is forcibly selected. 
	/// - Returns: a boolean value indicating whether forced relay is enabled.
	/// - See also: enableForcedIceRelay(). 
	public var forcedIceRelayEnabled: Bool
	{
		get
		{
			return linphone_core_forced_ice_relay_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_forced_ice_relay(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns whether or not friend lists subscription are enabled. 
	/// - Returns: whether or not the feature is enabled 
	public var friendListSubscriptionEnabled: Bool
	{
		get
		{
			return linphone_core_friend_list_subscription_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_friend_list_subscription(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the database filename where friends will be stored. 
	/// - Returns: filesystem path.   
	public var friendsDatabasePath: String
	{
		get
		{
			let cPointer = linphone_core_get_friends_database_path(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_friends_database_path(cPtr, newValue)
		}
	}

	/// Retrieves the list of `FriendList` from the core. 
	/// - Returns: A list of `FriendList`.    
	public var friendsLists: [FriendList]
	{
			var swiftList = [FriendList]()
			let cList = linphone_core_get_friends_lists(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(FriendList.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Returns the global state of core. 
	/// - Returns: a `GlobalState` enum.   
	public var globalState: GlobalState
	{
			return GlobalState(rawValue: Int(linphone_core_get_global_state(cPtr).rawValue))!
	}

	/// Returns true if hostname part of primary contact is guessed automatically. 
	/// - Returns: true if guess hostname enabled, false otherwise. 
	public var guessHostname: Bool
	{
		get
		{
			return linphone_core_get_guess_hostname(cPtr) != 0
		}
		set
		{
			linphone_core_set_guess_hostname(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get http proxy address to be used for signaling. 
	/// - Returns: hostname of IP adress of the http proxy (can be nil to disable).   
	public var httpProxyHost: String
	{
		get
		{
			let cPointer = linphone_core_get_http_proxy_host(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_http_proxy_host(cPtr, newValue)
		}
	}

	/// Get http proxy port to be used for signaling. 
	/// - Returns: port of the http proxy. 
	public var httpProxyPort: Int
	{
		get
		{
			return Int(linphone_core_get_http_proxy_port(cPtr))
		}
		set
		{
			linphone_core_set_http_proxy_port(cPtr, CInt(newValue))
		}
	}

	/// Gets the default identity SIP address. 
	/// This is an helper function. If no default proxy is set, this will return the
	/// primary contact ( see getPrimaryContact() ). If a default proxy is set it
	/// returns the registered identity on the proxy. 
	/// - Returns: The default identity SIP address.   
	public var identity: String
	{
			let cPointer = linphone_core_get_identity(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the `ImNotifPolicy` object controlling the instant messaging notifications. 
	/// - Returns: A `ImNotifPolicy` object.   
	public var imNotifPolicy: ImNotifPolicy?
	{
			let cPointer = linphone_core_get_im_notif_policy(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ImNotifPolicy.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the in call timeout See setInCallTimeout() for details. 
	/// - Returns: The current in call timeout in seconds 
	public var inCallTimeout: Int
	{
		get
		{
			return Int(linphone_core_get_in_call_timeout(cPtr))
		}
		set
		{
			linphone_core_set_in_call_timeout(cPtr, CInt(newValue))
		}
	}

	/// Returns the incoming call timeout See setIncTimeout() for details. 
	/// - Returns: The current incoming call timeout in seconds 
	public var incTimeout: Int
	{
		get
		{
			return Int(linphone_core_get_inc_timeout(cPtr))
		}
		set
		{
			linphone_core_set_inc_timeout(cPtr, CInt(newValue))
		}
	}

	/// Gets the input audio device for the current call. 
	/// - Returns: The input audio device for the current or first call, nil if there
	/// is no call.   
	public var inputAudioDevice: AudioDevice?
	{
		get
		{
			let cPointer = linphone_core_get_input_audio_device(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = AudioDevice.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_core_set_input_audio_device(cPtr, newValue?.cPtr)
		}
	}

	/// Tells whether IPv6 is enabled or not. 
	/// - Returns: A boolean value telling whether IPv6 is enabled or not
	/// - See also: enableIpv6() for more details on how IPv6 is supported in
	/// liblinphone. 
	public var ipv6Enabled: Bool
	{
		get
		{
			return linphone_core_ipv6_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_ipv6(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets if the auto download for incoming icalendars is enabled or not. 
	/// - Returns: true if icalendars will be automatically downloaded, false otherwise.
	/// - deprecated: 16/12/2021 Use autoDownloadIcalendarsEnabled() instead. 
	@available(*, deprecated)
	public var isAutoDownloadIcalendarsEnabled: Bool
	{
			return linphone_core_is_auto_download_icalendars_enabled(cPtr) != 0
	}

	/// Gets if the auto download for incoming voice recordings is enabled or not. 
	/// - Returns: true if voice recordings will be automatically downloaded, false
	/// otherwise.
	/// - deprecated: 16/12/2021 Use autoDownloadVoiceRecordingsEnabled() instead. 
	@available(*, deprecated)
	public var isAutoDownloadVoiceRecordingsEnabled: Bool
	{
			return linphone_core_is_auto_download_voice_recordings_enabled(cPtr) != 0
	}

	/// Gets whether auto iterate is enabled or not (Android & iOS only). 
	/// - Returns: true if iterate() is scheduled automatically, false otherwise
	/// - deprecated: 16/12/2021 Use autoIterateEnabled() instead. 
	@available(*, deprecated)
	public var isAutoIterateEnabled: Bool
	{
			return linphone_core_is_auto_iterate_enabled(cPtr) != 0
	}

	/// Check if the capability negotiation (RFC5939) reINVITE is enabled or not. 
	/// - Returns: true if capability negotiation reINVITE is enabled; false otherwise.
	/// - deprecated: 16/12/2021 Use capabilityNegotiationReinviteEnabled() instead. 
	@available(*, deprecated)
	public var isCapabilityNegotiationReinviteEnabled: Bool
	{
			return linphone_core_is_capability_negotiation_reinvite_enabled(cPtr) != 0
	}

	/// Check whether the device is echo canceller calibration is required. 
	/// - Returns: true if it is required, false otherwise 
	public var isEchoCancellerCalibrationRequired: Bool
	{
			return linphone_core_is_echo_canceller_calibration_required(cPtr) != 0
	}

	/// Returns whether or not friend lists subscription are enabled. 
	/// - Returns: whether or not the feature is enabled 
	/// - deprecated: 16/12/2021 Use friendListSubscriptionEnabled() instead. 
	@available(*, deprecated)
	public var isFriendListSubscriptionEnabled: Bool
	{
			return linphone_core_is_friend_list_subscription_enabled(cPtr) != 0
	}

	/// Gets whether the Core is considering itself in background or not. 
	/// The Core foreground/background state depends on the last call made to
	/// enterBackground() or enterForeground(). - Returns: true if the Core is in
	/// background, false otherwise. 
	public var isInBackground: Bool
	{
			return linphone_core_is_in_background(cPtr) != 0
	}

	/// Indicates whether the local participant is part of a conference. 
	/// - Warning: That function automatically fails in the case of conferences using a
	/// conferencet server (focus). If you use such a conference, you should use
	/// Conference.removeParticipant() instead. 
	/// - Returns: true if the local participant is in a conference, false otherwise. 
	/// - deprecated: 09/03/2021 Use Conference.isIn() instead. 
	@available(*, deprecated)
	public var isInConference: Bool
	{
			return linphone_core_is_in_conference(cPtr) != 0
	}

	/// Tells whether there is an incoming invite pending. 
	/// - Returns: A boolean telling whether an incoming invite is pending or not. 
	public var isIncomingInvitePending: Bool
	{
			return linphone_core_is_incoming_invite_pending(cPtr) != 0
	}

	/// Check if the configured media encryption is mandatory or not. 
	/// - Returns: true if media encryption is mandatory; false otherwise. 
	public var isMediaEncryptionMandatory: Bool
	{
			return linphone_core_is_media_encryption_mandatory(cPtr) != 0
	}

	/// Returns whether the native ringing is enabled or not. 
	/// - Returns: True if we use the native ringing, false otherwise
	/// - deprecated: 16/12/2021 Use nativeRingingEnabled() instead. 
	@available(*, deprecated)
	public var isNativeRingingEnabled: Bool
	{
			return linphone_core_is_native_ringing_enabled(cPtr) != 0
	}

	/// return network state either as positioned by the application or by linphone
	/// itself. 
	/// - Returns: true if network is reachable, false otherwise 
	public var isNetworkReachable: Bool
	{
			return linphone_core_is_network_reachable(cPtr) != 0
	}

	/// Gets whether push notifications are available or not (Android & iOS only). 
	/// - Returns: true if push notifications are available, false otherwise 
	public var isPushNotificationAvailable: Bool
	{
			return linphone_core_is_push_notification_available(cPtr) != 0
	}

	/// Gets whether push notifications are enabled or not (Android & iOS only). 
	/// If not, the app will have to handle all the push-related settings for each
	/// accounts 
	/// - Returns: true if push notifications are enabled, false otherwise
	/// - deprecated: 16/12/2021 Use pushNotificationEnabled() instead. 
	@available(*, deprecated)
	public var isPushNotificationEnabled: Bool
	{
			return linphone_core_is_push_notification_enabled(cPtr) != 0
	}

	/// Gets if the record aware feature is enabled or not. 
	/// - Returns: true if the record aware feature is enabled, false otherwise. 
	/// - deprecated: 16/12/2021 Use recordAwareEnabled() instead. 
	@available(*, deprecated)
	public var isRecordAwareEnabled: Bool
	{
			return linphone_core_is_record_aware_enabled(cPtr) != 0
	}

	/// Returns whether or not sender name is hidden in forward message. 
	/// - Returns: whether or not the feature 
	public var isSenderNameHiddenInForwardMessage: Bool
	{
			return linphone_core_is_sender_name_hidden_in_forward_message(cPtr) != 0
	}

	/// Get whether the tls server certificate must be verified when connecting to a
	/// SIP/TLS server. 
	/// - Returns: True if the tls server certificate must be verified 
	public var isVerifyServerCertificates: Bool
	{
			return linphone_core_is_verify_server_certificates(cPtr) != 0
	}

	/// Get whether the tls server certificate common name must be verified when
	/// connecting to a SIP/TLS server. 
	/// - Returns: True if the tls server certificate common name must be verified 
	public var isVerifyServerCn: Bool
	{
			return linphone_core_is_verify_server_cn(cPtr) != 0
	}

	/// Gets whether the device will vibrate while an incoming call is ringing (Android
	/// only). 
	/// - Returns: true if the device will vibrate (if possible), false otherwise
	/// - deprecated: 16/12/2021 Use vibrationOnIncomingCallEnabled() instead. 
	@available(*, deprecated)
	public var isVibrationOnIncomingCallEnabled: Bool
	{
			return linphone_core_is_vibration_on_incoming_call_enabled(cPtr) != 0
	}

	/// Check if RTP port is set to 0 when a stream is inactive. 
	/// - Returns: true if the RTP port is set to 0 if the stream direction is
	/// inactive; false otherwise.
	/// - deprecated: 16/12/2021 Use zeroRtpPortForStreamInactiveEnabled() instead. 
	@available(*, deprecated)
	public var isZeroRtpPortForStreamInactiveEnabled: Bool
	{
			return linphone_core_is_zero_rtp_port_for_stream_inactive_enabled(cPtr) != 0
	}

	/// Is signaling keep alive enabled. 
	/// - Returns: A boolean value telling whether signaling keep alive is enabled 
	public var keepAliveEnabled: Bool
	{
		get
		{
			return linphone_core_keep_alive_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_keep_alive(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the latest outgoing call log. 
	/// - Returns: The last outgoing call log if any.   
	public var lastOutgoingCallLog: CallLog?
	{
			let cPointer = linphone_core_get_last_outgoing_call_log(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = CallLog.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns a list of entered LDAPs. 
	/// Items must be freed with linphone_ldap_unref 
	/// - Returns:       
	public var ldapList: [Ldap]
	{
			var swiftList = [Ldap]()
			let cList = linphone_core_get_ldap_list(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Ldap.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Tells wether LIME X3DH is enabled or not. 
	/// - Returns: The current lime state 
	public var limeX3DhEnabled: Bool
	{
		get
		{
			return linphone_core_lime_x3dh_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_lime_x3dh(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the x3dh server url. 
	/// - Returns: The x3dh server url.   
	public var limeX3DhServerUrl: String
	{
		get
		{
			let cPointer = linphone_core_get_lime_x3dh_server_url(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_lime_x3dh_server_url(cPtr, newValue)
		}
	}

	/// Get the list of linphone specs string values representing what functionalities
	/// the linphone client supports. 
	/// - Returns: A list of supported specs. The list must be freed with
	/// bctbx_list_free() after usage.    
	public var linphoneSpecsList: [String]
	{
		get
		{
			var swiftList = [String]()
			let cList = linphone_core_get_linphone_specs_list(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp!.pointee.next)
			}
			return swiftList
		}
		set
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				let sData:NSString = data as NSString
				cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
			}
			linphone_core_set_linphone_specs_list(cPtr, cList)
		}
	}

	/// Special function to check if the local network permission has been granted by
	/// the user (useful for iOS). 
	/// The test performed by this function may popup the local network permission
	/// dialog, for that reason it could be a good idea to check it twice to conclude
	/// that the user has deny the permission. 
	/// - Returns: true if local permission request is granted, false otherwise. 
	public var localPermissionEnabled: Bool
	{
			return linphone_core_local_permission_enabled(cPtr) != 0
	}

	/// Gets the url of the server where to upload the collected log files. 
	/// - Returns: The url of the server where to upload the collected log files.   
	public var logCollectionUploadServerUrl: String
	{
		get
		{
			let cPointer = linphone_core_get_log_collection_upload_server_url(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_log_collection_upload_server_url(cPtr, newValue)
		}
	}

	/// Get the maximum number of simultaneous calls Linphone core can manage at a
	/// time. 
	/// All new call above this limit are declined with a busy answer 
	/// - Returns: max number of simultaneous calls 
	public var maxCalls: Int
	{
		get
		{
			return Int(linphone_core_get_max_calls(cPtr))
		}
		set
		{
			linphone_core_set_max_calls(cPtr, CInt(newValue))
		}
	}

	/// Gets the size under which incoming files in chat messages will be downloaded
	/// automatically. 
	/// - Returns: The size in bytes, -1 if autodownload feature is disabled, 0 to
	/// download them all no matter the size 
	public var maxSizeForAutoDownloadIncomingFiles: Int
	{
		get
		{
			return Int(linphone_core_get_max_size_for_auto_download_incoming_files(cPtr))
		}
		set
		{
			linphone_core_set_max_size_for_auto_download_incoming_files(cPtr, CInt(newValue))
		}
	}

	/// Gets the name of the currently assigned sound device for media. 
	/// - Returns: The name of the currently assigned sound device for capture.   
	public var mediaDevice: String
	{
			let cPointer = linphone_core_get_media_device(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setMediadevice(newValue: String) throws
	{
		let exception_result = linphone_core_set_media_device(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the media encryption policy being used for RTP packets. 
	/// - Returns: The `MediaEncryption` policy being used. 
	public var mediaEncryption: MediaEncryption
	{
			return MediaEncryption(rawValue: Int(linphone_core_get_media_encryption(cPtr).rawValue))!
	}

	public func setMediaencryption(newValue: MediaEncryption) throws
	{
		let exception_result = linphone_core_set_media_encryption(cPtr, LinphoneMediaEncryption(rawValue: CUnsignedInt(newValue.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Define whether the configured media encryption is mandatory, if it is and the
	/// negotation cannot result in the desired media encryption then the call will
	/// fail. 
	/// If not an INVITE will be resent with encryption disabled. 
	/// - Parameter mandatory: true to set it mandatory; false otherwise. 
	public var mediaEncryptionMandatory: Bool?
	{
		willSet
		{
			linphone_core_set_media_encryption_mandatory(cPtr, newValue==true ? 1:0)
		}
	}

	/// This method is called by the application to notify the linphone core library
	/// when the media (RTP) network is reachable. 
	/// This is for advanced usage, when SIP and RTP layers are required to use
	/// different interfaces. Most applications just need setNetworkReachable().
	/// - Parameter reachable: true if network is reachable, false otherwise 
	public var mediaNetworkReachable: Bool?
	{
		willSet
		{
			linphone_core_set_media_network_reachable(cPtr, newValue==true ? 1:0)
		}
	}

	/// This function returns the media resource mode for this core. 
	/// - Returns: The media resource mode 
	public var mediaResourceMode: MediaResourceMode
	{
		get
		{
			return MediaResourceMode(rawValue: Int(linphone_core_get_media_resource_mode(cPtr).rawValue))!
		}
		set
		{
			linphone_core_set_media_resource_mode(cPtr, LinphoneMediaResourceMode(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Tells whether the microphone is enabled. 
	/// - Returns: true if the microphone is enabled, false if disabled. 
	public var micEnabled: Bool
	{
		get
		{
			return linphone_core_mic_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_mic(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get microphone gain in db. 
	/// - Returns: The current microphone gain 
	public var micGainDb: Float
	{
		get
		{
			return linphone_core_get_mic_gain_db(cPtr)
		}
		set
		{
			linphone_core_set_mic_gain_db(cPtr, newValue)
		}
	}

	/// Get the number of missed calls. 
	/// Once checked, this counter can be reset with resetMissedCallsCount(). 
	/// - Returns: The number of missed calls. 
	public var missedCallsCount: Int
	{
			return Int(linphone_core_get_missed_calls_count(cPtr))
	}

	/// Returns the maximum transmission unit size in bytes. 
	public var mtu: Int
	{
		get
		{
			return Int(linphone_core_get_mtu(cPtr))
		}
		set
		{
			linphone_core_set_mtu(cPtr, CInt(newValue))
		}
	}

	/// Get the public IP address of NAT being used. 
	/// - Returns: The public IP address of NAT being used.   
	public var natAddress: String
	{
		get
		{
			let cPointer = linphone_core_get_nat_address(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_nat_address(cPtr, newValue)
		}
	}

	/// Get The policy that is used to pass through NATs/firewalls. 
	/// It may be overridden by a NAT policy for a specific proxy config. 
	/// - Returns: `NatPolicy` object in use.  
	/// - See also: AccountParams.getNatPolicy() 
	public var natPolicy: NatPolicy?
	{
		get
		{
			let cPointer = linphone_core_get_nat_policy(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = NatPolicy.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_core_set_nat_policy(cPtr, newValue?.cPtr)
		}
	}

	/// Get the native window handle of the video preview window. 
	/// see setNativeVideoWindowId() for details about window_id
	/// There is a special case for Qt : getNativePreviewWindowId() wreturns a
	/// #QQuickFramebufferObject::Renderer and creates one if it doesn't exist. This
	/// object must be returned by your QQuickFramebufferObject::createRenderer()
	/// overload for Qt. Note : Qt blocks GUI thread when calling createRenderer(), so
	/// it is safe to call linphone functions there if needed.
	/// - Returns: The native window handle of the video preview window.   
	public var nativePreviewWindowId: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_core_get_native_preview_window_id(cPtr)
		}
		set
		{
			linphone_core_set_native_preview_window_id(cPtr, newValue)
		}
	}

	/// Returns whether the native ringing is enabled or not. 
	/// - Returns: True if we use the native ringing, false otherwise 
	public var nativeRingingEnabled: Bool
	{
		get
		{
			return linphone_core_native_ringing_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_native_ringing(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the native window handle of the video window. 
	/// see linphone_core_set_native_video_window_id for details about window_id
	/// There is a special case for Qt : getNativeVideoWindowId() returns a
	/// #QQuickFramebufferObject::Renderer and creates one if it doesn't exist. This
	/// object must be returned by your QQuickFramebufferObject::createRenderer()
	/// overload for Qt. Note : Qt blocks GUI thread when calling createRenderer(), so
	/// it is safe to call linphone functions there if needed.
	/// - Returns: The native window handle of the video window.   
	public var nativeVideoWindowId: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_core_get_native_video_window_id(cPtr)
		}
		set
		{
			linphone_core_set_native_video_window_id(cPtr, newValue)
		}
	}

	/// This method is called by the application to notify the linphone core library
	/// when network is reachable. 
	/// Calling this method with true trigger linphone to initiate a registration
	/// process for all proxies. Calling this method disables the automatic network
	/// detection mode. It means you must call this method after each network state
	/// changes.
	/// - Parameter reachable: true if network is reachable, false otherwise 
	public var networkReachable: Bool?
	{
		willSet
		{
			linphone_core_set_network_reachable(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the value of the no-rtp timeout. 
	/// When no RTP or RTCP packets have been received for a while `Core` will consider
	/// the call is broken (remote end crashed or disconnected from the network), and
	/// thus will terminate the call. The no-rtp timeout is the duration above which
	/// the call is considered broken. 
	/// - Returns: The value of the no-rtp timeout in seconds 
	public var nortpTimeout: Int
	{
		get
		{
			return Int(linphone_core_get_nortp_timeout(cPtr))
		}
		set
		{
			linphone_core_set_nortp_timeout(cPtr, CInt(newValue))
		}
	}

	/// Gets the output audio device for the current call. 
	/// - Returns: The output audio device for the current or first call, nil if there
	/// is no call.   
	public var outputAudioDevice: AudioDevice?
	{
		get
		{
			let cPointer = linphone_core_get_output_audio_device(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = AudioDevice.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_core_set_output_audio_device(cPtr, newValue?.cPtr)
		}
	}

	/// Get the wav file that is played when putting somebody on hold, or when files
	/// are used instead of soundcards (see setUseFiles()). 
	/// The file is a 16 bit linear wav file. 
	/// - Returns: The path to the file that is played when putting somebody on hold.   
	public var playFile: String
	{
		get
		{
			let cPointer = linphone_core_get_play_file(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_play_file(cPtr, newValue)
		}
	}

	/// Gets the name of the currently assigned sound device for playback. 
	/// - Returns: The name of the currently assigned sound device for playback.   
	public var playbackDevice: String
	{
			let cPointer = linphone_core_get_playback_device(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setPlaybackdevice(newValue: String) throws
	{
		let exception_result = linphone_core_set_playback_device(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get playback gain in db before entering sound card. 
	/// - Returns: The current playback gain 
	public var playbackGainDb: Float
	{
		get
		{
			return linphone_core_get_playback_gain_db(cPtr)
		}
		set
		{
			linphone_core_set_playback_gain_db(cPtr, newValue)
		}
	}

	/// Returns the preferred video framerate, previously set by
	/// setPreferredFramerate(). 
	/// - Returns: frame rate in number of frames per seconds. 
	public var preferredFramerate: Float
	{
		get
		{
			return linphone_core_get_preferred_framerate(cPtr)
		}
		set
		{
			linphone_core_set_preferred_framerate(cPtr, newValue)
		}
	}

	/// Get the preferred video definition for the stream that is captured and sent to
	/// the remote party. 
	/// - Returns: The preferred `VideoDefinition`   
	public var preferredVideoDefinition: VideoDefinition?
	{
		get
		{
			let cPointer = linphone_core_get_preferred_video_definition(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = VideoDefinition.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_core_set_preferred_video_definition(cPtr, newValue?.cPtr)
		}
	}

	/// Sets the preferred video definition by its name. 
	/// Call Factory.getSupportedVideoDefinitions() to have a list of supported video
	/// definitions.
	/// - Parameter name: The name of the definition to set   
	public var preferredVideoDefinitionByName: String = ""
	{
		willSet
		{
			linphone_core_set_preferred_video_definition_by_name(cPtr, newValue)
		}
	}

	/// Get my presence model. 
	/// - Returns: A `PresenceModel` object, or nil if no presence model has been set. 
	///  
	public var presenceModel: PresenceModel?
	{
		get
		{
			let cPointer = linphone_core_get_presence_model(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = PresenceModel.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_core_set_presence_model(cPtr, newValue?.cPtr)
		}
	}

	/// Get the definition of the captured video. 
	/// - Returns: The captured `VideoDefinition` if it was previously set by
	/// setPreviewVideoDefinition(), otherwise a 0x0 LinphoneVideoDefinition.   
	/// - See also: setPreviewVideoDefinition() 
	public var previewVideoDefinition: VideoDefinition?
	{
		get
		{
			let cPointer = linphone_core_get_preview_video_definition(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = VideoDefinition.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_core_set_preview_video_definition(cPtr, newValue?.cPtr)
		}
	}

	/// - Parameter name: The name of the definition to set   
	public var previewVideoDefinitionByName: String = ""
	{
		willSet
		{
			linphone_core_set_preview_video_definition_by_name(cPtr, newValue)
		}
	}

	/// Returns the default identity when no proxy configuration is used. 
	/// - Returns: the primary contact identity   
	public var primaryContact: String
	{
			let cPointer = linphone_core_get_primary_contact(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setPrimarycontact(newValue: String) throws
	{
		let exception_result = linphone_core_set_primary_contact(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Same as getPrimaryContact() but the result is a `Address` object instead of
	/// const char *. 
	/// - Returns: a `Address` object.    
	/// - deprecated: 22/10/2018 Use createPrimaryContactParsed() instead. 
	@available(*, deprecated)
	public var primaryContactParsed: Address?
	{
			let cPointer = linphone_core_get_primary_contact_parsed(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
			return result
	}

	/// Get provisioning URI. 
	/// - Returns: the provisioning URI.   
	public var provisioningUri: String
	{
			let cPointer = linphone_core_get_provisioning_uri(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setProvisioninguri(newValue: String) throws
	{
		let exception_result = linphone_core_set_provisioning_uri(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns an unmodifiable list of entered proxy configurations. 
	/// - Returns: A list of `ProxyConfig`.    
	public var proxyConfigList: [ProxyConfig]
	{
			var swiftList = [ProxyConfig]()
			let cList = linphone_core_get_proxy_config_list(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(ProxyConfig.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Returns the push incoming call timeout See setPushIncomingCallTimeout() for
	/// details. 
	/// - Returns: The current push incoming call timeout in seconds 
	public var pushIncomingCallTimeout: Int
	{
		get
		{
			return Int(linphone_core_get_push_incoming_call_timeout(cPtr))
		}
		set
		{
			linphone_core_set_push_incoming_call_timeout(cPtr, CInt(newValue))
		}
	}

	/// Gets whether push notifications are enabled or not (Android & iOS only). 
	/// If not, the app will have to handle all the push-related settings for each
	/// accounts 
	/// - Returns: true if push notifications are enabled, false otherwise 
	public var pushNotificationEnabled: Bool
	{
		get
		{
			return linphone_core_push_notification_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_push_notification(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether QRCode is enabled in the preview. 
	/// - Returns: A boolean value telling whether QRCode is enabled in the preview. 
	public var qrcodeVideoPreviewEnabled: Bool
	{
		get
		{
			return linphone_core_qrcode_video_preview_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_qrcode_video_preview(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets if realtime text is enabled or not. 
	/// - Returns: true if realtime text is enabled, false otherwise 
	public var realtimeTextEnabled: Bool
	{
			return linphone_core_realtime_text_enabled(cPtr) != 0
	}

	/// Gets if the record aware feature is enabled or not. 
	/// - Returns: true if the record aware feature is enabled, false otherwise. 
	public var recordAwareEnabled: Bool
	{
		get
		{
			return linphone_core_record_aware_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_record_aware(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the wav file where incoming stream is recorded, when files are used instead
	/// of soundcards (see setUseFiles()). 
	/// This feature is different from call recording (CallParams.setRecordFile()) The
	/// file is a 16 bit linear wav file. 
	/// - Returns: The path to the file where incoming stream is recorded.   
	public var recordFile: String
	{
		get
		{
			let cPointer = linphone_core_get_record_file(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_record_file(cPtr, newValue)
		}
	}

	/// Get the ring back tone played to far end during incoming calls. 
	/// - Returns: the path to the remote ring back tone to be played.   
	public var remoteRingbackTone: String
	{
		get
		{
			let cPointer = linphone_core_get_remote_ringback_tone(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_remote_ringback_tone(cPtr, newValue)
		}
	}

	/// Tells whether NACK context is enabled or not. 
	/// - Returns: A boolean value telling whether NACK context is enabled or not 
	public var retransmissionOnNackEnabled: Bool
	{
		get
		{
			return linphone_core_retransmission_on_nack_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_retransmission_on_nack(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns the path to the wav file used for ringing. 
	/// - Returns: The path to the wav file used for ringing.   
	public var ring: String
	{
		get
		{
			let cPointer = linphone_core_get_ring(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_ring(cPtr, newValue)
		}
	}

	/// Tells whether the ring play is enabled during an incoming early media call. 
	public var ringDuringIncomingEarlyMedia: Bool
	{
		get
		{
			return linphone_core_get_ring_during_incoming_early_media(cPtr) != 0
		}
		set
		{
			linphone_core_set_ring_during_incoming_early_media(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns the path to the wav file used for ringing back. 
	/// - Returns: The path to the wav file used for ringing back.   
	public var ringback: String
	{
		get
		{
			let cPointer = linphone_core_get_ringback(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_ringback(cPtr, newValue)
		}
	}

	/// Gets the name of the currently assigned sound device for ringing. 
	/// - Returns: The name of the currently assigned sound device for ringing.   
	public var ringerDevice: String
	{
			let cPointer = linphone_core_get_ringer_device(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setRingerdevice(newValue: String) throws
	{
		let exception_result = linphone_core_set_ringer_device(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the path to a file or folder containing the trusted root CAs (PEM format) 
	/// - Returns: The path to a file or folder containing the trusted root CAs.   
	public var rootCa: String
	{
		get
		{
			let cPointer = linphone_core_get_root_ca(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_root_ca(cPtr, newValue)
		}
	}

	/// Sets the trusted root CAs (PEM format) 
	/// - Parameter data: The trusted root CAs as a string   
	public var rootCaData: String = ""
	{
		willSet
		{
			linphone_core_set_root_ca_data(cPtr, newValue)
		}
	}

	/// Returns whether RTP bundle mode (also known as Media Multiplexing) is enabled. 
	/// See https://tools.ietf.org/html/draft-ietf-mmusic-sdp-bundle-negotiation-54 for
	/// more information. 
	/// - Returns: a boolean indicating the enablement of rtp bundle mode. 
	public var rtpBundleEnabled: Bool
	{
		get
		{
			return linphone_core_rtp_bundle_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_rtp_bundle(cPtr, newValue==true ? 1:0)
		}
	}

	/// Media offer control param for SIP INVITE. 
	/// - Returns: true if INVITE has to be sent whitout SDP. 
	public var sdp200AckEnabled: Bool
	{
		get
		{
			return linphone_core_sdp_200_ack_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_sdp_200_ack(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether video self view during call is enabled or not. 
	/// - Returns: A boolean value telling whether self view is enabled 
	/// - See also: enableSelfView() for details. 
	public var selfViewEnabled: Bool
	{
		get
		{
			return linphone_core_self_view_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_self_view(cPtr, newValue==true ? 1:0)
		}
	}

	/// Enable whether or not to hide sender name in forward message. 
	/// - Parameter enable: whether or not to enable the feature 
	public var senderNameHiddenInForwardMessageEnabled: Bool?
	{
		willSet
		{
			linphone_core_enable_sender_name_hidden_in_forward_message(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check if the Session Timers feature is enabled. 
	public var sessionExpiresEnabled: Bool
	{
		get
		{
			return linphone_core_session_expires_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_session_expires(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns the session expires min value, 90 by default. 
	public var sessionExpiresMinValue: Int
	{
		get
		{
			return Int(linphone_core_get_session_expires_min_value(cPtr))
		}
		set
		{
			linphone_core_set_session_expires_min_value(cPtr, CInt(newValue))
		}
	}

	/// Returns the session expires refresher value. 
	public var sessionExpiresRefresherValue: SessionExpiresRefresher
	{
		get
		{
			return SessionExpiresRefresher(rawValue: Int(linphone_core_get_session_expires_refresher_value(cPtr).rawValue))!
		}
		set
		{
			linphone_core_set_session_expires_refresher_value(cPtr, LinphoneSessionExpiresRefresher(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Returns the session expires value. 
	public var sessionExpiresValue: Int
	{
		get
		{
			return Int(linphone_core_get_session_expires_value(cPtr))
		}
		set
		{
			linphone_core_set_session_expires_value(cPtr, CInt(newValue))
		}
	}

	/// Get the DSCP field for SIP signaling channel. 
	/// The DSCP defines the quality of service in IP packets. 
	/// - Returns: The current DSCP value 
	public var sipDscp: Int
	{
		get
		{
			return Int(linphone_core_get_sip_dscp(cPtr))
		}
		set
		{
			linphone_core_set_sip_dscp(cPtr, CInt(newValue))
		}
	}

	/// This method is called by the application to notify the linphone core library
	/// when the SIP network is reachable. 
	/// This is for advanced usage, when SIP and RTP layers are required to use
	/// different interfaces. Most applications just need setNetworkReachable().
	/// - Parameter reachable: true if network is reachable, false otherwise 
	public var sipNetworkReachable: Bool?
	{
		willSet
		{
			linphone_core_set_sip_network_reachable(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the SIP transport timeout. 
	/// - Returns: The SIP transport timeout in milliseconds. 
	public var sipTransportTimeout: Int
	{
		get
		{
			return Int(linphone_core_get_sip_transport_timeout(cPtr))
		}
		set
		{
			linphone_core_set_sip_transport_timeout(cPtr, CInt(newValue))
		}
	}

	/// Gets the list of the available sound devices. 
	/// - Returns: An unmodifiable array of strings contanining the names of the
	/// available sound devices that is nil terminated.      
	/// - deprecated: 10/04/2021 Use getAudioDevices() instead.
	@available(*, deprecated)
	public var soundDevicesList: [String]
	{
			var swiftList = [String]()
			let cList = linphone_core_get_sound_devices_list(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp!.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Get the crypto suites available to the core. 
	/// - Returns: a comma separated list of supported suites   
	public var srtpCryptoSuites: String
	{
		get
		{
			let cPointer = linphone_core_get_srtp_crypto_suites(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_srtp_crypto_suites(cPtr, newValue)
		}
	}

	/// Get the path to the image file streamed when "Static picture" is set as the
	/// video device. 
	/// - Returns: The path to the image file streamed when "Static picture" is set as
	/// the video device.   
	public var staticPicture: String
	{
			let cPointer = linphone_core_get_static_picture(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setStaticpicture(newValue: String) throws
	{
		let exception_result = linphone_core_set_static_picture(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the frame rate for static picture. 
	/// - Returns: The frame rate used for static picture. 
	public var staticPictureFps: Float
	{
			return linphone_core_get_static_picture_fps(cPtr)
	}

	public func setStaticpicturefps(newValue: Float) throws
	{
		let exception_result = linphone_core_set_static_picture_fps(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the STUN server address being used. 
	/// - Returns: The STUN server address being used.   
	public var stunServer: String
	{
		get
		{
			let cPointer = linphone_core_get_stun_server(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_stun_server(cPtr, newValue)
		}
	}

	/// Returns a null terminated table of strings containing the file format extension
	/// supported for call recording. 
	/// - Returns: The supported formats, typically 'wav' and 'mkv'.      
	public var supportedFileFormatsList: [String]
	{
			var swiftList = [String]()
			let cList = linphone_core_get_supported_file_formats_list(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp!.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Set the supported tags. 
	public var supportedTag: String = ""
	{
		willSet
		{
			linphone_core_set_supported_tag(cPtr, newValue)
		}
	}

	/// Get the support level of the 100rel attribute. 
	/// - Returns: The 100 rel support level 
	public var tag100RelSupportLevel: SupportLevel
	{
		get
		{
			return SupportLevel(rawValue: Int(linphone_core_get_tag_100rel_support_level(cPtr).rawValue))!
		}
		set
		{
			linphone_core_set_tag_100rel_support_level(cPtr, LinphoneSupportLevel(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Define whether tcap lines are going to be merged if capability negotiation
	/// (RFC5939) is supported. 
	/// - Parameter merge: true to merge tcap lines with consecutive indexes; false
	/// otherwise. 
	public var tcapLineMergingEnabled: Bool?
	{
		willSet
		{
			linphone_core_enable_tcap_line_merging(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check if tcap lines are going to the merged if the capability negotiation
	/// (RFC5939) is supported or not. 
	/// - Returns: true if tcap lines with consecutive indexes are going to be merged;
	/// false otherwise. 
	public var tcapLinesMergingEnabled: Bool
	{
			return linphone_core_tcap_lines_merging_enabled(cPtr) != 0
	}

	/// Return the list of the available text payload types. 
	/// - Returns: A freshly allocated list of the available payload types. The list
	/// must be destroyed with bctbx_list_free() after usage. The elements of the list
	/// haven't to be unref.    
	public var textPayloadTypes: [PayloadType]
	{
		get
		{
			var swiftList = [PayloadType]()
			let cList = linphone_core_get_text_payload_types(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(PayloadType.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
		}
		set
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				cList = bctbx_list_append(cList, UnsafeMutableRawPointer(data.cPtr))
			}
			linphone_core_set_text_payload_types(cPtr, cList)
		}
	}

	/// Gets the UDP port used for text streaming. 
	/// - Returns: The UDP port used for text streaming 
	public var textPort: Int
	{
		get
		{
			return Int(linphone_core_get_text_port(cPtr))
		}
		set
		{
			linphone_core_set_text_port(cPtr, CInt(newValue))
		}
	}

	/// Get the text port range from which is randomly chosen the UDP port used for
	/// text streaming. 
	/// - Returns: a `Range` object     
	public var textPortsRange: Range?
	{
			let cPointer = linphone_core_get_text_ports_range(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Range.getSwiftObject(cObject:cPointer!)
			belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
			return result
	}

	/// Gets the TLS certificate. 
	/// - Returns: the TLS certificate or nil if not set yet.   
	public var tlsCert: String
	{
		get
		{
			let cPointer = linphone_core_get_tls_cert(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_tls_cert(cPtr, newValue)
		}
	}

	/// Gets the path to the TLS certificate file. 
	/// - Returns: the TLS certificate path or nil if not set yet.   
	public var tlsCertPath: String
	{
		get
		{
			let cPointer = linphone_core_get_tls_cert_path(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_tls_cert_path(cPtr, newValue)
		}
	}

	/// Gets the TLS key. 
	/// - Returns: the TLS key or nil if not set yet.   
	public var tlsKey: String
	{
		get
		{
			let cPointer = linphone_core_get_tls_key(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_tls_key(cPtr, newValue)
		}
	}

	/// Gets the path to the TLS key file. 
	/// - Returns: the TLS key path or nil if not set yet.   
	public var tlsKeyPath: String
	{
		get
		{
			let cPointer = linphone_core_get_tls_key_path(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_tls_key_path(cPtr, newValue)
		}
	}

	/// Retrieves the port configuration used for each transport (udp, tcp, tls). 
	/// A zero value port for a given transport means the transport is not used. A
	/// value of LC_SIP_TRANSPORT_RANDOM (-1) means the port is to be chosen randomly
	/// by the system. A value of LC_SIP_TRANSPORT_DONTBIND (-2) means that the socket
	/// will not be bound explicitely, in other words liblinphone won't listen for
	/// incoming connections at all. This mode is suitable for a pure client
	/// application (ex: a mobile application). 
	/// - Returns: A `Transports` structure with the configured ports     
	public var transports: Transports?
	{
			let cPointer = linphone_core_get_transports(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Transports.getSwiftObject(cObject:cPointer!)
			belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
			return result
	}

	public func setTransports(newValue: Transports) throws
	{
		let exception_result = linphone_core_set_transports(cPtr, newValue.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Retrieves the real port number assigned for each sip transport (udp, tcp, tls). 
	/// A zero value means that the transport is not activated. If
	/// LC_SIP_TRANSPORT_RANDOM was passed to linphone_core_set_sip_transports, the
	/// random port choosed by the system is returned. 
	/// - Returns: A `Transports` structure with the ports being used     
	public var transportsUsed: Transports?
	{
			let cPointer = linphone_core_get_transports_used(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Transports.getSwiftObject(cObject:cPointer!)
			belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
			return result
	}

	/// get tunnel instance if available 
	/// - Returns: `Tunnel` or nil if not available.   
	public var tunnel: Tunnel?
	{
			let cPointer = linphone_core_get_tunnel(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Tunnel.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Return the global unread chat message count. 
	/// - Returns: The global unread chat message count. 
	public var unreadChatMessageCount: Int
	{
			return Int(linphone_core_get_unread_chat_message_count(cPtr))
	}

	/// Return the unread chat message count for all active local address. 
	/// (Primary contact + proxy configs.) 
	/// - Returns: The unread chat message count. 
	public var unreadChatMessageCountFromActiveLocals: Int
	{
			return Int(linphone_core_get_unread_chat_message_count_from_active_locals(cPtr))
	}

	/// Retrieve the maximum available upload bandwidth. 
	/// This value was set by setUploadBandwidth(). 
	/// - Returns: the upload bandiwdth in kbits/s, 0 for infinite 
	public var uploadBandwidth: Int
	{
		get
		{
			return Int(linphone_core_get_upload_bandwidth(cPtr))
		}
		set
		{
			linphone_core_set_upload_bandwidth(cPtr, CInt(newValue))
		}
	}

	/// Set audio packetization time linphone will send (in absence of requirement from
	/// peer) A value of 0 stands for the current codec default packetization time. 
	/// - Returns: the upload packetization time set 
	public var uploadPtime: Int
	{
		get
		{
			return Int(linphone_core_get_upload_ptime(cPtr))
		}
		set
		{
			linphone_core_set_upload_ptime(cPtr, CInt(newValue))
		}
	}

	/// Return the external ip address of router. 
	/// In some cases the uPnP can have an external ip address but not a usable uPnP
	/// (state different of Ok).
	/// - Returns: a null terminated string containing the external ip address. If the
	/// the external ip address is not available return null.   
	public var upnpExternalIpaddress: String
	{
			let cPointer = linphone_core_get_upnp_external_ipaddress(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Return the internal state of uPnP. 
	/// - Returns: an LinphoneUpnpState. 
	public var upnpState: UpnpState
	{
			return UpnpState(rawValue: Int(linphone_core_get_upnp_state(cPtr).rawValue))!
	}

	/// Gets whether linphone is currently streaming audio from and to files, rather
	/// than using the soundcard. 
	/// - Returns: A boolean value representing whether linphone is streaming audio
	/// from and to files or not. 
	public var useFiles: Bool
	{
		get
		{
			return linphone_core_get_use_files(cPtr) != 0
		}
		set
		{
			linphone_core_set_use_files(cPtr, newValue==true ? 1:0)
		}
	}

	/// Indicates whether SIP INFO is used to send digits. 
	/// - Returns: A boolean value telling whether SIP INFO is used to send digits 
	public var useInfoForDtmf: Bool
	{
		get
		{
			return linphone_core_get_use_info_for_dtmf(cPtr) != 0
		}
		set
		{
			linphone_core_set_use_info_for_dtmf(cPtr, newValue==true ? 1:0)
		}
	}

	/// Indicates whether RFC2833 is used to send digits. 
	/// - Returns: A boolean value telling whether RFC2833 is used to send digits 
	public var useRfc2833ForDtmf: Bool
	{
		get
		{
			return linphone_core_get_use_rfc2833_for_dtmf(cPtr) != 0
		}
		set
		{
			linphone_core_set_use_rfc2833_for_dtmf(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the user-agent as a string. 
	/// - Returns: liblinphone's user agent as a string.   
	public var userAgent: String
	{
			let cPointer = linphone_core_get_user_agent(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the path to the directory storing the user's certificates. 
	/// - Returns: The path to the directory storing the user's certificates.   
	public var userCertificatesPath: String
	{
		get
		{
			let cPointer = linphone_core_get_user_certificates_path(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_user_certificates_path(cPtr, newValue)
		}
	}

	/// Retrieves the user pointer that was given to linphone_core_new 
	/// - Returns: The user data associated with the `Core` object.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_core_get_user_data(cPtr)
		}
		set
		{
			linphone_core_set_user_data(cPtr, newValue)
		}
	}

	/// Gets whether the device will vibrate while an incoming call is ringing (Android
	/// only). 
	/// - Returns: true if the device will vibrate (if possible), false otherwise 
	public var vibrationOnIncomingCallEnabled: Bool
	{
		get
		{
			return linphone_core_vibration_on_incoming_call_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_vibration_on_incoming_call(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the default policy for video. 
	/// See setVideoActivationPolicy() for more details. 
	/// - Returns: The video policy being used     
	public var videoActivationPolicy: VideoActivationPolicy?
	{
		get
		{
			let cPointer = linphone_core_get_video_activation_policy(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = VideoActivationPolicy.getSwiftObject(cObject:cPointer!)
			belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
			return result
		}
		set
		{
			linphone_core_set_video_activation_policy(cPtr, newValue?.cPtr)
		}
	}

	/// Tells whether the video adaptive jitter compensation is enabled. 
	/// - Returns: true if the video adaptive jitter compensation is enabled, false
	/// otherwise. 
	public var videoAdaptiveJittcompEnabled: Bool
	{
		get
		{
			return linphone_core_video_adaptive_jittcomp_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_video_adaptive_jittcomp(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether video capture is enabled. 
	/// - Returns: true if video capture is enabled, false if disabled. 
	public var videoCaptureEnabled: Bool
	{
		get
		{
			return linphone_core_video_capture_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_video_capture(cPtr, newValue==true ? 1:0)
		}
	}

	/// Returns the name of the currently active video device. 
	/// - Returns: The name of the currently active video device.   
	public var videoDevice: String
	{
			let cPointer = linphone_core_get_video_device(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setVideodevice(newValue: String) throws
	{
		let exception_result = linphone_core_set_video_device(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the list of the available video capture devices. 
	/// - Returns: An unmodifiable array of strings contanining the names of the
	/// available video capture devices that is nil terminated.      
	public var videoDevicesList: [String]
	{
			var swiftList = [String]()
			let cList = linphone_core_get_video_devices_list(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp!.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Tells whether video display is enabled. 
	/// - Returns: true if video display is enabled, false if disabled. 
	public var videoDisplayEnabled: Bool
	{
		get
		{
			return linphone_core_video_display_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_video_display(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the name of the mediastreamer2 filter used for rendering video. 
	/// - Returns: The currently selected video display filter.   
	public var videoDisplayFilter: String
	{
		get
		{
			let cPointer = linphone_core_get_video_display_filter(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_video_display_filter(cPtr, newValue)
		}
	}

	/// Get the DSCP field for outgoing video streams. 
	/// The DSCP defines the quality of service in IP packets. 
	/// - Returns: The current DSCP value 
	public var videoDscp: Int
	{
		get
		{
			return Int(linphone_core_get_video_dscp(cPtr))
		}
		set
		{
			linphone_core_set_video_dscp(cPtr, CInt(newValue))
		}
	}

	/// Returns true if either capture or display is enabled, false otherwise. 
	/// same as ( videoCaptureEnabled() | videoDisplayEnabled() )
	/// - Returns: true if either capture or display is enabled, false otherwise. 
	public var videoEnabled: Bool
	{
			return linphone_core_video_enabled(cPtr) != 0
	}

	/// Returns the nominal video jitter buffer size in milliseconds. 
	/// - Returns: The nominal video jitter buffer size in milliseconds 
	public var videoJittcomp: Int
	{
		get
		{
			return Int(linphone_core_get_video_jittcomp(cPtr))
		}
		set
		{
			linphone_core_set_video_jittcomp(cPtr, CInt(newValue))
		}
	}

	/// Use to get multicast address to be used for video stream. 
	/// - Returns: an ipv4/6 multicast address, or default value.   
	public var videoMulticastAddr: String
	{
			let cPointer = linphone_core_get_video_multicast_addr(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setVideomulticastaddr(newValue: String) throws
	{
		let exception_result = linphone_core_set_video_multicast_addr(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Use to get multicast state of video stream. 
	/// - Returns: true if subsequent calls will propose multicast ip set by
	/// setVideoMulticastAddr() 
	public var videoMulticastEnabled: Bool
	{
		get
		{
			return linphone_core_video_multicast_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_video_multicast(cPtr, newValue==true ? 1:0)
		}
	}

	/// Use to get multicast ttl to be used for video stream. 
	/// - Returns: a time to leave value 
	public var videoMulticastTtl: Int
	{
			return Int(linphone_core_get_video_multicast_ttl(cPtr))
	}

	public func setVideomulticastttl(newValue: Int) throws
	{
		let exception_result = linphone_core_set_video_multicast_ttl(cPtr, CInt(newValue))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Return the list of the available video payload types. 
	/// - Returns: A freshly allocated list of the available payload types. The list
	/// must be destroyed with bctbx_list_free() after usage. The elements of the list
	/// haven't to be unref.    
	public var videoPayloadTypes: [PayloadType]
	{
		get
		{
			var swiftList = [PayloadType]()
			let cList = linphone_core_get_video_payload_types(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(PayloadType.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
		}
		set
		{
			var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
			for data in newValue {
				cList = bctbx_list_append(cList, UnsafeMutableRawPointer(data.cPtr))
			}
			linphone_core_set_video_payload_types(cPtr, cList)
		}
	}

	/// Gets the UDP port used for video streaming. 
	/// - Returns: The UDP port used for video streaming 
	public var videoPort: Int
	{
		get
		{
			return Int(linphone_core_get_video_port(cPtr))
		}
		set
		{
			linphone_core_set_video_port(cPtr, CInt(newValue))
		}
	}

	/// Get the video port range from which is randomly chosen the UDP port used for
	/// video streaming. 
	/// - Returns: a `Range` object     
	public var videoPortsRange: Range?
	{
			let cPointer = linphone_core_get_video_ports_range(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Range.getSwiftObject(cObject:cPointer!)
			belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
			return result
	}

	/// Get the video preset used for video calls. 
	/// - Returns: The name of the video preset used for video calls (can be nil if the
	/// default video preset is used).   
	public var videoPreset: String
	{
		get
		{
			let cPointer = linphone_core_get_video_preset(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_video_preset(cPtr, newValue)
		}
	}

	/// Tells whether video preview is enabled. 
	/// - Returns: A boolean value telling whether video preview is enabled 
	public var videoPreviewEnabled: Bool
	{
		get
		{
			return linphone_core_video_preview_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_video_preview(cPtr, newValue==true ? 1:0)
		}
	}

	/// Enable or disable video source reuse when switching from preview to actual
	/// video call. 
	/// This source reuse is useful when you always display the preview, even before
	/// calls are initiated. By keeping the video source for the transition to a real
	/// video call, you will smooth out the source close/reopen cycle.
	/// This function does not have any effect durfing calls. It just indicates the
	/// `Core` to initiate future calls with video source reuse or not. Also, at the
	/// end of a video call, the source will be closed whatsoever for now. 
	/// - Parameter enable: true to enable video source reuse. false to disable it for
	/// subsequent calls. 
	public var videoSourceReuseEnabled: Bool?
	{
		willSet
		{
			linphone_core_enable_video_source_reuse(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether Wifi only mode is enabled or not. 
	/// - Warning: Only works for Android platform. 
	/// - Returns: A boolean value telling whether Wifi only mode is enabled or not 
	public var wifiOnlyEnabled: Bool
	{
		get
		{
			return linphone_core_wifi_only_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_wifi_only(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check if RTP port is set to 0 when a stream is inactive. 
	/// - Returns: true if the RTP port is set to 0 if the stream direction is
	/// inactive; false otherwise. 
	public var zeroRtpPortForStreamInactiveEnabled: Bool
	{
		get
		{
			return linphone_core_zero_rtp_port_for_stream_inactive_enabled(cPtr) != 0
		}
		set
		{
			linphone_core_enable_zero_rtp_port_for_stream_inactive(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the path to the file storing the zrtp secrets cache. 
	/// - Returns: The path to the file storing the zrtp secrets cache.   
	public var zrtpSecretsFile: String
	{
		get
		{
			let cPointer = linphone_core_get_zrtp_secrets_file(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_core_set_zrtp_secrets_file(cPtr, newValue)
		}
	}

	/// Special function to indicate if the audio session is activated. 
	/// Must be called when ProviderDelegate of the callkit notifies that the audio
	/// session is activated or deactivated. 
	public func activateAudioSession(actived:Bool) 
	{
		linphone_core_activate_audio_session(cPtr, actived==true ? 1:0)
	}

	/// Add an account. 
	/// This will start registration on the proxy, if registration is enabled. 
	/// - Parameter account: the `Account` to add   
	/// - Returns: 0 if successful, -1 otherwise 
	public func addAccount(account:Account) throws 
	{
		let exception_result = linphone_core_add_account(cPtr, account.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addAccount returned value \(exception_result)")
		}
	}

	/// Add all current calls into the conference. 
	/// If no conference is running a new internal conference context is created and
	/// all current calls are added to it. 
	/// - Returns: 0 if succeeded. Negative number if failed 
	/// - Warning: This function guarantees that the local endpoint is added to the
	/// conference. 
	public func addAllToConference() throws 
	{
		let exception_result = linphone_core_add_all_to_conference(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addAllToConference returned value \(exception_result)")
		}
	}

	/// Adds authentication information to the `Core`. 
	/// That piece of information will be used during all SIP transactions that require
	/// authentication. 
	/// - Parameter info: The `AuthInfo` to add.   
	public func addAuthInfo(info:AuthInfo) 
	{
		linphone_core_add_auth_info(cPtr, info.cPtr)
	}

	/// Add support for the specified content type. 
	/// It is the application responsibility to handle it correctly afterwards. 
	/// - Parameter contentType: The content type to add support for   
	public func addContentTypeSupport(contentType:String) 
	{
		linphone_core_add_content_type_support(cPtr, contentType)
	}

	/// Add a friend list. 
	/// - Parameter list: `FriendList` object   
	public func addFriendList(list:FriendList) 
	{
		linphone_core_add_friend_list(cPtr, list.cPtr)
	}

	/// Add or update a LDAP server and save it to the configuration. 
	/// - Parameter ldap: The LDAP to add/update.   
	public func addLdap(ldap:Ldap) 
	{
		linphone_core_add_ldap(cPtr, ldap.cPtr)
	}

	/// Add the given linphone specs to the list of functionalities the linphone client
	/// supports. 
	/// - Parameter spec: The spec to add   
	public func addLinphoneSpec(spec:String) 
	{
		linphone_core_add_linphone_spec(cPtr, spec)
	}

	/// Add a proxy configuration. 
	/// This will start registration on the proxy, if registration is enabled. 
	/// - Parameter config: the `ProxyConfig` to add   
	/// - Returns: 0 if successful, -1 otherwise 
	public func addProxyConfig(config:ProxyConfig) throws 
	{
		let exception_result = linphone_core_add_proxy_config(cPtr, config.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addProxyConfig returned value \(exception_result)")
		}
	}

	/// This function controls signaling features supported by the core. 
	/// They are typically included in a SIP Supported header. 
	/// - Parameter tag: The feature tag name   
	public func addSupportedTag(tag:String) 
	{
		linphone_core_add_supported_tag(cPtr, tag)
	}

	/// Add a participant to the conference. 
	/// If no conference is going on a new internal conference context is created and
	/// the participant is added to it. 
	/// - Parameter call: The current call with the participant to add   
	/// - Returns: 0 if succeeded. Negative number if failed 
	public func addToConference(call:Call) throws 
	{
		let exception_result = linphone_core_add_to_conference(cPtr, call.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addToConference returned value \(exception_result)")
		}
	}

	/// Special function to indicate if the audio route is changed. 
	/// Must be called in the callback of AVAudioSessionRouteChangeNotification. 
	/// - deprecated: 07/01/2020 now handled in the linphone SDK directly 
	@available(*, deprecated)
	public func audioRouteChanged() 
	{
		linphone_core_audio_route_changed(cPtr)
	}

	/// Gets the default ephemeral message mode @core core the linphone core. 
	/// - Returns: the default ephemeral message mode `ChatRoomEphemeralMode` 
	public func chatRoomGetDefaultEphemeralMode() -> ChatRoomEphemeralMode
	{
		return ChatRoomEphemeralMode(rawValue: Int(linphone_core_chat_room_get_default_ephemeral_mode(cPtr).rawValue))!
	}

	/// Sets the default ephemeral message mode. 
	/// - Parameter mode: default ephemeral message mode `ChatRoomEphemeralMode` 
	public func chatRoomSetDefaultEphemeralMode(mode:ChatRoomEphemeralMode) 
	{
		linphone_core_chat_room_set_default_ephemeral_mode(cPtr, LinphoneChatRoomEphemeralMode(rawValue: CUnsignedInt(mode.rawValue)))
	}

	/// Checks if a new version of the application is available. 
	/// - Parameter currentVersion: The current version of the application   
	public func checkForUpdate(currentVersion:String) 
	{
		linphone_core_check_for_update(cPtr, currentVersion)
	}

	/// Erase all account from config. 
	public func clearAccounts() 
	{
		linphone_core_clear_accounts(cPtr)
	}

	/// Clear all authentication information. 
	public func clearAllAuthInfo() 
	{
		linphone_core_clear_all_auth_info(cPtr)
	}

	/// Erase the call log. 
	public func clearCallLogs() 
	{
		linphone_core_clear_call_logs(cPtr)
	}

	/// Erase all LDAP from the configuration. 
	public func clearLdaps() 
	{
		linphone_core_clear_ldaps(cPtr)
	}

	/// Erase all proxies from config. 
	public func clearProxyConfig() 
	{
		linphone_core_clear_proxy_config(cPtr)
	}

	/// Writes the config file to disk. 
	/// - Returns: 0 if successful, -1 otherwise 
	public func configSync() throws 
	{
		let exception_result = linphone_core_config_sync(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "configSync returned value \(exception_result)")
		}
	}

	/// Special function to configure audio session with default settings. 
	/// Must be called in ProviderDelegate's callbacks when answer an incoming call and
	/// start an outgoing call. 
	public func configureAudioSession() 
	{
		linphone_core_configure_audio_session(cPtr)
	}

	/// Create an account using given parameters, see createAccountParams(). 
	/// - Parameter params: `AccountParams` object   
	/// - Returns: `Account` with default values set   
	public func createAccount(params:AccountParams) throws -> Account
	{
		let cPointer = linphone_core_create_account(cPtr, params.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Account value")
		}
		let result = Account.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `AccountCreator` and set Linphone Request callbacks. 
	/// - Parameter xmlrpcUrl: The URL to the XML-RPC server.   
	/// - Returns: The new `AccountCreator` object.   
	public func createAccountCreator(xmlrpcUrl:String?) throws -> AccountCreator
	{
		let cPointer = linphone_core_create_account_creator(cPtr, xmlrpcUrl)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null AccountCreator value")
		}
		let result = AccountCreator.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create an account params using default values from Linphone core. 
	/// - Returns: `AccountParams` with default values set   
	public func createAccountParams() throws -> AccountParams
	{
		let cPointer = linphone_core_create_account_params(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null AccountParams value")
		}
		let result = AccountParams.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `Address` object by parsing the user supplied address, given as a
	/// string. 
	/// - Parameter address: String containing the user supplied address   
	/// - Returns: The create `Address` object   
	public func createAddress(address:String?) throws -> Address
	{
		let cPointer = linphone_core_create_address(cPtr, address)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Address value")
		}
		let result = Address.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates a fake `CallLog`. 
	/// - Parameter from: `Address` of caller   
	/// - Parameter to: `Address` of callee   
	/// - Parameter dir: `Call.Dir` of call 
	/// - Parameter duration: call length in seconds 
	/// - Parameter startTime: timestamp of call start time 
	/// - Parameter connectedTime: timestamp of call connection 
	/// - Parameter status: `Call.Status` of call 
	/// - Parameter videoEnabled: whether video was enabled or not for this call 
	/// - Parameter quality: call quality 
	/// - Returns: a `CallLog` object   
	public func createCallLog(from:Address, to:Address, dir:Call.Dir, duration:Int, startTime:time_t, connectedTime:time_t, status:Call.Status, videoEnabled:Bool, quality:Float) throws -> CallLog
	{
		let cPointer = linphone_core_create_call_log(cPtr, from.cPtr, to.cPtr, LinphoneCallDir(rawValue: CUnsignedInt(dir.rawValue)), CInt(duration), startTime, connectedTime, LinphoneCallStatus(rawValue: CUnsignedInt(status.rawValue)), videoEnabled==true ? 1:0, quality)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null CallLog value")
		}
		let result = CallLog.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `CallParams` suitable for inviteWithParams(),
	/// linphone_core_accept_call_with_params,
	/// linphone_core_accept_early_media_with_params or
	/// linphone_core_accept_call_update. 
	/// The parameters are initialized according to the current `Core` configuration
	/// and the last used local `CallParams`, the ones passed through Call.update(),
	/// Call.acceptWithParams() or linphone_call_accept_update_with_params(). 
	/// - Parameter call: `Call` for which the parameters are to be build, or nil in
	/// the case where the parameters are to be used for a new outgoing call.   
	/// - Returns: A new `CallParams` object.   
	public func createCallParams(call:Call?) throws -> CallParams
	{
		let cPointer = linphone_core_create_call_params(cPtr, call?.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null CallParams value")
		}
		let result = CallParams.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a chat room. 
	/// - Parameter params: The chat room creation parameters `ChatRoomParams`   
	/// - Parameter localAddr: `Address` representing the local proxy configuration to
	/// use for the chat room creation or nil   
	/// - Parameter participants: The initial list of participants of the chat room.    
	/// - Returns: The newly created chat room (can be an existing one if backend is
	/// Basic) or nil.   
	public func createChatRoom(params:ChatRoomParams, localAddr:Address?, participants:[Address]) throws -> ChatRoom
	{
		let cPointer = linphone_core_create_chat_room_6(cPtr, params.cPtr, localAddr?.cPtr, ObjectArrayToBctbxList(list: participants))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoom value")
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a chat room. 
	/// - Parameter params: The chat room creation parameters `ChatRoomParams`   
	/// - Parameter localAddr: `Address` representing the local proxy configuration to
	/// use for the chat room creation   
	/// - Parameter subject: The subject of the group chat room   
	/// - Parameter participants: The initial list of participants of the chat room    
	/// - Returns: The newly created chat room.   
	/// - deprecated: 02/07/2020, use createChatRoom() instead
	@available(*, deprecated)
	public func createChatRoom(params:ChatRoomParams, localAddr:Address, subject:String, participants:[Address]) throws -> ChatRoom
	{
		let cPointer = linphone_core_create_chat_room(cPtr, params.cPtr, localAddr.cPtr, subject, ObjectArrayToBctbxList(list: participants))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoom value")
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a chat room. 
	/// - Parameter params: The chat room creation parameters `ChatRoomParams`   
	/// - Parameter participants: The initial list of participants of the chat room.    
	/// - Returns: The newly created chat room.   
	/// - deprecated: 02/07/2020, use createChatRoom() instead
	@available(*, deprecated)
	public func createChatRoom(params:ChatRoomParams, subject:String, participants:[Address]) throws -> ChatRoom
	{
		let cPointer = linphone_core_create_chat_room_2(cPtr, params.cPtr, subject, ObjectArrayToBctbxList(list: participants))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoom value")
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// - Parameter subject: The subject of the group chat room   
	/// - Parameter participants: The initial list of participants of the chat room.    
	/// - Returns: The newly created chat room.   
	/// - deprecated: 02/07/2020, use createChatRoom() instead
	@available(*, deprecated)
	public func createChatRoom(subject:String, participants:[Address]) throws -> ChatRoom
	{
		let cPointer = linphone_core_create_chat_room_3(cPtr, subject, ObjectArrayToBctbxList(list: participants))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoom value")
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// - Parameter params: The chat room creation parameters `ChatRoomParams`   
	/// - Parameter localAddr: `Address` representing the local proxy configuration to
	/// use for the chat room creation   
	/// - Parameter participant: `Address` representing the initial participant to add
	/// to the chat room   
	/// - Returns: The newly created chat room.   
	/// - deprecated: 02/07/2020, use createChatRoom() instead
	@available(*, deprecated)
	public func createChatRoom(params:ChatRoomParams, localAddr:Address, participant:Address) throws -> ChatRoom
	{
		let cPointer = linphone_core_create_chat_room_4(cPtr, params.cPtr, localAddr.cPtr, participant.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoom value")
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// - Parameter participant: `Address` representing the initial participant to add
	/// to the chat room   
	/// - Returns: The newly created chat room.   
	/// - deprecated: 02/07/2020, use createChatRoom() instead
	@available(*, deprecated)
	public func createChatRoom(participant:Address) throws -> ChatRoom
	{
		let cPointer = linphone_core_create_chat_room_5(cPtr, participant.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoom value")
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create some default conference parameters for instanciating a conference with
	/// createConferenceWithParams(). 
	/// - Returns: a `ConferenceParams` object.   
	public func createConferenceParams() throws -> ConferenceParams
	{
		let cPointer = linphone_core_create_conference_params(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ConferenceParams value")
		}
		let result = ConferenceParams.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a conference. 
	/// - Parameter params: Parameters of the conference. See `ConferenceParams`.   
	/// - Returns: A pointer on the freshly created conference `Conference`. That
	/// object will be automatically freed by the core after calling
	/// terminateConference().   
	public func createConferenceWithParams(params:ConferenceParams) throws -> Conference
	{
		let cPointer = linphone_core_create_conference_with_params(cPtr, params.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Conference value")
		}
		let result = Conference.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `Config` object from a user config file. 
	/// - Parameter filename: The filename of the config file to read to fill the
	/// instantiated `Config`   
	/// - Returns: a `Config` object.   
	public func createConfig(filename:String?) throws -> Config
	{
		let cPointer = linphone_core_create_config(cPtr, filename)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Config value")
		}
		let result = Config.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a content with default values from Linphone core. 
	/// - Returns: `Content` object with default values set   
	public func createContent() throws -> Content
	{
		let cPointer = linphone_core_create_content(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Content value")
		}
		let result = Content.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates and returns the default chat room parameters. 
	/// - Returns: A `ChatRoomParams` object   
	public func createDefaultChatRoomParams() throws -> ChatRoomParams
	{
		let cPointer = linphone_core_create_default_chat_room_params(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ChatRoomParams value")
		}
		let result = ChatRoomParams.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a default LinphoneFriend. 
	/// - Returns: The created `Friend` object   
	public func createFriend() throws -> Friend
	{
		let cPointer = linphone_core_create_friend(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Friend value")
		}
		let result = Friend.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a new empty `FriendList` object. 
	/// - Returns: A new `FriendList` object.   
	public func createFriendList() throws -> FriendList
	{
		let cPointer = linphone_core_create_friend_list(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null FriendList value")
		}
		let result = FriendList.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `Friend` from the given address. 
	/// - Parameter address: A string containing the address to create the `Friend`
	/// from   
	/// - Returns: The created `Friend` object.   
	public func createFriendWithAddress(address:String) throws -> Friend
	{
		let cPointer = linphone_core_create_friend_with_address(cPtr, address)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Friend value")
		}
		let result = Friend.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an empty info message. 
	/// - Returns: a new LinphoneInfoMessage.  
	/// The info message can later be filled with information using
	/// InfoMessage.addHeader() or InfoMessage.setContent(), and finally sent with
	/// linphone_core_send_info_message(). 
	public func createInfoMessage() throws -> InfoMessage
	{
		let cPointer = linphone_core_create_info_message(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null InfoMessage value")
		}
		let result = InfoMessage.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create an empty LDAP search. 
	/// Ldap.setParams() must be call to save the parameters in the configuration file.
	/// - Returns: `Ldap` with default values set     
	public func createLdap() throws -> Ldap
	{
		let cPointer = linphone_core_create_ldap(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Ldap value")
		}
		let result = Ldap.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a LDAP params using default values from Linphone core. 
	/// Check #linphone_ldap_params to update values. In order to add a new LDAP
	/// configuration to Magic search, these parameters must be passed to
	/// linphone_core_create_ldap_with_params. Or, use Ldap.setParams().
	/// The newly created LDAP from createLdap().
	/// - Returns: `LdapParams` with default values set.     
	public func createLdapParams() throws -> LdapParams
	{
		let cPointer = linphone_core_create_ldap_params(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null LdapParams value")
		}
		let result = LdapParams.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a LDAP search using given parameters and store them in the configuration
	/// file. 
	/// - Parameter params: `LdapParams` object   
	/// - Returns: `Ldap` with default values set     
	public func createLdapWithParams(params:LdapParams) throws -> Ldap
	{
		let cPointer = linphone_core_create_ldap_with_params(cPtr, params.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Ldap value")
		}
		let result = Ldap.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create an independent media file player. 
	/// This player support WAVE and MATROSKA formats. 
	/// - Parameter soundCardName: Playback sound card. If nil, the ringer sound card
	/// set in `Core` will be used   
	/// - Parameter videoDisplayName: Video display. If nil, the video display set in
	/// `Core` will be used   
	/// - Parameter windowId: Id of the drawing window. Depend of video out   
	/// - Returns: A pointer on the new instance. nil if failed.   
	public func createLocalPlayer(soundCardName:String?, videoDisplayName:String?, windowId:UnsafeMutableRawPointer?) throws -> Player
	{
		let cPointer = linphone_core_create_local_player(cPtr, soundCardName, videoDisplayName, windowId)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Player value")
		}
		let result = Player.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `MagicSearch` object. 
	/// - Returns: The created `MagicSearch` object   
	public func createMagicSearch() throws -> MagicSearch
	{
		let cPointer = linphone_core_create_magic_search(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null MagicSearch value")
		}
		let result = MagicSearch.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a new `NatPolicy` object with every policies being disabled. 
	/// - Returns: A new `NatPolicy` object.   
	public func createNatPolicy() throws -> NatPolicy
	{
		let cPointer = linphone_core_create_nat_policy(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null NatPolicy value")
		}
		let result = NatPolicy.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a new `NatPolicy` by reading the config of a `Core` according to the
	/// passed ref. 
	/// - Parameter ref: The reference of a NAT policy in the config of the `Core`   
	/// - Returns: A new `NatPolicy` object.   
	public func createNatPolicyFromConfig(ref:String) throws -> NatPolicy
	{
		let cPointer = linphone_core_create_nat_policy_from_config(cPtr, ref)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null NatPolicy value")
		}
		let result = NatPolicy.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create an out-of-dialog notification, specifying the destination resource, the
	/// event name. 
	/// The notification can be send with Event.notify(). 
	/// - Parameter resource: the destination resource   
	/// - Parameter event: the event name   
	/// - Returns: a `Event` holding the context of the notification.   
	public func createNotify(resource:Address, event:String) throws -> Event
	{
		let cPointer = linphone_core_create_notify(cPtr, resource.cPtr, event)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Event value")
		}
		let result = Event.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a publish context for a one-shot publish. 
	/// After being created, the publish must be sent using Event.sendPublish(). The
	/// `Event` is automatically terminated when the publish transaction is finished,
	/// either with success or failure. The application must not call Event.terminate()
	/// for such one-shot publish. 
	/// - Parameter resource: the resource uri for the event   
	/// - Parameter event: the event name   
	/// - Returns: the `Event` holding the context of the publish.   
	public func createOneShotPublish(resource:Address, event:String) throws -> Event
	{
		let cPointer = linphone_core_create_one_shot_publish(cPtr, resource.cPtr, event)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Event value")
		}
		let result = Event.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `PresenceActivity` with the given type and description. 
	/// - Parameter acttype: The `PresenceActivityType` to set for the activity. 
	/// - Parameter description: An additional description of the activity to set for
	/// the activity. Can be nil if no additional description is to be added.   
	/// - Returns: The created `PresenceActivity` object.   
	public func createPresenceActivity(acttype:PresenceActivityType, description:String?) throws -> PresenceActivity
	{
		let cPointer = linphone_core_create_presence_activity(cPtr, LinphonePresenceActivityType(rawValue: CUnsignedInt(acttype.rawValue)), description)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresenceActivity value")
		}
		let result = PresenceActivity.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a default LinphonePresenceModel. 
	/// - Returns: The created `PresenceModel` object.   
	public func createPresenceModel() throws -> PresenceModel
	{
		let cPointer = linphone_core_create_presence_model(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresenceModel value")
		}
		let result = PresenceModel.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `PresenceModel` with the given activity type and activity description. 
	/// - Parameter acttype: The `PresenceActivityType` to set for the activity of the
	/// created model. 
	/// - Parameter description: An additional description of the activity to set for
	/// the activity. Can be nil if no additional description is to be added.   
	/// - Returns: The created `PresenceModel` object.   
	public func createPresenceModelWithActivity(acttype:PresenceActivityType, description:String?) throws -> PresenceModel
	{
		let cPointer = linphone_core_create_presence_model_with_activity(cPtr, LinphonePresenceActivityType(rawValue: CUnsignedInt(acttype.rawValue)), description)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresenceModel value")
		}
		let result = PresenceModel.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `PresenceModel` with the given activity type, activity description,
	/// note content and note language. 
	/// - Parameter acttype: The `PresenceActivityType` to set for the activity of the
	/// created model. 
	/// - Parameter description: An additional description of the activity to set for
	/// the activity. Can be nil if no additional description is to be added.   
	/// - Parameter note: The content of the note to be added to the created model.   
	/// - Parameter lang: The language of the note to be added to the created model.   
	/// - Returns: The created `PresenceModel` object.   
	public func createPresenceModelWithActivityAndNote(acttype:PresenceActivityType, description:String?, note:String, lang:String?) throws -> PresenceModel
	{
		let cPointer = linphone_core_create_presence_model_with_activity_and_note(cPtr, LinphonePresenceActivityType(rawValue: CUnsignedInt(acttype.rawValue)), description, note, lang)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresenceModel value")
		}
		let result = PresenceModel.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `PresenceNote` with the given content and language. 
	/// - Parameter content: The content of the note to be created.   
	/// - Parameter lang: The language of the note to be created.   
	/// - Returns: The created `PresenceNote` object.   
	public func createPresenceNote(content:String, lang:String?) throws -> PresenceNote
	{
		let cPointer = linphone_core_create_presence_note(cPtr, content, lang)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresenceNote value")
		}
		let result = PresenceNote.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `PresencePerson` with the given id. 
	/// - Parameter id: The id of the person to be created.   
	/// - Returns: The created `PresencePerson` object.   
	public func createPresencePerson(id:String) throws -> PresencePerson
	{
		let cPointer = linphone_core_create_presence_person(cPtr, id)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresencePerson value")
		}
		let result = PresencePerson.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `PresenceService` with the given id, basic status and contact. 
	/// - Parameter id: The id of the service to be created.   
	/// - Parameter basicStatus: The basic status of the service to be created. 
	/// - Parameter contact: A string containing a contact information corresponding to
	/// the service to be created.   
	/// - Returns: The created `PresenceService` object.   
	public func createPresenceService(id:String, basicStatus:PresenceBasicStatus, contact:String) throws -> PresenceService
	{
		let cPointer = linphone_core_create_presence_service(cPtr, id, LinphonePresenceBasicStatus(rawValue: CUnsignedInt(basicStatus.rawValue)), contact)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null PresenceService value")
		}
		let result = PresenceService.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Same as getPrimaryContact() but the result is a `Address` object instead of
	/// const char *. 
	/// - Returns: a `Address` object.   
	public func createPrimaryContactParsed() throws -> Address
	{
		let cPointer = linphone_core_create_primary_contact_parsed(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Address value")
		}
		let result = Address.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a proxy config with default values from Linphone core. 
	/// - Returns: `ProxyConfig` with default values set   
	public func createProxyConfig() throws -> ProxyConfig
	{
		let cPointer = linphone_core_create_proxy_config(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ProxyConfig value")
		}
		let result = ProxyConfig.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a publish context for an event state. 
	/// After being created, the publish must be sent using Event.sendPublish(). After
	/// expiry, the publication is refreshed unless it is terminated before. 
	/// - Parameter resource: the resource uri for the event   
	/// - Parameter event: the event name   
	/// - Parameter expires: the lifetime of event being published, -1 if no associated
	/// duration, in which case it will not be refreshed. 
	/// - Returns: the `Event` holding the context of the publish.   
	public func createPublish(resource:Address, event:String, expires:Int) throws -> Event
	{
		let cPointer = linphone_core_create_publish(cPtr, resource.cPtr, event, CInt(expires))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Event value")
		}
		let result = Event.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a media file recorder. 
	/// This recorder support WAVE and MATROSKA formats. 
	/// - Parameter params: The `RecorderParams` that will contains all recorder
	/// parameters.   
	/// - Returns: A pointer on the new instance. nil if failed.   
	public func createRecorder(params:RecorderParams) throws -> Recorder
	{
		let cPointer = linphone_core_create_recorder(cPtr, params.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Recorder value")
		}
		let result = Recorder.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a recorder params that will hold parameters. 
	/// This recorder support WAVE and MATROSKA formats. 
	/// - Returns: A pointer on the newly created instance.   
	public func createRecorderParams() throws -> RecorderParams
	{
		let cPointer = linphone_core_create_recorder_params(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null RecorderParams value")
		}
		let result = RecorderParams.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create an outgoing subscription, specifying the destination resource, the event
	/// name, and an optional content body. 
	/// If accepted, the subscription runs for a finite period, but is automatically
	/// renewed if not terminated before. Unlike subscribe() the subscription isn't
	/// sent immediately. It will be send when calling Event.sendSubscribe(). 
	/// - Parameter resource: the destination resource   
	/// - Parameter event: the event name   
	/// - Parameter expires: the whished duration of the subscription 
	/// - Returns: a `Event` holding the context of the created subcription.   
	public func createSubscribe(resource:Address, event:String, expires:Int) throws -> Event
	{
		let cPointer = linphone_core_create_subscribe(cPtr, resource.cPtr, event, CInt(expires))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Event value")
		}
		let result = Event.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create an outgoing subscription, specifying the destination resource, the event
	/// name, and an optional content body. 
	/// If accepted, the subscription runs for a finite period, but is automatically
	/// renewed if not terminated before. Unlike subscribe() the subscription isn't
	/// sent immediately. It will be send when calling Event.sendSubscribe(). 
	/// - Parameter resource: the destination resource   
	/// - Parameter proxy: the proxy configuration to use   
	/// - Parameter event: the event name   
	/// - Parameter expires: the whished duration of the subscription 
	/// - Returns: a `Event` holding the context of the created subcription.   
	public func createSubscribe(resource:Address, proxy:ProxyConfig, event:String, expires:Int) throws -> Event
	{
		let cPointer = linphone_core_create_subscribe_2(cPtr, resource.cPtr, proxy.cPtr, event, CInt(expires))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Event value")
		}
		let result = Event.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `XmlRpcSession` for a given url. 
	/// - Parameter url: The URL to the XML-RPC server. Must be NON nil.   
	/// - Returns: The new `XmlRpcSession` object.   
	public func createXmlRpcSession(url:String) throws -> XmlRpcSession
	{
		let cPointer = linphone_core_create_xml_rpc_session(cPtr, url)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null XmlRpcSession value")
		}
		let result = XmlRpcSession.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Removes a chatroom including all message history from the LinphoneCore. 
	/// - Parameter chatRoom: A `ChatRoom` object   
	public func deleteChatRoom(chatRoom:ChatRoom) 
	{
		linphone_core_delete_chat_room(cPtr, chatRoom.cPtr)
	}

	/// Sets device_token when application
	/// didRegisterForRemoteNotificationsWithDeviceToken (IOS only). 
	/// - Parameter deviceToken: (NSData *).   
	public func didRegisterForRemotePush(deviceToken:UnsafeMutableRawPointer?) 
	{
		linphone_core_did_register_for_remote_push(cPtr, deviceToken)
	}

	/// Sets device_token when application
	/// didRegisterForRemoteNotificationsWithDeviceToken (IOS only). 
	/// - Parameter deviceTokenStr: extracted from the Data objectf received in
	/// didRegisterForRemoteNotificationsWithDeviceToken ios function. Append ":remote"
	/// after data formating..   
	public func didRegisterForRemotePushWithStringifiedToken(deviceTokenStr:String?) 
	{
		linphone_core_did_register_for_remote_push_with_stringified_token(cPtr, deviceTokenStr)
	}

	/// Inconditionnaly disable incoming chat messages. 
	/// - Parameter denyReason: the deny reason (`None` has no effect). 
	public func disableChat(denyReason:Reason) 
	{
		linphone_core_disable_chat(cPtr, LinphoneReason(rawValue: CUnsignedInt(denyReason.rawValue)))
	}

	/// Enable reception of incoming chat messages. 
	/// By default it is enabled but it can be disabled with disableChat(). 
	public func enableChat() 
	{
		linphone_core_enable_chat(cPtr)
	}

	/// Call this method when you receive a push notification (if you handle push
	/// notifications manually). 
	/// It will ensure the proxy configs are correctly registered to the proxy server,
	/// so the call or the message will be correctly delivered. 
	public func ensureRegistered() 
	{
		linphone_core_ensure_registered(cPtr)
	}

	/// This method is called by the application to notify the linphone core library
	/// when it enters background mode. 
	public func enterBackground() 
	{
		linphone_core_enter_background(cPtr)
	}

	/// Join the local participant to the running conference. 
	/// - Returns: 0 if succeeded. Negative number if failed 
	/// - deprecated: 09/03/2021 Use Conference.enter() instead. 
	@available(*, deprecated)
	public func enterConference() throws 
	{
		let exception_result = linphone_core_enter_conference(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "enterConference returned value \(exception_result)")
		}
	}

	/// This method is called by the application to notify the linphone core library
	/// when it enters foreground mode. 
	public func enterForeground() 
	{
		linphone_core_enter_foreground(cPtr)
	}

	/// Returns whether a specific file format is supported. 
	/// - See also: linphone_core_get_supported_file_formats 
	/// - Parameter fmt: The format extension (wav, mkv).   
	/// - Returns: true if the file format is supported, false otherwise 
	public func fileFormatSupported(fmt:String) -> Bool
	{
		return linphone_core_file_format_supported(cPtr, fmt) != 0
	}

	/// Find authentication info matching realm, username, domain criteria. 
	/// First of all, (realm,username) pair are searched. If multiple results (which
	/// should not happen because realm are supposed to be unique), then domain is
	/// added to the search. 
	/// - Parameter realm: the authentication 'realm' (optional)   
	/// - Parameter username: the SIP username to be authenticated (mandatory)   
	/// - Parameter sipDomain: the SIP domain name (optional)   
	/// - Returns: a `AuthInfo` if found.   
	public func findAuthInfo(realm:String?, username:String, sipDomain:String?) -> AuthInfo?
	{
		let cPointer = linphone_core_find_auth_info(cPtr, realm, username, sipDomain)
		if (cPointer == nil) {
			return nil
		}
		let result = AuthInfo.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Search from the list of current calls if a remote address match uri. 
	/// - Parameter uri: which should match call remote uri   
	/// - Returns: `Call` or nil is no match is found.   
	/// - deprecated: 27/10/2020. Use getCallByRemoteAddress2() instead. 
	@available(*, deprecated)
	public func findCallFromUri(uri:String) -> Call?
	{
		let cPointer = linphone_core_find_call_from_uri(cPtr, uri)
		if (cPointer == nil) {
			return nil
		}
		let result = Call.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Get the call log matching the call id, or nil if can't be found. 
	/// - Parameter callId: Call id of the call log to find   
	/// - Parameter limit: Search limit of the most recent call logs to find   
	/// - Returns: A call log matching the call id if any.     
	public func findCallLog(callId:String, limit:Int) -> CallLog?
	{
		let cPointer = linphone_core_find_call_log(cPtr, callId, CInt(limit))
		if (cPointer == nil) {
			return nil
		}
		let result = CallLog.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Get the call log matching the call id, or nil if can't be found. 
	/// - Parameter callId: Call id of the call log to find   
	/// - Returns: A call log matching the call id if any.     
	public func findCallLogFromCallId(callId:String) -> CallLog?
	{
		let cPointer = linphone_core_find_call_log_from_call_id(cPtr, callId)
		if (cPointer == nil) {
			return nil
		}
		let result = CallLog.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Find a chat room. 
	/// No reference is transfered to the application. The `Core` keeps a reference on
	/// the chat room. 
	/// - Parameter peerAddr: a linphone address.   
	/// - Parameter localAddr: a linphone address.   
	/// - Returns: `ChatRoom` where messaging can take place.   
	/// - deprecated: 02/07/2020, use searchChatRoom() instead
	@available(*, deprecated)
	public func findChatRoom(peerAddr:Address, localAddr:Address) -> ChatRoom?
	{
		let cPointer = linphone_core_find_chat_room(cPtr, peerAddr.cPtr, localAddr.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Retrieves a list of `Address` sort and filter. 
	/// - Parameter filter: Chars used for the filter*   
	/// - Parameter sipOnly: Only sip address or not 
	/// - Returns: A list of filtered `Address` + the `Address` created with the
	/// filter.    
	public func findContactsByChar(filter:String, sipOnly:Bool) -> [Address]
	{
		var swiftList = [Address]()
		let cList = linphone_core_find_contacts_by_char(cPtr, filter, sipOnly==true ? 1:0)
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(Address.getSwiftObject(cObject: data))
			listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		return swiftList
	}

	/// Search a `Friend` by its address. 
	/// - Parameter address: The `Address` to use to search the friend.   
	/// - Returns: The `Friend` object corresponding to the given address or nil if not
	/// found.   
	public func findFriend(address:Address) -> Friend?
	{
		let cPointer = linphone_core_find_friend(cPtr, address.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Friend.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Search a `Friend` by its phone number. 
	/// - Parameter phoneNumber: The phone number to use to search the friend.   
	/// - Returns: The `Friend` object corresponding to the given phone number or nil
	/// if not found.   
	public func findFriendByPhoneNumber(phoneNumber:String) -> Friend?
	{
		let cPointer = linphone_core_find_friend_by_phone_number(cPtr, phoneNumber)
		if (cPointer == nil) {
			return nil
		}
		let result = Friend.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Search all `Friend` matching an address. 
	/// - Parameter address: The address to use to search the friends.   
	/// - Returns: A list of `Friend` corresponding to the given address.      
	public func findFriends(address:Address) -> [Friend]
	{
		var swiftList = [Friend]()
		let cList = linphone_core_find_friends(cPtr, address.cPtr)
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(Friend.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Find a one to one chat room. 
	/// No reference is transfered to the application. The `Core` keeps a reference on
	/// the chat room. 
	/// - Parameter localAddr: a linphone address.   
	/// - Parameter participantAddr: a linphone address.   
	/// - Parameter encrypted: whether to look for an encrypted chat room or not 
	/// - Returns: `ChatRoom` where messaging can take place.   
	/// - deprecated: 02/07/2020, use searchChatRoom() instead
	@available(*, deprecated)
	public func findOneToOneChatRoom(localAddr:Address, participantAddr:Address, encrypted:Bool) -> ChatRoom?
	{
		let cPointer = linphone_core_find_one_to_one_chat_room_2(cPtr, localAddr.cPtr, participantAddr.cPtr, encrypted==true ? 1:0)
		if (cPointer == nil) {
			return nil
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Search for a `Account` by it's idkey. 
	/// - Parameter idkey: An arbitrary idkey string associated to an account.   
	/// - Returns: the `Account` object for the given idkey value, or nil if none found
	///   
	public func getAccountByIdkey(idkey:String?) -> Account?
	{
		let cPointer = linphone_core_get_account_by_idkey(cPtr, idkey)
		if (cPointer == nil) {
			return nil
		}
		let result = Account.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Get the call by callid. 
	/// - Returns: call `Call`, return null if there is no call find.   
	public func getCallByCallid(callId:String) -> Call?
	{
		let cPointer = linphone_core_get_call_by_callid(cPtr, callId)
		if (cPointer == nil) {
			return nil
		}
		let result = Call.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Get the call with the remote_address specified. 
	/// - Parameter remoteAddress: The remote address of the call that we want to get   
	/// - Returns: The call if it has been found, nil otherwise.  
	/// - deprecated: 08/07/2020 use getCallByRemoteAddress2() instead 
	@available(*, deprecated)
	public func getCallByRemoteAddress(remoteAddress:String) -> Call?
	{
		let cPointer = linphone_core_get_call_by_remote_address(cPtr, remoteAddress)
		if (cPointer == nil) {
			return nil
		}
		let result = Call.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Get the call with the specified `Address`. 
	/// - Parameter remoteAddress: the `Address` for which the call remote address must
	/// match   
	/// - Returns: the `Call` of the call if found.   
	public func getCallByRemoteAddress2(remoteAddress:Address) -> Call?
	{
		let cPointer = linphone_core_get_call_by_remote_address2(cPtr, remoteAddress.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Call.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Get the list of call logs (past calls). 
	/// At the contrary of linphone_core_get_call_logs, it is your responsibility to
	/// unref the logs and free this list once you are done using it. 
	/// - Parameter peerAddress: The remote `Address` object.   
	/// - Parameter localAddress: The local `Address` object   
	/// - Returns: A list of `CallLog`.      
	public func getCallHistory(peerAddress:Address, localAddress:Address) -> [CallLog]
	{
		var swiftList = [CallLog]()
		let cList = linphone_core_get_call_history_2(cPtr, peerAddress.cPtr, localAddress.cPtr)
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(CallLog.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Get the list of call logs (past calls) that matches the given `Address`. 
	/// At the contrary of linphone_core_get_call_logs, it is your responsibility to
	/// unref the logs and free this list once you are done using it. 
	/// - Parameter address: `Address` object   
	/// - Returns: A list of `CallLog`.      
	/// - deprecated: 29/10/2018 Use getCallHistory() instead.
	@available(*, deprecated)
	public func getCallHistoryForAddress(address:Address) -> [CallLog]
	{
		var swiftList = [CallLog]()
		let cList = linphone_core_get_call_history_for_address(cPtr, address.cPtr)
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(CallLog.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Get a chat room whose peer is the supplied address. 
	/// If it does not exist yet, it will be created as a basic chat room. No reference
	/// is transfered to the application. The `Core` keeps a reference on the chat
	/// room. - Warning: This method is prone to errors, use searchChatRoom() instead 
	/// - Parameter addr: a linphone address.   
	/// - Returns: `ChatRoom` where messaging can take place.   
	/// - deprecated: 02/07/2020, use searchChatRoom() instead
	@available(*, deprecated)
	public func getChatRoom(addr:Address) -> ChatRoom?
	{
		let cPointer = linphone_core_get_chat_room(cPtr, addr.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Get a chat room. 
	/// If it does not exist yet, it will be created as a basic chat room. No reference
	/// is transfered to the application. The `Core` keeps a reference on the chat
	/// room. - Warning: This method is prone to errors, use searchChatRoom() instead 
	/// - Parameter peerAddr: a linphone address.   
	/// - Parameter localAddr: a linphone address.   
	/// - Returns: `ChatRoom` where messaging can take place.   
	/// - deprecated: 02/07/2020, use searchChatRoom() instead
	@available(*, deprecated)
	public func getChatRoom(peerAddr:Address, localAddr:Address) -> ChatRoom?
	{
		let cPointer = linphone_core_get_chat_room_2(cPtr, peerAddr.cPtr, localAddr.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Get a chat room for messaging from a sip uri like sip:joe@sip.linphone.org. 
	/// If it does not exist yet, it will be created as a basic chat room. No reference
	/// is transfered to the application. The `Core` keeps a reference on the chat
	/// room. - Warning: This method is prone to errors, use searchChatRoom() instead 
	/// - Parameter to: The destination address for messages.   
	/// - Returns: `ChatRoom` where messaging can take place.   
	/// - deprecated: 02/07/2020, use searchChatRoom() instead
	@available(*, deprecated)
	public func getChatRoomFromUri(to:String) -> ChatRoom?
	{
		let cPointer = linphone_core_get_chat_room_from_uri(cPtr, to)
		if (cPointer == nil) {
			return nil
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Search a `Friend` by its reference key. 
	/// - Parameter key: The reference key to use to search the friend.   
	/// - Returns: The `Friend` object corresponding to the given reference key.   
	public func getFriendByRefKey(key:String) -> Friend?
	{
		let cPointer = linphone_core_get_friend_by_ref_key(cPtr, key)
		if (cPointer == nil) {
			return nil
		}
		let result = Friend.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Retrieves the list of `Friend` from the core that has the given display name. 
	/// - Parameter name: the name of the list   
	/// - Returns: the first `FriendList` object or nil.   
	public func getFriendListByName(name:String) -> FriendList?
	{
		let cPointer = linphone_core_get_friend_list_by_name(cPtr, name)
		if (cPointer == nil) {
			return nil
		}
		let result = FriendList.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Get the chat room we have been added into using the chat_room_addr included in
	/// the push notification body This will start the core given in parameter, iterate
	/// until the new chat room is received and return it. 
	/// By default, after 25 seconds the function returns because iOS kills the app
	/// extension after 30 seconds. 
	/// - Parameter chatRoomAddr: The sip address of the chat room   
	/// - Returns: The `ChatRoom` object.   
	public func getNewChatRoomFromConfAddr(chatRoomAddr:String) -> ChatRoom?
	{
		let cPointer = linphone_core_get_new_chat_room_from_conf_addr(cPtr, chatRoomAddr)
		if (cPointer == nil) {
			return nil
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Get the chat message with the call_id included in the push notification body
	/// This will start the core given in parameter, iterate until the message is
	/// received and return it. 
	/// By default, after 25 seconds the function returns because iOS kills the app
	/// extension after 30 seconds. 
	/// - Parameter callId: The callId of the Message SIP transaction   
	/// - Returns: The `ChatMessage` object.   
	public func getNewMessageFromCallid(callId:String) -> PushNotificationMessage?
	{
		let cPointer = linphone_core_get_new_message_from_callid(cPtr, callId)
		if (cPointer == nil) {
			return nil
		}
		let result = PushNotificationMessage.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Get payload type from mime type and clock rate. 
	/// This function searches in audio and video codecs for the given payload type
	/// name and clockrate. 
	/// - Parameter type: payload mime type (I.E SPEEX, PCMU, VP8)   
	/// - Parameter rate: can be LINPHONE_FIND_PAYLOAD_IGNORE_RATE 
	/// - Parameter channels: number of channels, can be
	/// LINPHONE_FIND_PAYLOAD_IGNORE_CHANNELS 
	/// - Returns: Returns nil if not found. If a `PayloadType` is returned, it must be
	/// released with linphone_payload_type_unref after using it.   
	/// - Warning: The returned payload type is allocated as a floating reference i.e.
	/// the reference counter is initialized to 0. 
	public func getPayloadType(type:String, rate:Int, channels:Int) -> PayloadType?
	{
		let cPointer = linphone_core_get_payload_type(cPtr, type, CInt(rate), CInt(channels))
		if (cPointer == nil) {
			return nil
		}
		let result = PayloadType.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Search for a `ProxyConfig` by it's idkey. 
	/// - Parameter idkey: An arbitrary idkey string associated to a proxy
	/// configuration 
	/// - Returns: the `ProxyConfig` object for the given idkey value, or nil if none
	/// found   
	public func getProxyConfigByIdkey(idkey:String) -> ProxyConfig?
	{
		let cPointer = linphone_core_get_proxy_config_by_idkey(cPtr, idkey)
		if (cPointer == nil) {
			return nil
		}
		let result = ProxyConfig.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Return the unread chat message count for a given local address. 
	/// - Parameter address: `Address` object.   
	/// - Returns: The unread chat message count. 
	public func getUnreadChatMessageCountFromLocal(address:Address) -> Int
	{
		return Int(linphone_core_get_unread_chat_message_count_from_local(cPtr, address.cPtr))
	}

	/// Get the zrtp sas validation status for a peer uri. 
	/// Once the SAS has been validated or rejected, the status will never return to
	/// Unknown (unless you delete your cache) 
	/// - Parameter addr: the peer uri  
	/// - Returns: - LinphoneZrtpPeerStatusUnknown: this uri is not present in cache OR
	/// during calls with the active device, SAS never was validated or rejected
	public func getZrtpStatus(addr:String) -> ZrtpPeerStatus
	{
		return ZrtpPeerStatus(rawValue: Int(linphone_core_get_zrtp_status(cPtr, addr).rawValue))!
	}

	/// Check whether the device has a hardware echo canceller. 
	/// - Returns: true if it does, false otherwise 
	public func hasBuiltinEchoCanceller() -> Bool
	{
		return linphone_core_has_builtin_echo_canceller(cPtr) != 0
	}

	/// Check whether the device is flagged has crappy opengl. 
	/// - Returns: true if crappy opengl flag is set, false otherwise 
	public func hasCrappyOpengl() -> Bool
	{
		return linphone_core_has_crappy_opengl(cPtr) != 0
	}

	/// Tells whether there is a call running. 
	/// - Returns: A boolean value telling whether a call is currently running or not 
	public func inCall() -> Bool
	{
		return linphone_core_in_call(cPtr) != 0
	}

	/// Constructs a `Address` from the given string if possible. 
	/// In case of just a username, characters will be unescaped. If a phone number is
	/// detected, it will be flattened. sip: or sips: prefix will be added if not
	/// present. Finally, @domain will be added if not present using default proxy
	/// config. - See also: ProxyConfig.normalizeSipUri() for documentation. 
	/// - Parameter url: the url to parse   
	/// - Returns: the `Address` matching the url or nil in case of failure.     
	public func interpretUrl(url:String) -> Address?
	{
		let cPointer = linphone_core_interpret_url(cPtr, url)
		if (cPointer == nil) {
			return nil
		}
		let result = Address.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Initiates an outgoing call. 
	/// The application doesn't own a reference to the returned LinphoneCall object.
	/// Use linphone_call_ref to safely keep the LinphoneCall pointer valid within your
	/// application.
	/// - Parameter url: The destination of the call (sip address, or phone number).   
	/// - Returns: A `Call` object or nil in case of failure.   
	public func invite(url:String) -> Call?
	{
		let cPointer = linphone_core_invite(cPtr, url)
		if (cPointer == nil) {
			return nil
		}
		let result = Call.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Initiates an outgoing call given a destination `Address` The `Address` can be
	/// constructed directly using linphone_address_new, or created by interpretUrl(). 
	/// The application doesn't own a reference to the returned `Call` object. Use
	/// linphone_call_ref to safely keep the `Call` pointer valid within your
	/// application. 
	/// - Parameter addr: The destination of the call (sip address).   
	/// - Returns: A `Call` object or nil in case of failure.   
	public func inviteAddress(addr:Address) -> Call?
	{
		let cPointer = linphone_core_invite_address(cPtr, addr.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Call.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Initiates an outgoing call given a destination `Address` The `Address` can be
	/// constructed directly using linphone_address_new, or created by interpretUrl(). 
	/// The application doesn't own a reference to the returned `Call` object. Use
	/// linphone_call_ref to safely keep the `Call` pointer valid within your
	/// application. If the proxy is not specified in parameters, the caller proxy will
	/// be automatically selected by finding what is the best to reach the destination
	/// of the call. 
	/// - Parameter addr: The destination of the call (sip address).   
	/// - Parameter params: Call parameters   
	/// - Returns: A `Call` object or nil in case of failure.   
	public func inviteAddressWithParams(addr:Address, params:CallParams) -> Call?
	{
		let cPointer = linphone_core_invite_address_with_params(cPtr, addr.cPtr, params.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Call.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Initiates an outgoing call according to supplied call parameters The
	/// application doesn't own a reference to the returned `Call` object. 
	/// Use linphone_call_ref to safely keep the `Call` pointer valid within your
	/// application. 
	/// - Parameter url: The destination of the call (sip address, or phone number).   
	/// - Parameter params: the `CallParams` call parameters   
	/// - Returns: A `Call` object or nil in case of failure.   
	public func inviteWithParams(url:String, params:CallParams) -> Call?
	{
		let cPointer = linphone_core_invite_with_params(cPtr, url, params.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Call.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Tells whether a content type is supported. 
	/// - Parameter contentType: The content type to check   
	/// - Returns: A boolean value telling whether the specified content type is
	/// supported or not. 
	public func isContentTypeSupported(contentType:String) -> Bool
	{
		return linphone_core_is_content_type_supported(cPtr, contentType) != 0
	}

	/// Check if media encryption is supported. 
	/// - Parameter menc: The media encryption policy to be used. 
	/// - Returns: true if the media encryption is supported, false otherwise 
	public func isMediaEncryptionSupported(menc:MediaEncryption) -> Bool
	{
		return linphone_core_is_media_encryption_supported(cPtr, LinphoneMediaEncryption(rawValue: CUnsignedInt(menc.rawValue))) != 0
	}

	/// Checks if the given media filter is loaded and usable. 
	/// This is for advanced users of the library, mainly to expose mediastreamer video
	/// filter status. 
	/// - Parameter filtername: the filter name   
	/// - Returns: true if the filter is loaded and usable, false otherwise 
	public func isMediaFilterSupported(filtername:String) -> Bool
	{
		return linphone_core_is_media_filter_supported(cPtr, filtername) != 0
	}

	/// Main loop function. 
	/// It is crucial that your application call it periodically.
	/// iterate() performs various backgrounds tasks:
	public func iterate() 
	{
		linphone_core_iterate(cPtr)
	}

	/// Tells if LDAP is available. 
	/// - Returns: true if LDAP is available, false otherwise 
	public func ldapAvailable() -> Bool
	{
		return linphone_core_ldap_available(cPtr) != 0
	}

	/// Make the local participant leave the running conference. 
	/// - Returns: 0 if succeeded. Negative number if failed 
	/// - deprecated: 09/03/2021 Use Conference.leave() instead. 
	@available(*, deprecated)
	public func leaveConference() throws 
	{
		let exception_result = linphone_core_leave_conference(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "leaveConference returned value \(exception_result)")
		}
	}

	/// Tells if LIME X3DH is available. 
	public func limeX3DhAvailable() -> Bool
	{
		return linphone_core_lime_x3dh_available(cPtr) != 0
	}

	/// Update current config with the content of a xml config file. 
	/// - Parameter xmlUri: the path to the xml file   
	public func loadConfigFromXml(xmlUri:String) 
	{
		linphone_core_load_config_from_xml(cPtr, xmlUri)
	}

	/// Check if a media encryption type is supported. 
	/// - Parameter menc: `MediaEncryption` 
	/// - Returns: whether a media encryption scheme is supported by the `Core` engine 
	public func mediaEncryptionSupported(menc:MediaEncryption) -> Bool
	{
		return linphone_core_media_encryption_supported(cPtr, LinphoneMediaEncryption(rawValue: CUnsignedInt(menc.rawValue))) != 0
	}

	/// Migrates the call logs from the linphonerc to the database if not done yet. 
	public func migrateLogsFromRcToDb() 
	{
		linphone_core_migrate_logs_from_rc_to_db(cPtr)
	}

	/// Migrate configuration so that all SIP transports are enabled. 
	/// Versions of linphone < 3.7 did not support using multiple SIP transport
	/// simultaneously. This function helps application to migrate the configuration so
	/// that all transports are enabled. Existing proxy configuration are added a
	/// transport parameter so that they continue using the unique transport that was
	/// set previously. This function must be used just after creating the core, before
	/// any call to iterate() 
	/// - Returns: 1 if migration was done, 0 if not done because unnecessary or
	/// already done, -1 in case of error. 
	public func migrateToMultiTransport() throws 
	{
		let exception_result = linphone_core_migrate_to_multi_transport(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "migrateToMultiTransport returned value \(exception_result)")
		}
	}

	/// Notify all friends that have subscribed. 
	/// - Parameter presence: `PresenceModel` to notify   
	public func notifyAllFriends(presence:PresenceModel) 
	{
		linphone_core_notify_all_friends(cPtr, presence.cPtr)
	}

	/// Notifies the upper layer that a presence status has been received by calling
	/// the appropriate callback if one has been set. 
	/// This method is for advanced usage, where customization of the liblinphone's
	/// internal behavior is required. 
	/// - Parameter linphoneFriend: the `Friend` whose presence information has been
	/// received.   
	public func notifyNotifyPresenceReceived(linphoneFriend:Friend) 
	{
		linphone_core_notify_notify_presence_received(cPtr, linphoneFriend.cPtr)
	}

	/// Notifies the upper layer that a presence model change has been received for the
	/// uri or telephone number given as a parameter, by calling the appropriate
	/// callback if one has been set. 
	/// This method is for advanced usage, where customization of the liblinphone's
	/// internal behavior is required. 
	/// - Parameter linphoneFriend: the `Friend` whose presence information has been
	/// received.   
	/// - Parameter uriOrTel: telephone number or sip uri   
	/// - Parameter presenceModel: the `PresenceModel` that has been modified   
	public func notifyNotifyPresenceReceivedForUriOrTel(linphoneFriend:Friend, uriOrTel:String, presenceModel:PresenceModel) 
	{
		linphone_core_notify_notify_presence_received_for_uri_or_tel(cPtr, linphoneFriend.cPtr, uriOrTel, presenceModel.cPtr)
	}

	/// Pause all currently running calls. 
	/// - Returns: 0 
	public func pauseAllCalls() throws 
	{
		let exception_result = linphone_core_pause_all_calls(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "pauseAllCalls returned value \(exception_result)")
		}
	}

	/// Plays a dtmf sound to the local user. 
	/// - Parameter dtmf: DTMF to play ['0'..'16'] | '#' | '#' 
	/// - Parameter durationMs: Duration in ms, -1 means play until next further call
	/// to stopDtmf() 
	public func playDtmf(dtmf:CChar, durationMs:Int) 
	{
		linphone_core_play_dtmf(cPtr, dtmf, CInt(durationMs))
	}

	/// Plays an audio file to the local user. 
	/// This function works at any time, during calls, or when no calls are running. It
	/// doesn't request the underlying audio system to support multiple playback
	/// streams. 
	/// - Parameter audiofile: The path to an audio file in wav PCM 16 bit format   
	/// - Returns: 0 on success, -1 on error 
	public func playLocal(audiofile:String) throws 
	{
		let exception_result = linphone_core_play_local(cPtr, audiofile)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "playLocal returned value \(exception_result)")
		}
	}

	/// Empties sound resources to allow a new call to be accepted. 
	/// This function is autyomatically called by the core if the media resource mode
	/// is set to unique. 
	/// - Returns: An integer returning the exit value. If it is 0, sound resources
	/// have been emptied. Otherwise, sound resources are busy and cannot be freed
	/// immediately. 
	public func preemptSoundResources() -> Int
	{
		return Int(linphone_core_preempt_sound_resources(cPtr))
	}

	/// Call generic OpenGL render for a given core. 
	public func previewOglRender() 
	{
		linphone_core_preview_ogl_render(cPtr)
	}

	/// Publish an event state. 
	/// This first create a `Event` with createPublish() and calls Event.sendPublish()
	/// to actually send it. After expiry, the publication is refreshed unless it is
	/// terminated before. 
	/// - Parameter resource: the resource uri for the event   
	/// - Parameter event: the event name   
	/// - Parameter expires: the lifetime of event being published, -1 if no associated
	/// duration, in which case it will not be refreshed. 
	/// - Parameter body: the actual published data   
	/// - Returns: the `Event` holding the context of the publish.   
	public func publish(resource:Address, event:String, expires:Int, body:Content) -> Event?
	{
		let cPointer = linphone_core_publish(cPtr, resource.cPtr, event, CInt(expires), body.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Event.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Gets keep alive interval of real time text. 
	/// - Returns: keep alive interval of real time text. 
	public func realtimeTextGetKeepaliveInterval() -> UInt
	{
		return UInt(linphone_core_realtime_text_get_keepalive_interval(cPtr))
	}

	/// Set keep alive interval for real time text. 
	/// - Parameter interval: The keep alive interval of real time text, 25000 by
	/// default. 
	public func realtimeTextSetKeepaliveInterval(interval:UInt) 
	{
		linphone_core_realtime_text_set_keepalive_interval(cPtr, CUnsignedInt(interval))
	}

	/// force registration refresh to be initiated upon next iterate 
	public func refreshRegisters() 
	{
		linphone_core_refresh_registers(cPtr)
	}

	/// Black list a friend. 
	/// same as Friend.setIncSubscribePolicy() with `SPDeny` policy; 
	/// - Parameter linphoneFriend: `Friend` to reject   
	public func rejectSubscriber(linphoneFriend:Friend) 
	{
		linphone_core_reject_subscriber(cPtr, linphoneFriend.cPtr)
	}

	/// Reload mediastreamer2 plugins from specified directory. 
	/// - Parameter path: the path from where plugins are to be loaded, pass nil to use
	/// default (compile-time determined) plugin directory.   
	public func reloadMsPlugins(path:String?) 
	{
		linphone_core_reload_ms_plugins(cPtr, path)
	}

	/// Update detection of sound devices. 
	/// Use this function when the application is notified of USB plug events, so that
	/// list of available hardwares for sound playback and capture is updated. 
	public func reloadSoundDevices() 
	{
		linphone_core_reload_sound_devices(cPtr)
	}

	/// Update detection of camera devices. 
	/// Use this function when the application is notified of USB plug events, so that
	/// list of available hardwares for video capture is updated. 
	public func reloadVideoDevices() 
	{
		linphone_core_reload_video_devices(cPtr)
	}

	/// Removes an account. 
	/// `Core` will then automatically unregister and place the account on a deleted
	/// list. For that reason, a removed account does NOT need to be freed. 
	/// - Parameter account: the `Account` to remove   
	public func removeAccount(account:Account) 
	{
		linphone_core_remove_account(cPtr, account.cPtr)
	}

	/// Removes an authentication information object. 
	/// - Parameter info: The `AuthInfo` to remove.   
	public func removeAuthInfo(info:AuthInfo) 
	{
		linphone_core_remove_auth_info(cPtr, info.cPtr)
	}

	/// Remove a specific call log from call history list. 
	/// This function destroys the call log object. It must not be accessed anymore by
	/// the application after calling this function. 
	/// - Parameter callLog: `CallLog` object to remove.   
	public func removeCallLog(callLog:CallLog) 
	{
		linphone_core_remove_call_log(cPtr, callLog.cPtr)
	}

	/// Remove support for the specified content type. 
	/// It is the application responsibility to handle it correctly afterwards. 
	/// - Parameter contentType: The content type to remove support for   
	public func removeContentTypeSupport(contentType:String) 
	{
		linphone_core_remove_content_type_support(cPtr, contentType)
	}

	/// Removes a friend list. 
	/// - Parameter list: `FriendList` object   
	public func removeFriendList(list:FriendList) 
	{
		linphone_core_remove_friend_list(cPtr, list.cPtr)
	}

	/// Remove a call from the conference. 
	/// - Parameter call: a call that has been previously merged into the conference.  
	/// After removing the remote participant belonging to the supplied call, the call
	/// becomes a normal call in paused state. If one single remote participant is left
	/// alone together with the local user in the conference after the removal, then
	/// the conference is automatically transformed into a simple call in
	/// StreamsRunning state. The conference's resources are then automatically
	/// destroyed.
	/// In other words, unless leaveConference() is explicitly called, the last remote
	/// participant of a conference is automatically put in a simple call in running
	/// state.
	/// - Returns: 0 if successful, -1 otherwise. 
	public func removeFromConference(call:Call) throws 
	{
		let exception_result = linphone_core_remove_from_conference(cPtr, call.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "removeFromConference returned value \(exception_result)")
		}
	}

	/// Remove a LDAP from the configuration. 
	/// - Parameter ldap: The LDAP to remove.   
	public func removeLdap(ldap:Ldap) 
	{
		linphone_core_remove_ldap(cPtr, ldap.cPtr)
	}

	/// Remove the given linphone specs from the list of functionalities the linphone
	/// client supports. 
	/// - Parameter spec: The spec to remove   
	public func removeLinphoneSpec(spec:String) 
	{
		linphone_core_remove_linphone_spec(cPtr, spec)
	}

	/// Removes a proxy configuration. 
	/// `Core` will then automatically unregister and place the proxy configuration on
	/// a deleted list. For that reason, a removed proxy does NOT need to be freed. 
	/// - Parameter config: the `ProxyConfig` to remove   
	public func removeProxyConfig(config:ProxyConfig) 
	{
		linphone_core_remove_proxy_config(cPtr, config.cPtr)
	}

	/// Remove a supported tag. 
	/// - Parameter tag: The tag to remove  
	/// - See also: addSupportedTag() 
	public func removeSupportedTag(tag:String) 
	{
		linphone_core_remove_supported_tag(cPtr, tag)
	}

	/// Reset the counter of missed calls. 
	public func resetMissedCallsCount() 
	{
		linphone_core_reset_missed_calls_count(cPtr)
	}

	/// Find a chat room. 
	/// - Parameter params: The chat room parameters to match `ChatRoomParams` or nil   
	/// - Parameter localAddr: `Address` representing the local proxy configuration or
	/// nil   
	/// - Parameter remoteAddr: `Address` to search for or nil   
	/// - Parameter participants: The participants that must be present in the chat
	/// room to find.    
	/// - Returns: A matching chat room or nil if none matches.   
	public func searchChatRoom(params:ChatRoomParams?, localAddr:Address?, remoteAddr:Address?, participants:[Address]?) -> ChatRoom?
	{
		let cPointer = linphone_core_search_chat_room(cPtr, params?.cPtr, localAddr?.cPtr, remoteAddr?.cPtr, ObjectArrayToBctbxList(list: participants))
		if (cPointer == nil) {
			return nil
		}
		let result = ChatRoom.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Find a conference. 
	/// - Parameter params: The conference parameters to match `ConferenceParams` or
	/// nil   
	/// - Parameter localAddr: `Address` representing the local proxy configuration or
	/// nil   
	/// - Parameter remoteAddr: `Address` to search for or nil   
	/// - Parameter participants: The participants that must be present in the chat
	/// room to find    
	/// - Returns: A pointer on `Conference` satisfying the non-nil function arguments
	/// or nil if none matches   
	public func searchConference(params:ConferenceParams?, localAddr:Address?, remoteAddr:Address?, participants:[Address]?) -> Conference?
	{
		let cPointer = linphone_core_search_conference(cPtr, params?.cPtr, localAddr?.cPtr, remoteAddr?.cPtr, ObjectArrayToBctbxList(list: participants))
		if (cPointer == nil) {
			return nil
		}
		let result = Conference.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Send the conference invitations to all participants as an ICS file. 
	/// - Parameter conferenceInformation: The `ConferenceInfo`   
	/// - Parameter text: An optional text to be added to the sent chat message   
	public func sendConferenceInformation(conferenceInformation:ConferenceInfo, text:String?) 
	{
		linphone_core_send_conference_information(cPtr, conferenceInformation.cPtr, text)
	}

	/// Sets the UDP port range from which to randomly select the port used for audio
	/// streaming. 
	/// - Parameter minPort: The lower bound of the audio port range to use 
	/// - Parameter maxPort: The upper bound of the audio port range to use 
	public func setAudioPortRange(minPort:Int, maxPort:Int) 
	{
		linphone_core_set_audio_port_range(cPtr, CInt(minPort), CInt(maxPort))
	}

	/// Assign an audio file to be played locally upon call failure, for a given
	/// reason. 
	/// - Parameter reason: the `Reason` representing the failure error code. 
	/// - Parameter audiofile: a wav file to be played when such call failure happensd
	/// or nil to disable it.   
	public func setCallErrorTone(reason:Reason, audiofile:String?) 
	{
		linphone_core_set_call_error_tone(cPtr, LinphoneReason(rawValue: CUnsignedInt(reason.rawValue)), audiofile)
	}

	/// Set the rectangle where the decoder will search a QRCode. 
	/// - Parameter x: axis 
	/// - Parameter y: axis 
	/// - Parameter w: width 
	/// - Parameter h: height 
	public func setQrcodeDecodeRect(x:Int, y:Int, w:Int, h:Int) 
	{
		linphone_core_set_qrcode_decode_rect(cPtr, CInt(x), CInt(y), CInt(w), CInt(h))
	}

	/// Sets the UDP port range from which to randomly select the port used for text
	/// streaming. 
	/// - Parameter minPort: The lower bound of the text port range to use 
	/// - Parameter maxPort: The upper bound of the text port range to use 
	public func setTextPortRange(minPort:Int, maxPort:Int) 
	{
		linphone_core_set_text_port_range(cPtr, CInt(minPort), CInt(maxPort))
	}

	/// Assign an audio file to be played as a specific tone id. 
	/// This function typically allows to customize telephony tones per country. 
	/// - Parameter toneId: the #LinphoneToneId 
	/// - Parameter audiofile: a wav file to be played or nil to disable it.   
	public func setTone(toneId:ToneID, audiofile:String?) 
	{
		linphone_core_set_tone(cPtr, LinphoneToneID(rawValue: CUnsignedInt(toneId.rawValue)), audiofile)
	}

	/// Set the user agent string used in SIP messages. 
	/// Set the user agent string used in SIP messages as "[ua_name]/[version]". No
	/// slash character will be printed if nil is given to "version". If nil is given
	/// to "ua_name" and "version" both, the User-agent header will be empty.
	/// This function should be called just after linphone_factory_create_core ideally. 
	/// - Parameter name: Name of the user agent.   
	/// - Parameter version: Version of the user agent.   
	public func setUserAgent(name:String?, version:String?) 
	{
		linphone_core_set_user_agent(cPtr, name, version)
	}

	/// Sets the UDP port range from which to randomly select the port used for video
	/// streaming. 
	/// - Parameter minPort: The lower bound of the video port range to use 
	/// - Parameter maxPort: The upper bound of the video port range to use 
	public func setVideoPortRange(minPort:Int, maxPort:Int) 
	{
		linphone_core_set_video_port_range(cPtr, CInt(minPort), CInt(maxPort))
	}

	/// Tells whether a specified sound device can capture sound. 
	/// - Parameter device: the device name as returned by
	/// linphone_core_get_sound_devices   
	/// - Returns: A boolean value telling whether the specified sound device can
	/// capture sound 
	/// - deprecated: 08/07/2020 use `AudioDevice` API instead()
	@available(*, deprecated)
	public func soundDeviceCanCapture(device:String) -> Bool
	{
		return linphone_core_sound_device_can_capture(cPtr, device) != 0
	}

	/// Tells whether a specified sound device can play sound. 
	/// - Parameter device: the device name as returned by
	/// linphone_core_get_sound_devices   
	/// - Returns: A boolean value telling whether the specified sound device can play
	/// sound 
	/// - deprecated: 08/07/2020 use `AudioDevice` API instead()
	@available(*, deprecated)
	public func soundDeviceCanPlayback(device:String) -> Bool
	{
		return linphone_core_sound_device_can_playback(cPtr, device) != 0
	}

	/// Check if a call will need the sound resources in near future (typically an
	/// outgoing call that is awaiting response). 
	/// In liblinphone, it is not possible to have two independant calls using sound
	/// device or camera at the same time. In order to prevent this situation, an
	/// application can use soundResourcesLocked() to know whether it is possible at a
	/// given time to start a new outgoing call. When the function returns true, an
	/// application should not allow the user to start an outgoing call. 
	/// - Returns: A boolean value telling whether a call will need the sound resources
	/// in near future 
	public func soundResourcesLocked() -> Bool
	{
		return linphone_core_sound_resources_locked(cPtr) != 0
	}

	/// Start a `Core` object after it has been instantiated and not automatically
	/// started. 
	/// Also re-initialize a `Core` object that has been stopped using stop(). Must be
	/// called only if `GlobalState` is either Ready of Off. State will changed to
	/// Startup, Configuring and then On.
	/// - Returns: 0: success, -1: global failure, -2: could not connect database 
	public func start() throws 
	{
		let exception_result = linphone_core_start(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "start returned value \(exception_result)")
		}
	}

	/// Start recording the running conference. 
	/// - Parameter path: Path to the file where the recording will be written   
	/// - Returns: 0 if succeeded. Negative number if failed 
	/// - deprecated: 14/09/2021 Use Conference.startRecording() instead. 
	@available(*, deprecated)
	public func startConferenceRecording(path:String) throws 
	{
		let exception_result = linphone_core_start_conference_recording(cPtr, path)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "startConferenceRecording returned value \(exception_result)")
		}
	}

	/// Starts an echo calibration of the sound devices, in order to find adequate
	/// settings for the echo canceler automatically. 
	/// - Returns: LinphoneStatus whether calibration has started or not. 
	public func startEchoCancellerCalibration() throws 
	{
		let exception_result = linphone_core_start_echo_canceller_calibration(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "startEchoCancellerCalibration returned value \(exception_result)")
		}
	}

	/// Start the simulation of call to test the latency with an external device. 
	/// - Parameter rate: Sound sample rate. 
	/// - Returns: -1 in case of failure, 1 otherwise. 
	public func startEchoTester(rate:UInt) throws 
	{
		let exception_result = linphone_core_start_echo_tester(cPtr, CUnsignedInt(rate))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "startEchoTester returned value \(exception_result)")
		}
	}

	/// Stop a `Core` object after it has been instantiated and started. 
	/// If stopped, it can be started again using start(). Must be called only if
	/// `GlobalState` is either On. State will changed to Shutdown and then Off.
	public func stop() 
	{
		linphone_core_stop(cPtr)
	}

	/// Stop asynchronously a `Core` object after it has been instantiated and started. 
	/// State changes to Shutdown then iterate() must be called to allow the Core to
	/// end asynchronous tasks (terminate call, etc.). When all tasks are finished,
	/// State will change to Off. Must be called only if `GlobalState` is On. When
	/// `GlobalState` is Off `Core` can be started again using start().
	public func stopAsync() 
	{
		linphone_core_stop_async(cPtr)
	}

	/// Stop recording the running conference. 
	/// - Returns: 0 if succeeded. Negative number if failed 
	/// - deprecated: 14/09/2021 Use Conference.stopRecording() instead. 
	@available(*, deprecated)
	public func stopConferenceRecording() throws 
	{
		let exception_result = linphone_core_stop_conference_recording(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "stopConferenceRecording returned value \(exception_result)")
		}
	}

	/// Stops playing a dtmf started by playDtmf(). 
	public func stopDtmf() 
	{
		linphone_core_stop_dtmf(cPtr)
	}

	/// Stop the simulation of call. 
	public func stopEchoTester() throws 
	{
		let exception_result = linphone_core_stop_echo_tester(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "stopEchoTester returned value \(exception_result)")
		}
	}

	/// Whenever the liblinphone is playing a ring to advertise an incoming call or
	/// ringback of an outgoing call, this function stops the ringing. 
	/// Typical use is to stop ringing when the user requests to ignore the call. 
	public func stopRinging() 
	{
		linphone_core_stop_ringing(cPtr)
	}

	/// Create an outgoing subscription, specifying the destination resource, the event
	/// name, and an optional content body. 
	/// If accepted, the subscription runs for a finite period, but is automatically
	/// renewed if not terminated before. 
	/// - Parameter resource: the destination resource   
	/// - Parameter event: the event name   
	/// - Parameter expires: the whished duration of the subscription 
	/// - Parameter body: an optional body, may be nil.   
	/// - Returns: a `Event` holding the context of the created subcription.   
	public func subscribe(resource:Address, event:String, expires:Int, body:Content?) -> Event?
	{
		let cPointer = linphone_core_subscribe(cPtr, resource.cPtr, event, CInt(expires), body?.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Event.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Take a photo of currently from capture device and write it into a jpeg file. 
	/// Note that the snapshot is asynchronous, an application shall not assume that
	/// the file is created when the function returns.
	/// - Parameter file: a path where to write the jpeg content.   
	/// - Returns: 0 if successfull, -1 otherwise (typically if jpeg format is not
	/// supported). 
	public func takePreviewSnapshot(file:String) throws 
	{
		let exception_result = linphone_core_take_preview_snapshot(cPtr, file)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "takePreviewSnapshot returned value \(exception_result)")
		}
	}

	/// Terminates all the calls. 
	/// - Returns: 0 
	public func terminateAllCalls() throws 
	{
		let exception_result = linphone_core_terminate_all_calls(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "terminateAllCalls returned value \(exception_result)")
		}
	}

	/// Terminate the running conference. 
	/// If it is a local conference, all calls inside it will become back separate
	/// calls and will be put in #LinphoneCallPaused state. If it is a conference
	/// involving a focus server, all calls inside the conference will be terminated. 
	/// - Returns: 0 if succeeded. Negative number if failed 
	public func terminateConference() throws 
	{
		let exception_result = linphone_core_terminate_conference(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "terminateConference returned value \(exception_result)")
		}
	}

	/// Upload the log collection to the configured server url. 
	public func uploadLogCollection() 
	{
		linphone_core_upload_log_collection(cPtr)
	}

	/// Tells the core to use a separate window for local camera preview video, instead
	/// of inserting local view within the remote video window. 
	/// - Parameter yesno: true to use a separate window, false to insert the preview
	/// in the remote video window. 
	public func usePreviewWindow(yesno:Bool) 
	{
		linphone_core_use_preview_window(cPtr, yesno==true ? 1:0)
	}

	/// Specify whether the tls server certificate must be verified when connecting to
	/// a SIP/TLS server. 
	/// - Parameter yesno: A boolean value telling whether the tls server certificate
	/// must be verified 
	public func verifyServerCertificates(yesno:Bool) 
	{
		linphone_core_verify_server_certificates(cPtr, yesno==true ? 1:0)
	}

	/// Specify whether the tls server certificate common name must be verified when
	/// connecting to a SIP/TLS server. 
	/// - Parameter yesno: A boolean value telling whether the tls server certificate
	/// common name must be verified 
	public func verifyServerCn(yesno:Bool) 
	{
		linphone_core_verify_server_cn(cPtr, yesno==true ? 1:0)
	}

	/// Test if video is supported. 
	/// - Returns: true if the library was built with video support, false otherwise 
	public func videoSupported() -> Bool
	{
		return linphone_core_video_supported(cPtr) != 0
	}
}

/// Represents a dial plan. 
public class DialPlan : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> DialPlan {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<DialPlan>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = DialPlan(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Find best match for given CCC. 
	/// - Parameter ccc: The country calling code   
	/// - Returns: the matching dial plan, or a generic one if none found   
	static public func byCcc(ccc:String) -> DialPlan?
	{
		let cPointer = linphone_dial_plan_by_ccc(ccc)
		if (cPointer == nil) {
			return nil
		}
		let result = DialPlan.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Find best match for given CCC. 
	/// - Parameter ccc: the country calling code   
	/// - Returns: the matching dial plan, or a generic one if none found   
	static public func byCccAsInt(ccc:Int) -> DialPlan?
	{
		let cPointer = linphone_dial_plan_by_ccc_as_int(CInt(ccc))
		if (cPointer == nil) {
			return nil
		}
		let result = DialPlan.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Returns a list of all known dial plans. 
	/// - Returns: The list of all known dial plans.      
	static public var getAllList: [DialPlan]
	{
			var swiftList = [DialPlan]()
			let cList = linphone_dial_plan_get_all_list()
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(DialPlan.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Function to get call country code from an e164 number, ex: +33952650121 will
	/// return 33. 
	/// - Parameter e164: phone number   
	/// - Returns: call country code or -1 if not found 
	static public func lookupCccFromE164(e164:String) -> Int
	{
		return Int(linphone_dial_plan_lookup_ccc_from_e164(e164))
	}

	/// Function to get call country code from ISO 3166-1 alpha-2 code, ex: FR returns
	/// 33. 
	/// - Parameter iso: country code alpha2   
	/// - Returns: call country code or -1 if not found 
	static public func lookupCccFromIso(iso:String) -> Int
	{
		return Int(linphone_dial_plan_lookup_ccc_from_iso(iso))
	}

	/// Returns the country name of the dialplan. 
	/// - Returns: the country name 
	public var country: String
	{
			let cPointer = linphone_dial_plan_get_country(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns the country calling code of the dialplan. 
	/// - Returns: the country calling code   
	public var countryCallingCode: String
	{
			let cPointer = linphone_dial_plan_get_country_calling_code(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns the international call prefix of the dialplan. 
	/// - Returns: the international call prefix   
	public var internationalCallPrefix: String
	{
			let cPointer = linphone_dial_plan_get_international_call_prefix(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Return if given plan is generic. 
	/// - Returns: true if generic, false otherwise 
	public var isGeneric: Bool
	{
			return linphone_dial_plan_is_generic(cPtr) != 0
	}

	/// Returns the iso country code of the dialplan. 
	/// - Returns: the iso country code   
	public var isoCountryCode: String
	{
			let cPointer = linphone_dial_plan_get_iso_country_code(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns the national number length of the dialplan. 
	/// - Returns: the national number length 
	public var nationalNumberLength: Int
	{
			return Int(linphone_dial_plan_get_national_number_length(cPtr))
	}
}

/// The LinphoneDigestAuthenticationPolicy holds parameters relative to digest
/// authentication procedures. 
public class DigestAuthenticationPolicy : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> DigestAuthenticationPolicy {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<DigestAuthenticationPolicy>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = DigestAuthenticationPolicy(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get whether MD5 hash algorithm is allowed. 
	/// The default value is true, in order to maximize interoperability. MD5 is
	/// considered as a weak algorithm, some might want to disable it, in which case
	/// SHA-256 will be required to perform digest authentication. 
	/// - Returns: a boolean value 
	public var allowMd5: Bool
	{
		get
		{
			return linphone_digest_authentication_policy_get_allow_md5(cPtr) != 0
		}
		set
		{
			linphone_digest_authentication_policy_set_allow_md5(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get whether digest authentication without 'qop=auth' mode is allowed. 
	/// The default value is true, in order to maximize interoperability. 'qop=auth'
	/// mode enforces security thanks to the use of a client nonce, which makes
	/// password brute forcing more difficult. When set to false, linphone will refuse
	/// to authenticate to servers that are not implementing the qop=auth mode. 
	/// - Returns: a boolean value 
	public var allowNoQop: Bool
	{
		get
		{
			return linphone_digest_authentication_policy_get_allow_no_qop(cPtr) != 0
		}
		set
		{
			linphone_digest_authentication_policy_set_allow_no_qop(cPtr, newValue==true ? 1:0)
		}
	}

	/// Retrieve the user pointer associated with the `DigestAuthenticationPolicy`
	/// object. 
	/// - Returns: The user pointer.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_digest_authentication_policy_get_user_data(cPtr)
		}
		set
		{
			linphone_digest_authentication_policy_set_user_data(cPtr, newValue)
		}
	}
}

/// Object representing full details about a signaling error or status. 
/// All `ErrorInfo` object returned by the liblinphone API are readonly and
/// transcients. For safety they must be used immediately after obtaining them. Any
/// other function call to the liblinphone may change their content or invalidate
/// the pointer. 
public class ErrorInfo : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> ErrorInfo {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ErrorInfo>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ErrorInfo(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get textual phrase from the error info. 
	/// This is the text that is provided by the peer in the protocol (SIP). 
	/// - Returns: The error phrase   
	public var phrase: String
	{
		get
		{
			let cPointer = linphone_error_info_get_phrase(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_error_info_set_phrase(cPtr, newValue)
		}
	}

	/// Get protocol from the error info. 
	/// - Returns: The protocol.   
	public var proto: String
	{
		get
		{
			let cPointer = linphone_error_info_get_protocol(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_error_info_set_protocol(cPtr, newValue)
		}
	}

	/// Get the status code from the low level protocol (ex a SIP status code). 
	/// - Returns: The status code 
	public var protocolCode: Int
	{
		get
		{
			return Int(linphone_error_info_get_protocol_code(cPtr))
		}
		set
		{
			linphone_error_info_set_protocol_code(cPtr, CInt(newValue))
		}
	}

	/// Get reason code from the error info. 
	/// - Returns: A `Reason` object 
	public var reason: Reason
	{
		get
		{
			return Reason(rawValue: Int(linphone_error_info_get_reason(cPtr).rawValue))!
		}
		set
		{
			linphone_error_info_set_reason(cPtr, LinphoneReason(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get Retry-After delay second from the error info. 
	/// - Returns: The Retry-After delay second 
	public var retryAfter: Int
	{
		get
		{
			return Int(linphone_error_info_get_retry_after(cPtr))
		}
		set
		{
			linphone_error_info_set_retry_after(cPtr, CInt(newValue))
		}
	}

	/// Get pointer to chained `ErrorInfo` set in sub_ei. 
	/// It corresponds to a Reason header in a received SIP response. 
	/// - Returns: `ErrorInfo` pointer defined in the ei object.   
	public var subErrorInfo: ErrorInfo?
	{
		get
		{
			let cPointer = linphone_error_info_get_sub_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ErrorInfo.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_error_info_set_sub_error_info(cPtr, newValue?.cPtr)
		}
	}

	/// Provides additional information regarding the failure. 
	/// With SIP protocol, the content of "Warning" headers are returned. 
	/// - Returns: More details about the failure.   
	public var warnings: String
	{
		get
		{
			let cPointer = linphone_error_info_get_warnings(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_error_info_set_warnings(cPtr, newValue)
		}
	}

	/// Assign information to a `ErrorInfo` object. 
	/// - Parameter proto: protocol name   
	/// - Parameter reason: reason from `Reason` enum 
	/// - Parameter code: protocol code 
	/// - Parameter status: description of the reason   
	/// - Parameter warning: warning message   
	public func set(proto:String?, reason:Reason, code:Int, status:String?, warning:String?) 
	{
		linphone_error_info_set(cPtr, proto, LinphoneReason(rawValue: CUnsignedInt(reason.rawValue)), CInt(code), status, warning)
	}
}

/// Object representing an event state, which is subcribed or published. 
/// - See also: Core.publish() 
/// - See also: Core.subscribe() 
public class Event : LinphoneObject
{
	var delegateManagers : [EventDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> Event {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Event>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Event(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Object representing an event state, which is subcribed or published. 
	/// - See also: Core.publish() 
	/// - See also: Core.subscribe() 
	public func addDelegate(delegate: EventDelegate)
	{
		let manager = EventDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_event_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// Object representing an event state, which is subcribed or published. 
	/// - See also: Core.publish() 
	/// - See also: Core.subscribe() 
	public func removeDelegate(delegate: EventDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_event_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Returns back pointer to the `Core` that created this `Event`. 
	/// - Returns: the `Core` object associated.   
	public var core: Core?
	{
			let cPointer = linphone_event_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Core.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the current LinphoneEventCbs object associated with a LinphoneEvent. 
	/// - Returns: The current LinphoneEventCbs object associated with the
	/// LinphoneEvent.   
	public var currentDelegate: EventDelegate?
	{
			let cObject = linphone_event_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<EventDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Get full details about an error occured. 
	/// - Returns: a `ErrorInfo` object.   
	public var errorInfo: ErrorInfo?
	{
			let cPointer = linphone_event_get_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ErrorInfo.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the "from" address of the subscription. 
	/// - Returns: the from `Address`.   
	public var from: Address?
	{
			let cPointer = linphone_event_get_from(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the name of the event as specified in the event package RFC. 
	/// - Returns: the event name.   
	public var name: String
	{
			let cPointer = linphone_event_get_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get publish state. 
	/// If the event object was not created by a publish mechanism, `None` is returned. 
	/// - Returns: the current `PublishState` 
	public var publishState: PublishState
	{
			return PublishState(rawValue: Int(linphone_event_get_publish_state(cPtr).rawValue))!
	}

	/// Return reason code (in case of error state reached). 
	/// - Returns: a `Reason` enum 
	public var reason: Reason
	{
			return Reason(rawValue: Int(linphone_event_get_reason(cPtr).rawValue))!
	}

	/// Get the "contact" address of the subscription. 
	/// - Returns: The "contact" address of the subscription   
	public var remoteContact: Address?
	{
			let cPointer = linphone_event_get_remote_contact(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the resource address of the subscription or publish. 
	/// - Returns: the resource `Address`.   
	public var resource: Address?
	{
			let cPointer = linphone_event_get_resource(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get subscription direction. 
	/// If the object wasn't created by a subscription mechanism, `InvalidDir` is
	/// returned. 
	/// - Returns: the `SubscriptionDir` 
	public var subscriptionDir: SubscriptionDir
	{
			return SubscriptionDir(rawValue: Int(linphone_event_get_subscription_dir(cPtr).rawValue))!
	}

	/// Get subscription state. 
	/// If the event object was not created by a subscription mechanism, `None` is
	/// returned. 
	/// - Returns: the current `SubscriptionState` 
	public var subscriptionState: SubscriptionState
	{
			return SubscriptionState(rawValue: Int(linphone_event_get_subscription_state(cPtr).rawValue))!
	}

	/// Get the "to" address of the subscription. 
	/// - Returns: the "to" `Address`.   
	public var to: Address?
	{
			let cPointer = linphone_event_get_to(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Retrieve user pointer. 
	/// - Returns: the user_data pointer or nil.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_event_get_user_data(cPtr)
		}
		set
		{
			linphone_event_set_user_data(cPtr, newValue)
		}
	}

	/// Accept an incoming subcription. 
	/// - Returns: 0 if successful, error code otherwise 
	public func acceptSubscription() throws 
	{
		let exception_result = linphone_event_accept_subscription(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "acceptSubscription returned value \(exception_result)")
		}
	}

	/// Add a custom header to an outgoing susbscription or publish. 
	/// - Parameter name: header's name   
	/// - Parameter value: the header's value.   
	public func addCustomHeader(name:String, value:String?) 
	{
		linphone_event_add_custom_header(cPtr, name, value)
	}

	/// Deny an incoming subscription with given reason. 
	/// - Returns: 0 if successful, error code otherwise 
	public func denySubscription(reason:Reason) throws 
	{
		let exception_result = linphone_event_deny_subscription(cPtr, LinphoneReason(rawValue: CUnsignedInt(reason.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "denySubscription returned value \(exception_result)")
		}
	}

	/// Obtain the value of a given header for an incoming subscription. 
	/// - Parameter name: header's name   
	/// - Returns: the header's value or nil if such header doesn't exist.   
	public func getCustomHeader(name:String) -> String
	{
		let cstr = linphone_event_get_custom_header(cPtr, name)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Send a notification. 
	/// - Parameter body: an optional body containing the actual notification data.   
	/// - Returns: 0 if successful, -1 otherwise. 
	public func notify(body:Content?) throws 
	{
		let exception_result = linphone_event_notify(cPtr, body?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "notify returned value \(exception_result)")
		}
	}

	/// Prevent an event from refreshing its publish. 
	/// This is useful to let registrations to expire naturally (or) when the
	/// application wants to keep control on when refreshes are sent. The refreshing
	/// operations can be resumed with ProxyConfig.refreshRegister(). 
	public func pausePublish() 
	{
		linphone_event_pause_publish(cPtr)
	}

	/// Refresh an outgoing publish keeping the same body. 
	/// - Returns: 0 if successful, -1 otherwise. 
	public func refreshPublish() throws 
	{
		let exception_result = linphone_event_refresh_publish(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "refreshPublish returned value \(exception_result)")
		}
	}

	/// Refresh an outgoing subscription keeping the same body. 
	/// - Returns: 0 if successful, -1 otherwise. 
	public func refreshSubscribe() throws 
	{
		let exception_result = linphone_event_refresh_subscribe(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "refreshSubscribe returned value \(exception_result)")
		}
	}

	/// Remove custom header to an outgoing susbscription or publish. 
	/// - Parameter name: header's name   
	public func removeCustomHeader(name:String) 
	{
		linphone_event_remove_custom_header(cPtr, name)
	}

	/// Send a publish created by Core.createPublish(). 
	/// - Parameter body: the new data to be published   
	/// - Returns: 0 if successful, -1 otherwise. 
	public func sendPublish(body:Content) throws 
	{
		let exception_result = linphone_event_send_publish(cPtr, body.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "sendPublish returned value \(exception_result)")
		}
	}

	/// Send a subscription previously created by Core.createSubscribe(). 
	/// - Parameter body: optional content to attach with the subscription.   
	/// - Returns: 0 if successful, -1 otherwise. 
	public func sendSubscribe(body:Content?) throws 
	{
		let exception_result = linphone_event_send_subscribe(cPtr, body?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "sendSubscribe returned value \(exception_result)")
		}
	}

	/// Terminate an incoming or outgoing subscription that was previously acccepted,
	/// or a previous publication. 
	/// The `Event` shall not be used anymore after this operation. 
	public func terminate() 
	{
		linphone_event_terminate(cPtr)
	}

	/// Update (refresh) a publish. 
	/// - Parameter body: the new data to be published   
	/// - Returns: 0 if successful, error code otherwise 
	public func updatePublish(body:Content) throws 
	{
		let exception_result = linphone_event_update_publish(cPtr, body.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "updatePublish returned value \(exception_result)")
		}
	}

	/// Update (refresh) an outgoing subscription, changing the body. 
	/// - Parameter body: an optional body to include in the subscription update, may
	/// be nil.   
	/// - Returns: 0 if successful, error code otherwise    
	public func updateSubscribe(body:Content?) throws 
	{
		let exception_result = linphone_event_update_subscribe(cPtr, body?.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "updateSubscribe returned value \(exception_result)")
		}
	}
}

/// Object that represents an event that must be stored in database. 
/// For example, all chat related events are wrapped in an `EventLog`, and many
/// callbacks use this kind of type as parameter.
/// Use getType() to get the `EventLogType` it refers to, and then you can use one
/// of the accessor methods to get the underlying object, for example
/// getChatMessage() for a `ChatMessage`. 
public class EventLog : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> EventLog {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<EventLog>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = EventLog(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Returns the call of a conference call event. 
	/// - Returns: The conference `Call`.   
	public var call: Call?
	{
			let cPointer = linphone_event_log_get_call(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Call.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the chat message of a conference chat message event. 
	/// - Returns: The conference `ChatMessage`.   
	public var chatMessage: ChatMessage?
	{
			let cPointer = linphone_event_log_get_chat_message(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ChatMessage.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the creation time of a event log. 
	/// - Returns: The event creation time 
	public var creationTime: time_t
	{
			return linphone_event_log_get_creation_time(cPtr)
	}

	/// Returns the device address of a conference participant device event. 
	/// - Returns: The conference device `Address`.   
	public var deviceAddress: Address?
	{
			let cPointer = linphone_event_log_get_device_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the ephemeral message lifetime of a conference ephemeral message event. 
	/// Ephemeral lifetime means the time before an ephemeral message which has been
	/// viewed gets deleted. 
	/// - Returns: The ephemeral message lifetime. 
	public var ephemeralMessageLifetime: Int
	{
			return Int(linphone_event_log_get_ephemeral_message_lifetime(cPtr))
	}

	/// Returns the local address of a conference event. 
	/// - Returns: The local `Address`.   
	public var localAddress: Address?
	{
			let cPointer = linphone_event_log_get_local_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the notify id of a conference notified event. 
	/// - Returns: The conference notify id. 
	public var notifyId: UInt
	{
			return UInt(linphone_event_log_get_notify_id(cPtr))
	}

	/// Returns the participant address of a conference participant event. 
	/// - Returns: The conference participant `Address`.   
	public var participantAddress: Address?
	{
			let cPointer = linphone_event_log_get_participant_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the peer address of a conference event. 
	/// - Returns: The peer `Address`.   
	public var peerAddress: Address?
	{
			let cPointer = linphone_event_log_get_peer_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the faulty device address of a conference security event. 
	/// - Returns: The `Address` of the faulty device.     
	public var securityEventFaultyDeviceAddress: Address?
	{
			let cPointer = linphone_event_log_get_security_event_faulty_device_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
			return result
	}

	/// Returns the type of security event. 
	/// - Returns: The `SecurityEventType` type. 
	public var securityEventType: SecurityEventType
	{
			return SecurityEventType(rawValue: Int(linphone_event_log_get_security_event_type(cPtr).rawValue))!
	}

	/// Returns the subject of a conference subject event. 
	/// - Returns: The conference subject.   
	public var subject: String
	{
			let cPointer = linphone_event_log_get_subject(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Returns the type of a event log. 
	/// - Returns: The `EventLogType` type 
	public var type: EventLogType
	{
			return EventLogType(rawValue: Int(linphone_event_log_get_type(cPtr).rawValue))!
	}

	/// Delete event log from database. 
	public func deleteFromDatabase() 
	{
		linphone_event_log_delete_from_database(cPtr)
	}
}

/// The factory is a singleton object devoted to the creation of all the objects of
/// Liblinphone that cannot be created by `Core` itself. 
/// It is also used to configure a few behaviors before creating the `Core`, like
/// the logs verbosity or collection. 
public class Factory : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Factory {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Factory>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Factory(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Clean the factory. 
	/// This function is generally useless as the factory is unique per process,
	/// however calling this function at the end avoid getting reports from belle-sip
	/// leak detector about memory leaked in get(). 
	static public func clean() 
	{
		linphone_factory_clean()
	}

	/// Create the `Factory` if that has not been done and return a pointer on it. 
	/// - Returns: A pointer on the `Factory`   
	static public var Instance: Factory
	{
			let cPointer = linphone_factory_get()
			let result = Factory.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Set the directory where the configurations are located. 
	/// If the path is empty (default value), the path will be computed when calling
	/// getConfigDir() 
	/// - Parameter path: The path to the directory where the configurations are
	/// located   
	public var configDir: String = ""
	{
		willSet
		{
			linphone_factory_set_config_dir(cPtr, newValue)
		}
	}

	/// Set the directory where the application local data are located. 
	/// If the path is empty (default value), the path will be computed when calling
	/// getDataDir() 
	/// - Parameter path: The path to the directory where the application local data
	/// are located   
	public var dataDir: String = ""
	{
		willSet
		{
			linphone_factory_set_data_dir(cPtr, newValue)
		}
	}

	/// Get the directory where the data resources are located. 
	/// - Returns: The path to the directory where the data resources are located   
	public var dataResourcesDir: String
	{
		get
		{
			let cPointer = linphone_factory_get_data_resources_dir(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_factory_set_data_resources_dir(cPtr, newValue)
		}
	}

	/// Returns a bctbx_list_t of all DialPlans. 
	/// - Returns: A list of `DialPlan`    
	public var dialPlans: [DialPlan]
	{
			var swiftList = [DialPlan]()
			let cList = linphone_factory_get_dial_plans(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(DialPlan.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Set the directory where downloads are located. 
	/// If the path is empty (default value), the path will be computed when calling
	/// getDownloadDir() 
	/// - Parameter path: The path to the directory where downloads are located   
	public var downloadDir: String = ""
	{
		willSet
		{
			linphone_factory_set_download_dir(cPtr, newValue)
		}
	}

	/// Get the directory where the image resources are located. 
	/// - Returns: The path to the directory where the image resources are located   
	public var imageResourcesDir: String
	{
		get
		{
			let cPointer = linphone_factory_get_image_resources_dir(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_factory_set_image_resources_dir(cPtr, newValue)
		}
	}

	/// Test if config dir has been set. 
	/// - Returns: true if config dir has been set. 
	public var isConfigDirSet: Bool
	{
			return linphone_factory_is_config_dir_set(cPtr) != 0
	}

	/// Test if data dir has been set. 
	/// - Returns: true if data dir has been set. 
	public var isDataDirSet: Bool
	{
			return linphone_factory_is_data_dir_set(cPtr) != 0
	}

	/// Indicates if the storage in database is available. 
	/// - Returns: true if the database storage is available, false otherwise 
	public var isDatabaseStorageAvailable: Bool
	{
			return linphone_factory_is_database_storage_available(cPtr) != 0
	}

	/// Test if download dir has been set. 
	/// - Returns: true if download dir has been set. 
	public var isDownloadDirSet: Bool
	{
			return linphone_factory_is_download_dir_set(cPtr) != 0
	}

	/// Indicates if IMDN are available. 
	/// - Returns: true if IDMN are available 
	public var isImdnAvailable: Bool
	{
			return linphone_factory_is_imdn_available(cPtr) != 0
	}

	/// Sets the log collection path. 
	/// - Parameter path: the path of the logs   
	public var logCollectionPath: String = ""
	{
		willSet
		{
			linphone_factory_set_log_collection_path(cPtr, newValue)
		}
	}

	/// Get the directory where the mediastreamer2 plugins are located. 
	/// - Returns: The path to the directory where the mediastreamer2 plugins are
	/// located, or nil if it has not been set.   
	public var mspluginsDir: String
	{
		get
		{
			let cPointer = linphone_factory_get_msplugins_dir(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_factory_set_msplugins_dir(cPtr, newValue)
		}
	}

	/// Get the recommended list of standard video definitions. 
	/// This list is suitable for a widest set of hardware for all video codec
	/// implementations, and thus excludes some very high definition formats that are
	/// unlikely to work unless specific hardware or codecs are used. 
	/// - Returns: A list of video definitions.    
	public var recommendedVideoDefinitions: [VideoDefinition]
	{
			var swiftList = [VideoDefinition]()
			let cList = linphone_factory_get_recommended_video_definitions(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(VideoDefinition.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Get the directory where the ring resources are located. 
	/// - Returns: The path to the directory where the ring resources are located   
	public var ringResourcesDir: String
	{
		get
		{
			let cPointer = linphone_factory_get_ring_resources_dir(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_factory_set_ring_resources_dir(cPtr, newValue)
		}
	}

	/// Get the directory where the sound resources are located. 
	/// - Returns: The path to the directory where the sound resources are located   
	public var soundResourcesDir: String
	{
		get
		{
			let cPointer = linphone_factory_get_sound_resources_dir(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_factory_set_sound_resources_dir(cPtr, newValue)
		}
	}

	/// Get the list of standard video definitions supported by Linphone. 
	/// - Returns: A list of video definitions.    
	public var supportedVideoDefinitions: [VideoDefinition]
	{
			var swiftList = [VideoDefinition]()
			let cList = linphone_factory_get_supported_video_definitions(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(VideoDefinition.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Get the top directory where the resources are located. 
	/// - Returns: The path to the top directory where the resources are located   
	public var topResourcesDir: String
	{
		get
		{
			let cPointer = linphone_factory_get_top_resources_dir(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_factory_set_top_resources_dir(cPtr, newValue)
		}
	}

	/// Gets the user data in the `Factory` object. 
	/// - Returns: the user data.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_factory_get_user_data(cPtr)
		}
		set
		{
			linphone_factory_set_user_data(cPtr, newValue)
		}
	}

	/// Parse a string holding a SIP URI and create the according `Address` object. 
	/// - Parameter addr: A string holding the SIP URI to parse.   
	/// - Returns: A new `Address`.   
	public func createAddress(addr:String) throws -> Address
	{
		let cPointer = linphone_factory_create_address(cPtr, addr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Address value")
		}
		let result = Address.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates a `AuthInfo` object. 
	/// The object can be created empty, that is with all arguments set to nil.
	/// Username, userid, password, realm and domain can be set later using specific
	/// methods. At the end, username and passwd (or ha1) are required. 
	/// - Parameter username: The username that needs to be authenticated   
	/// - Parameter userid: The userid used for authenticating (use nil if you don't
	/// know what it is)   
	/// - Parameter passwd: The password in clear text   
	/// - Parameter ha1: The ha1-encrypted password if password is not given in clear
	/// text.   
	/// - Parameter realm: The authentication domain (which can be larger than the sip
	/// domain. Unfortunately many SIP servers don't use this parameter.   
	/// - Parameter domain: The SIP domain for which this authentication information is
	/// valid, if it has to be restricted for a single SIP domain.   
	/// - Returns: A `AuthInfo` object. linphone_auth_info_destroy must be used to
	/// destroy it when no longer needed. The `Core` makes a copy of `AuthInfo` passed
	/// through Core.addAuthInfo().   
	public func createAuthInfo(username:String, userid:String?, passwd:String?, ha1:String?, realm:String?, domain:String?) throws -> AuthInfo
	{
		let cPointer = linphone_factory_create_auth_info(cPtr, username, userid, passwd, ha1, realm, domain)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null AuthInfo value")
		}
		let result = AuthInfo.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates a `AuthInfo` object. 
	/// The object can be created empty, that is with all arguments set to nil.
	/// Username, userid, password, realm and domain can be set later using specific
	/// methods. At the end, username and passwd (or ha1) are required. 
	/// - Parameter username: The username that needs to be authenticated   
	/// - Parameter userid: The userid used for authenticating (use nil if you don't
	/// know what it is)   
	/// - Parameter passwd: The password in clear text   
	/// - Parameter ha1: The ha1-encrypted password if password is not given in clear
	/// text.   
	/// - Parameter realm: The authentication domain (which can be larger than the sip
	/// domain. Unfortunately many SIP servers don't use this parameter.   
	/// - Parameter domain: The SIP domain for which this authentication information is
	/// valid, if it has to be restricted for a single SIP domain.   
	/// - Parameter algorithm: The algorithm for encrypting password.   
	/// - Returns: A `AuthInfo` object. linphone_auth_info_destroy must be used to
	/// destroy it when no longer needed. The `Core` makes a copy of `AuthInfo` passed
	/// through Core.addAuthInfo().   
	public func createAuthInfo(username:String, userid:String?, passwd:String?, ha1:String?, realm:String?, domain:String?, algorithm:String?) throws -> AuthInfo
	{
		let cPointer = linphone_factory_create_auth_info_2(cPtr, username, userid, passwd, ha1, realm, domain, algorithm)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null AuthInfo value")
		}
		let result = AuthInfo.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object `Buffer`. 
	/// - Returns: a `Buffer`   
	public func createBuffer() throws -> Buffer
	{
		let cPointer = linphone_factory_create_buffer(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Buffer value")
		}
		let result = Buffer.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object `Buffer`. 
	/// - Parameter data: the data to set in the buffer   
	/// - Parameter size: the size of the data 
	/// - Returns: a `Buffer`   
	public func createBufferFromData(data:UnsafePointer<UInt8>, size:Int) throws -> Buffer
	{
		let cPointer = linphone_factory_create_buffer_from_data(cPtr, data, size)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Buffer value")
		}
		let result = Buffer.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object `Buffer`. 
	/// - Parameter data: the data to set in the buffer   
	/// - Returns: a `Buffer`   
	public func createBufferFromString(data:String) throws -> Buffer
	{
		let cPointer = linphone_factory_create_buffer_from_string(cPtr, data)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Buffer value")
		}
		let result = Buffer.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object `ConferenceInfo`. 
	/// - Returns: a `ConferenceInfo`   
	public func createConferenceInfo() throws -> ConferenceInfo
	{
		let cPointer = linphone_factory_create_conference_info(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ConferenceInfo value")
		}
		let result = ConferenceInfo.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object `ConferenceInfo` from an Icalendar `Content`. 
	/// - Parameter content: the Icalendar `Content`   
	/// - Returns: a `ConferenceInfo` created from an Icalendar `Content`   
	public func createConferenceInfoFromIcalendarContent(content:Content) throws -> ConferenceInfo
	{
		let cPointer = linphone_factory_create_conference_info_from_icalendar_content(cPtr, content.cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ConferenceInfo value")
		}
		let result = ConferenceInfo.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object `Config`. 
	/// - Parameter path: the path of the config   
	/// - Returns: a `Config`   
	public func createConfig(path:String?) throws -> Config
	{
		let cPointer = linphone_factory_create_config(cPtr, path)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Config value")
		}
		let result = Config.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object `Config`. 
	/// - Parameter data: the config data   
	/// - Returns: a `Config`   
	public func createConfigFromString(data:String) throws -> Config
	{
		let cPointer = linphone_factory_create_config_from_string(cPtr, data)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Config value")
		}
		let result = Config.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object `Config`. 
	/// - Parameter path: the path of the config   
	/// - Parameter factoryPath: the path of the factory   
	/// - Returns: a `Config`   
	public func createConfigWithFactory(path:String?, factoryPath:String?) throws -> Config
	{
		let cPointer = linphone_factory_create_config_with_factory(cPtr, path, factoryPath)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Config value")
		}
		let result = Config.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object `Content`. 
	/// - Returns: a `Content`   
	public func createContent() throws -> Content
	{
		let cPointer = linphone_factory_create_content(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Content value")
		}
		let result = Content.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Instantiate a `Core` object. 
	/// The `Core` object is the primary handle for doing all phone actions. It should
	/// be unique within your application. The `Core` object is not started
	/// automatically, you need to call Core.start() to that effect. The returned
	/// `Core` will be in `GlobalState` Ready. Core ressources can be released using
	/// Core.stop() which is strongly encouraged on garbage collected languages. 
	/// - Parameter configPath: A path to a config file. If it does not exists it will
	/// be created. The config file is used to store all settings, proxies... so that
	/// all these settings become persistent over the life of the `Core` object. It is
	/// allowed to set a nil config file. In that case `Core` will not store any
	/// settings.   
	/// - Parameter factoryConfigPath: A path to a read-only config file that can be
	/// used to store hard-coded preferences such as proxy settings or internal
	/// preferences. The settings in this factory file always override the ones in the
	/// normal config file. It is optional, use nil if unneeded.   
	/// - Parameter systemContext: A pointer to a system object required by the core to
	/// operate. Currently it is required to pass an android Context on android, pass
	/// nil on other platforms.   
	/// - Returns: a `Core` object   
	/// - See also: linphone_core_new_with_config_3() 
	public func createCore(configPath:String?, factoryConfigPath:String?, systemContext:UnsafeMutableRawPointer?) throws -> Core
	{
		let cPointer = linphone_factory_create_core_3(cPtr, configPath, factoryConfigPath, systemContext)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Core value")
		}
		let result = Core.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Instantiate a `Core` object with a given LinphoneConfig. 
	/// The `Core` object is the primary handle for doing all phone actions. It should
	/// be unique within your application. The `Core` object is not started
	/// automatically, you need to call Core.start() to that effect. The returned
	/// `Core` will be in `GlobalState` Ready. Core ressources can be released using
	/// Core.stop() which is strongly encouraged on garbage collected languages. 
	/// - Parameter config: A `Config` object holding the configuration for the `Core`
	/// to be instantiated.   
	/// - Parameter systemContext: A pointer to a system object required by the core to
	/// operate. Currently it is required to pass an android Context on android, pass
	/// nil on other platforms.   
	/// - Returns: a `Core` object   
	/// - See also: createCore() 
	public func createCoreWithConfig(config:Config, systemContext:UnsafeMutableRawPointer?) throws -> Core
	{
		let cPointer = linphone_factory_create_core_with_config_3(cPtr, config.cPtr, systemContext)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Core value")
		}
		let result = Core.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `DigestAuthenticationPolicy` object. 
	/// The `DigestAuthenticationPolicy` object which is used to configure a policy for
	/// digest authentication, such as allowing MD5 or mode without qop=auth. 
	/// - Returns: a new `DigestAuthenticationPolicy` .   
	public func createDigestAuthenticationPolicy() throws -> DigestAuthenticationPolicy
	{
		let cPointer = linphone_factory_create_digest_authentication_policy(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null DigestAuthenticationPolicy value")
		}
		let result = DigestAuthenticationPolicy.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object LinphoneErrorInfo. 
	/// - Returns: a `ErrorInfo` object.   
	public func createErrorInfo() throws -> ErrorInfo
	{
		let cPointer = linphone_factory_create_error_info(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ErrorInfo value")
		}
		let result = ErrorInfo.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates a new `FriendPhoneNumber` objects. 
	/// - Parameter phoneNumber: The phone number.   
	/// - Parameter label: the type of phone number, for example "home", "cell", etc.
	/// Use nil or empty for no label.   
	/// - Returns: The newly created `FriendPhoneNumber` object.   
	public func createFriendPhoneNumber(phoneNumber:String, label:String?) throws -> FriendPhoneNumber
	{
		let cPointer = linphone_factory_create_friend_phone_number(cPtr, phoneNumber, label)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null FriendPhoneNumber value")
		}
		let result = FriendPhoneNumber.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `ParticipantDeviceIdentity` object. 
	/// - Parameter address: `Address` object.   
	/// - Parameter name: the name given to the device.   
	/// - Returns: A new `ParticipantDeviceIdentity`.   
	public func createParticipantDeviceIdentity(address:Address, name:String?) throws -> ParticipantDeviceIdentity
	{
		let cPointer = linphone_factory_create_participant_device_identity(cPtr, address.cPtr, name)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null ParticipantDeviceIdentity value")
		}
		let result = ParticipantDeviceIdentity.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object LinphoneRange. 
	/// - Returns: a `Range` object.   
	public func createRange() throws -> Range
	{
		let cPointer = linphone_factory_create_range(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Range value")
		}
		let result = Range.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Instantiate a shared `Core` object. 
	/// The shared `Core` allow you to create several `Core` with the same config. Two
	/// `Core` can't run at the same time.
	/// A shared `Core` can be a "Main Core" or an "Executor Core". A "Main Core"
	/// automatically stops a running "Executor Core" when calling Core.start() An
	/// "Executor Core" can't start unless no other `Core` is started. It can be
	/// stopped by a "Main Core" and switch to `GlobalState` Off at any time.
	/// Shared Executor Core are used in iOS UNNotificationServiceExtension to receive
	/// new messages from push notifications. When the application is in background,
	/// its Shared Main Core is stopped.
	/// The `Core` object is not started automatically, you need to call Core.start()
	/// to that effect. The returned `Core` will be in `GlobalState` Ready. Core
	/// ressources can be released using Core.stop() which is strongly encouraged on
	/// garbage collected languages. 
	/// - Parameter configFilename: The name of the config file. If it does not exists
	/// it will be created. Its path is computed using the app_group_id. The config
	/// file is used to store all settings, proxies... so that all these settings
	/// become persistent over the life of the `Core` object. It is allowed to set a
	/// nil config file. In that case `Core` will not store any settings.   
	/// - Parameter factoryConfigPath: A path to a read-only config file that can be
	/// used to store hard-coded preferences such as proxy settings or internal
	/// preferences. The settings in this factory file always override the ones in the
	/// normal config file. It is optional, use nil if unneeded.   
	/// - Parameter systemContext: A pointer to a system object required by the core to
	/// operate. Currently it is required to pass an android Context on android, pass
	/// nil on other platforms.   
	/// - Parameter appGroupId: Name of iOS App Group that lead to the file system that
	/// is shared between an app and its app extensions.   
	/// - Parameter mainCore: Indicate if we want to create a "Main Core" or an
	/// "Executor Core". 
	/// - Returns: a `Core` object   
	/// - See also: createSharedCoreWithConfig() 
	public func createSharedCore(configFilename:String?, factoryConfigPath:String?, systemContext:UnsafeMutableRawPointer?, appGroupId:String, mainCore:Bool) throws -> Core
	{
		let cPointer = linphone_factory_create_shared_core(cPtr, configFilename, factoryConfigPath, systemContext, appGroupId, mainCore==true ? 1:0)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Core value")
		}
		let result = Core.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Instantiate a shared `Core` object. 
	/// The shared `Core` allow you to create several `Core` with the same config. Two
	/// `Core` can't run at the same time.
	/// A shared `Core` can be a "Main Core" or an "Executor Core". A "Main Core"
	/// automatically stops a running "Executor Core" when calling Core.start() An
	/// "Executor Core" can't start unless no other `Core` is started. It can be
	/// stopped by a "Main Core" and switch to `GlobalState` Off at any time.
	/// Shared Executor Core are used in iOS UNNotificationServiceExtension to receive
	/// new messages from push notifications. When the application is in background,
	/// its Shared Main Core is stopped.
	/// The `Core` object is not started automatically, you need to call Core.start()
	/// to that effect. The returned `Core` will be in `GlobalState` Ready. Core
	/// ressources can be released using Core.stop() which is strongly encouraged on
	/// garbage collected languages. 
	/// - Parameter config: A `Config` object holding the configuration for the `Core`
	/// to be instantiated.   
	/// - Parameter systemContext: A pointer to a system object required by the core to
	/// operate. Currently it is required to pass an android Context on android, pass
	/// nil on other platforms.   
	/// - Parameter appGroupId: Name of iOS App Group that lead to the file system that
	/// is shared between an app and its app extensions.   
	/// - Parameter mainCore: Indicate if we want to create a "Main Core" or an
	/// "Executor Core". 
	/// - Returns: a `Core` object   
	/// - See also: createSharedCore() 
	public func createSharedCoreWithConfig(config:Config, systemContext:UnsafeMutableRawPointer?, appGroupId:String, mainCore:Bool) throws -> Core
	{
		let cPointer = linphone_factory_create_shared_core_with_config(cPtr, config.cPtr, systemContext, appGroupId, mainCore==true ? 1:0)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Core value")
		}
		let result = Core.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object LinphoneTransports. 
	/// - Returns: a `Transports` object.   
	public func createTransports() throws -> Transports
	{
		let cPointer = linphone_factory_create_transports(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Transports value")
		}
		let result = Transports.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object `TunnelConfig`. 
	/// - Returns: a `TunnelConfig`   
	public func createTunnelConfig() throws -> TunnelConfig
	{
		let cPointer = linphone_factory_create_tunnel_config(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null TunnelConfig value")
		}
		let result = TunnelConfig.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create an empty `Vcard`. 
	/// - Returns: a new `Vcard`.   
	public func createVcard() throws -> Vcard
	{
		let cPointer = linphone_factory_create_vcard(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Vcard value")
		}
		let result = Vcard.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates an object LinphoneVideoActivationPolicy. 
	/// - Returns: `VideoActivationPolicy` object.   
	public func createVideoActivationPolicy() throws -> VideoActivationPolicy
	{
		let cPointer = linphone_factory_create_video_activation_policy(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null VideoActivationPolicy value")
		}
		let result = VideoActivationPolicy.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `VideoDefinition` from a given width and height. 
	/// - Parameter width: The width of the created video definition 
	/// - Parameter height: The height of the created video definition 
	/// - Returns: A new `VideoDefinition` object   
	public func createVideoDefinition(width:UInt, height:UInt) throws -> VideoDefinition
	{
		let cPointer = linphone_factory_create_video_definition(cPtr, CUnsignedInt(width), CUnsignedInt(height))
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null VideoDefinition value")
		}
		let result = VideoDefinition.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Create a `VideoDefinition` from a given standard definition name. 
	/// - Parameter name: The standard definition name of the video definition to
	/// create   
	/// - Returns: A new `VideoDefinition` object   
	public func createVideoDefinitionFromName(name:String) throws -> VideoDefinition
	{
		let cPointer = linphone_factory_create_video_definition_from_name(cPtr, name)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null VideoDefinition value")
		}
		let result = VideoDefinition.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Enables or disables log collection. 
	/// - Parameter state: the `LogCollectionState` for log collection 
	public func enableLogCollection(state:LogCollectionState) 
	{
		linphone_factory_enable_log_collection(cPtr, LinphoneLogCollectionState(rawValue: CUnsignedInt(state.rawValue)))
	}

	/// Get the config path. 
	/// - Parameter context: used to compute path. Can be nil. JavaPlatformHelper on
	/// Android and char *appGroupId on iOS with shared core.   
	/// - Returns: The config path   
	public func getConfigDir(context:UnsafeMutableRawPointer?) -> String
	{
		let cstr = linphone_factory_get_config_dir(cPtr, context)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Get the data path. 
	/// - Parameter context: used to compute path. Can be nil. JavaPlatformHelper on
	/// Android and char *appGroupId on iOS with shared core.   
	/// - Returns: The data path   
	public func getDataDir(context:UnsafeMutableRawPointer?) -> String
	{
		let cstr = linphone_factory_get_data_dir(cPtr, context)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Get the download path. 
	/// - Parameter context: used to compute path. Can be nil. JavaPlatformHelper on
	/// Android and char *appGroupId on iOS with shared core.   
	/// - Returns: The download path   
	public func getDownloadDir(context:UnsafeMutableRawPointer?) -> String
	{
		let cstr = linphone_factory_get_download_dir(cPtr, context)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Indicates if the given LinphoneChatRoomBackend is available. 
	/// - Parameter chatroomBackend: the `ChatRoomBackend` 
	/// - Returns: true if the chatroom backend is available, false otherwise 
	public func isChatroomBackendAvailable(chatroomBackend:ChatRoomBackend) -> Bool
	{
		return linphone_factory_is_chatroom_backend_available(cPtr, LinphoneChatRoomBackend(rawValue: CUnsignedInt(chatroomBackend.rawValue))) != 0
	}

	/// Select encryption module and set secret material to encrypt the files. 
	/// - Parameter encryptionModule: One of the available encryption module for VFS,
	/// pick in the LINPHONE_VFS_ENCRYPTION_* list if set to _UNSET, default bctoolbox
	/// VFS is switch to Standard one 
	/// - Parameter secret: the secret material used to encrypt the files, can be nil
	/// for the _PLAIN module   
	/// - Parameter secretSize: size of the secret 
	public func setVfsEncryption(encryptionModule:UInt16, secret:UnsafePointer<UInt8>?, secretSize:Int) 
	{
		linphone_factory_set_vfs_encryption(cPtr, encryptionModule, secret, secretSize)
	}
}

/// This object is used to store a SIP address. 
/// `Friend` is mainly used to implement an adressbook feature, and are used as
/// data for the `MagicSearch` object. If your proxy supports it, you can also use
/// it to subscribe to presence information.
/// The objects are stored in a `FriendList` which are in turn stored inside the
/// `Core`. They can be stored inside a database if the path to it is configured,
/// otherwise they will be lost after the `Core` is destroyed.
/// Thanks to the vCard plugin, you can also store more information like phone
/// numbers, organization, etc... 
public class Friend : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Friend {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Friend>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Friend(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Contructor same as linphone_friend_new + setAddress() 
	/// - Parameter vcard: a `Vcard` object   
	/// - Returns: a new `Friend` which has its vCard attribute initialized from the
	/// given vCard. This can be get by getVcard().   
	static public func newFromVcard(vcard:Vcard) -> Friend?
	{
		let cPointer = linphone_friend_new_from_vcard(vcard.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Friend.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Get address of this friend. 
	/// - Note: the `Address` object returned is hold by the LinphoneFriend, however
	/// calling several time this function may return different objects. 
	/// - Returns: the `Address`.   
	public var address: Address?
	{
			let cPointer = linphone_friend_get_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	public func setAddress(newValue: Address) throws
	{
		let exception_result = linphone_friend_set_address(cPtr, newValue.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Returns a list of `Address` for this friend. 
	/// - Returns: A list of `Address`.    
	public var addresses: [Address]
	{
			var swiftList = [Address]()
			let cList = linphone_friend_get_addresses(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Address.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Returns the capabilities associated to this friend. 
	/// - Returns: an int representing the capabilities of the friend 
	public var capabilities: Int
	{
			return Int(linphone_friend_get_capabilities(cPtr))
	}

	/// Get the consolidated presence of a friend. 
	/// - Returns: The `ConsolidatedPresence` of the friend 
	public var consolidatedPresence: ConsolidatedPresence
	{
			return ConsolidatedPresence(rawValue: Int(linphone_friend_get_consolidated_presence(cPtr).rawValue))!
	}

	/// Returns the `Core` object managing this friend, if any. 
	/// - Returns: the `Core` object associated.   
	public var core: Core?
	{
			let cPointer = linphone_friend_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Core.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// get current subscription policy for this `Friend` 
	/// - Returns: the `SubscribePolicy` enum 
	public var incSubscribePolicy: SubscribePolicy
	{
			return SubscribePolicy(rawValue: Int(linphone_friend_get_inc_subscribe_policy(cPtr).rawValue))!
	}

	public func setIncsubscribepolicy(newValue: SubscribePolicy) throws
	{
		let exception_result = linphone_friend_set_inc_subscribe_policy(cPtr, LinphoneSubscribePolicy(rawValue: CUnsignedInt(newValue.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Tells whether we already received presence information for a friend. 
	/// - Returns: true if presence information has been received for the friend, false
	/// otherwise. 
	public var isPresenceReceived: Bool
	{
			return linphone_friend_is_presence_received(cPtr) != 0
	}

	/// Get the display name for this friend. 
	/// - Returns: The display name of this friend.   
	public var name: String
	{
			let cPointer = linphone_friend_get_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setName(newValue: String) throws
	{
		let exception_result = linphone_friend_set_name(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the contact's native URI. 
	/// - Returns: the native URI set if any, nil otherwise.   
	public var nativeUri: String
	{
		get
		{
			let cPointer = linphone_friend_get_native_uri(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_friend_set_native_uri(cPtr, newValue)
		}
	}

	/// Gets the contact's organization from it's vCard. 
	/// It's a shortcut to getVcard() and Vcard.getOrganization(). 
	/// - Returns: the organization set if any & vCard is available, nil otherwise.   
	public var organization: String
	{
		get
		{
			let cPointer = linphone_friend_get_organization(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_friend_set_organization(cPtr, newValue)
		}
	}

	/// Returns a list of phone numbers for this friend. 
	/// - Returns: A list of phone numbers as string.      
	public var phoneNumbers: [String]
	{
			var swiftList = [String]()
			let cList = linphone_friend_get_phone_numbers(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp!.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Returns a list of `FriendPhoneNumber` for this friend. 
	/// - Returns: A list of phone numbers as string.      
	public var phoneNumbersWithLabel: [FriendPhoneNumber]
	{
			var swiftList = [FriendPhoneNumber]()
			let cList = linphone_friend_get_phone_numbers_with_label(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(FriendPhoneNumber.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Gets the contact's picture URI. 
	/// - Returns: the picture URI set if any, nil otherwise.   
	public var photo: String
	{
		get
		{
			let cPointer = linphone_friend_get_photo(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_friend_set_photo(cPtr, newValue)
		}
	}

	/// Get the presence model of a friend. 
	/// - Returns: A `PresenceModel` object, or nil if the friend do not have presence
	/// information (in which case he is considered offline).   
	public var presenceModel: PresenceModel?
	{
		get
		{
			let cPointer = linphone_friend_get_presence_model(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = PresenceModel.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_friend_set_presence_model(cPtr, newValue?.cPtr)
		}
	}

	/// Get the reference key of a friend. 
	/// - Returns: The reference key of the friend.   
	public var refKey: String
	{
		get
		{
			let cPointer = linphone_friend_get_ref_key(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_friend_set_ref_key(cPtr, newValue)
		}
	}

	/// Gets if the friend is to be considered as important for the user. 
	/// - Returns: true if the contact is a user's favorite, false otherwise. 
	public var starred: Bool
	{
		get
		{
			return linphone_friend_get_starred(cPtr) != 0
		}
		set
		{
			linphone_friend_set_starred(cPtr, newValue==true ? 1:0)
		}
	}

	/// get subscription flag value 
	/// - Returns: returns true is subscription is activated for this friend 
	public var subscribesEnabled: Bool
	{
			return linphone_friend_subscribes_enabled(cPtr) != 0
	}

	public func setSubscribesenabled(newValue: Bool) throws
	{
		let exception_result = linphone_friend_enable_subscribes(cPtr, newValue==true ? 1:0)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get subscription state of a friend. 
	/// - Returns: the `SubscriptionState` enum 
	public var subscriptionState: SubscriptionState
	{
			return SubscriptionState(rawValue: Int(linphone_friend_get_subscription_state(cPtr).rawValue))!
	}

	/// Retrieve user data associated with friend. 
	/// - Returns: the user data pointer.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_friend_get_user_data(cPtr)
		}
		set
		{
			linphone_friend_set_user_data(cPtr, newValue)
		}
	}

	/// Returns the vCard object associated to this friend, if any. 
	/// - Returns: the `Vcard` or nil.   
	public var vcard: Vcard?
	{
		get
		{
			let cPointer = linphone_friend_get_vcard(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Vcard.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_friend_set_vcard(cPtr, newValue?.cPtr)
		}
	}

	/// Adds an address in this friend. 
	/// - Parameter address: `Address` object   
	public func addAddress(address:Address) 
	{
		linphone_friend_add_address(cPtr, address.cPtr)
	}

	/// Adds a phone number in this friend. 
	/// - Parameter phoneNumber: number to add   
	public func addPhoneNumber(phoneNumber:String) 
	{
		linphone_friend_add_phone_number(cPtr, phoneNumber)
	}

	/// Adds a `FriendPhoneNumber` to this friend. 
	/// - Parameter phoneNumber: the `FriendPhoneNumber` to add   
	public func addPhoneNumberWithLabel(phoneNumber:FriendPhoneNumber) 
	{
		linphone_friend_add_phone_number_with_label(cPtr, phoneNumber.cPtr)
	}

	/// Creates a vCard object associated to this friend if there isn't one yet and if
	/// the full name is available, either by the parameter or the one in the friend's
	/// SIP URI. 
	/// - Parameter name: The full name of the friend or nil to use the one from the
	/// friend's SIP URI   
	/// - Returns: true if the vCard has been created, false if it wasn't possible (for
	/// exemple if name and the friend's SIP URI are null or if the friend's SIP URI
	/// doesn't have a display name), or if there is already one vcard 
	public func createVcard(name:String?) throws -> Bool
	{
		return linphone_friend_create_vcard(cPtr, name) != 0
	}

	/// Commits modification made to the friend configuration. 
	public func done() 
	{
		linphone_friend_done(cPtr)
	}

	/// Starts editing a friend configuration. 
	/// Because friend configuration must be consistent, applications MUST call edit()
	/// before doing any attempts to modify friend configuration (such as setAddress()
	/// or setIncSubscribePolicy()). Once the modifications are done, then the
	/// application must call done() to commit the changes. 
	public func edit() 
	{
		linphone_friend_edit(cPtr)
	}

	/// Returns the version of a friend's capbility. 
	/// - Parameter capability: `FriendCapability` object 
	/// - Returns: the version of a friend's capbility. 
	public func getCapabilityVersion(capability:FriendCapability) -> Float
	{
		return linphone_friend_get_capability_version(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue)))
	}

	/// Get the presence model for a specific SIP URI or phone number of a friend. 
	/// - Parameter uriOrTel: The SIP URI or phone number for which to get the presence
	/// model   
	/// - Returns: A `PresenceModel` object, or nil if the friend do not have presence
	/// information for this SIP URI or phone number.   
	public func getPresenceModelForUriOrTel(uriOrTel:String) -> PresenceModel?
	{
		let cPointer = linphone_friend_get_presence_model_for_uri_or_tel(cPtr, uriOrTel)
		if (cPointer == nil) {
			return nil
		}
		let result = PresenceModel.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Returns whether or not a friend has a capbility. 
	/// - Parameter capability: `FriendCapability` object 
	/// - Returns: whether or not a friend has a capbility 
	public func hasCapability(capability:FriendCapability) -> Bool
	{
		return linphone_friend_has_capability(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue))) != 0
	}

	/// Returns whether or not a friend has a capbility with a given version. 
	/// - Parameter capability: `FriendCapability` object 
	/// - Parameter version: the version to test 
	/// - Returns: whether or not a friend has a capbility with a given version or -1.0
	/// if friend has not capability. 
	public func hasCapabilityWithVersion(capability:FriendCapability, version:Float) -> Bool
	{
		return linphone_friend_has_capability_with_version(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue)), version) != 0
	}

	/// Returns whether or not a friend has a capbility with a given version or more. 
	/// - Parameter capability: `FriendCapability` object 
	/// - Parameter version: the version to test 
	/// - Returns: whether or not a friend has a capbility with a given version or
	/// more. 
	public func hasCapabilityWithVersionOrMore(capability:FriendCapability, version:Float) -> Bool
	{
		return linphone_friend_has_capability_with_version_or_more(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue)), version) != 0
	}

	/// Returns whether a friend contains the given phone number. 
	/// - Parameter phoneNumber: the phone number to search for   
	/// - Returns: true if found, false otherwise 
	public func hasPhoneNumber(phoneNumber:String) -> Bool
	{
		return linphone_friend_has_phone_number(cPtr, phoneNumber) != 0
	}

	/// Check that the given friend is in a friend list. 
	/// - Returns: true if the friend is in a friend list, false otherwise. 
	public func inList() -> Bool
	{
		return linphone_friend_in_list(cPtr) != 0
	}

	/// Removes a friend from it's friend list and from the rc if exists. 
	public func remove() 
	{
		linphone_friend_remove(cPtr)
	}

	/// Removes an address in this friend. 
	/// - Parameter address: `Address` object   
	public func removeAddress(address:Address) 
	{
		linphone_friend_remove_address(cPtr, address.cPtr)
	}

	/// Removes a phone number in this friend. 
	/// - Parameter phoneNumber: number to remove   
	public func removePhoneNumber(phoneNumber:String) 
	{
		linphone_friend_remove_phone_number(cPtr, phoneNumber)
	}

	/// Removes a `FriendPhoneNumber` from this friend. 
	/// - Parameter phoneNumber: the `FriendPhoneNumber` to remove   
	public func removePhoneNumberWithLabel(phoneNumber:FriendPhoneNumber) 
	{
		linphone_friend_remove_phone_number_with_label(cPtr, phoneNumber.cPtr)
	}

	/// Saves a friend either in database if configured, otherwise in linphonerc. 
	/// - Parameter core: the linphone core   
	public func save(core:Core) 
	{
		linphone_friend_save(cPtr, core.cPtr)
	}

	/// Set the presence model for a specific SIP URI or phone number of a friend. 
	/// - Parameter uriOrTel: The SIP URI or phone number for which to set the presence
	/// model   
	/// - Parameter presence: The `PresenceModel` object to set   
	public func setPresenceModelForUriOrTel(uriOrTel:String, presence:PresenceModel?) 
	{
		linphone_friend_set_presence_model_for_uri_or_tel(cPtr, uriOrTel, presence?.cPtr)
	}
}

/// This object representing a list of `Friend`. 
/// You can use it to store contacts locally or synchronize them through CardDAV
/// protocol. 
public class FriendList : LinphoneObject
{
	var delegateManagers : [FriendListDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> FriendList {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<FriendList>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = FriendList(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///Enum describing the status of a CardDAV synchronization. 
	public enum SyncStatus:Int
	{
		/// Synchronization started. 
		case Started = 0
		/// Synchronization finished successfuly. 
		case Successful = 1
		/// Synchronization failed. 
		case Failure = 2
	}

	///Enum describing the status of a LinphoneFriendList operation. 
	public enum Status:Int
	{
		/// Operation went fine. 
		case OK = 0
		/// `Friend` wasn't found in the `FriendList` 
		case NonExistentFriend = 1
		/// `Friend` is already present in a `FriendList` 
		case InvalidFriend = 2
	}

	/// This object representing a list of `Friend`. 
	/// You can use it to store contacts locally or synchronize them through CardDAV
	/// protocol. 
	public func addDelegate(delegate: FriendListDelegate)
	{
		let manager = FriendListDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_friend_list_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// This object representing a list of `Friend`. 
	/// You can use it to store contacts locally or synchronize them through CardDAV
	/// protocol. 
	public func removeDelegate(delegate: FriendListDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_friend_list_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Returns the `Core` object attached to this LinphoneFriendList. 
	/// - Returns: a `Core` object   
	public var core: Core?
	{
			let cPointer = linphone_friend_list_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Core.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the current LinphoneFriendListCbs object associated with a
	/// LinphoneFriendList. 
	/// - Returns: The current LinphoneFriendListCbs object associated with the
	/// LinphoneFriendList.   
	public var currentDelegate: FriendListDelegate?
	{
			let cObject = linphone_friend_list_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<FriendListDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Get the display name of the friend list. 
	/// - Returns: The display name of the friend list.   
	public var displayName: String
	{
		get
		{
			let cPointer = linphone_friend_list_get_display_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_friend_list_set_display_name(cPtr, newValue)
		}
	}

	/// Retrieves the list of `Friend` from this LinphoneFriendList. 
	/// - Returns: A list of `Friend`    
	public var friends: [Friend]
	{
			var swiftList = [Friend]()
			let cList = linphone_friend_list_get_friends(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Friend.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Get wheter the subscription of the friend list is bodyless or not. 
	/// - Returns: Wheter the subscription of the friend list is bodyless or not. 
	public var isSubscriptionBodyless: Bool
	{
			return linphone_friend_list_is_subscription_bodyless(cPtr) != 0
	}

	/// Get the RLS (Resource List Server) URI associated with the friend list to
	/// subscribe to these friends presence. 
	/// - Returns: The RLS URI as `Address` associated with the friend list.   
	public var rlsAddress: Address?
	{
		get
		{
			let cPointer = linphone_friend_list_get_rls_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_friend_list_set_rls_address(cPtr, newValue?.cPtr)
		}
	}

	/// Get the RLS (Resource List Server) URI associated with the friend list to
	/// subscribe to these friends presence. 
	/// - Returns: The RLS URI associated with the friend list.   
	/// - deprecated: 27/10/2020. Use getRlsAddress() instead. 
	@available(*, deprecated)
	public var rlsUri: String
	{
		get
		{
			let cPointer = linphone_friend_list_get_rls_uri(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_friend_list_set_rls_uri(cPtr, newValue)
		}
	}

	/// Set wheter the subscription of the friend list is bodyless or not. 
	/// - Parameter bodyless: boolean telling if the subscription of the friend list is
	/// bodyless or not. 
	public var subscriptionBodyless: Bool?
	{
		willSet
		{
			linphone_friend_list_set_subscription_bodyless(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets whether subscription to NOTIFYes of all friends list are enabled or not. 
	/// - Returns: Whether subscriptions are enabled or not 
	public var subscriptionsEnabled: Bool
	{
		get
		{
			return linphone_friend_list_subscriptions_enabled(cPtr) != 0
		}
		set
		{
			linphone_friend_list_enable_subscriptions(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the type of a friend list. 
	public var type: FriendListType
	{
		get
		{
			return FriendListType(rawValue: Int(linphone_friend_list_get_type(cPtr).rawValue))!
		}
		set
		{
			linphone_friend_list_set_type(cPtr, LinphoneFriendListType(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get the URI associated with the friend list. 
	/// - Returns: The URI associated with the friend list.   
	public var uri: String
	{
		get
		{
			let cPointer = linphone_friend_list_get_uri(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_friend_list_set_uri(cPtr, newValue)
		}
	}

	/// Retrieve the user pointer associated with the friend list. 
	/// - Returns: The user pointer associated with the friend list.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_friend_list_get_user_data(cPtr)
		}
		set
		{
			linphone_friend_list_set_user_data(cPtr, newValue)
		}
	}

	/// Add a friend to a friend list. 
	/// If or when a remote CardDAV server will be attached to the list, the friend
	/// will be sent to the server. 
	/// - Parameter linphoneFriend: `Friend` object to add to the friend list.   
	/// - Returns: `OK` if successfully added, `InvalidFriend` if the friend is not
	/// valid. 
	public func addFriend(linphoneFriend:Friend) -> FriendList.Status
	{
		return FriendList.Status(rawValue: Int(linphone_friend_list_add_friend(cPtr, linphoneFriend.cPtr).rawValue))!
	}

	/// Add a friend to a friend list. 
	/// The friend will never be sent to a remote CardDAV server. Warning!
	/// #LinphoneFriends added this way will be removed on the next synchronization,
	/// and the callback contact_deleted will be called. 
	/// - Parameter linphoneFriend: `Friend` object to add to the friend list.   
	/// - Returns: `OK` if successfully added, `InvalidFriend` if the friend is not
	/// valid. 
	public func addLocalFriend(linphoneFriend:Friend) -> FriendList.Status
	{
		return FriendList.Status(rawValue: Int(linphone_friend_list_add_local_friend(cPtr, linphoneFriend.cPtr).rawValue))!
	}

	/// Creates and export `Friend` objects from `FriendList` to a file using vCard 4
	/// format. 
	/// - Parameter vcardFile: the path to a file that will contain the vCards   
	public func exportFriendsAsVcard4File(vcardFile:String) 
	{
		linphone_friend_list_export_friends_as_vcard4_file(cPtr, vcardFile)
	}

	/// Find a friend in the friend list using a LinphoneAddress. 
	/// - Parameter address: `Address` object of the friend we want to search for.   
	/// - Returns: A `Friend` if found, nil otherwise.   
	public func findFriendByAddress(address:Address) -> Friend?
	{
		let cPointer = linphone_friend_list_find_friend_by_address(cPtr, address.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Friend.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Find a friend in the friend list using a phone number. 
	/// - Parameter phoneNumber: a string of the phone number for which we want to find
	/// a friend.   
	/// - Returns: A `Friend` if found, nil otherwise.   
	public func findFriendByPhoneNumber(phoneNumber:String) -> Friend?
	{
		let cPointer = linphone_friend_list_find_friend_by_phone_number(cPtr, phoneNumber)
		if (cPointer == nil) {
			return nil
		}
		let result = Friend.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Find a friend in the friend list using a ref key. 
	/// - Parameter refKey: The ref key string of the friend we want to search for.   
	/// - Returns: A `Friend` if found, nil otherwise.   
	public func findFriendByRefKey(refKey:String) -> Friend?
	{
		let cPointer = linphone_friend_list_find_friend_by_ref_key(cPtr, refKey)
		if (cPointer == nil) {
			return nil
		}
		let result = Friend.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Find a friend in the friend list using an URI string. 
	/// - Parameter uri: A string containing the URI of the friend we want to search
	/// for.   
	/// - Returns: A `Friend` if found, nil otherwise.   
	public func findFriendByUri(uri:String) -> Friend?
	{
		let cPointer = linphone_friend_list_find_friend_by_uri(cPtr, uri)
		if (cPointer == nil) {
			return nil
		}
		let result = Friend.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Find all friends in the friend list using a LinphoneAddress. 
	/// - Parameter address: `Address` object of the friends we want to search for.   
	/// - Returns: A list of `Friend` if found, nil otherwise.    
	public func findFriendsByAddress(address:Address) -> [Friend]
	{
		var swiftList = [Friend]()
		let cList = linphone_friend_list_find_friends_by_address(cPtr, address.cPtr)
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(Friend.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Find all friends in the friend list using an URI string. 
	/// - Parameter uri: A string containing the URI of the friends we want to search
	/// for.   
	/// - Returns: A list of `Friend` if found, nil otherwise.    
	public func findFriendsByUri(uri:String) -> [Friend]
	{
		var swiftList = [Friend]()
		let cList = linphone_friend_list_find_friends_by_uri(cPtr, uri)
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(Friend.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Creates and adds `Friend` objects to `FriendList` from a buffer that contains
	/// the vCard(s) to parse. 
	/// - Parameter vcardBuffer: the buffer that contains the vCard(s) to parse   
	/// - Returns: the amount of linphone friends created 
	public func importFriendsFromVcard4Buffer(vcardBuffer:String) -> Int
	{
		return Int(linphone_friend_list_import_friends_from_vcard4_buffer(cPtr, vcardBuffer))
	}

	/// Creates and adds `Friend` objects to `FriendList` from a file that contains the
	/// vCard(s) to parse. 
	/// - Parameter vcardFile: the path to a file that contains the vCard(s) to parse   
	/// - Returns: the amount of linphone friends created 
	public func importFriendsFromVcard4File(vcardFile:String) -> Int
	{
		return Int(linphone_friend_list_import_friends_from_vcard4_file(cPtr, vcardFile))
	}

	/// Notify our presence to all the friends in the friend list that have subscribed
	/// to our presence directly (not using a RLS). 
	/// - Parameter presence: `PresenceModel` object.   
	public func notifyPresence(presence:PresenceModel) 
	{
		linphone_friend_list_notify_presence(cPtr, presence.cPtr)
	}

	/// Remove a friend from a friend list. 
	/// - Parameter linphoneFriend: `Friend` object to remove from the friend list.   
	/// - Returns: `OK` if removed successfully, `NonExistentFriend` if the friend is
	/// not in the list. 
	public func removeFriend(linphoneFriend:Friend) -> FriendList.Status
	{
		return FriendList.Status(rawValue: Int(linphone_friend_list_remove_friend(cPtr, linphoneFriend.cPtr).rawValue))!
	}

	/// Starts a CardDAV synchronization using value set using
	/// linphone_friend_list_set_uri. 
	public func synchronizeFriendsFromServer() 
	{
		linphone_friend_list_synchronize_friends_from_server(cPtr)
	}

	/// Goes through all the `Friend` that are dirty and does a CardDAV PUT to update
	/// the server. 
	public func updateDirtyFriends() 
	{
		linphone_friend_list_update_dirty_friends(cPtr)
	}

	/// Sets the revision from the last synchronization. 
	/// - Parameter revision: The revision 
	public func updateRevision(revision:Int) 
	{
		linphone_friend_list_update_revision(cPtr, CInt(revision))
	}

	/// Update presence subscriptions for the entire list. 
	/// Calling this function is necessary when list subscriptions are enabled, ie when
	/// a RLS presence server is used. 
	public func updateSubscriptions() 
	{
		linphone_friend_list_update_subscriptions(cPtr)
	}
}

/// Object that represents a `Friend`'s phone number. 
public class FriendPhoneNumber : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> FriendPhoneNumber {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<FriendPhoneNumber>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = FriendPhoneNumber(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the label associated to this phone number. 
	/// - Returns: the label set if any, nil otherwise.   
	public var label: String
	{
		get
		{
			let cPointer = linphone_friend_phone_number_get_label(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_friend_phone_number_set_label(cPtr, newValue)
		}
	}

	/// Gets the phone number. 
	/// - Returns: the phone number stored.   
	public var phoneNumber: String
	{
		get
		{
			let cPointer = linphone_friend_phone_number_get_phone_number(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_friend_phone_number_set_phone_number(cPtr, newValue)
		}
	}

	/// Clones a phone number. 
	/// - Returns: The newly created `FriendPhoneNumber` object.   
	public func clone() -> FriendPhoneNumber?
	{
		let cPointer = linphone_friend_phone_number_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = FriendPhoneNumber.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}
}

/// Object representing a chain of protocol headers. 
/// It provides read/write access to the headers of the underlying protocol. 
public class Headers : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Headers {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Headers>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Headers(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Add given header name and corresponding value. 
	/// - Parameter name: the header's name   
	/// - Parameter value: the header's value   
	public func add(name:String, value:String?) 
	{
		linphone_headers_add(cPtr, name, value)
	}

	/// Search for a given header name and return its value. 
	/// - Returns: the header's value or nil if not found.   
	public func getValue(headerName:String) -> String
	{
		let cstr = linphone_headers_get_value(cPtr, headerName)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Add given header name and corresponding value. 
	/// - Parameter name: the header's name   
	public func remove(name:String) 
	{
		linphone_headers_remove(cPtr, name)
	}
}

/// Policy to use to send/receive instant messaging composing/delivery/display
/// notifications. 
/// The sending of this information is done as in the RFCs 3994 (is_composing) and
/// 5438 (imdn delivered/displayed). 
public class ImNotifPolicy : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> ImNotifPolicy {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ImNotifPolicy>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ImNotifPolicy(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Tell whether imdn delivered notifications are being notified when received. 
	/// - Returns: Boolean value telling whether imdn delivered notifications are being
	/// notified when received. 
	public var recvImdnDelivered: Bool
	{
		get
		{
			return linphone_im_notif_policy_get_recv_imdn_delivered(cPtr) != 0
		}
		set
		{
			linphone_im_notif_policy_set_recv_imdn_delivered(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether imdn displayed notifications are being notified when received. 
	/// - Returns: Boolean value telling whether imdn displayed notifications are being
	/// notified when received. 
	public var recvImdnDisplayed: Bool
	{
		get
		{
			return linphone_im_notif_policy_get_recv_imdn_displayed(cPtr) != 0
		}
		set
		{
			linphone_im_notif_policy_set_recv_imdn_displayed(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether is_composing notifications are being notified when received. 
	/// - Returns: Boolean value telling whether is_composing notifications are being
	/// notified when received. 
	public var recvIsComposing: Bool
	{
		get
		{
			return linphone_im_notif_policy_get_recv_is_composing(cPtr) != 0
		}
		set
		{
			linphone_im_notif_policy_set_recv_is_composing(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether imdn delivered notifications are being sent. 
	/// - Returns: Boolean value telling whether imdn delivered notifications are being
	/// sent. 
	public var sendImdnDelivered: Bool
	{
		get
		{
			return linphone_im_notif_policy_get_send_imdn_delivered(cPtr) != 0
		}
		set
		{
			linphone_im_notif_policy_set_send_imdn_delivered(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether imdn displayed notifications are being sent. 
	/// - Returns: Boolean value telling whether imdn displayed notifications are being
	/// sent. 
	public var sendImdnDisplayed: Bool
	{
		get
		{
			return linphone_im_notif_policy_get_send_imdn_displayed(cPtr) != 0
		}
		set
		{
			linphone_im_notif_policy_set_send_imdn_displayed(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether is_composing notifications are being sent. 
	/// - Returns: Boolean value telling whether is_composing notifications are being
	/// sent. 
	public var sendIsComposing: Bool
	{
		get
		{
			return linphone_im_notif_policy_get_send_is_composing(cPtr) != 0
		}
		set
		{
			linphone_im_notif_policy_set_send_is_composing(cPtr, newValue==true ? 1:0)
		}
	}

	/// Retrieve the user pointer associated with the `ImNotifPolicy` object. 
	/// - Returns: The user pointer associated with the `ImNotifPolicy` object.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_im_notif_policy_get_user_data(cPtr)
		}
		set
		{
			linphone_im_notif_policy_set_user_data(cPtr, newValue)
		}
	}

	/// Clear an IM notif policy (deactivate all receiving and sending of
	/// notifications). 
	public func clear() 
	{
		linphone_im_notif_policy_clear(cPtr)
	}

	/// Enable all receiving and sending of notifications. 
	public func enableAll() 
	{
		linphone_im_notif_policy_enable_all(cPtr)
	}
}

/// Object representing an informational message sent or received by the core. 
public class InfoMessage : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> InfoMessage {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<InfoMessage>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = InfoMessage(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Returns the info message's content as a `Content` structure. 
	/// - Returns: the `Content` object.   
	public var content: Content?
	{
		get
		{
			let cPointer = linphone_info_message_get_content(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Content.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_info_message_set_content(cPtr, newValue?.cPtr)
		}
	}

	/// Add a header to an info message to be sent. 
	/// - Parameter name: the header'name   
	/// - Parameter value: the header's value   
	public func addHeader(name:String, value:String?) 
	{
		linphone_info_message_add_header(cPtr, name, value)
	}

	/// Obtain a header value from a received info message. 
	/// - Parameter name: the header'name   
	/// - Returns: the corresponding header's value, or nil if not exists.   
	public func getHeader(name:String) -> String
	{
		let cstr = linphone_info_message_get_header(cPtr, name)
		let result = charArrayToString(charPointer: cstr)
		return result
	}
}

/// Object that represents a Linphone Ldap. 
/// Use a `LdapParams` object to configure it. 
public class Ldap : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Ldap {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Ldap>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Ldap(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Create a new `Ldap`, associate it with the `LdapParams` and store it into the
	/// configuration file. 
	/// - Parameter lc: The `Core` object.   
	/// - Parameter params: The `LdapParams` object.   
	/// - Returns: The newly created `Ldap` object.     
	static public func newWithParams(lc:Core, params:LdapParams) -> Ldap?
	{
		let cPointer = linphone_ldap_new_with_params(lc.cPtr, params.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Ldap.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Get the `Core` object to which is associated the `Ldap`. 
	/// - Returns: The `Core` object to which is associated the `Ldap`.   
	public var core: Core?
	{
			let cPointer = linphone_ldap_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Core.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the index of the `Ldap`. 
	/// - Returns: The index of the Ldap 
	public var index: Int
	{
		get
		{
			return Int(linphone_ldap_get_index(cPtr))
		}
		set
		{
			linphone_ldap_set_index(cPtr, CInt(newValue))
		}
	}

	/// Get the `LdapParams` as read-only object. 
	/// To make changes, clone the returned object using LdapParams.clone() method,
	/// make your changes on it and apply them using with setParams(). 
	/// - Returns: The `LdapParams` attached to this ldap.   
	public var params: LdapParams?
	{
		get
		{
			let cPointer = linphone_ldap_get_params(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = LdapParams.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_ldap_set_params(cPtr, newValue?.cPtr)
		}
	}
}

/// Object that is used to set the different parameters of a `Ldap`. 
public class LdapParams : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> LdapParams {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<LdapParams>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = LdapParams(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get the authentification method. 
	/// Check `LdapAuthMethod` for authentification values.
	/// - Returns: The `LdapAuthMethod`. 
	public var authMethod: LdapAuthMethod
	{
		get
		{
			return LdapAuthMethod(rawValue: Int(linphone_ldap_params_get_auth_method(cPtr).rawValue))!
		}
		set
		{
			linphone_ldap_params_set_auth_method(cPtr, LinphoneLdapAuthMethod(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get the BaseObject. 
	/// It is a specification for LDAP Search Scopes that specifies that the Search
	/// Request should only be performed against the entry specified as the search base
	/// DN. No entries above it will be considered. This field is required.
	/// - Returns: The specification.   
	public var baseObject: String
	{
		get
		{
			let cPointer = linphone_ldap_params_get_base_object(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_ldap_params_set_base_object(cPtr, newValue)
		}
	}

	/// Get the Bind DN to use for bindings. 
	/// The bindDN DN is the credential that is used to authenticate against an LDAP.
	/// If empty, the connection will be Anonymous. eg:
	/// cn=ausername,ou=people,dc=bc,dc=com
	/// - Returns: The Bind DN to use for bindings.   
	public var bindDn: String
	{
		get
		{
			let cPointer = linphone_ldap_params_get_bind_dn(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_ldap_params_set_bind_dn(cPtr, newValue)
		}
	}

	/// Return the debug verbosity level. 
	/// - Returns: The `LdapDebugLevel` debug level. 
	public var debugLevel: LdapDebugLevel
	{
		get
		{
			return LdapDebugLevel(rawValue: Int(linphone_ldap_params_get_debug_level(cPtr).rawValue))!
		}
		set
		{
			linphone_ldap_params_set_debug_level(cPtr, LinphoneLdapDebugLevel(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get the delay between each search in milliseconds. 
	/// - Returns: The delay in milliseconds. 
	public var delay: Int
	{
		get
		{
			return Int(linphone_ldap_params_get_delay(cPtr))
		}
		set
		{
			linphone_ldap_params_set_delay(cPtr, CInt(newValue))
		}
	}

	/// Return if the configuration is enabled. 
	/// - Returns: Enable or not the LDAP configuration. 
	public var enabled: Bool
	{
		get
		{
			return linphone_ldap_params_get_enabled(cPtr) != 0
		}
		set
		{
			linphone_ldap_params_set_enabled(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the search is based on this filter to search contacts. 
	/// - Returns: The filter to use.   
	public var filter: String
	{
		get
		{
			let cPointer = linphone_ldap_params_get_filter(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_ldap_params_set_filter(cPtr, newValue)
		}
	}

	/// Get the max results when requesting searches. 
	/// - Returns: The max results when requesting searches. 
	public var maxResults: Int
	{
		get
		{
			return Int(linphone_ldap_params_get_max_results(cPtr))
		}
		set
		{
			linphone_ldap_params_set_max_results(cPtr, CInt(newValue))
		}
	}

	/// Get the minimum characters needed for doing a search on LDAP servers. 
	/// - Returns: The minimum characters needed by a search. 
	public var minChars: Int
	{
		get
		{
			return Int(linphone_ldap_params_get_min_chars(cPtr))
		}
		set
		{
			linphone_ldap_params_set_min_chars(cPtr, CInt(newValue))
		}
	}

	/// Get the attributes to build Name Friend, separated by a comma and the first is
	/// the highest priority. 
	/// - Returns: The comma separated attributes for the search.   
	public var nameAttribute: String
	{
		get
		{
			let cPointer = linphone_ldap_params_get_name_attribute(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_ldap_params_set_name_attribute(cPtr, newValue)
		}
	}

	/// Get the password to pass to server when binding. 
	/// - Returns: The password to pass to server when binding.   
	public var password: String
	{
		get
		{
			let cPointer = linphone_ldap_params_get_password(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_ldap_params_set_password(cPtr, newValue)
		}
	}

	/// Return if the dns resolution is done by Linphone using Sal. 
	/// It will pass an IP to LDAP. By doing that, the TLS negociation could not check
	/// the hostname. You may deactivate the verifications if wanted to force the
	/// connection.
	/// - Returns: Enable or not the use of sal. 
	public var salEnabled: Bool
	{
		get
		{
			return linphone_ldap_params_sal_enabled(cPtr) != 0
		}
		set
		{
			linphone_ldap_params_enable_sal(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the LDAP Server. 
	/// - Returns: LDAP Server address.   
	public var server: String
	{
		get
		{
			let cPointer = linphone_ldap_params_get_server(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_ldap_params_set_server(cPtr, newValue)
		}
	}

	/// Return whether the tls server certificate must be verified when connecting to a
	/// LDAP server. 
	/// - Returns: The TLS verification mode from `LdapCertVerificationMode` 
	public var serverCertificatesVerificationMode: LdapCertVerificationMode
	{
		get
		{
			return LdapCertVerificationMode(rawValue: Int(linphone_ldap_params_get_server_certificates_verification_mode(cPtr).rawValue))!
		}
		set
		{
			linphone_ldap_params_set_server_certificates_verification_mode(cPtr, LinphoneLdapCertVerificationMode(rawValue: CInt(newValue.rawValue)))
		}
	}

	/// Get the attributes to build the SIP username in address of Friend. 
	/// Attributes are separated by a comma.
	/// - Returns: The comma separated attributes for building Friend.   
	public var sipAttribute: String
	{
		get
		{
			let cPointer = linphone_ldap_params_get_sip_attribute(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_ldap_params_set_sip_attribute(cPtr, newValue)
		}
	}

	/// Get the domain to the sip address(sip:username@domain). 
	/// - Returns: The SIP domain for the friend.   
	public var sipDomain: String
	{
		get
		{
			let cPointer = linphone_ldap_params_get_sip_domain(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_ldap_params_set_sip_domain(cPtr, newValue)
		}
	}

	/// Get the timeout in seconds. 
	/// - Returns: The timeout in seconds. 
	public var timeout: Int
	{
		get
		{
			return Int(linphone_ldap_params_get_timeout(cPtr))
		}
		set
		{
			linphone_ldap_params_set_timeout(cPtr, CInt(newValue))
		}
	}

	/// Return if transactions are encrypted by LDAP over TLS(StartTLS). 
	/// You must use \'ldap\' scheme. \'ldaps\' for LDAP over SSL is non-standardized
	/// and deprecated. StartTLS in an extension to the LDAP protocol which uses the
	/// TLS protocol to encrypt communication. It works by establishing a normal - i.e.
	/// unsecured - connection with the LDAP server before a handshake negotiation
	/// between the server and the web services is carried out. Here, the server sends
	/// its certificate to prove its identity before the secure connection is
	/// established.
	/// - Returns: Enable or not the use of TLS. 
	public var tlsEnabled: Bool
	{
		get
		{
			return linphone_ldap_params_tls_enabled(cPtr) != 0
		}
		set
		{
			linphone_ldap_params_enable_tls(cPtr, newValue==true ? 1:0)
		}
	}

	/// Check parameters and return what are wrong. 
	/// - Returns: The `LdapCheck` values. LinphoneLdapCheckOk if everything is ok. 
	public func check() -> Int
	{
		return Int(linphone_ldap_params_check(cPtr))
	}

	/// Instantiate a new `LdapParams` with values from source. 
	/// - Returns: The newly created `LdapParams` object.   
	public func clone() -> LdapParams?
	{
		let cPointer = linphone_ldap_params_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = LdapParams.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Get the value from field. 
	/// - Parameter key: The key string.   
	/// - Returns: The Value associated to the key.   
	public func getCustomValue(key:String) -> String
	{
		let cstr = linphone_ldap_params_get_custom_value(cPtr, key)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Set custom field. 
	/// - Parameter key: The key string.   
	/// - Parameter value: The value string.   
	public func setCustomValue(key:String, value:String?) 
	{
		linphone_ldap_params_set_custom_value(cPtr, key, value)
	}
}

/// Singleton class giving access to logging features. 
/// It supports custom domain, writing into a file as well as several verbosity
/// levels. The LinphoneLoggingServiceCbs listener allows you to be notified each
/// time a log is printed.
/// As the `LoggingService` is a singleton, use get() to get it. 
public class LoggingService : LinphoneObject
{
	var delegateManagers : [LoggingServiceDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> LoggingService {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<LoggingService>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = LoggingService(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Singleton class giving access to logging features. 
	/// It supports custom domain, writing into a file as well as several verbosity
	/// levels. The LinphoneLoggingServiceCbs listener allows you to be notified each
	/// time a log is printed.
	/// As the `LoggingService` is a singleton, use get() to get it. 
	public func addDelegate(delegate: LoggingServiceDelegate)
	{
		let manager = LoggingServiceDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_logging_service_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// Singleton class giving access to logging features. 
	/// It supports custom domain, writing into a file as well as several verbosity
	/// levels. The LinphoneLoggingServiceCbs listener allows you to be notified each
	/// time a log is printed.
	/// As the `LoggingService` is a singleton, use get() to get it. 
	public func removeDelegate(delegate: LoggingServiceDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_logging_service_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Gets the singleton logging service object. 
	/// The singleton is automatically instantiated if it hasn't been done yet.
	/// - Returns: A pointer on the `LoggingService` singleton.   
	static public var Instance: LoggingService
	{
			let cPointer = linphone_logging_service_get()
			let result = LoggingService.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the current callbacks being called while iterating on callbacks. 
	/// - Returns: A pointer to the current LinphoneLoggingServiceCbs object   
	public var currentDelegate: LoggingServiceDelegate?
	{
			let cObject = linphone_logging_service_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<LoggingServiceDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Get the domain where application logs are written (for example with message()). 
	/// - Returns: The domain where application logs are written.   
	public var domain: String
	{
		get
		{
			let cPointer = linphone_logging_service_get_domain(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_logging_service_set_domain(cPtr, newValue)
		}
	}

	/// Set the verbosity of the log. 
	/// For instance, a level of `Message` will let pass fatal, error, warning and
	/// message-typed messages whereas trace and debug messages will be dumped out. 
	/// - Parameter level: the `LogLevel` to set 
	public var logLevel: LogLevel?
	{
		willSet
		{
			linphone_logging_service_set_log_level(cPtr, LinphoneLogLevel(rawValue: CUnsignedInt(newValue!.rawValue)))
		}
	}

	/// Gets the log level mask. 
	/// - Returns: the log level mask 
	public var logLevelMask: UInt
	{
		get
		{
			return UInt(linphone_logging_service_get_log_level_mask(cPtr))
		}
		set
		{
			linphone_logging_service_set_log_level_mask(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Write a LinphoneLogLevelDebug message to the logs. 
	/// - Parameter message: The log message.   
	public func debug(message:String) 
	{
		linphone_logging_service_debug(cPtr, message)
	}

	/// Write a LinphoneLogLevelError message to the logs. 
	/// - Parameter message: The log message.   
	public func error(message:String) 
	{
		linphone_logging_service_error(cPtr, message)
	}

	/// Write a LinphoneLogLevelFatal message to the logs. 
	/// - Parameter message: The log message.   
	public func fatal(message:String) 
	{
		linphone_logging_service_fatal(cPtr, message)
	}

	/// Write a LinphoneLogLevelMessage message to the logs. 
	/// - Parameter message: The log message.   
	public func message(message:String) 
	{
		linphone_logging_service_message(cPtr, message)
	}

	/// Enables logging in a file. 
	/// That function enables an internal log handler that writes log messages in
	/// log-rotated files.
	/// - Parameter dir: Directory where to create the distinct parts of the log.   
	/// - Parameter filename: Name of the log file.   
	/// - Parameter maxSize: The maximal size of each part of the log. The log rotating
	/// is triggered each time the currently opened log part reach that limit. 
	public func setLogFile(dir:String, filename:String, maxSize:Int) 
	{
		linphone_logging_service_set_log_file(cPtr, dir, filename, maxSize)
	}

	/// Write a LinphoneLogLevelTrace message to the logs. 
	/// - Parameter message: The log message.   
	public func trace(message:String) 
	{
		linphone_logging_service_trace(cPtr, message)
	}

	/// Write a LinphoneLogLevelWarning message to the logs. 
	/// - Parameter message: The log message.   
	public func warning(message:String) 
	{
		linphone_logging_service_warning(cPtr, message)
	}
}

/// A `MagicSearch` is used to do specifics searchs. 
public class MagicSearch : LinphoneObject
{
	var delegateManagers : [MagicSearchDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> MagicSearch {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<MagicSearch>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = MagicSearch(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// A `MagicSearch` is used to do specifics searchs. 
	public func addDelegate(delegate: MagicSearchDelegate)
	{
		let manager = MagicSearchDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_magic_search_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// A `MagicSearch` is used to do specifics searchs. 
	public func removeDelegate(delegate: MagicSearchDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_magic_search_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Gets the current LinphoneMagicSearchCbs. 
	/// This is meant only to be called from a callback to be able to get the user_data
	/// associated with the LinphoneMagicSearchCbs that is calling the callback. 
	/// - Returns: The LinphoneMagicSearchCbs that has called the last callback.   
	public var currentDelegate: MagicSearchDelegate?
	{
			let cObject = linphone_magic_search_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<MagicSearchDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Get the delimiter used for the search. 
	/// - Returns: the delimiter used to find matched filter word   
	public var delimiter: String
	{
		get
		{
			let cPointer = linphone_magic_search_get_delimiter(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_magic_search_set_delimiter(cPtr, newValue)
		}
	}

	/// - Returns: sorted list of      
	public var lastSearch: [SearchResult]
	{
			var swiftList = [SearchResult]()
			let cList = linphone_magic_search_get_last_search(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(SearchResult.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Return whether or not the search is limited. 
	/// - Returns: true if the search is limited, false otherwise 
	public var limitedSearch: Bool
	{
		get
		{
			return linphone_magic_search_get_limited_search(cPtr) != 0
		}
		set
		{
			linphone_magic_search_set_limited_search(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the maximum value used to calculate the weight in search. 
	/// - Returns: the maximum value used to calculate the weight in search 
	public var maxWeight: UInt
	{
		get
		{
			return UInt(linphone_magic_search_get_max_weight(cPtr))
		}
		set
		{
			linphone_magic_search_set_max_weight(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Get the minimum value used to calculate the weight in search. 
	/// - Returns: the minimum value used to calculate the weight in search 
	public var minWeight: UInt
	{
		get
		{
			return UInt(linphone_magic_search_get_min_weight(cPtr))
		}
		set
		{
			linphone_magic_search_set_min_weight(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Get the number of maximum search result the search will return. 
	/// - Returns: the number of the maximum `SearchResult` which will be returned 
	public var searchLimit: UInt
	{
		get
		{
			return UInt(linphone_magic_search_get_search_limit(cPtr))
		}
		set
		{
			linphone_magic_search_set_search_limit(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Returns whether the delimiter is being used for the search. 
	/// - Returns: if the delimiter search is used 
	public var useDelimiter: Bool
	{
		get
		{
			return linphone_magic_search_get_use_delimiter(cPtr) != 0
		}
		set
		{
			linphone_magic_search_set_use_delimiter(cPtr, newValue==true ? 1:0)
		}
	}

	/// Create a sorted list of SearchResult from SipUri, Contact name, Contact
	/// displayname, Contact phone number, which match with a filter word The last item
	/// list will be an address formed with "filter" if a proxy config exist During the
	/// first search, a cache is created and used for the next search Use
	/// resetSearchCache() to begin a new search. 
	/// - Parameter filter: word we search   
	/// - Parameter domain: domain which we want to search only  
	/// - Returns: sorted list of      
	/// - deprecated: 22/03/2022 Use getContacts() instead. 
	@available(*, deprecated)
	public func getContactListFromFilter(filter:String?, domain:String?) -> [SearchResult]
	{
		var swiftList = [SearchResult]()
		let cList = linphone_magic_search_get_contact_list_from_filter(cPtr, filter, domain)
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(SearchResult.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Create a sorted list of SearchResult asynchronous from SipUri, Contact name,
	/// Contact displayname, Contact phone number, which match with a filter word The
	/// last item list will be an address formed with "filter" if a proxy config exist
	/// During the first search, a cache is created and used for the next search Use
	/// resetSearchCache() to begin a new search. 
	/// - Parameter filter: word we search   
	/// - Parameter domain: domain which we want to search only   nil or "" for
	/// searching in all contact "*" for searching in contact with sip SipUri
	/// "yourdomain" for searching in contact from "yourdomain" domain 
	/// - deprecated: 22/03/2022 Use getContactsAsync() instead. 
	@available(*, deprecated)
	public func getContactListFromFilterAsync(filter:String?, domain:String?) 
	{
		linphone_magic_search_get_contact_list_from_filter_async(cPtr, filter, domain)
	}

	/// Create a sorted list of SearchResult which match with a filter word, from
	/// SipUri in this order : Contact's display name, address username, address domain
	/// and phone number. 
	/// The last item list will be an address formed with "filter" if a proxy config
	/// exist and requested in sourceFlags During the first search, a cache is created
	/// and used for the next search Use resetSearchCache() to begin a new search 
	/// - Parameter filter: word we search   
	/// - Parameter domain: domain which we want to search only  
	/// - Parameter sourceFlags: Flags that specify where to search :
	/// `MagicSearchSource` 
	/// - Returns: sorted list of      
	/// - deprecated: 08/04/2022 Use getContactsList() instead. 
	@available(*, deprecated)
	public func getContacts(filter:String?, domain:String?, sourceFlags:Int) -> [SearchResult]
	{
		var swiftList = [SearchResult]()
		let cList = linphone_magic_search_get_contacts(cPtr, filter, domain, CInt(sourceFlags))
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(SearchResult.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// This is the asynchronous version of getContacts(). 
	/// Create a sorted list of SearchResult which match with a filter word, from
	/// SipUri in this order : Contact's display name, address username, address domain
	/// and phone number. The last item list will be an address formed with "filter" if
	/// a proxy config exist and requested in sourceFlags During the first search, a
	/// cache is created and used for the next search Use resetSearchCache() to begin a
	/// new search 
	/// - Parameter filter: word we search   
	/// - Parameter domain: domain which we want to search only  
	/// - Parameter sourceFlags: Flags that specify where to search :
	/// `MagicSearchSource` 
	/// - deprecated: 08/04/2022 Use getContactsListAsync() instead. 
	@available(*, deprecated)
	public func getContactsAsync(filter:String?, domain:String?, sourceFlags:Int) 
	{
		linphone_magic_search_get_contacts_async(cPtr, filter, domain, CInt(sourceFlags))
	}

	/// Create a sorted list of SearchResult which match with a filter word, from
	/// SipUri in this order : Contact's display name, address username, address domain
	/// and phone number. 
	/// The last item list will be an address formed with "filter" if a proxy config
	/// exist and requested in sourceFlags During the first search, a cache is created
	/// and used for the next search Use resetSearchCache() to begin a new search 
	/// - Parameter filter: word we search   
	/// - Parameter domain: domain which we want to search only  
	/// - Parameter sourceFlags: Flags that specify where to search :
	/// `MagicSearchSource` 
	/// - Parameter aggregation: a `MagicSearchAggregation` mode to indicate how to
	/// merge results 
	/// - Returns: sorted list of      
	public func getContactsList(filter:String?, domain:String?, sourceFlags:Int, aggregation:MagicSearchAggregation) -> [SearchResult]
	{
		var swiftList = [SearchResult]()
		let cList = linphone_magic_search_get_contacts_list(cPtr, filter, domain, CInt(sourceFlags), LinphoneMagicSearchAggregation(rawValue: CUnsignedInt(aggregation.rawValue)))
		var listTemp = cList
		while (listTemp != nil) {
			let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
			swiftList.append(SearchResult.getSwiftObject(cObject: data))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// This is the asynchronous version of getContacts(). 
	/// Create a sorted list of SearchResult which match with a filter word, from
	/// SipUri in this order : Contact's display name, address username, address domain
	/// and phone number. The last item list will be an address formed with "filter" if
	/// a proxy config exist and requested in sourceFlags During the first search, a
	/// cache is created and used for the next search Use resetSearchCache() to begin a
	/// new search 
	/// - Parameter filter: word we search   
	/// - Parameter domain: domain which we want to search only  
	/// - Parameter sourceFlags: Flags that specify where to search :
	/// `MagicSearchSource` 
	/// - Parameter aggregation: a `MagicSearchAggregation` mode to indicate how to
	/// merge results 
	public func getContactsListAsync(filter:String?, domain:String?, sourceFlags:Int, aggregation:MagicSearchAggregation) 
	{
		linphone_magic_search_get_contacts_list_async(cPtr, filter, domain, CInt(sourceFlags), LinphoneMagicSearchAggregation(rawValue: CUnsignedInt(aggregation.rawValue)))
	}

	/// Reset the cache to begin a new search. 
	public func resetSearchCache() 
	{
		linphone_magic_search_reset_search_cache(cPtr)
	}
}

/// Policy to use to pass through NATs/firewalls. 
public class NatPolicy : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> NatPolicy {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<NatPolicy>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = NatPolicy(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Returns the `Core` object managing this nat policy, if any. 
	/// - Returns: the `Core` object associated.   
	public var core: Core?
	{
			let cPointer = linphone_nat_policy_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Core.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Tell whether ICE is enabled. 
	/// - Returns: Boolean value telling whether ICE is enabled. 
	public var iceEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_ice_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_ice(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether STUN is enabled. 
	/// - Returns: Boolean value telling whether STUN is enabled. 
	public var stunEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_stun_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_stun(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the STUN/TURN server to use with this NAT policy. 
	/// Used when STUN or TURN are enabled. 
	/// - Returns: The STUN server used by this NAT policy.   
	public var stunServer: String
	{
		get
		{
			let cPointer = linphone_nat_policy_get_stun_server(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_nat_policy_set_stun_server(cPtr, newValue)
		}
	}

	/// Get the username used to authenticate with the STUN/TURN server. 
	/// The authentication will search for a `AuthInfo` with this username. If it is
	/// not set the username of the currently used `ProxyConfig` is used to search for
	/// a LinphoneAuthInfo. 
	/// - Returns: The username used to authenticate with the STUN/TURN server.   
	public var stunServerUsername: String
	{
		get
		{
			let cPointer = linphone_nat_policy_get_stun_server_username(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_nat_policy_set_stun_server_username(cPtr, newValue)
		}
	}

	/// Tells whether TCP TURN transport is enabled. 
	/// Used when TURN is enabled. 
	/// - Returns: Boolean value telling whether TCP TURN transport is enabled. 
	public var tcpTurnTransportEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_tcp_turn_transport_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_tcp_turn_transport(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether TLS TURN transport is enabled. 
	/// Used when TURN is enabled. 
	/// - Returns: Boolean value telling whether TLS TURN transport is enabled. 
	public var tlsTurnTransportEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_tls_turn_transport_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_tls_turn_transport(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether TURN is enabled. 
	/// - Returns: Boolean value telling whether TURN is enabled. 
	public var turnEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_turn_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_turn(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tells whether UDP TURN transport is enabled. 
	/// Used when TURN is enabled. 
	/// - Returns: Boolean value telling whether UDP TURN transport is enabled. 
	public var udpTurnTransportEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_udp_turn_transport_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_udp_turn_transport(cPtr, newValue==true ? 1:0)
		}
	}

	/// Tell whether uPnP is enabled. 
	/// - Returns: Boolean value telling whether uPnP is enabled. 
	public var upnpEnabled: Bool
	{
		get
		{
			return linphone_nat_policy_upnp_enabled(cPtr) != 0
		}
		set
		{
			linphone_nat_policy_enable_upnp(cPtr, newValue==true ? 1:0)
		}
	}

	/// Retrieve the user pointer associated with the `NatPolicy` object. 
	/// - Returns: The user pointer associated with the `NatPolicy` object.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_nat_policy_get_user_data(cPtr)
		}
		set
		{
			linphone_nat_policy_set_user_data(cPtr, newValue)
		}
	}

	/// Clear a NAT policy (deactivate all protocols and unset the STUN server). 
	public func clear() 
	{
		linphone_nat_policy_clear(cPtr)
	}

	/// Clone a `NatPolicy` object. 
	/// - Returns: a new `NatPolicy` object.   
	public func clone() -> NatPolicy?
	{
		let cPointer = linphone_nat_policy_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = NatPolicy.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Start a STUN server DNS resolution. 
	public func resolveStunServer() 
	{
		linphone_nat_policy_resolve_stun_server(cPtr)
	}
}

/// Identifies a member of a `Conference` or `ChatRoom`. 
/// A participant is identified by it's SIP address. It can have many
/// `ParticipantDevice`. 
public class Participant : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Participant {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Participant>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Participant(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get the address of a conference participant. 
	/// - Returns: The `Address` of the participant   
	public var address: Address?
	{
			let cPointer = linphone_participant_get_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the timestamp of the creation of the participant. 
	/// - Returns: time of creation of the participant as returned by time(nullptr).
	/// For UNIX based systems it is the number of seconds since 00:00hours of the 1st
	/// of January 1970 
	public var creationTime: time_t
	{
			return linphone_participant_get_creation_time(cPtr)
	}

	/// Gets the list of devices from a chat room's participant. 
	/// - Returns: List of devices.      
	public var devices: [ParticipantDevice]
	{
			var swiftList = [ParticipantDevice]()
			let cList = linphone_participant_get_devices(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(ParticipantDevice.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Tells whether a conference participant is an administrator of the conference. 
	/// - Returns: A boolean value telling whether the participant is an administrator 
	public var isAdmin: Bool
	{
			return linphone_participant_is_admin(cPtr) != 0
	}

	/// Tells whether a conference participant is the focus of the conference. 
	/// - Returns: A boolean value telling whether the participant is a focus of a
	/// conference 
	public var isFocus: Bool
	{
			return linphone_participant_is_focus(cPtr) != 0
	}

	/// Get the security level of a participant. 
	/// - Returns: The `ChatRoomSecurityLevel` of the participant 
	public var securityLevel: ChatRoomSecurityLevel
	{
			return ChatRoomSecurityLevel(rawValue: Int(linphone_participant_get_security_level(cPtr).rawValue))!
	}

	/// Retrieve the user pointer associated with the conference participant. 
	/// - Returns: The user pointer associated with the participant.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_participant_get_user_data(cPtr)
		}
		set
		{
			linphone_participant_set_user_data(cPtr, newValue)
		}
	}

	/// Find a device in the list of devices from a chat room's participant. 
	/// - Parameter address: A `Address` object   
	/// - Returns: a `ParticipantDevice` or nil if not found.   
	public func findDevice(address:Address) -> ParticipantDevice?
	{
		let cPointer = linphone_participant_find_device(cPtr, address.cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = ParticipantDevice.getSwiftObject(cObject: cPointer!)
		return result
	}
}

/// This object represents a unique device for a member of a `Conference` or
/// `ChatRoom`. 
/// Devices are identified by the gruu parameter inside the `Address` which can be
/// obtained by getAddress(). It is specially usefull to know the security level of
/// each device inside an end-to-end encrypted `ChatRoom`.
/// You can get a list of all `ParticipantDevice` using Participant.getDevices(). 
public class ParticipantDevice : LinphoneObject
{
	var delegateManagers : [ParticipantDeviceDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> ParticipantDevice {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ParticipantDevice>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ParticipantDevice(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// This object represents a unique device for a member of a `Conference` or
	/// `ChatRoom`. 
	/// Devices are identified by the gruu parameter inside the `Address` which can be
	/// obtained by getAddress(). It is specially usefull to know the security level of
	/// each device inside an end-to-end encrypted `ChatRoom`.
	/// You can get a list of all `ParticipantDevice` using Participant.getDevices(). 
	public func addDelegate(delegate: ParticipantDeviceDelegate)
	{
		let manager = ParticipantDeviceDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_participant_device_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// This object represents a unique device for a member of a `Conference` or
	/// `ChatRoom`. 
	/// Devices are identified by the gruu parameter inside the `Address` which can be
	/// obtained by getAddress(). It is specially usefull to know the security level of
	/// each device inside an end-to-end encrypted `ChatRoom`.
	/// You can get a list of all `ParticipantDevice` using Participant.getDevices(). 
	public func removeDelegate(delegate: ParticipantDeviceDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_participant_device_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Get the address of a participant's device. 
	/// - Returns: The `Address` of the participant's device   
	public var address: Address?
	{
			let cPointer = linphone_participant_device_get_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the audio direction of the device. 
	/// - Returns: the audio direction of the device 
	public var audioDirection: MediaDirection
	{
			return MediaDirection(rawValue: Int(linphone_participant_device_get_audio_direction(cPtr).rawValue))!
	}

	/// Gets the current LinphoneParticipantDeviceCbs. 
	/// - Returns: The LinphoneParticipantDeviceCbs that has called the last callback. 
	///  
	public var currentDelegate: ParticipantDeviceDelegate?
	{
			let cObject = linphone_participant_device_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<ParticipantDeviceDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Return whether the participant device is in a conference or not. 
	/// - Returns: a boolean to state whether the device is in a conference 
	public var isInConference: Bool
	{
			return linphone_participant_device_is_in_conference(cPtr) != 0
	}

	/// Return the name of the device or nil. 
	/// - Returns: the name of the device or nil.   
	public var name: String
	{
			let cPointer = linphone_participant_device_get_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the security level of a participant's device. 
	/// - Returns: The `ChatRoomSecurityLevel` of the device 
	public var securityLevel: ChatRoomSecurityLevel
	{
			return ChatRoomSecurityLevel(rawValue: Int(linphone_participant_device_get_security_level(cPtr).rawValue))!
	}

	/// Get the SSRC of the device. 
	/// - Returns: the SSRC of the device 
	public var ssrc: UInt32
	{
			return linphone_participant_device_get_ssrc(cPtr)
	}

	/// Get the text direction of the device. 
	/// - Returns: the text direction of the device 
	public var textDirection: MediaDirection
	{
			return MediaDirection(rawValue: Int(linphone_participant_device_get_text_direction(cPtr).rawValue))!
	}

	/// Get the timestamp the device joined a conference. 
	/// - Returns: time of joining a conference as returned by time(nullptr). For UNIX
	/// based systems it is the number of seconds since 00:00hours of the 1st of
	/// January 1970 
	public var timeOfJoining: time_t
	{
			return linphone_participant_device_get_time_of_joining(cPtr)
	}

	/// Retrieve the user pointer associated with the participant's device. 
	/// - Returns: The user pointer associated with the participant's device.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_participant_device_get_user_data(cPtr)
		}
		set
		{
			linphone_participant_device_set_user_data(cPtr, newValue)
		}
	}

	/// Get the video direction of the device. 
	/// - Returns: the video direction of the device 
	public var videoDirection: MediaDirection
	{
			return MediaDirection(rawValue: Int(linphone_participant_device_get_video_direction(cPtr).rawValue))!
	}
}

/// This object is only used on server side for `ChatRoom` with `FlexisipChat`
/// backend. 
public class ParticipantDeviceIdentity : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> ParticipantDeviceIdentity {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ParticipantDeviceIdentity>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ParticipantDeviceIdentity(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get the address of the participant device. 
	/// - Returns: the address.   
	public var address: Address?
	{
			let cPointer = linphone_participant_device_identity_get_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the capability descriptor (currently +org.linphone.specs value) for this
	/// participant device identity. 
	/// - Returns: the capability descriptor string. 
	public var capabilityDescriptor: String
	{
		get
		{
			let cPointer = linphone_participant_device_identity_get_capability_descriptor(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_participant_device_identity_set_capability_descriptor(cPtr, newValue)
		}
	}
}

/// This object represents the delivery/display state of a given chat message for a
/// given participant. 
/// It also contains a timestamp at which this participant state has changed.
/// Use ChatMessage.getParticipantsByImdnState() to get all `ParticipantImdnState`
/// for a given state. From there use getParticipant() to get the `Participant`
/// object if you need it. 
public class ParticipantImdnState : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> ParticipantImdnState {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ParticipantImdnState>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ParticipantImdnState(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get the participant concerned by a LinphoneParticipantImdnState. 
	/// - Returns: The `Participant` concerned by the LinphoneParticipantImdnState   
	public var participant: Participant?
	{
			let cPointer = linphone_participant_imdn_state_get_participant(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Participant.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the chat message state the participant is in. 
	/// - Returns: The `ChatMessage.State` the participant is in 
	public var state: ChatMessage.State
	{
			return ChatMessage.State(rawValue: Int(linphone_participant_imdn_state_get_state(cPtr).rawValue))!
	}

	/// Get the timestamp at which a participant has reached the state described by a
	/// LinphoneParticipantImdnState. 
	/// - Returns: The timestamp at which the participant has reached the state
	/// described in the LinphoneParticipantImdnState 
	public var stateChangeTime: time_t
	{
			return linphone_participant_imdn_state_get_state_change_time(cPtr)
	}

	/// Retrieve the user pointer associated with a LinphoneParticipantImdnState. 
	/// - Returns: The user pointer associated with the LinphoneParticipantImdnState.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_participant_imdn_state_get_user_data(cPtr)
		}
		set
		{
			linphone_participant_imdn_state_set_user_data(cPtr, newValue)
		}
	}
}

/// Object representing an RTP payload type. 
public class PayloadType : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> PayloadType {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PayloadType>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PayloadType(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get the number of channels. 
	/// - Returns: The number of channels. 
	public var channels: Int
	{
			return Int(linphone_payload_type_get_channels(cPtr))
	}

	/// Get the clock rate of a payload type. 
	/// - Returns: The clock rate in Hz. 
	public var clockRate: Int
	{
			return Int(linphone_payload_type_get_clock_rate(cPtr))
	}

	/// Return a string describing a payload type. 
	/// The format of the string is <mime_type>/<clock_rate>/<channels>. 
	/// - Returns: The description of the payload type. Must be release after use.     
	public var description: String
	{
			let cPointer = linphone_payload_type_get_description(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			if (cPointer != nil) {
				bctbx_free(cPointer)
			}
			return result
	}

	/// Get a description of the encoder used to provide a payload type. 
	/// - Returns: The description of the encoder. Can be nil if the payload type is
	/// not supported by Mediastreamer2.   
	public var encoderDescription: String
	{
			let cPointer = linphone_payload_type_get_encoder_description(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Check whether the payload is usable according the bandwidth targets set in the
	/// core. 
	/// - Returns: true if the payload type is usable. 
	public var isUsable: Bool
	{
			return linphone_payload_type_is_usable(cPtr) != 0
	}

	/// Tells whether the specified payload type represents a variable bitrate codec. 
	/// - Returns: true if the payload type represents a VBR codec, false instead. 
	public var isVbr: Bool
	{
			return linphone_payload_type_is_vbr(cPtr) != 0
	}

	/// Get the mime type. 
	/// - Returns: The mime type.   
	public var mimeType: String
	{
			let cPointer = linphone_payload_type_get_mime_type(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the normal bitrate in bits/s. 
	/// - Returns: The normal bitrate in bits/s or -1 if an error has occured. 
	public var normalBitrate: Int
	{
		get
		{
			return Int(linphone_payload_type_get_normal_bitrate(cPtr))
		}
		set
		{
			linphone_payload_type_set_normal_bitrate(cPtr, CInt(newValue))
		}
	}

	/// Returns the payload type number assigned for this codec. 
	/// - Returns: The number of the payload type. 
	public var number: Int
	{
		get
		{
			return Int(linphone_payload_type_get_number(cPtr))
		}
		set
		{
			linphone_payload_type_set_number(cPtr, CInt(newValue))
		}
	}

	/// Get the format parameters for incoming streams. 
	/// - Returns: The format parameters as string.   
	public var recvFmtp: String
	{
		get
		{
			let cPointer = linphone_payload_type_get_recv_fmtp(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_payload_type_set_recv_fmtp(cPtr, newValue)
		}
	}

	/// Get the format parameters for outgoing streams. 
	/// - Returns: The format parameters as string.   
	public var sendFmtp: String
	{
		get
		{
			let cPointer = linphone_payload_type_get_send_fmtp(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_payload_type_set_send_fmtp(cPtr, newValue)
		}
	}

	/// Get the type of a payload type. 
	/// - Returns: The type of the payload e.g. PAYLOAD_AUDIO_CONTINUOUS or
	/// PAYLOAD_VIDEO. 
	public var type: Int
	{
			return Int(linphone_payload_type_get_type(cPtr))
	}

	/// Instantiates a new payload type with values from source. 
	/// - Returns: The newly created `PayloadType` object.   
	public func clone() -> PayloadType?
	{
		let cPointer = linphone_payload_type_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = PayloadType.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Enable/disable a payload type. 
	/// - Parameter enabled: Set true for enabling and false for disabling. 
	/// - Returns: 0 for success, -1 for failure. 
	public func enable(enabled:Bool) -> Int
	{
		return Int(linphone_payload_type_enable(cPtr, enabled==true ? 1:0))
	}

	/// Check whether a palyoad type is enabled. 
	/// - Returns: true if enabled, false if disabled. 
	public func enabled() -> Bool
	{
		return linphone_payload_type_enabled(cPtr) != 0
	}
}

/// Player interface. 
public class Player : LinphoneObject
{
	var delegateManagers : [PlayerDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> Player {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Player>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Player(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///The state of a `Player`. 
	public enum State:Int
	{
		/// No file is opened for playing. 
		case Closed = 0
		/// The player is paused. 
		case Paused = 1
		/// The player is playing. 
		case Playing = 2
	}

	/// Player interface. 
	public func addDelegate(delegate: PlayerDelegate)
	{
		let manager = PlayerDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_player_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// Player interface. 
	public func removeDelegate(delegate: PlayerDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_player_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Returns the `Core` object managing this player's call, if any. 
	/// - Returns: the `Core` object associated   
	public var core: Core?
	{
			let cPointer = linphone_player_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Core.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the current LinphonePlayerCbsCbs object. 
	/// - Returns: The current LinphonePlayerCbs object   
	public var currentDelegate: PlayerDelegate?
	{
			let cObject = linphone_player_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<PlayerDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Get the current position in the opened file. 
	/// - Returns: The current position in the opened file 
	public var currentPosition: Int
	{
			return Int(linphone_player_get_current_position(cPtr))
	}

	/// Get the duration of the opened file. 
	/// - Returns: The duration of the opened file 
	public var duration: Int
	{
			return Int(linphone_player_get_duration(cPtr))
	}

	/// Returns whether the file has video and if it can be displayed. 
	/// - Returns: true if file has video and it can be displayed, false otherwise 
	public var isVideoAvailable: Bool
	{
			return linphone_player_get_is_video_available(cPtr) != 0
	}

	/// Get the current state of a player. 
	/// - Returns: The current `State` of the player. 
	public var state: Player.State
	{
			return Player.State(rawValue: Int(linphone_player_get_state(cPtr).rawValue))!
	}

	/// Retrieve the user pointer associated with the player. 
	/// - Returns: The user pointer associated with the player.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_player_get_user_data(cPtr)
		}
		set
		{
			linphone_player_set_user_data(cPtr, newValue)
		}
	}

	/// Get the volume gain of the player. 
	/// - Returns: Percentage of the gain. Valid values are in [ 0.0 : 1.0 ]. 
	public var volumeGain: Float
	{
		get
		{
			return linphone_player_get_volume_gain(cPtr)
		}
		set
		{
			linphone_player_set_volume_gain(cPtr, newValue)
		}
	}

	/// Sets a window id to be used to display video if any. 
	/// - Parameter windowId: The window id pointer to use.   
	public var windowId: UnsafeMutableRawPointer?
	{
		willSet
		{
			linphone_player_set_window_id(cPtr, newValue)
		}
	}

	/// Close the opened file. 
	public func close() 
	{
		linphone_player_close(cPtr)
	}

	/// Open a file for playing. 
	/// - Parameter filename: The path to the file to open   
	public func open(filename:String) throws 
	{
		let exception_result = linphone_player_open(cPtr, filename)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "open returned value \(exception_result)")
		}
	}

	/// Pause the playing of a file. 
	/// - Returns: 0 on success, a negative value otherwise 
	public func pause() throws 
	{
		let exception_result = linphone_player_pause(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "pause returned value \(exception_result)")
		}
	}

	/// Seek in an opened file. 
	/// - Parameter timeMs: The time we want to go to in the file (in milliseconds). 
	/// - Returns: 0 on success, a negative value otherwise. 
	public func seek(timeMs:Int) throws 
	{
		let exception_result = linphone_player_seek(cPtr, CInt(timeMs))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "seek returned value \(exception_result)")
		}
	}

	/// Start playing a file that has been opened with open(). 
	/// - Returns: 0 on success, a negative value otherwise 
	public func start() throws 
	{
		let exception_result = linphone_player_start(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "start returned value \(exception_result)")
		}
	}
}

/// Presence activity type holding information about a presence activity. 
public class PresenceActivity : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> PresenceActivity {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PresenceActivity>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PresenceActivity(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the description of a presence activity. 
	/// - Returns: A pointer to the description string of the presence activity, or nil
	/// if no description is specified.   
	public var description: String
	{
			let cPointer = linphone_presence_activity_get_description(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setDescription(newValue: String) throws
	{
		let exception_result = linphone_presence_activity_set_description(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the activity type of a presence activity. 
	/// - Returns: The `PresenceActivityType` of the activity. 
	public var type: PresenceActivityType
	{
			return PresenceActivityType(rawValue: Int(linphone_presence_activity_get_type(cPtr).rawValue))!
	}

	public func setType(newValue: PresenceActivityType) throws
	{
		let exception_result = linphone_presence_activity_set_type(cPtr, LinphonePresenceActivityType(rawValue: CUnsignedInt(newValue.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the user data of a `PresenceActivity` object. 
	/// - Returns: A pointer to the user data.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_presence_activity_get_user_data(cPtr)
		}
		set
		{
			linphone_presence_activity_set_user_data(cPtr, newValue)
		}
	}

	/// Gets the string representation of a presence activity. 
	/// - Returns: A pointer a dynamically allocated string representing the given
	/// activity.    
	/// The returned string is to be freed by calling ms_free(). 
	public func toString() -> String
	{
		let cstr = linphone_presence_activity_to_string(cPtr)
		let result = charArrayToString(charPointer: cstr)
		if (cstr != nil) {
			bctbx_free(cstr)
		}
		return result
	}
}

/// Presence model type holding information about the presence of a person. 
public class PresenceModel : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> PresenceModel {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PresenceModel>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PresenceModel(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Creates a presence model specifying an activity. 
	/// - Parameter activity: The `PresenceActivityType` to set for the created
	/// presence model. 
	/// - Parameter description: An additional description of the activity (mainly
	/// useful for the 'other' activity). Set it to nil to not add a description.   
	/// - Returns: The created `PresenceModel`, or nil if an error occured.   
	/// - See also: linphone_presence_model_new, newWithActivityAndNote()
	/// The created presence model has the activity specified in the parameters. 
	static public func newWithActivity(activity:PresenceActivityType, description:String?) -> PresenceModel?
	{
		let cPointer = linphone_presence_model_new_with_activity(LinphonePresenceActivityType(rawValue: CUnsignedInt(activity.rawValue)), description)
		if (cPointer == nil) {
			return nil
		}
		let result = PresenceModel.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Creates a presence model specifying an activity and adding a note. 
	/// - Parameter activity: The `PresenceActivityType` to set for the created
	/// presence model. 
	/// - Parameter description: An additional description of the activity (mainly
	/// useful for the 'other' activity). Set it to nil to not add a description.   
	/// - Parameter note: An additional note giving additional information about the
	/// contact presence.   
	/// - Parameter lang: The language the note is written in. It can be set to nil in
	/// order to not specify the language of the note.   
	/// - Returns: The created `PresenceModel`, or nil if an error occured.   
	/// - See also: newWithActivity(), newWithActivityAndNote()
	/// The created presence model has the activity and the note specified in the
	/// parameters. 
	static public func newWithActivityAndNote(activity:PresenceActivityType, description:String?, note:String, lang:String?) -> PresenceModel?
	{
		let cPointer = linphone_presence_model_new_with_activity_and_note(LinphonePresenceActivityType(rawValue: CUnsignedInt(activity.rawValue)), description, note, lang)
		if (cPointer == nil) {
			return nil
		}
		let result = PresenceModel.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Gets the first activity of a presence model (there is usually only one). 
	/// - Returns: A `PresenceActivity` object if successful, nil otherwise.     
	public var activity: PresenceActivity?
	{
			let cPointer = linphone_presence_model_get_activity(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = PresenceActivity.getSwiftObject(cObject:cPointer!)
			belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
			return result
	}

	/// Gets the basic status of a presence model. 
	/// - Returns: The `PresenceBasicStatus` of the `PresenceModel` object given as
	/// parameter. 
	public var basicStatus: PresenceBasicStatus
	{
			return PresenceBasicStatus(rawValue: Int(linphone_presence_model_get_basic_status(cPtr).rawValue))!
	}

	public func setBasicstatus(newValue: PresenceBasicStatus) throws
	{
		let exception_result = linphone_presence_model_set_basic_status(cPtr, LinphonePresenceBasicStatus(rawValue: CUnsignedInt(newValue.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the capabilities of a `PresenceModel` object. 
	/// - Returns: the capabilities. 
	public var capabilities: Int
	{
			return Int(linphone_presence_model_get_capabilities(cPtr))
	}

	/// Get the consolidated presence from a presence model. 
	/// - Returns: The `ConsolidatedPresence` corresponding to the presence model 
	public var consolidatedPresence: ConsolidatedPresence
	{
			return ConsolidatedPresence(rawValue: Int(linphone_presence_model_get_consolidated_presence(cPtr).rawValue))!
	}

	/// Gets the contact of a presence model. 
	/// - Returns: A pointer to a dynamically allocated string containing the contact,
	/// or nil if no contact is found.    
	/// The returned string is to be freed by calling ms_free(). 
	public var contact: String
	{
			let cPointer = linphone_presence_model_get_contact(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			if (cPointer != nil) {
				bctbx_free(cPointer)
			}
			return result
	}

	public func setContact(newValue: String) throws
	{
		let exception_result = linphone_presence_model_set_contact(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Tells whether a presence model is considered online. 
	/// It is any of theses cases:
	public var isOnline: Bool
	{
			return linphone_presence_model_is_online(cPtr) != 0
	}

	/// Gets the number of activities included in the presence model. 
	/// - Returns: The number of activities included in the `PresenceModel` object. 
	public var nbActivities: UInt
	{
			return UInt(linphone_presence_model_get_nb_activities(cPtr))
	}

	/// Gets the number of persons included in the presence model. 
	/// - Returns: The number of persons included in the `PresenceModel` object. 
	public var nbPersons: UInt
	{
			return UInt(linphone_presence_model_get_nb_persons(cPtr))
	}

	/// Gets the number of services included in the presence model. 
	/// - Returns: The number of services included in the `PresenceModel` object. 
	public var nbServices: UInt
	{
			return UInt(linphone_presence_model_get_nb_services(cPtr))
	}

	/// Gets the presentity of a presence model. 
	/// - Returns: A pointer to a const `Address`, or nil if no contact is found.   
	public var presentity: Address?
	{
			let cPointer = linphone_presence_model_get_presentity(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	public func setPresentity(newValue: Address) throws
	{
		let exception_result = linphone_presence_model_set_presentity(cPtr, newValue.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the timestamp of a presence model. 
	/// - Returns: The timestamp of the `PresenceModel` object or -1 on error. 
	public var timestamp: time_t
	{
			return linphone_presence_model_get_timestamp(cPtr)
	}

	/// Gets the user data of a `PresenceModel` object. 
	/// - Returns: A pointer to the user data.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_presence_model_get_user_data(cPtr)
		}
		set
		{
			linphone_presence_model_set_user_data(cPtr, newValue)
		}
	}

	/// Adds an activity to a presence model. 
	/// - Parameter activity: The `PresenceActivity` object to add to the model.   
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addActivity(activity:PresenceActivity) throws 
	{
		let exception_result = linphone_presence_model_add_activity(cPtr, activity.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addActivity returned value \(exception_result)")
		}
	}

	/// Adds a note to a presence model. 
	/// - Parameter noteContent: The note to be added to the presence model.   
	/// - Parameter lang: The language of the note to be added. Can be nil if no
	/// language is to be specified for the note.   
	/// - Returns: 0 if successful, a value < 0 in case of error.
	/// Only one note for each language can be set, so e.g. setting a note for the 'fr'
	/// language if there is only one will replace the existing one. 
	public func addNote(noteContent:String, lang:String?) throws 
	{
		let exception_result = linphone_presence_model_add_note(cPtr, noteContent, lang)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addNote returned value \(exception_result)")
		}
	}

	/// Adds a person to a presence model. 
	/// - Parameter person: The `PresencePerson` object to add to the model.   
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addPerson(person:PresencePerson) throws 
	{
		let exception_result = linphone_presence_model_add_person(cPtr, person.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addPerson returned value \(exception_result)")
		}
	}

	/// Adds a service to a presence model. 
	/// - Parameter service: The `PresenceService` object to add to the model.   
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addService(service:PresenceService) throws 
	{
		let exception_result = linphone_presence_model_add_service(cPtr, service.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addService returned value \(exception_result)")
		}
	}

	/// Clears the activities of a presence model. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearActivities() throws 
	{
		let exception_result = linphone_presence_model_clear_activities(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearActivities returned value \(exception_result)")
		}
	}

	/// Clears all the notes of a presence model. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearNotes() throws 
	{
		let exception_result = linphone_presence_model_clear_notes(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearNotes returned value \(exception_result)")
		}
	}

	/// Clears the persons of a presence model. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearPersons() throws 
	{
		let exception_result = linphone_presence_model_clear_persons(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearPersons returned value \(exception_result)")
		}
	}

	/// Clears the services of a presence model. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearServices() throws 
	{
		let exception_result = linphone_presence_model_clear_services(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearServices returned value \(exception_result)")
		}
	}

	/// Returns the version of the capability of a `PresenceModel`. 
	/// - Parameter capability: The `FriendCapability` to test. 
	/// - Returns: the version of the capability of a `PresenceModel` or -1.0 if the
	/// model has not the capability. 
	public func getCapabilityVersion(capability:FriendCapability) -> Float
	{
		return linphone_presence_model_get_capability_version(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue)))
	}

	/// Gets the first note of a presence model (there is usually only one). 
	/// - Parameter lang: The language of the note to get. Can be nil to get a note
	/// that has no language specified or to get the first note whatever language it is
	/// written into.   
	/// - Returns: A pointer to a `PresenceNote` object if successful, nil otherwise.   
	public func getNote(lang:String?) -> PresenceNote?
	{
		let cPointer = linphone_presence_model_get_note(cPtr, lang)
		if (cPointer == nil) {
			return nil
		}
		let result = PresenceNote.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Gets the nth activity of a presence model. 
	/// - Parameter index: The index of the activity to get (the first activity having
	/// the index 0). 
	/// - Returns: A pointer to a `PresenceActivity` object if successful, nil
	/// otherwise.     
	public func getNthActivity(index:UInt) -> PresenceActivity?
	{
		let cPointer = linphone_presence_model_get_nth_activity(cPtr, CUnsignedInt(index))
		if (cPointer == nil) {
			return nil
		}
		let result = PresenceActivity.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Gets the nth person of a presence model. 
	/// - Parameter index: The index of the person to get (the first person having the
	/// index 0). 
	/// - Returns: A pointer to a `PresencePerson` object if successful, nil otherwise.
	///   
	public func getNthPerson(index:UInt) -> PresencePerson?
	{
		let cPointer = linphone_presence_model_get_nth_person(cPtr, CUnsignedInt(index))
		if (cPointer == nil) {
			return nil
		}
		let result = PresencePerson.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Gets the nth service of a presence model. 
	/// - Parameter index: The index of the service to get (the first service having
	/// the index 0). 
	/// - Returns: A pointer to a `PresenceService` object if successful, nil
	/// otherwise.   
	public func getNthService(index:UInt) -> PresenceService?
	{
		let cPointer = linphone_presence_model_get_nth_service(cPtr, CUnsignedInt(index))
		if (cPointer == nil) {
			return nil
		}
		let result = PresenceService.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Returns whether or not the `PresenceModel` object has a given capability. 
	/// - Parameter capability: The capability to test. 
	/// - Returns: whether or not the `PresenceModel` object has a given capability. 
	public func hasCapability(capability:FriendCapability) -> Bool
	{
		return linphone_presence_model_has_capability(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue))) != 0
	}

	/// Returns whether or not the `PresenceModel` object has a given capability with a
	/// certain version. 
	/// - Parameter capability: The `FriendCapability` to test. 
	/// - Parameter version: The wanted version to test. 
	/// - Returns: whether or not the `PresenceModel` object has a given capability
	/// with a certain version. 
	public func hasCapabilityWithVersion(capability:FriendCapability, version:Float) -> Bool
	{
		return linphone_presence_model_has_capability_with_version(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue)), version) != 0
	}

	/// Returns whether or not the `PresenceModel` object has a given capability with a
	/// certain version or more. 
	/// - Parameter capability: The `FriendCapability` to test. 
	/// - Parameter version: The wanted version to test. 
	/// - Returns: whether or not the `PresenceModel` object has a given capability
	/// with a certain version or more. 
	public func hasCapabilityWithVersionOrMore(capability:FriendCapability, version:Float) -> Bool
	{
		return linphone_presence_model_has_capability_with_version_or_more(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue)), version) != 0
	}

	/// Sets the activity of a presence model (limits to only one activity). 
	/// - Parameter activity: The `PresenceActivityType` to set for the model. 
	/// - Parameter description: An additional description of the activity to set for
	/// the model. Can be nil if no additional description is to be added.   
	/// - Returns: 0 if successful, a value < 0 in case of error.
	/// WARNING: This function will modify the basic status of the model according to
	/// the activity being set. If you don't want the basic status to be modified
	/// automatically, you can use the combination of setBasicStatus(),
	/// clearActivities() and addActivity(). 
	public func setActivity(activity:PresenceActivityType, description:String?) throws 
	{
		let exception_result = linphone_presence_model_set_activity(cPtr, LinphonePresenceActivityType(rawValue: CUnsignedInt(activity.rawValue)), description)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "setActivity returned value \(exception_result)")
		}
	}
}

/// Presence note type holding information about a presence note. 
public class PresenceNote : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> PresenceNote {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PresenceNote>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PresenceNote(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the content of a presence note. 
	/// - Returns: A pointer to the content of the presence note.   
	public var content: String
	{
			let cPointer = linphone_presence_note_get_content(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setContent(newValue: String) throws
	{
		let exception_result = linphone_presence_note_set_content(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the language of a presence note. 
	/// - Returns: A pointer to the language string of the presence note, or nil if no
	/// language is specified.   
	public var lang: String
	{
			let cPointer = linphone_presence_note_get_lang(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setLang(newValue: String) throws
	{
		let exception_result = linphone_presence_note_set_lang(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the user data of a `PresenceNote` object. 
	/// - Returns: A pointer to the user data.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_presence_note_get_user_data(cPtr)
		}
		set
		{
			linphone_presence_note_set_user_data(cPtr, newValue)
		}
	}
}

/// Presence person holding information about a presence person. 
public class PresencePerson : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> PresencePerson {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PresencePerson>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PresencePerson(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the id of a presence person. 
	/// - Returns: A pointer to a dynamically allocated string containing the id, or
	/// nil in case of error.    
	/// The returned string is to be freed by calling ms_free(). 
	public var id: String
	{
			let cPointer = linphone_presence_person_get_id(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			if (cPointer != nil) {
				bctbx_free(cPointer)
			}
			return result
	}

	public func setId(newValue: String) throws
	{
		let exception_result = linphone_presence_person_set_id(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the number of activities included in the presence person. 
	/// - Returns: The number of activities included in the `PresencePerson` object. 
	public var nbActivities: UInt
	{
			return UInt(linphone_presence_person_get_nb_activities(cPtr))
	}

	/// Gets the number of activities notes included in the presence person. 
	/// - Returns: The number of activities notes included in the `PresencePerson`
	/// object. 
	public var nbActivitiesNotes: UInt
	{
			return UInt(linphone_presence_person_get_nb_activities_notes(cPtr))
	}

	/// Gets the number of notes included in the presence person. 
	/// - Returns: The number of notes included in the `PresencePerson` object. 
	public var nbNotes: UInt
	{
			return UInt(linphone_presence_person_get_nb_notes(cPtr))
	}

	/// Gets the user data of a `PresencePerson` object. 
	/// - Returns: A pointer to the user data.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_presence_person_get_user_data(cPtr)
		}
		set
		{
			linphone_presence_person_set_user_data(cPtr, newValue)
		}
	}

	/// Adds an activities note to a presence person. 
	/// - Parameter note: The `PresenceNote` object to add to the person.   
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addActivitiesNote(note:PresenceNote) throws 
	{
		let exception_result = linphone_presence_person_add_activities_note(cPtr, note.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addActivitiesNote returned value \(exception_result)")
		}
	}

	/// Adds an activity to a presence person. 
	/// - Parameter activity: The `PresenceActivity` object to add to the person.   
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addActivity(activity:PresenceActivity) throws 
	{
		let exception_result = linphone_presence_person_add_activity(cPtr, activity.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addActivity returned value \(exception_result)")
		}
	}

	/// Adds a note to a presence person. 
	/// - Parameter note: The `PresenceNote` object to add to the person.   
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addNote(note:PresenceNote) throws 
	{
		let exception_result = linphone_presence_person_add_note(cPtr, note.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addNote returned value \(exception_result)")
		}
	}

	/// Clears the activities of a presence person. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearActivities() throws 
	{
		let exception_result = linphone_presence_person_clear_activities(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearActivities returned value \(exception_result)")
		}
	}

	/// Clears the activities notes of a presence person. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearActivitiesNotes() throws 
	{
		let exception_result = linphone_presence_person_clear_activities_notes(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearActivitiesNotes returned value \(exception_result)")
		}
	}

	/// Clears the notes of a presence person. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearNotes() throws 
	{
		let exception_result = linphone_presence_person_clear_notes(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearNotes returned value \(exception_result)")
		}
	}

	/// Gets the nth activities note of a presence person. 
	/// - Parameter index: The index of the activities note to get (the first note
	/// having the index 0). 
	/// - Returns: A pointer to a `PresenceNote` object if successful, nil otherwise.   
	public func getNthActivitiesNote(index:UInt) -> PresenceNote?
	{
		let cPointer = linphone_presence_person_get_nth_activities_note(cPtr, CUnsignedInt(index))
		if (cPointer == nil) {
			return nil
		}
		let result = PresenceNote.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Gets the nth activity of a presence person. 
	/// - Parameter index: The index of the activity to get (the first activity having
	/// the index 0). 
	/// - Returns: A pointer to a `PresenceActivity` object if successful, nil
	/// otherwise.   
	public func getNthActivity(index:UInt) -> PresenceActivity?
	{
		let cPointer = linphone_presence_person_get_nth_activity(cPtr, CUnsignedInt(index))
		if (cPointer == nil) {
			return nil
		}
		let result = PresenceActivity.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Gets the nth note of a presence person. 
	/// - Parameter index: The index of the note to get (the first note having the
	/// index 0). 
	/// - Returns: A pointer to a `PresenceNote` object if successful, nil otherwise.   
	public func getNthNote(index:UInt) -> PresenceNote?
	{
		let cPointer = linphone_presence_person_get_nth_note(cPtr, CUnsignedInt(index))
		if (cPointer == nil) {
			return nil
		}
		let result = PresenceNote.getSwiftObject(cObject: cPointer!)
		return result
	}
}

/// Presence service type holding information about a presence service. 
public class PresenceService : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> PresenceService {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PresenceService>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PresenceService(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the basic status of a presence service. 
	/// - Returns: The `PresenceBasicStatus` of the `PresenceService` object given as
	/// parameter. 
	public var basicStatus: PresenceBasicStatus
	{
			return PresenceBasicStatus(rawValue: Int(linphone_presence_service_get_basic_status(cPtr).rawValue))!
	}

	public func setBasicstatus(newValue: PresenceBasicStatus) throws
	{
		let exception_result = linphone_presence_service_set_basic_status(cPtr, LinphonePresenceBasicStatus(rawValue: CUnsignedInt(newValue.rawValue)))
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the contact of a presence service. 
	/// - Returns: A pointer to a dynamically allocated string containing the contact,
	/// or nil if no contact is found.    
	/// The returned string is to be freed by calling ms_free(). 
	public var contact: String
	{
			let cPointer = linphone_presence_service_get_contact(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			if (cPointer != nil) {
				bctbx_free(cPointer)
			}
			return result
	}

	public func setContact(newValue: String) throws
	{
		let exception_result = linphone_presence_service_set_contact(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the id of a presence service. 
	/// - Returns: A pointer to a dynamically allocated string containing the id, or
	/// nil in case of error.    
	/// The returned string is to be freed by calling ms_free(). 
	public var id: String
	{
			let cPointer = linphone_presence_service_get_id(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			if (cPointer != nil) {
				bctbx_free(cPointer)
			}
			return result
	}

	public func setId(newValue: String) throws
	{
		let exception_result = linphone_presence_service_set_id(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the number of notes included in the presence service. 
	/// - Returns: The number of notes included in the `PresenceService` object. 
	public var nbNotes: UInt
	{
			return UInt(linphone_presence_service_get_nb_notes(cPtr))
	}

	/// Gets the service descriptions of a presence service. 
	/// - Returns: A  containing the services descriptions.  
	/// The returned string is to be freed. 
	public var serviceDescriptions: [String]
	{
			var swiftList = [String]()
			let cList = linphone_presence_service_get_service_descriptions(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp!.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	public func setServicedescriptions(newValue: [String]) throws
	{
		var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
		for data in newValue {
			let sData:NSString = data as NSString
			cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
		}
		let exception_result = linphone_presence_service_set_service_descriptions(cPtr, cList)
		bctbx_list_free(cList)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the user data of a `PresenceService` object. 
	/// - Returns: A pointer to the user data.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_presence_service_get_user_data(cPtr)
		}
		set
		{
			linphone_presence_service_set_user_data(cPtr, newValue)
		}
	}

	/// Adds a note to a presence service. 
	/// - Parameter note: The `PresenceNote` object to add to the service.   
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func addNote(note:PresenceNote) throws 
	{
		let exception_result = linphone_presence_service_add_note(cPtr, note.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "addNote returned value \(exception_result)")
		}
	}

	/// Clears the notes of a presence service. 
	/// - Returns: 0 if successful, a value < 0 in case of error. 
	public func clearNotes() throws 
	{
		let exception_result = linphone_presence_service_clear_notes(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "clearNotes returned value \(exception_result)")
		}
	}

	/// Gets the nth note of a presence service. 
	/// - Parameter index: The index of the note to get (the first note having the
	/// index 0). 
	/// - Returns: A pointer to a `PresenceNote` object if successful, nil otherwise.   
	public func getNthNote(index:UInt) -> PresenceNote?
	{
		let cPointer = linphone_presence_service_get_nth_note(cPtr, CUnsignedInt(index))
		if (cPointer == nil) {
			return nil
		}
		let result = PresenceNote.getSwiftObject(cObject: cPointer!)
		return result
	}
}

/// Represents an account configuration to be used by `Core`. 
/// In addition to the `AuthInfo` that stores the credentials, you need to
/// configure a `ProxyConfig` as well to be able to connect to a proxy server.
/// A minimal proxy config consists of an identity address
/// (sip:username@domain.tld) and the proxy server address, - See also:
/// setServerAddr().
/// If any, it will be stored inside the default configuration file, so it will
/// survive the destruction of the `Core` and be available at the next start.
/// The account set with Core.setDefaultProxyConfig() will be used as default for
/// outgoing calls & chat messages unless specified otherwise.
/// - deprecated: 06/04/2020 Use `Account` object instead 
public class ProxyConfig : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> ProxyConfig {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<ProxyConfig>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = ProxyConfig(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Indicates whether AVPF/SAVPF is being used for calls using this proxy config. 
	/// - Returns: True if AVPF/SAVPF is enabled, false otherwise. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var avpfEnabled: Bool
	{
			return linphone_proxy_config_avpf_enabled(cPtr) != 0
	}

	/// Get enablement status of RTCP feedback (also known as AVPF profile). 
	/// - Returns: the enablement mode, which can be `Default` (use LinphoneCore's
	/// mode), `Enabled` (avpf is enabled), or `Disabled` (disabled). 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var avpfMode: AVPFMode
	{
		get
		{
			return AVPFMode(rawValue: Int(linphone_proxy_config_get_avpf_mode(cPtr).rawValue))!
		}
		set
		{
			linphone_proxy_config_set_avpf_mode(cPtr, LinphoneAVPFMode(rawValue: CInt(newValue.rawValue)))
		}
	}

	/// Get the interval between regular RTCP reports when using AVPF/SAVPF. 
	/// - Returns: The interval in seconds. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var avpfRrInterval: UInt8
	{
		get
		{
			return linphone_proxy_config_get_avpf_rr_interval(cPtr)
		}
		set
		{
			linphone_proxy_config_set_avpf_rr_interval(cPtr, newValue)
		}
	}

	/// Get the conference factory uri. 
	/// - Returns: The uri of the conference factory.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var conferenceFactoryUri: String
	{
		get
		{
			let cPointer = linphone_proxy_config_get_conference_factory_uri(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_proxy_config_set_conference_factory_uri(cPtr, newValue)
		}
	}

	/// Return the contact address of the proxy config. 
	/// - Returns: a `Address` correspong to the contact address of the proxy config.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var contact: Address?
	{
			let cPointer = linphone_proxy_config_get_contact(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the contact parameters. 
	/// - Returns: previously set contact parameters.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var contactParameters: String
	{
		get
		{
			let cPointer = linphone_proxy_config_get_contact_parameters(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_proxy_config_set_contact_parameters(cPtr, newValue)
		}
	}

	/// Returns the contact URI parameters. 
	/// - Returns: previously set contact URI parameters.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var contactUriParameters: String
	{
		get
		{
			let cPointer = linphone_proxy_config_get_contact_uri_parameters(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_proxy_config_set_contact_uri_parameters(cPtr, newValue)
		}
	}

	/// Get the `Core` object to which is associated the `ProxyConfig`. 
	/// - Returns: The `Core` object to which is associated the `ProxyConfig`.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var core: Core?
	{
			let cPointer = linphone_proxy_config_get_core(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Core.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Get the dependency of a `ProxyConfig`. 
	/// - Returns: The proxy config this one is dependent upon, or nil if not marked
	/// dependent.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var dependency: ProxyConfig?
	{
		get
		{
			let cPointer = linphone_proxy_config_get_dependency(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ProxyConfig.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_proxy_config_set_dependency(cPtr, newValue?.cPtr)
		}
	}

	/// Returns whether or not the + should be replaced by 00. 
	/// - Returns: whether liblinphone should replace "+" by "00" in dialed numbers
	/// (passed to Core.invite()). 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var dialEscapePlus: Bool
	{
		get
		{
			return linphone_proxy_config_get_dial_escape_plus(cPtr) != 0
		}
		set
		{
			linphone_proxy_config_set_dial_escape_plus(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the prefix set for this proxy config. 
	/// - Returns: dialing prefix.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var dialPrefix: String
	{
		get
		{
			let cPointer = linphone_proxy_config_get_dial_prefix(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_proxy_config_set_dial_prefix(cPtr, newValue)
		}
	}

	/// Get the domain name of the given proxy config. 
	/// - Returns: The domain name of the proxy config.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var domain: String
	{
			let cPointer = linphone_proxy_config_get_domain(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the reason why registration failed when the proxy config state is
	/// LinphoneRegistrationFailed. 
	/// - Returns: The `Reason` why registration failed for this proxy config. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var error: Reason
	{
			return Reason(rawValue: Int(linphone_proxy_config_get_error(cPtr).rawValue))!
	}

	/// Get detailed information why registration failed when the proxy config state is
	/// LinphoneRegistrationFailed. 
	/// - Returns: The `ErrorInfo` explaining why registration failed for this proxy
	/// config.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var errorInfo: ErrorInfo?
	{
			let cPointer = linphone_proxy_config_get_error_info(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = ErrorInfo.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the proxy config expires. 
	/// - Returns: the duration of registration. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var expires: Int
	{
		get
		{
			return Int(linphone_proxy_config_get_expires(cPtr))
		}
		set
		{
			linphone_proxy_config_set_expires(cPtr, CInt(newValue))
		}
	}

	/// Gets the identity addres of the proxy config. 
	/// - Returns: the SIP identity that belongs to this proxy configuration.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var identityAddress: Address?
	{
			let cPointer = linphone_proxy_config_get_identity_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	public func setIdentityaddress(newValue: Address) throws
	{
		let exception_result = linphone_proxy_config_set_identity_address(cPtr, newValue.cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the idkey property of a `ProxyConfig`. 
	/// - Returns: The idkey string, or nil.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var idkey: String
	{
		get
		{
			let cPointer = linphone_proxy_config_get_idkey(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_proxy_config_set_idkey(cPtr, newValue)
		}
	}

	/// Indicates whether to add to the contact parameters the push notification
	/// information. 
	/// For IOS, it indicates to VOIP push notification. 
	/// - Returns: true if push notification informations should be added, false
	/// otherwise. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var isPushNotificationAllowed: Bool
	{
			return linphone_proxy_config_is_push_notification_allowed(cPtr) != 0
	}

	/// Gets whether push notifications are available or not (Android & iOS only). 
	/// - Returns: true if push notifications are available, false otherwise 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var isPushNotificationAvailable: Bool
	{
			return linphone_proxy_config_is_push_notification_available(cPtr) != 0
	}

	/// Indicates whether to add to the contact parameters the remote push notification
	/// information (IOS only). 
	/// Default value is false. 
	/// - Returns: true if remote push notification informations should be added, false
	/// otherwise. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var isRemotePushNotificationAllowed: Bool
	{
			return linphone_proxy_config_is_remote_push_notification_allowed(cPtr) != 0
	}

	/// Get The policy that is used to pass through NATs/firewalls when using this
	/// proxy config. 
	/// If it is set to nil, the default NAT policy from the core will be used instead. 
	/// - Returns: `NatPolicy` object in use.   
	/// - See also: Core.getNatPolicy() 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var natPolicy: NatPolicy?
	{
		get
		{
			let cPointer = linphone_proxy_config_get_nat_policy(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = NatPolicy.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_proxy_config_set_nat_policy(cPtr, newValue?.cPtr)
		}
	}

	/// Get default privacy policy for all calls routed through this proxy. 
	/// - Returns: Privacy mode as LinphonePrivacyMask 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var privacy: UInt
	{
		get
		{
			return UInt(linphone_proxy_config_get_privacy(cPtr))
		}
		set
		{
			linphone_proxy_config_set_privacy(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Gets if the PUBLISH is enabled. 
	/// - Returns: true if PUBLISH request is enabled for this proxy. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var publishEnabled: Bool
	{
		get
		{
			return linphone_proxy_config_publish_enabled(cPtr) != 0
		}
		set
		{
			linphone_proxy_config_enable_publish(cPtr, newValue==true ? 1:0)
		}
	}

	/// get the publish expiration time in second. 
	/// Default value is the registration expiration value. 
	/// - Returns: expires in second 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var publishExpires: Int
	{
		get
		{
			return Int(linphone_proxy_config_get_publish_expires(cPtr))
		}
		set
		{
			linphone_proxy_config_set_publish_expires(cPtr, CInt(newValue))
		}
	}

	/// Indicates whether to add to the contact parameters the push notification
	/// information. 
	/// For IOS, it indicates to VOIP push notification. 
	/// - Parameter allow: true to allow push notification information, false
	/// otherwise. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var pushNotificationAllowed: Bool?
	{
		willSet
		{
			linphone_proxy_config_set_push_notification_allowed(cPtr, newValue==true ? 1:0)
		}
	}

	/// Retrieves the push notification configuration. 
	/// - Returns: The `PushNotificationConfig`.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var pushNotificationConfig: PushNotificationConfig?
	{
		get
		{
			let cPointer = linphone_proxy_config_get_push_notification_config(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = PushNotificationConfig.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_proxy_config_set_push_notification_config(cPtr, newValue?.cPtr)
		}
	}

	/// Get the route of the collector end-point when using quality reporting. 
	/// This SIP address should be used on server-side to process packets directly
	/// before discarding packets. Collector address should be a non existing account
	/// and will not receive any messages. If nil, reports will be send to the proxy
	/// domain. 
	/// - Returns: The SIP address of the collector end-point.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var qualityReportingCollector: String
	{
		get
		{
			let cPointer = linphone_proxy_config_get_quality_reporting_collector(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_proxy_config_set_quality_reporting_collector(cPtr, newValue)
		}
	}

	/// Indicates whether quality statistics during call should be stored and sent to a
	/// collector according to RFC 6035. 
	/// - Returns: True if quality repotring is enabled, false otherwise. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var qualityReportingEnabled: Bool
	{
		get
		{
			return linphone_proxy_config_quality_reporting_enabled(cPtr) != 0
		}
		set
		{
			linphone_proxy_config_enable_quality_reporting(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the interval between interval reports when using quality reporting. 
	/// - Returns: The interval in seconds, 0 means interval reports are disabled. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var qualityReportingInterval: Int
	{
		get
		{
			return Int(linphone_proxy_config_get_quality_reporting_interval(cPtr))
		}
		set
		{
			linphone_proxy_config_set_quality_reporting_interval(cPtr, CInt(newValue))
		}
	}

	/// Get the realm of the given proxy config. 
	/// - Returns: The realm of the proxy config.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var realm: String
	{
		get
		{
			let cPointer = linphone_proxy_config_get_realm(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_proxy_config_set_realm(cPtr, newValue)
		}
	}

	/// Get the persistent reference key associated to the proxy config. 
	/// The reference key can be for example an id to an external database. It is
	/// stored in the config file, thus can survive to process exits/restarts.
	/// - Returns: The reference key string that has been associated to the proxy
	/// config, or nil if none has been associated.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var refKey: String
	{
		get
		{
			let cPointer = linphone_proxy_config_get_ref_key(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_proxy_config_set_ref_key(cPtr, newValue)
		}
	}

	/// Returns whether the proxy config is enabled or not. 
	/// - Returns: true if registration to the proxy is enabled. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var registerEnabled: Bool
	{
		get
		{
			return linphone_proxy_config_register_enabled(cPtr) != 0
		}
		set
		{
			linphone_proxy_config_enable_register(cPtr, newValue==true ? 1:0)
		}
	}

	/// Indicates whether to add to the contact parameters the remote push notification
	/// information (IOS only). 
	/// - Parameter allow: true to allow remote push notification information, false
	/// otherwise. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var remotePushNotificationAllowed: Bool?
	{
		willSet
		{
			linphone_proxy_config_set_remote_push_notification_allowed(cPtr, newValue==true ? 1:0)
		}
	}

	/// Sets a SIP route. 
	/// When a route is set, all outgoing calls will go to the route's destination if
	/// this proxy is the default one (see Core.setDefaultProxyConfig() ). 
	/// - Parameter route: the SIP route to set   
	/// - Returns: -1 if route is invalid, 0 otherwise. 
	/// - deprecated: 08/07/2020 use setRoutes() instead 
	@available(*, deprecated)

	public func setRoute(newValue: String) throws
	{
		let exception_result = linphone_proxy_config_set_route(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the list of the routes set for this proxy config. 
	/// - Returns: The list of routes as string.    
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var routes: [String]
	{
			var swiftList = [String]()
			let cList = linphone_proxy_config_get_routes(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp!.pointee.next)
			}
			return swiftList
	}

	public func setRoutes(newValue: [String]) throws
	{
		var cList: UnsafeMutablePointer<bctbx_list_t>? = nil
		for data in newValue {
			let sData:NSString = data as NSString
			cList = bctbx_list_append(cList, unsafeBitCast(sData.utf8String, to: UnsafeMutablePointer<CChar>.self))
		}
		let exception_result = linphone_proxy_config_set_routes(cPtr, cList)
		bctbx_list_free(cList)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Gets the proxy config proxy address. 
	/// - Returns: the proxy's SIP address.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var serverAddr: String
	{
			let cPointer = linphone_proxy_config_get_server_addr(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	public func setServeraddr(newValue: String) throws
	{
		let exception_result = linphone_proxy_config_set_server_addr(cPtr, newValue)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "username setter returned value \(exception_result)")
		}
	}

	/// Get the registration state of the given proxy config. 
	/// - Returns: The `RegistrationState` of the proxy config. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var state: RegistrationState
	{
			return RegistrationState(rawValue: Int(linphone_proxy_config_get_state(cPtr).rawValue))!
	}

	/// Get the transport from either service route, route or addr. 
	/// - Returns: The transport as a string (I.E udp, tcp, tls, dtls)   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var transport: String
	{
			let cPointer = linphone_proxy_config_get_transport(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Return the unread chat message count for a given proxy config. 
	/// - Returns: The unread chat message count. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public var unreadChatMessageCount: Int
	{
			return Int(linphone_proxy_config_get_unread_chat_message_count(cPtr))
	}

	/// Retrieve the user pointer associated with the proxy config. 
	/// - Returns: The user pointer associated with the proxy config.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_proxy_config_get_user_data(cPtr)
		}
		set
		{
			linphone_proxy_config_set_user_data(cPtr, newValue)
		}
	}

	/// Commits modification made to the proxy configuration. 
	/// - Returns: 0 if successful, -1 otherwise 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public func done() throws 
	{
		let exception_result = linphone_proxy_config_done(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "done returned value \(exception_result)")
		}
	}

	/// Starts editing a proxy configuration. 
	/// Because proxy configuration must be consistent, applications MUST call edit()
	/// before doing any attempts to modify proxy configuration (such as identity,
	/// proxy address and so on). Once the modifications are done, then the application
	/// must call done() to commit the changes. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public func edit() 
	{
		linphone_proxy_config_edit(cPtr)
	}

	/// Find authentication info matching proxy config, if any, similarly to
	/// linphone_core_find_auth_info. 
	/// - Returns: a `AuthInfo` matching proxy config criteria if possible, nil if
	/// nothing can be found.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public func findAuthInfo() -> AuthInfo?
	{
		let cPointer = linphone_proxy_config_find_auth_info(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = AuthInfo.getSwiftObject(cObject: cPointer!)
		return result
	}

	/// Obtain the value of a header sent by the server in last answer to REGISTER. 
	/// - Parameter headerName: the header name for which to fetch corresponding value 
	///  
	/// - Returns: the value of the queried header.   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public func getCustomHeader(headerName:String) -> String
	{
		let cstr = linphone_proxy_config_get_custom_header(cPtr, headerName)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Normalize a human readable phone number into a basic string. 
	/// 888-444-222 becomes 888444222 or +33888444222 depending on the `ProxyConfig`
	/// object. This function will always generate a normalized username if input is a
	/// phone number. 
	/// - Parameter username: the string to parse   
	/// - Returns: nil if input is an invalid phone number, normalized phone number
	/// from username input otherwise.     
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public func normalizePhoneNumber(username:String) -> String
	{
		let cstr = linphone_proxy_config_normalize_phone_number(cPtr, username)
		let result = charArrayToString(charPointer: cstr)
		if (cstr != nil) {
			bctbx_free(cstr)
		}
		return result
	}

	/// Normalize a human readable sip uri into a fully qualified LinphoneAddress. 
	/// A sip address should look like DisplayName <sip:username@domain:port> .
	/// Basically this function performs the following tasks
	/// The result is a syntactically correct SIP address. 
	/// - Parameter username: the string to parse   
	/// - Returns: nil if invalid input, normalized sip address otherwise.     
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public func normalizeSipUri(username:String) -> Address?
	{
		let cPointer = linphone_proxy_config_normalize_sip_uri(cPtr, username)
		if (cPointer == nil) {
			return nil
		}
		let result = Address.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Prevent a proxy config from refreshing its registration. 
	/// This is useful to let registrations to expire naturally (or) when the
	/// application wants to keep control on when refreshes are sent. However,
	/// linphone_core_set_network_reachable(lc,true) will always request the proxy
	/// configs to refresh their registrations. The refreshing operations can be
	/// resumed with refreshRegister(). 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public func pauseRegister() 
	{
		linphone_proxy_config_pause_register(cPtr)
	}

	/// Refresh a proxy registration. 
	/// This is useful if for example you resuming from suspend, thus IP address may
	/// have changed. 
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public func refreshRegister() 
	{
		linphone_proxy_config_refresh_register(cPtr)
	}

	/// Set the value of a custom header sent to the server in REGISTERs request. 
	/// - Parameter headerName: the header name   
	/// - Parameter headerValue: the header's value   
	/// - deprecated: 06/04/2020 Use `Account` object instead 
	@available(*, deprecated)
	public func setCustomHeader(headerName:String, headerValue:String?) 
	{
		linphone_proxy_config_set_custom_header(cPtr, headerName, headerValue)
	}
}

/// Object holding push notification config that will be set in the contact URI
/// parameters of the Contact header in the REGISTER, if the `AccountParams` is
/// configured to allow push notifications, see
/// AccountParams.setPushNotificationAllowed(). 
/// This object can be accessed through the `AccountParams` object, which can be
/// obtained from your `Account` object. 
public class PushNotificationConfig : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> PushNotificationConfig {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PushNotificationConfig>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PushNotificationConfig(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the app's bundle identifier for "contact uri parameter". 
	/// - Returns: The app's bundle identifier, default value "".   
	public var bundleIdentifier: String
	{
		get
		{
			let cPointer = linphone_push_notification_config_get_bundle_identifier(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_push_notification_config_set_bundle_identifier(cPtr, newValue)
		}
	}

	/// Gets the call_snd for "contact uri parameter". 
	/// - Returns: The call_snd, default value "notes_of_the_optimistic.caf".   
	public var callSnd: String
	{
		get
		{
			let cPointer = linphone_push_notification_config_get_call_snd(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_push_notification_config_set_call_snd(cPtr, newValue)
		}
	}

	/// Gets the call_str for "contact uri parameter". 
	/// - Returns: The call_str, default value "IC_MSG".   
	public var callStr: String
	{
		get
		{
			let cPointer = linphone_push_notification_config_get_call_str(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_push_notification_config_set_call_str(cPtr, newValue)
		}
	}

	/// Gets the groupchat_str for "contact uri parameter". 
	/// - Returns: The groupchat_str, default value "GC_MSG".   
	public var groupChatStr: String
	{
		get
		{
			let cPointer = linphone_push_notification_config_get_group_chat_str(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_push_notification_config_set_group_chat_str(cPtr, newValue)
		}
	}

	/// Gets the msg_snd for "contact uri parameter". 
	/// - Returns: The msg_snd, default value "msg.caf".   
	public var msgSnd: String
	{
		get
		{
			let cPointer = linphone_push_notification_config_get_msg_snd(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_push_notification_config_set_msg_snd(cPtr, newValue)
		}
	}

	/// Gets the msg_str for "contact uri parameter". 
	/// - Returns: The msg_str, default value "IM_MSG".   
	public var msgStr: String
	{
		get
		{
			let cPointer = linphone_push_notification_config_get_msg_str(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_push_notification_config_set_msg_str(cPtr, newValue)
		}
	}

	/// Gets the param for "contact uri parameter". 
	/// - Returns: The param, default value "".   
	public var param: String
	{
		get
		{
			let cPointer = linphone_push_notification_config_get_param(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_push_notification_config_set_param(cPtr, newValue)
		}
	}

	/// Gets the prid for "contact uri parameter". 
	/// - Returns: The prid, default value "".   
	public var prid: String
	{
		get
		{
			let cPointer = linphone_push_notification_config_get_prid(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_push_notification_config_set_prid(cPtr, newValue)
		}
	}

	/// Gets the provider for "contact uri parameter". 
	/// - Returns: The provider, default value "".   
	public var provider: String
	{
		get
		{
			let cPointer = linphone_push_notification_config_get_provider(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_push_notification_config_set_provider(cPtr, newValue)
		}
	}

	/// Gets the remote token for "contact uri parameter". 
	/// - Returns: The remote token, default value "".   
	public var remoteToken: String
	{
		get
		{
			let cPointer = linphone_push_notification_config_get_remote_token(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_push_notification_config_set_remote_token(cPtr, newValue)
		}
	}

	/// Gets the team id for "contact uri parameter". 
	/// - Returns: The team id, default value "ABCD1234".   
	public var teamId: String
	{
		get
		{
			let cPointer = linphone_push_notification_config_get_team_id(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_push_notification_config_set_team_id(cPtr, newValue)
		}
	}

	/// Gets the voip token for "contact uri parameter". 
	/// - Returns: The voip token, default value "".   
	public var voipToken: String
	{
		get
		{
			let cPointer = linphone_push_notification_config_get_voip_token(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_push_notification_config_set_voip_token(cPtr, newValue)
		}
	}

	/// Instantiate a new push notification parameters with values from source. 
	/// - Returns: The newly created `PushNotificationConfig` object.   
	public func clone() -> PushNotificationConfig?
	{
		let cPointer = linphone_push_notification_config_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = PushNotificationConfig.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Checks if two Push Notification Configurations are identical. 
	/// - Parameter otherConfig: The `PushNotificationConfig` object to compare to.   
	/// - Returns: True only if the two configurations are identical.   
	public func isEqual(otherConfig:PushNotificationConfig) -> Bool
	{
		return linphone_push_notification_config_is_equal(cPtr, otherConfig.cPtr) != 0
	}
}

/// Object holding chat message data received by a push notification on iOS
/// platform only. 
/// This object is a subset of `ChatMessage`, so only a few methods of it's parent
/// are available, like getTextContent() and getSubject(), just enough to be able
/// to build a notification to show the user. 
public class PushNotificationMessage : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> PushNotificationMessage {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<PushNotificationMessage>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = PushNotificationMessage(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the call id. 
	/// - Returns: The call id.   
	public var callId: String
	{
			let cPointer = linphone_push_notification_message_get_call_id(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Gets the from address. 
	/// - Returns: The from `Address`.   
	public var fromAddr: Address?
	{
			let cPointer = linphone_push_notification_message_get_from_addr(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns wether it is a text message or not. 
	/// - Returns: true if it is a text message, false otherwise. 
	public var isText: Bool
	{
			return linphone_push_notification_message_is_text(cPtr) != 0
	}

	/// Gets the local address. 
	/// - Returns: The local `Address`.   
	public var localAddr: Address?
	{
			let cPointer = linphone_push_notification_message_get_local_addr(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the peer address. 
	/// - Returns: The peer `Address`.   
	public var peerAddr: Address?
	{
			let cPointer = linphone_push_notification_message_get_peer_addr(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the subject. 
	/// - Returns: The subject or nil.   
	public var subject: String
	{
			let cPointer = linphone_push_notification_message_get_subject(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Gets the text content. 
	/// - Returns: The text content or nil.   
	public var textContent: String
	{
			let cPointer = linphone_push_notification_message_get_text_content(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}
}

/// Structure describing a range of integers. 
public class Range : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Range {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Range>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Range(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the higher value of the range. 
	/// - Returns: The higher value 
	public var max: Int
	{
		get
		{
			return Int(linphone_range_get_max(cPtr))
		}
		set
		{
			linphone_range_set_max(cPtr, CInt(newValue))
		}
	}

	/// Gets the lower value of the range. 
	/// - Returns: The lower value 
	public var min: Int
	{
		get
		{
			return Int(linphone_range_get_min(cPtr))
		}
		set
		{
			linphone_range_set_min(cPtr, CInt(newValue))
		}
	}

	/// Gets the user data in the `Range` object. 
	/// - Returns: the user data.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_range_get_user_data(cPtr)
		}
		set
		{
			linphone_range_set_user_data(cPtr, newValue)
		}
	}
}

/// Object used to record the audio or video of a call. 
public class Recorder : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Recorder {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Recorder>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Recorder(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get linear volume when capturing audio. 
	/// - Returns: Linear volume. 
	public var captureVolume: Float
	{
			return linphone_recorder_get_capture_volume(cPtr)
	}

	/// Gets the duration of the recording. 
	/// - Returns: the duration of the recording, in milliseconds. 
	public var duration: Int
	{
			return Int(linphone_recorder_get_duration(cPtr))
	}

	/// Gets the file used for recording. 
	/// - Returns: the file used for the recording if any.   
	public var file: String
	{
			let cPointer = linphone_recorder_get_file(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Retrieve the `RecorderParams` object. 
	/// - Returns: The `RecorderParams` object.   
	public var params: RecorderParams?
	{
		get
		{
			let cPointer = linphone_recorder_get_params(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = RecorderParams.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_recorder_set_params(cPtr, newValue?.cPtr)
		}
	}

	/// Gets the current state of the recorder. 
	/// - Returns: the current `RecorderState`. 
	public var state: RecorderState
	{
			return RecorderState(rawValue: Int(linphone_recorder_get_state(cPtr).rawValue))!
	}

	/// Retrieve the user data. 
	/// - Returns: the user data to retrieve.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_recorder_get_user_data(cPtr)
		}
		set
		{
			linphone_recorder_set_user_data(cPtr, newValue)
		}
	}

	/// Close the opened file. 
	public func close() 
	{
		linphone_recorder_close(cPtr)
	}

	/// Create a content from the recording, for example to send it in a chat message. 
	/// - Warning: Recorder must be in Closed state! 
	/// - Returns: the `Content` matching the recording, or nil.   
	public func createContent() throws -> Content
	{
		let cPointer = linphone_recorder_create_content(cPtr)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null Content value")
		}
		let result = Content.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Open a file for recording. 
	/// - Parameter file: The path to the file to open.   
	public func open(file:String) throws 
	{
		let exception_result = linphone_recorder_open(cPtr, file)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "open returned value \(exception_result)")
		}
	}

	/// Pause the recording. 
	public func pause() throws 
	{
		let exception_result = linphone_recorder_pause(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "pause returned value \(exception_result)")
		}
	}

	/// Start the recording into the opened file. 
	public func start() throws 
	{
		let exception_result = linphone_recorder_start(cPtr)
		guard exception_result == 0 else {
			throw LinphoneError.exception(result: "start returned value \(exception_result)")
		}
	}
}

/// Object containing various parameters of a `Recorder`. 
public class RecorderParams : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> RecorderParams {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<RecorderParams>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = RecorderParams(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Retrieve the `AudioDevice` object. 
	/// - Returns: the `AudioDevice` object.   
	public var audioDevice: AudioDevice?
	{
		get
		{
			let cPointer = linphone_recorder_params_get_audio_device(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = AudioDevice.getSwiftObject(cObject:cPointer!)
			return result
		}
		set
		{
			linphone_recorder_params_set_audio_device(cPtr, newValue?.cPtr)
		}
	}

	/// Retrieves the `RecorderFileFormat`. 
	/// - Returns: the `RecorderFileFormat`. 
	public var fileFormat: RecorderFileFormat
	{
		get
		{
			return RecorderFileFormat(rawValue: Int(linphone_recorder_params_get_file_format(cPtr).rawValue))!
		}
		set
		{
			linphone_recorder_params_set_file_format(cPtr, LinphoneRecorderFileFormat(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Retrieves the video codec. 
	/// - Returns: the video codec.   
	public var videoCodec: String
	{
		get
		{
			let cPointer = linphone_recorder_params_get_video_codec(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_recorder_params_set_video_codec(cPtr, newValue)
		}
	}

	/// Retrieves the webcam name. 
	/// - Returns: the webcam name.   
	public var webcamName: String
	{
		get
		{
			let cPointer = linphone_recorder_params_get_webcam_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_recorder_params_set_webcam_name(cPtr, newValue)
		}
	}

	/// Retrieves the window id. 
	/// - Returns: the window id.   
	public var windowId: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_recorder_params_get_window_id(cPtr)
		}
		set
		{
			linphone_recorder_params_set_window_id(cPtr, newValue)
		}
	}

	/// Clone a `RecorderParams` object. 
	/// - Returns: the cloned `RecorderParams` object.   
	public func clone() -> RecorderParams?
	{
		let cPointer = linphone_recorder_params_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = RecorderParams.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}
}

/// The LinphoneSearchResult object represents a result of a search. 
public class SearchResult : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> SearchResult {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<SearchResult>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = SearchResult(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the address of the search result if any. 
	/// - Returns: The associed `Address` or nil.   
	public var address: Address?
	{
			let cPointer = linphone_search_result_get_address(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Address.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Returns the capabilities mask of the search result. 
	/// - Returns: the capabilities mask associated to the search result 
	public var capabilities: Int
	{
			return Int(linphone_search_result_get_capabilities(cPtr))
	}

	/// Gets the friend of the search result if any. 
	/// - Returns: The associated `Friend` or nil.   
	public var friend: Friend?
	{
			let cPointer = linphone_search_result_get_friend(cPtr)
			if (cPointer == nil) {
				return nil
			}
			let result = Friend.getSwiftObject(cObject:cPointer!)
			return result
	}

	/// Gets the phone number of the search result if any. 
	/// - Returns: The associed phone number or nil.   
	public var phoneNumber: String
	{
			let cPointer = linphone_search_result_get_phone_number(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Gets source flags of the search result. 
	/// - Returns: the source flags from `MagicSearchSource` 
	public var sourceFlags: Int
	{
			return Int(linphone_search_result_get_source_flags(cPtr))
	}

	/// Gets the weight of the search result. 
	/// - Returns: the result weight 
	public var weight: UInt
	{
			return UInt(linphone_search_result_get_weight(cPtr))
	}

	/// Returns whether or not the search result has the given capability. 
	/// - Parameter capability: the `FriendCapability` to check 
	/// - Returns: true if it has the capability, false otherwise. 
	public func hasCapability(capability:FriendCapability) -> Bool
	{
		return linphone_search_result_has_capability(cPtr, LinphoneFriendCapability(rawValue: CUnsignedInt(capability.rawValue))) != 0
	}
}

/// SIP transports & ports configuration object. 
/// Indicates which transport among UDP, TCP, TLS and DTLS should be enabled and if
/// so on which port to listen. You can use special values like
/// LC_SIP_TRANSPORT_DISABLED (0), LC_SIP_TRANSPORT_RANDOM (-1) and
/// LC_SIP_TRANSPORT_DONTBIND (-2).
/// Once configuration is complete, use Core.setTransports() to apply it. This will
/// be saved in configuration file so you don't have to do it each time the `Core`
/// starts. 
public class Transports : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Transports {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Transports>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Transports(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the DTLS port in the `Transports` object. 
	/// - Returns: the DTLS port 
	public var dtlsPort: Int
	{
		get
		{
			return Int(linphone_transports_get_dtls_port(cPtr))
		}
		set
		{
			linphone_transports_set_dtls_port(cPtr, CInt(newValue))
		}
	}

	/// Gets the TCP port in the `Transports` object. 
	/// - Returns: the TCP port 
	public var tcpPort: Int
	{
		get
		{
			return Int(linphone_transports_get_tcp_port(cPtr))
		}
		set
		{
			linphone_transports_set_tcp_port(cPtr, CInt(newValue))
		}
	}

	/// Gets the TLS port in the `Transports` object. 
	/// - Returns: the TLS port 
	public var tlsPort: Int
	{
		get
		{
			return Int(linphone_transports_get_tls_port(cPtr))
		}
		set
		{
			linphone_transports_set_tls_port(cPtr, CInt(newValue))
		}
	}

	/// Gets the UDP port in the `Transports` object. 
	/// - Returns: the UDP port 
	public var udpPort: Int
	{
		get
		{
			return Int(linphone_transports_get_udp_port(cPtr))
		}
		set
		{
			linphone_transports_set_udp_port(cPtr, CInt(newValue))
		}
	}

	/// Gets the user data in the `Transports` object. 
	/// - Returns: the user data.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_transports_get_user_data(cPtr)
		}
		set
		{
			linphone_transports_set_user_data(cPtr, newValue)
		}
	}
}

/// Linphone tunnel object. 
public class Tunnel : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Tunnel {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Tunnel>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Tunnel(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	///Enum describing the tunnel modes. 
	public enum Mode:Int
	{
		/// The tunnel is disabled. 
		case Disable = 0
		/// The tunnel is enabled. 
		case Enable = 1
		/// The tunnel is enabled automatically if it is required. 
		case Auto = 2
	}

	/// Returns whether the tunnel is activated. 
	/// If mode is set to auto, this gives indication whether the automatic detection
	/// determined that tunnel was necessary or not. 
	/// - Returns: true if tunnel is in use, false otherwise. 
	public var activated: Bool
	{
			return linphone_tunnel_get_activated(cPtr) != 0
	}

	/// Get the domain. 
	/// - Returns: The domain.   
	public var domain: String
	{
		get
		{
			let cPointer = linphone_tunnel_get_domain(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_tunnel_set_domain(cPtr, newValue)
		}
	}

	/// Get the dual tunnel client mode. 
	/// - Returns: true if dual tunnel client mode is enabled, false otherwise 
	public var dualModeEnabled: Bool
	{
		get
		{
			return linphone_tunnel_dual_mode_enabled(cPtr) != 0
		}
		set
		{
			linphone_tunnel_enable_dual_mode(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the tunnel mode. 
	/// - Returns: The current `Mode` 
	public var mode: Tunnel.Mode
	{
		get
		{
			return Tunnel.Mode(rawValue: Int(linphone_tunnel_get_mode(cPtr).rawValue))!
		}
		set
		{
			linphone_tunnel_set_mode(cPtr, LinphoneTunnelMode(rawValue: CUnsignedInt(newValue.rawValue)))
		}
	}

	/// Get added servers. 
	/// - Returns: The list of servers.    
	public var servers: [TunnelConfig]
	{
			var swiftList = [TunnelConfig]()
			let cList = linphone_tunnel_get_servers(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(TunnelConfig.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Check whether tunnel is set to transport SIP packets. 
	/// - Returns: A boolean value telling whether SIP packets shall pass through the
	/// tunnel 
	public var sipEnabled: Bool
	{
		get
		{
			return linphone_tunnel_sip_enabled(cPtr) != 0
		}
		set
		{
			linphone_tunnel_enable_sip(cPtr, newValue==true ? 1:0)
		}
	}

	/// Get the username. 
	/// - Returns: The username.   
	public var username: String
	{
		get
		{
			let cPointer = linphone_tunnel_get_username(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_tunnel_set_username(cPtr, newValue)
		}
	}

	/// Add a tunnel server configuration. 
	/// - Parameter tunnelConfig: `TunnelConfig` object   
	public func addServer(tunnelConfig:TunnelConfig) 
	{
		linphone_tunnel_add_server(cPtr, tunnelConfig.cPtr)
	}

	/// Remove all tunnel server addresses previously entered with addServer() 
	public func cleanServers() 
	{
		linphone_tunnel_clean_servers(cPtr)
	}

	/// Check whether the tunnel is connected. 
	/// - Returns: A boolean value telling if the tunnel is connected 
	public func connected() -> Bool
	{
		return linphone_tunnel_connected(cPtr) != 0
	}

	/// Force reconnection to the tunnel server. 
	/// This method is useful when the device switches from wifi to Edge/3G or vice
	/// versa. In most cases the tunnel client socket won't be notified promptly that
	/// its connection is now zombie, so it is recommended to call this method that
	/// will cause the lost connection to be closed and new connection to be issued. 
	public func reconnect() 
	{
		linphone_tunnel_reconnect(cPtr)
	}

	/// Remove a tunnel server configuration. 
	/// - Parameter tunnelConfig: `TunnelConfig` object   
	public func removeServer(tunnelConfig:TunnelConfig) 
	{
		linphone_tunnel_remove_server(cPtr, tunnelConfig.cPtr)
	}

	/// Set an optional http proxy to go through when connecting to tunnel server. 
	/// - Parameter host: http proxy host   
	/// - Parameter port: http proxy port 
	/// - Parameter username: Optional http proxy username if the proxy request
	/// authentication. Currently only basic authentication is supported. Use nil if
	/// not needed.   
	/// - Parameter passwd: Optional http proxy password. Use nil if not needed.   
	public func setHttpProxy(host:String, port:Int, username:String?, passwd:String?) 
	{
		linphone_tunnel_set_http_proxy(cPtr, host, CInt(port), username, passwd)
	}

	/// Set authentication info for the http proxy. 
	/// - Parameter username: User name   
	/// - Parameter passwd: Password   
	public func setHttpProxyAuthInfo(username:String?, passwd:String?) 
	{
		linphone_tunnel_set_http_proxy_auth_info(cPtr, username, passwd)
	}
}

/// Tunnel settings. 
public class TunnelConfig : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> TunnelConfig {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<TunnelConfig>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = TunnelConfig(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get the UDP packet round trip delay in ms for a tunnel configuration. 
	/// - Returns: The UDP packet round trip delay in ms. 
	public var delay: Int
	{
		get
		{
			return Int(linphone_tunnel_config_get_delay(cPtr))
		}
		set
		{
			linphone_tunnel_config_set_delay(cPtr, CInt(newValue))
		}
	}

	/// Get the IP address or hostname of the tunnel server. 
	/// - Returns: The tunnel server IP address or hostname.   
	public var host: String
	{
		get
		{
			let cPointer = linphone_tunnel_config_get_host(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_tunnel_config_set_host(cPtr, newValue)
		}
	}

	/// Get the IP address or hostname of the second tunnel server when using dual
	/// tunnel client. 
	/// - Returns: The tunnel server IP address or hostname.   
	public var host2: String
	{
		get
		{
			let cPointer = linphone_tunnel_config_get_host2(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_tunnel_config_set_host2(cPtr, newValue)
		}
	}

	/// Get the TLS port of the tunnel server. 
	/// - Returns: The TLS port of the tunnel server 
	public var port: Int
	{
		get
		{
			return Int(linphone_tunnel_config_get_port(cPtr))
		}
		set
		{
			linphone_tunnel_config_set_port(cPtr, CInt(newValue))
		}
	}

	/// Get the TLS port of the second tunnel server when using dual tunnel client. 
	/// - Returns: The TLS port of the tunnel server 
	public var port2: Int
	{
		get
		{
			return Int(linphone_tunnel_config_get_port2(cPtr))
		}
		set
		{
			linphone_tunnel_config_set_port2(cPtr, CInt(newValue))
		}
	}

	/// Get the remote port on the tunnel server side used to test UDP reachability. 
	/// This is used when the mode is set auto, to detect whether the tunnel has to be
	/// enabled or not. 
	/// - Returns: The remote port on the tunnel server side used to test UDP
	/// reachability 
	public var remoteUdpMirrorPort: Int
	{
		get
		{
			return Int(linphone_tunnel_config_get_remote_udp_mirror_port(cPtr))
		}
		set
		{
			linphone_tunnel_config_set_remote_udp_mirror_port(cPtr, CInt(newValue))
		}
	}

	/// Retrieve user data from the tunnel config. 
	/// - Returns: the user data.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_tunnel_config_get_user_data(cPtr)
		}
		set
		{
			linphone_tunnel_config_set_user_data(cPtr, newValue)
		}
	}
}

/// Object storing contact information using vCard 4.0 format. 
public class Vcard : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> Vcard {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<Vcard>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = Vcard(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the eTag of the vCard. 
	/// - Returns: the eTag of the vCard in the CardDAV server, otherwise nil.   
	public var etag: String
	{
		get
		{
			let cPointer = linphone_vcard_get_etag(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_vcard_set_etag(cPtr, newValue)
		}
	}

	/// Returns the family name in the N attribute of the vCard, or nil if it isn't set
	/// yet. 
	/// - Returns: the family name of the vCard, or nil   
	public var familyName: String
	{
		get
		{
			let cPointer = linphone_vcard_get_family_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_vcard_set_family_name(cPtr, newValue)
		}
	}

	/// Returns the FN attribute of the vCard, or nil if it isn't set yet. 
	/// - Returns: the display name of the vCard, or nil.   
	public var fullName: String
	{
		get
		{
			let cPointer = linphone_vcard_get_full_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_vcard_set_full_name(cPtr, newValue)
		}
	}

	/// Returns the given name in the N attribute of the vCard, or nil if it isn't set
	/// yet. 
	/// - Returns: the given name of the vCard, or nil   
	public var givenName: String
	{
		get
		{
			let cPointer = linphone_vcard_get_given_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_vcard_set_given_name(cPtr, newValue)
		}
	}

	/// Gets the Organization of the vCard. 
	/// - Returns: the Organization of the vCard or nil.   
	public var organization: String
	{
		get
		{
			let cPointer = linphone_vcard_get_organization(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_vcard_set_organization(cPtr, newValue)
		}
	}

	/// Returns the list of phone numbers in the vCard (all the TEL attributes) or nil. 
	/// - Returns: The phone numbers as string.      
	public var phoneNumbers: [String]
	{
			var swiftList = [String]()
			let cList = linphone_vcard_get_phone_numbers(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp!.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Returns the list of phone numbers in the vCard (all the TEL attributes) or nil. 
	/// - Returns: The phone numbers as `FriendPhoneNumber`.      
	public var phoneNumbersWithLabel: [FriendPhoneNumber]
	{
			var swiftList = [FriendPhoneNumber]()
			let cList = linphone_vcard_get_phone_numbers_with_label(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(FriendPhoneNumber.getSwiftObject(cObject: data))
				listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			bctbx_list_free(cList)
			return swiftList
	}

	/// Returns the first PHOTO property or nil. 
	/// - Returns: The picture URI as string or nil if none has been set.   
	public var photo: String
	{
		get
		{
			let cPointer = linphone_vcard_get_photo(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_vcard_set_photo(cPtr, newValue)
		}
	}

	/// Returns the list of SIP addresses in the vCard (all the IMPP attributes that
	/// has an URI value starting by "sip:") or nil. 
	/// - Returns: The SIP addresses.    
	public var sipAddresses: [Address]
	{
			var swiftList = [Address]()
			let cList = linphone_vcard_get_sip_addresses(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				let data = unsafeBitCast(listTemp?.pointee.data, to: OpaquePointer.self)
				swiftList.append(Address.getSwiftObject(cObject: data))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp?.pointee.next)
			}
			return swiftList
	}

	/// Returns the skipFieldValidation property of the vcard. 
	/// - Returns: the skipFieldValidation property of the vcard 
	public var skipValidation: Bool
	{
		get
		{
			return linphone_vcard_get_skip_validation(cPtr) != 0
		}
		set
		{
			linphone_vcard_set_skip_validation(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the UID of the vCard. 
	/// - Returns: the UID of the vCard, otherwise nil.   
	public var uid: String
	{
		get
		{
			let cPointer = linphone_vcard_get_uid(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_vcard_set_uid(cPtr, newValue)
		}
	}

	/// Gets the URL of the vCard. 
	/// - Returns: the URL of the vCard in the CardDAV server, otherwise nil.   
	public var url: String
	{
		get
		{
			let cPointer = linphone_vcard_get_url(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_vcard_set_url(cPtr, newValue)
		}
	}

	/// Adds an extended property to the vCard. 
	/// - Parameter name: the name of the extended property to add   
	/// - Parameter value: the value of the extended property to add   
	public func addExtendedProperty(name:String, value:String) 
	{
		linphone_vcard_add_extended_property(cPtr, name, value)
	}

	/// Adds a phone number in the vCard, using the TEL property. 
	/// - Parameter phone: the phone number to add   
	public func addPhoneNumber(phone:String) 
	{
		linphone_vcard_add_phone_number(cPtr, phone)
	}

	/// Adds a `FriendPhoneNumber` in the vCard, using the TEL property. 
	/// - Parameter phoneNumber: the `FriendPhoneNumber` to add   
	public func addPhoneNumberWithLabel(phoneNumber:FriendPhoneNumber) 
	{
		linphone_vcard_add_phone_number_with_label(cPtr, phoneNumber.cPtr)
	}

	/// Adds a SIP address in the vCard, using the IMPP property. 
	/// - Parameter sipAddress: the SIP address to add   
	public func addSipAddress(sipAddress:String) 
	{
		linphone_vcard_add_sip_address(cPtr, sipAddress)
	}

	/// Returns the vCard4 representation of the LinphoneVcard. 
	/// - Returns: a const char * that represents the vCard.   
	public func asVcard4String() -> String
	{
		let cstr = linphone_vcard_as_vcard4_string(cPtr)
		let result = charArrayToString(charPointer: cstr)
		return result
	}

	/// Clone a `Vcard`. 
	/// - Returns: a new `Vcard` object   
	public func clone() -> Vcard?
	{
		let cPointer = linphone_vcard_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = Vcard.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Edits the preferred SIP address in the vCard (or the first one), using the IMPP
	/// property. 
	/// - Parameter sipAddress: the new SIP address   
	public func editMainSipAddress(sipAddress:String) 
	{
		linphone_vcard_edit_main_sip_address(cPtr, sipAddress)
	}

	/// Generates a random unique id for the vCard. 
	/// If is required to be able to synchronize the vCard with a CardDAV server 
	/// - Returns: true if operation is successful, otherwise false (for example if it
	/// already has an unique ID) 
	public func generateUniqueId() -> Bool
	{
		return linphone_vcard_generate_unique_id(cPtr) != 0
	}

	/// Get the vCard extended properties values per property name. 
	/// - Parameter name: the name to filter the extended properties on.   
	/// - Returns: The extended properties values as string.      
	public func getExtendedPropertiesValuesByName(name:String) -> [String]
	{
		var swiftList = [String]()
		let cList = linphone_vcard_get_extended_properties_values_by_name(cPtr, name)
		var listTemp = cList
		while (listTemp != nil) {
			swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
			listTemp = UnsafeMutablePointer<bctbx_list_t>(listTemp!.pointee.next)
		}
		bctbx_list_free(cList)
		return swiftList
	}

	/// Remove all the extend properties per property name. 
	/// - Parameter name: the name to remove the extended properties on.   
	public func removeExtentedPropertiesByName(name:String) 
	{
		linphone_vcard_remove_extented_properties_by_name(cPtr, name)
	}

	/// Removes the Organization field of the vCard. 
	public func removeOrganization() 
	{
		linphone_vcard_remove_organization(cPtr)
	}

	/// Removes a phone number in the vCard (if it exists), using the TEL property. 
	/// - Parameter phone: the phone number to remove   
	public func removePhoneNumber(phone:String) 
	{
		linphone_vcard_remove_phone_number(cPtr, phone)
	}

	/// Removes a `FriendPhoneNumber` in the vCard (if it exists), using the TEL
	/// property. 
	/// - Parameter phoneNumber: the `FriendPhoneNumber` to remove   
	public func removePhoneNumberWithLabel(phoneNumber:FriendPhoneNumber) 
	{
		linphone_vcard_remove_phone_number_with_label(cPtr, phoneNumber.cPtr)
	}

	/// Removes any existing PHOTO property. 
	public func removePhoto() 
	{
		linphone_vcard_remove_photo(cPtr)
	}

	/// Removes a SIP address in the vCard (if it exists), using the IMPP property. 
	/// - Parameter sipAddress: the SIP address to remove   
	public func removeSipAddress(sipAddress:String) 
	{
		linphone_vcard_remove_sip_address(cPtr, sipAddress)
	}
}

/// Object describing policy regarding video streams establishments. 
/// Use setAutomaticallyAccept() and setAutomaticallyInitiate() to tell the Core to
/// automatically accept or initiate video during calls.
/// Even if disabled, you'll still be able to add it later while the call is
/// running. 
public class VideoActivationPolicy : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> VideoActivationPolicy {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<VideoActivationPolicy>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = VideoActivationPolicy(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Gets the value for the automatically accept video policy. 
	/// - Returns: whether or not to automatically accept video requests is enabled 
	public var automaticallyAccept: Bool
	{
		get
		{
			return linphone_video_activation_policy_get_automatically_accept(cPtr) != 0
		}
		set
		{
			linphone_video_activation_policy_set_automatically_accept(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the value for the automatically initiate video policy. 
	/// - Returns: whether or not to automatically initiate video calls is enabled 
	public var automaticallyInitiate: Bool
	{
		get
		{
			return linphone_video_activation_policy_get_automatically_initiate(cPtr) != 0
		}
		set
		{
			linphone_video_activation_policy_set_automatically_initiate(cPtr, newValue==true ? 1:0)
		}
	}

	/// Gets the user data in the `VideoActivationPolicy` object. 
	/// - Returns: the user data   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_video_activation_policy_get_user_data(cPtr)
		}
		set
		{
			linphone_video_activation_policy_set_user_data(cPtr, newValue)
		}
	}
}

/// This object represents a video definition, eg. 
/// it's width, it's height and possibly it's name.
/// It is mostly used to configure the default video size sent by your camera
/// during a video call with Core.setPreferredVideoDefinition() method. 
public class VideoDefinition : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> VideoDefinition {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<VideoDefinition>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = VideoDefinition(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Get the height of the video definition. 
	/// - Returns: The height of the video definition 
	public var height: UInt
	{
		get
		{
			return UInt(linphone_video_definition_get_height(cPtr))
		}
		set
		{
			linphone_video_definition_set_height(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Tells whether a `VideoDefinition` is undefined. 
	/// - Returns: A boolean value telling whether the `VideoDefinition` is undefined. 
	public var isUndefined: Bool
	{
			return linphone_video_definition_is_undefined(cPtr) != 0
	}

	/// Get the name of the video definition. 
	/// - Returns: The name of the video definition   
	public var name: String
	{
		get
		{
			let cPointer = linphone_video_definition_get_name(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
		}
		set
		{
			linphone_video_definition_set_name(cPtr, newValue)
		}
	}

	/// Retrieve the user pointer associated with the video definition. 
	/// - Returns: The user pointer associated with the video definition.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_video_definition_get_user_data(cPtr)
		}
		set
		{
			linphone_video_definition_set_user_data(cPtr, newValue)
		}
	}

	/// Get the width of the video definition. 
	/// - Returns: The width of the video definition 
	public var width: UInt
	{
		get
		{
			return UInt(linphone_video_definition_get_width(cPtr))
		}
		set
		{
			linphone_video_definition_set_width(cPtr, CUnsignedInt(newValue))
		}
	}

	/// Clone a video definition. 
	/// - Returns: The new clone of the video definition   
	public func clone() -> VideoDefinition?
	{
		let cPointer = linphone_video_definition_clone(cPtr)
		if (cPointer == nil) {
			return nil
		}
		let result = VideoDefinition.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Tells whether two `VideoDefinition` objects are equal (the widths and the
	/// heights are the same but can be switched). 
	/// - Parameter videoDefinition2: `VideoDefinition` object   
	/// - Returns: A boolean value telling whether the two `VideoDefinition` objects
	/// are equal. 
	public func equals(videoDefinition2:VideoDefinition) -> Bool
	{
		return linphone_video_definition_equals(cPtr, videoDefinition2.cPtr) != 0
	}

	/// Set the width and the height of the video definition. 
	/// - Parameter width: The width of the video definition 
	/// - Parameter height: The height of the video definition 
	public func setDefinition(width:UInt, height:UInt) 
	{
		linphone_video_definition_set_definition(cPtr, CUnsignedInt(width), CUnsignedInt(height))
	}

	/// Tells whether two `VideoDefinition` objects are strictly equal (the widths are
	/// the same and the heights are the same). 
	/// - Parameter videoDefinition2: `VideoDefinition` object   
	/// - Returns: A boolean value telling whether the two `VideoDefinition` objects
	/// are strictly equal. 
	public func strictEquals(videoDefinition2:VideoDefinition) -> Bool
	{
		return linphone_video_definition_strict_equals(cPtr, videoDefinition2.cPtr) != 0
	}
}

/// The `XmlRpcRequest` object representing a XML-RPC request to be sent. 
public class XmlRpcRequest : LinphoneObject
{
	var delegateManagers : [XmlRpcRequestDelegateManager] = []

	static public func getSwiftObject(cObject:OpaquePointer) -> XmlRpcRequest {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<XmlRpcRequest>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = XmlRpcRequest(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// The `XmlRpcRequest` object representing a XML-RPC request to be sent. 
	public func addDelegate(delegate: XmlRpcRequestDelegate)
	{
		let manager = XmlRpcRequestDelegateManager()
		manager.delegate = delegate
		delegateManagers.append(manager)
		linphone_xml_rpc_request_add_callbacks(cPtr, manager.cPtr)
		belle_sip_object_unref(UnsafeMutableRawPointer(manager.cPtr))
		belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
	}

	/// The `XmlRpcRequest` object representing a XML-RPC request to be sent. 
	public func removeDelegate(delegate: XmlRpcRequestDelegate)
	{
		if let index = delegateManagers.firstIndex(where: { $0.delegate === delegate as AnyObject}) {
			linphone_xml_rpc_request_remove_callbacks(cPtr, delegateManagers[index].cPtr)
			delegateManagers.remove(at: index)
			belle_sip_object_data_set(UnsafeMutablePointer(cPtr), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()), nil)
		}
	}

	/// Get the content of the XML-RPC request. 
	/// - Returns: The string representation of the content of the XML-RPC request.   
	public var content: String
	{
			let cPointer = linphone_xml_rpc_request_get_content(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the current LinphoneXmlRpcRequestCbs object associated with a
	/// LinphoneXmlRpcRequest. 
	/// - Returns: The current LinphoneXmlRpcRequestCbs object associated with the
	/// LinphoneXmlRpcRequest.   
	public var currentDelegate: XmlRpcRequestDelegate?
	{
			let cObject = linphone_xml_rpc_request_get_current_callbacks(cPtr)
			let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
			if (result != nil) {
				return Unmanaged<XmlRpcRequestDelegateManager>.fromOpaque(result!).takeUnretainedValue().delegate
				}
			return nil
	}

	/// Get the response to an XML-RPC request sent with XmlRpcSession.sendRequest()
	/// and returning an integer response. 
	/// - Returns: The integer response to the XML-RPC request. 
	public var intResponse: Int
	{
			return Int(linphone_xml_rpc_request_get_int_response(cPtr))
	}

	/// Get the response to an XML-RPC request sent with XmlRpcSession.sendRequest()
	/// and returning a string response. 
	/// - Returns: A list of all string responses in the XML-RPC request.    
	public var listResponse: [String]
	{
			var swiftList = [String]()
			let cList = linphone_xml_rpc_request_get_list_response(cPtr)
			var listTemp = cList
			while (listTemp != nil) {
				swiftList.append(String(cString: unsafeBitCast(listTemp!.pointee.data, to: UnsafePointer<CChar>.self)))
				listTemp = UnsafePointer<bctbx_list_t>(listTemp!.pointee.next)
			}
			return swiftList
	}

	/// Get the raw response to an XML-RPC request sent with
	/// XmlRpcSession.sendRequest() and returning http body as string. 
	/// - Returns: The string response to the XML-RPC request.   
	public var rawResponse: String
	{
			let cPointer = linphone_xml_rpc_request_get_raw_response(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Get the status of the XML-RPC request. 
	/// - Returns: The `XmlRpcStatus` of the XML-RPC request. 
	public var status: XmlRpcStatus
	{
			return XmlRpcStatus(rawValue: Int(linphone_xml_rpc_request_get_status(cPtr).rawValue))!
	}

	/// Get the response to an XML-RPC request sent with XmlRpcSession.sendRequest()
	/// and returning a string response. 
	/// - Returns: The string response to the XML-RPC request.   
	public var stringResponse: String
	{
			let cPointer = linphone_xml_rpc_request_get_string_response(cPtr)
			let result = charArrayToString(charPointer: cPointer)
			return result
	}

	/// Retrieve the user pointer associated with the XML-RPC request. 
	/// - Returns: The user pointer associated with the XML-RPC request.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_xml_rpc_request_get_user_data(cPtr)
		}
		set
		{
			linphone_xml_rpc_request_set_user_data(cPtr, newValue)
		}
	}

	/// Add an integer argument to an XML-RPC request. 
	/// - Parameter value: The integer value of the added argument. 
	public func addIntArg(value:Int) 
	{
		linphone_xml_rpc_request_add_int_arg(cPtr, CInt(value))
	}

	/// Add a string argument to an XML-RPC request. 
	/// - Parameter value: The string value of the added argument.   
	public func addStringArg(value:String) 
	{
		linphone_xml_rpc_request_add_string_arg(cPtr, value)
	}
}

/// The `XmlRpcSession` object used to send XML-RPC requests and handle their
/// responses. 
public class XmlRpcSession : LinphoneObject
{

	static public func getSwiftObject(cObject:OpaquePointer) -> XmlRpcSession {
		let result = belle_sip_object_data_get(UnsafeMutablePointer(cObject), "swiftRef")
		if (result != nil) {
			return Unmanaged<XmlRpcSession>.fromOpaque(result!).takeUnretainedValue()
		}

		let sObject = XmlRpcSession(cPointer: cObject)
		belle_sip_object_data_set(UnsafeMutablePointer(cObject), "swiftRef",  UnsafeMutableRawPointer(Unmanaged.passUnretained(sObject).toOpaque()), nil)

		return sObject
	}

	public var getCobject: OpaquePointer? {
		return cPtr
	}

	/// Retrieve the user pointer associated with the XML-RPC session. 
	/// - Returns: The user pointer associated with the XML-RPC session.   
	public var userData: UnsafeMutableRawPointer?
	{
		get
		{
			return linphone_xml_rpc_session_get_user_data(cPtr)
		}
		set
		{
			linphone_xml_rpc_session_set_user_data(cPtr, newValue)
		}
	}

	/// Creates a `XmlRpcRequest` from a `XmlRpcSession`. 
	/// - Parameter returnType: the return type of the request as a `XmlRpcArgType` 
	/// - Parameter method: the function name to call   
	/// - Returns: a `XmlRpcRequest` object   
	public func createRequest(returnType:XmlRpcArgType, method:String) throws -> XmlRpcRequest
	{
		let cPointer = linphone_xml_rpc_session_create_request(cPtr, LinphoneXmlRpcArgType(rawValue: CUnsignedInt(returnType.rawValue)), method)
		if (cPointer == nil) {
			throw LinphoneError.exception(result: "create null XmlRpcRequest value")
		}
		let result = XmlRpcRequest.getSwiftObject(cObject: cPointer!)
		belle_sip_object_unref(UnsafeMutableRawPointer(cPointer))
		return result
	}

	/// Stop and unref an XML rpc session. 
	/// Pending requests will be aborted. 
	public func release() 
	{
		linphone_xml_rpc_session_release(cPtr)
	}

	/// Send an XML-RPC request. 
	/// - Parameter request: The `XmlRpcRequest` to be sent.   
	public func sendRequest(request:XmlRpcRequest) 
	{
		linphone_xml_rpc_session_send_request(cPtr, request.cPtr)
	}
}
