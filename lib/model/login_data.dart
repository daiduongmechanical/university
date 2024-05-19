import 'Token.dart';

class LoginData {
  int? userId;
  String? name;
  String? avatar;
  String? role;
  Token? token;

  LoginData({this.userId, this.name, this.avatar, this.role, this.token});

  LoginData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    avatar = json['avatar'];
    role = json['role'];
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['role'] = this.role;
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    return data;
  }
}


