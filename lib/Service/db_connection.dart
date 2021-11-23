import 'package:mongo_dart/mongo_dart.dart';


class DBConnection {
  static Db? db;
  Future<bool> getConnection() async {
    try {
      db = await Db.create(_getConnectionString());
      await db?.open();
      return true;
    } catch (_) {
      return false;
    }
  }

  _getConnectionString() {
    return "mongodb+srv://Karishma:karishma@cluster0.auku1.mongodb.net/miniProject?retryWrites=true&w=majority";
  }
}
