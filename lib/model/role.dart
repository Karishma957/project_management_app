class Role {
  Role({
    this.roleId,
    this.roleName,
    this.description,
  });

  String? roleId;
  String? roleName;
  String? description;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["roleId"] ?? "",
        roleName: json["roleName"] ?? "",
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "roleName": roleName,
        "description": description,
      };
}
