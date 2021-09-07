
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';

import 'fusion_model.dart';

class FusionStore<T extends FusionModel> {
  FusionConnection _fusionConnection;
  Map<String, T> _records;
  String _id_field = 'id';

  FusionStore(this._fusionConnection);

  FusionConnection get fusionConnection => _fusionConnection;

  storeRecord(T record) {
    _records[record.getId()] = record;
  }

  hasRecord(String id) {
    return _records.containsKey(id);
  }

  getRecord(String id, Function(T) callback) {
    if (_records.containsKey(id)) {
      callback(_records[id]);
    }
  }
}
