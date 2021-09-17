import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/models/coworkers.dart';

import 'carbon_date.dart';
import 'contact.dart';
import 'fusion_model.dart';
import 'fusion_store.dart';

class IntegratedContactsStore extends FusionStore<Contact> {
  IntegratedContactsStore(FusionConnection fusionConnection) : super(fusionConnection);

  search(String query, int limit, int offset, Function(List<Contact>) callback) {
        fusionConnection.apiV1Call(
        "post",
        "/clients/filtered_crm_contacts",
        {'page': (offset / limit).round(),
          'page_size': limit,
          'sort_dir': 'asc',
          'search_query': query,
          'sort_by': 'name_text',
        },
        callback: (Map<String, dynamic> datas) {
          print("gotinfo" + datas.toString());
          List<Contact> response = [];

          datas['items'].forEach((dynamic c) {
            Contact contact = Contact(c['contact'] as Map<String, dynamic>);
            contact.lastCommunication = c['last_communication'];
            contact.unread = int.parse(c['unread'].toString());
            response.add(contact);
          });

          callback(response);
        });
  }
}
