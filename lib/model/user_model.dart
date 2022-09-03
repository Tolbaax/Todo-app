/// Not used yet
class UserModel {
  String? name;
  String? email;
  UserModel({this.name, this.email});
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
