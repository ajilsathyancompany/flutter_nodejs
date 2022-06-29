class AllUsersModel {
  List<AllUsers>? allUsers;

  AllUsersModel({this.allUsers});

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    if (json['all_users'] != null) {
      allUsers = <AllUsers>[];
      json['all_users'].forEach((v) {
        allUsers!.add(new AllUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allUsers != null) {
      data['all_users'] = this.allUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllUsers {
  String? sId;
  String? name;
  int? age;
  int? iV;

  AllUsers({this.sId, this.name, this.age, this.iV});

  AllUsers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    age = json['age'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['__v'] = this.iV;
    return data;
  }
}