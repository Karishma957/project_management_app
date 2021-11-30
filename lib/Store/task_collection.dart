import 'package:mongo_dart/mongo_dart.dart' as mg;
import 'package:project_management_app/Service/db_connection.dart';
import 'package:project_management_app/model/project.dart';
import 'package:project_management_app/model/task.dart';

class TaskCollection {
  static var collection;
  static List tasks = List.empty(growable: true);

  static getCollection() {
    collection = DBConnection.db?.collection('tasks');
  }

  static printCollection() async {
    print(await collection?.find().toList());
  }

  static Future addToCollection(Task task) async {
    await collection?.insert(task.toJson());
  }

  static update(Task task) async {
    var old = await collection?.findOne({"_id": task.taskId});
    old["taskName"] = "new";
    await collection?.save(old);
  }

  static Future updateStatus(mg.ObjectId taskId, bool status) async {
    var old = await collection?.findOne({"_id": taskId});
    old["status"] = status;
    await collection?.save(old);
  }

  static delete(Task task) async {
    await collection?.remove(mg.where.id(task.taskId!));
  }

  static Future getTasks() async {
    try {
      final result = await collection.find().toList();
      if (result != null) {
        tasks = result.map((e) => Task.fromJson(e)).toList();
      }
    } catch (e) {}
  }
}
