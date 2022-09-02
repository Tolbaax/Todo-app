class UserModel {
  String? name;
  String? email;
  String? uID;
  UserModel({this.name, this.email, this.uID});
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uID = json['uId'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uId': uID,
    };
  }
}
