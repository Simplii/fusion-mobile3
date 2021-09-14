import '../backend/fusion_connection.dart';

class UserSettings {
  Map<String, dynamic> options = {};
  Map<String, dynamic> subscriber = {};
  final FusionConnection _fusionConnection;

  UserSettings(this._fusionConnection);

  setOptions(Map<String, dynamic> opts) {
    options = opts;
  }

  setSubscriber(Map<String, dynamic> me) {
    subscriber = me;
  }

  lookupSubscriber() {
    _fusionConnection.nsApiCall(
        'subscriber',
        'read',
        {'uid': _fusionConnection.getUid()},
        callback: (Map<String, dynamic> data) {
          if (data.containsKey('subscriber')) {
            subscriber = data['subscriber'];
          }
        });
  }

  String userScope() {
    return subscriber['scope'];
  }

  bool hasManagerPermissions() {
    String scope = userScope();
    return scope == 'Office Manager' || scope == 'Super User';
  }

  String avatarForUser(String uid) {
    if (options['avatars'][uid.toLowerCase()]) {
      return _fusionConnection.serverRoot + options['avatars'][uid
          .toLowerCase()];
    }
    else {
      return _fusionConnection.defaultAvatar;
    }
  }

  String myAvatar() {
    return avatarForUser(_fusionConnection.getUid());
  }

  List<Map<String, dynamic>> crmData() {
    return (options['crm_features'] as Map<String, dynamic>).values as List<Map<String, dynamic>>;
  }

  String crmIcon(crmName) {
    List<Map<String, dynamic>> crms = crmData();
    for (Map<String, dynamic> crmData in crms) {
      if (crmData['CRM_NAME'] == crmName) {
        return crmData['CRM_ICON'] as String;
      }
    }
    throw "Crm not found (" + crmName + ")";
  }

  List<String> enabledFeatures() {
    return options['client']['options'] as List<String>;
  }

  bool isFeatureEnabled(featureName) {
    return enabledFeatures().contains(featureName);
  }

  List<String> parkLines() {
    return options['park_lines'] as List<String>;
  }

  List<Map<String, dynamic>> userSmsNumbers() {
    List<Map<String, dynamic>> numbers = [];

    for (Map<String, dynamic> user in options['sms_users']) {
      numbers.add({'phoneNumber': options['phone_number_id'],
                    'isMMS': options['is_mms']
                  });
    }

    return numbers;
  }
}