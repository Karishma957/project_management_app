import 'package:mongo_dart/mongo_dart.dart';

class DBConnection {
  Db? db;

  Future getConnection() async {
    db=await Db.create(_getConnectionString());
    await db?.open();
    final coll=db?.collection('projects');
    print(await coll?.find().toList());
  }

  _getConnectionString() {
    return "mongodb+srv://Karishma:karishma@cluster0.auku1.mongodb.net/miniProject?retryWrites=true&w=majority";
  }
}
