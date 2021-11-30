import 'package:mongo_dart/mongo_dart.dart' as mg;
import 'package:project_management_app/Service/constants.dart';
import 'package:project_management_app/Service/db_connection.dart';
import 'package:project_management_app/model/project.dart';
import 'package:project_management_app/model/task.dart';

class ProjectCollection {
  static var collection;
  static List projectsList = List.empty(growable: true);

  static getCollection() {
    collection = DBConnection.db?.collection('projects');
  }

  static printCollection() async {
    print(await collection?.find().toList());
  }

  static addToCollection(Project project) async {
    await collection?.insert(project.toJson());
  }

  static Future update(mg.ObjectId project, mg.ObjectId taskId) async {
    var old = await collection?.findOne({"_id": project});
    old["tasks"].add(TaskId(taskId: taskId).toJson());
    await collection?.save(old);
  }

  static delete(Project project) async {
    await collection?.remove(mg.where.id(project.projectId!));
  }

  static Future getProjects() async {
    try {
      final result = await collection.find().toList();
      if (result != null) {
        List res = result.map((e) => Project.fromJson(e)).toList();
        res.forEach((element) {
          int i = element.userRoles
              .indexWhere((ele) => ele.userId == Constants.user.userId);
          if (i != -1) projectsList.add(element);
        });
      }
    } catch (e) {}
  }
}
