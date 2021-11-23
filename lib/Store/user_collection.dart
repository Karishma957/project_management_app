import 'package:project_management_app/Service/constants.dart';
import 'package:project_management_app/Service/db_connection.dart';
import 'package:project_management_app/model/user.dart';
import 'package:mongo_dart/mongo_dart.dart' as mg;

class UserCollection {
  static var collection;
  static List users = List.empty(growable: true);

  static getCollection() {
    collection = DBConnection.db?.collection('user');
  }

  static printCollection() async {
    print(await collection?.find().toList());
  }

  static addToCollection(User user) async {
    await collection?.insert(user.toJson());
  }

  static Future<User?> loginUser(User user) async {
    int index = users.indexWhere((e) => e.userName == user.userName);
    User? u;
    if (index == -1) {
      addToCollection(user);
      await getUsers();
      index = users.indexWhere((e) => e.userName == user.userName);
      u = users[index];
      users.removeAt(index);
    } else {
      u = users[index];
    }
    return u;
  }

  static update(User user) async {
    var old = await collection?.findOne({"_id": user.userId});
    old["userName"] = "bleh";
    await collection?.save(old);
  }

  static delete(User user) async {
    await collection?.remove(mg.where.id(user.userId!));
  }

  static Future getUsers() async {
    try {
      final result = await collection.find().toList();
      if (result != null) users = result.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }
  }
}
