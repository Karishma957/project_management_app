import 'package:mongo_dart/mongo_dart.dart' as mg;
import 'package:project_management_app/Service/db_connection.dart';
import 'package:project_management_app/model/project.dart';

class ProjectCollection {
  static var collection;

  static getCollection() {
    collection = DBConnection.db?.collection('projects');
  }

  static printCollection() async {
    print(await collection?.find().toList());
  }

  static addToCollection(Project project) async {
    await collection?.insert(project.toJson());
  }

  static update(Project project) async {
    var old = await collection?.findOne({"_id": project.projectId});
    old["projectName"] = "bleh";
    await collection?.save(old);
  }

  static delete(Project project) async {
    await collection?.remove(mg.where.id(project.projectId!));
  }

  static Future<List?> getProjects() async {
    try {
      final result = await collection.find().toList();
      if (result != null) return result.map((e) => Project.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }
  }
}
