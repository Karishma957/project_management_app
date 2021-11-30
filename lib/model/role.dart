import 'package:mongo_dart/mongo_dart.dart';

class Role {
  ObjectId? roleId;
  String? roleName;
  String? description;

  static bool isMember(ObjectId o) {
    return o ==
        ObjectId.fromBsonBinary(
            BsonBinary.fromHexString("00000001347ad1ccbd4b6a15"));
  }

  static bool isAdmin(ObjectId o) {
    return o ==
        ObjectId.fromBsonBinary(
            BsonBinary.fromHexString("00000001347ad1ccbd4b6a14"));
  }

  void admin() {
    roleId = ObjectId.fromBsonBinary(
        BsonBinary.fromHexString("00000001347ad1ccbd4b6a14"));
    roleName = "Admin";
    description =
        "Admin will be able to add, remove members from project, change role of group member, assign task and change the status";
  }

  void member() {
    roleId = ObjectId.fromBsonBinary(
        BsonBinary.fromHexString("00000002347ad1ccbd4b6a15"));
    roleName = "Member";
    description =
        "Co-Leader will able to assign task to members and can change the status";
  }

  void coLeader() {
    roleId = ObjectId.fromBsonBinary(
        BsonBinary.fromHexString("00000003347ad1ccbd4b6a16"));
    roleName = "Co-leader";
    description = "Only able to change the status";
  }
}
