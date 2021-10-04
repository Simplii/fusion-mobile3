import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/contacts/recent_contacts.dart';
import 'package:fusion_mobile_revamped/src/models/call_history.dart';
import 'package:fusion_mobile_revamped/src/models/coworkers.dart';

class ContactsSearch extends StatefulWidget {
  ContactsSearch(this._fusionConnection, this._softphone, {Key key})
      : super(key: key);

  final FusionConnection _fusionConnection;
  final Softphone _softphone;

  @override
  State<StatefulWidget> createState() => _ContactsSearchState();
}

class _ContactsSearchState extends State<ContactsSearch> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;
  List<CallHistory> _history = [];
  int lookupState = 0;
  String _subscriptionKey;
  Map<String, Coworker> _coworkers = {};

  @override
  void initState() {
    super.initState();
    _lookupHistory();
  }

  _lookupHistory() {
    lookupState = 1;

    if (_subscriptionKey != null) {
      _fusionConnection.coworkers.clearSubscription(_subscriptionKey);
    }

    _subscriptionKey =
        _fusionConnection.coworkers.subscribe(null, (List<Coworker> coworkers) {
          this.setState(() {
            for (Coworker c in coworkers) {
              _coworkers[c.uid] = c;
            }
          });
        });

    _fusionConnection.callHistory.getRecentHistory(300, 0,
            (List<CallHistory> history, bool fromServer) {
          this.setState(() {
            if (fromServer) {
              lookupState = 2;
            }
            _history = history;
          });
        });
  }

  _historyList() {
    return _history.map((item) {
      if (item.coworker != null && _coworkers[item.coworker.uid] != null) {
        item.coworker = _coworkers[item.coworker.uid];
      }
      return CallHistorySummaryView(_fusionConnection, _softphone, item);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(slivers: [
        SliverList(
            delegate: SliverChildListDelegate(_historyList()))
      ]),
    );
  }
}
